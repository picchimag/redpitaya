
`timescale 1 ns / 1 ps

module iir_filter_2nd_order #(
    parameter IN_DATA_WIDTH = 16,    // Input/output data width
    parameter OUT_DATA_WIDTH = 16,
    parameter IN_COEFF_WIDTH = 32,   // Coefficient width
    
    parameter DATA_WIDTH = 18,  // 
    parameter COEFF_WIDTH = 25,   // Coefficient width
    parameter B_SHIFT = 7, // if i want it to reach 1: max b_shift: IN_COEFF_WIDTH-COEFF_WIDTH = 32-18 = 14, 32-25=7. 
    parameter LOG_DIV = 10 // division of clock by 2**LOG_DIV
)(
    input wire clk,                   // System clock
    input wire rst,                   // Reset signal
    input wire signed [IN_DATA_WIDTH-1:0] x_in,          // signed current input sample (16-bit)
    input wire signed [IN_COEFF_WIDTH-1:0] b0, // Pre-scaled Coefficients from GPIO (32-bit)
    input wire signed [IN_COEFF_WIDTH-1:0] b1,
    input wire signed [IN_COEFF_WIDTH-1:0] b2,
    input wire signed [IN_COEFF_WIDTH-1:0] a1,
    input wire signed [IN_COEFF_WIDTH-1:0] a2,
    input wire signed [IN_COEFF_WIDTH-1:0] gain, // Controllable output gain
    output reg signed [OUT_DATA_WIDTH-1:0] y_out // output (16-bit)
);

    localparam LOG_A0 = COEFF_WIDTH - 2; // one bit for the sign, and one bit for a1,a2 to rach 2. 
    localparam ADC_DATA_WIDTH = 14; // The actual max value coming from the adc
    localparam DATA_SHIFT = DATA_WIDTH - ( ADC_DATA_WIDTH + LOG_DIV ) ;// DATA_WIDTH-(ADC_DATA_WIDTH+LOG_DIV)25-(14+2)=9 / 32-(14+2) = 16 // 32-(14+10) = 16  
    localparam DATA_SHIFT_OUT = DATA_WIDTH - ADC_DATA_WIDTH;

    // Internal registers
    reg [LOG_DIV-1:0] counter;

    reg signed [DATA_WIDTH - 1:0] x0, x1, x2, y1, y2;
    reg signed [DATA_WIDTH + LOG_DIV - 1:0] x_sum;
    reg signed [COEFF_WIDTH-1:0] b0_reg, b1_reg, b2_reg, a1_reg, a2_reg, gain_reg;

    wire signed [DATA_WIDTH + COEFF_WIDTH -1:0] b0_x0, b1_x1, b2_x2, a1_y1, a2_y2, acc_ff, acc_fb, acc, y_gain;
    wire signed [DATA_WIDTH-1:0] x, y;
    
   
    // Clock
    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
    wire counter_clk = (counter == 0);
    
    // Integrator
    always @(posedge clk) begin
        if (rst) begin
            x0 <=0;
            x_sum <= 0;
        end else if (counter_clk && DATA_SHIFT >= 0) begin
            x0 <= (x_sum + x_in) <<< DATA_SHIFT; //log_div = 2, -4->-2  >>>(LOG_DIV-4)
            x_sum <= 0;
        end else if (counter_clk && DATA_SHIFT < 0) begin
            x0 <= (x_sum + x_in) >>> - DATA_SHIFT;
            x_sum <= 0;
        end else begin
            x_sum <= x_sum + x_in;       
        end
    end
    
    /*// Alternative to Intewgrator: just decimation:
    always @(posedge clk) begin
        if (rst) begin
            x0 <=0;
        end else if (counter_clk) begin
            x0 <= x_in <<< DATA_SHIFT;
        end
    end
    */
    
    // Pipeline for coefficient registers
    always @(posedge clk) begin
        if (rst) begin
            b0_reg <= 0;
            b1_reg <= 0;
            b2_reg <= 0;
            a1_reg <= 0;
            a2_reg <= 0;
            gain_reg <= 0;
        end else begin
            b0_reg <= b0;
            b1_reg <= b1;
            b2_reg <= b2;
            a1_reg <= a1;
            a2_reg <= a2;
            gain_reg <= gain;
        end
    end

    // Pipeline for in and out registers
    always @(posedge clk)
      if (rst) begin
        x1 <= 0;
        x2 <= 0;
        y2 <= 0;
      end else if (counter_clk) begin
        x1 <= x0;
        x2 <= x1;
        y2 <= y1;
        y1 <= y;
      end
        
            
    // Combinational multiplications
    assign b0_x0 = (x0 * b0_reg) >>> B_SHIFT;
    assign b1_x1 = (x1 * b1_reg) >>> B_SHIFT;
    assign b2_x2 = (x2 * b2_reg) >>> B_SHIFT;
    assign a1_y1 = y1 * a1_reg;
    assign a2_y2 = y2 * a2_reg;
    
    //Filter equation 
    //assign acc_ff = (b0_x + b1_x1 + b2_x2);//>>> LOG_DELTA_B;
    //assign acc_fb = (a1_y1 + a1_y1);
    //assign y = (acc_ff - acc_fb) >>> LOG_A0;
    assign acc = b0_x0 + b1_x1 + b2_x2 - a1_y1 - a2_y2;
    assign y = acc >>> LOG_A0;
    
    always @(posedge clk) begin
        if (rst) begin
            y_out <= 0;
        end else begin
            y_out <= y >> DATA_SHIFT_OUT;
        end
    end
    
endmodule