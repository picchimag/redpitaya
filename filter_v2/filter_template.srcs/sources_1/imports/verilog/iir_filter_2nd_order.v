/**
* Now IIR filter in the coupled form. Takes as input registers apha, beta, c, gainP, gainQ
* alpha and beta define the filter, c is the normalization factor (for unity gain at resonance)
* and  gainP, gainQ are the gains for the in-phase and quadrature outputs. 
* The filter transfer function is given by:

*                                beta*z^-1
*      H(z) =   c * ------------------------------------------
*                   (1 - 2*alpha*z^-1 + (alpha^2+beta^2)*z^-2)
*
*/



`timescale 1 ns / 1 ps

module iir_filter_2nd_order #(
    parameter IN_DATA_WIDTH = 16,    // Input/output data width
    parameter OUT_DATA_WIDTH = 16,
    parameter DATA_WIDTH = 16,  // 
    parameter INTERNAL_STATE_WIDTH = 30,
    parameter COEFF_WIDTH = 20,   // Coefficient width
    parameter LOG_DIV = 10, // division of clock by 2**LOG_DIV
    parameter LOG_UNITY_GAIN = 10 // logarithm of unity gain

)(
    input wire clk,                   // System clock
    input wire rst_ext,                   // Reset signal
    input wire signed [IN_DATA_WIDTH-1:0] x_in,          // signed current input sample (16-bit)
    input wire signed [COEFF_WIDTH-1:0] alpha, // Pre-scaled Coefficients from GPIO (32-bit)
    input wire signed [COEFF_WIDTH-1:0] beta,
    input wire signed [COEFF_WIDTH-1:0] c,
    input wire signed [2*LOG_UNITY_GAIN-1:0] gainP,
    input wire signed [2*LOG_UNITY_GAIN-1:0] gainQ,
    input wire signed [31:0] gpio_in, //reset in upper bit.
    output reg signed [OUT_DATA_WIDTH-1:0] y_out // output (16-bit)

);


    localparam LOG_A0 = COEFF_WIDTH - 2; // one bit for the sign, and one bit for a1,a2 to rach 2. 
    localparam ADC_DATA_WIDTH = 14; // The actual max value coming from the adc
    localparam DATA_SHIFT = DATA_WIDTH - ( ADC_DATA_WIDTH + LOG_DIV ) ;// DATA_WIDTH-(ADC_DATA_WIDTH+LOG_DIV)25-(14+2)=9 / 32-(14+2) = 16 // 32-(14+10) = 16  
    localparam DATA_SHIFT_OUT = DATA_WIDTH - ADC_DATA_WIDTH;

    // Internal registers
    reg rst;
    reg [LOG_DIV-1:0] counter;
    
    reg signed [DATA_WIDTH - 1:0] x0, u_norm, v_norm;
    reg signed [DATA_WIDTH + LOG_DIV - 1:0] x_sum;
    reg signed [COEFF_WIDTH-1:0] alpha_reg, beta_reg;
    reg signed [2*LOG_UNITY_GAIN-1:0] gainP_reg, gainQ_reg;
    reg signed [DATA_WIDTH + 2*LOG_UNITY_GAIN -1:0] u_out, v_out;
    reg signed [INTERNAL_STATE_WIDTH -1:0] u, v;
    
    wire signed [INTERNAL_STATE_WIDTH -1:0] u_new, v_new, alpha_u, beta_v, alpha_v, beta_u;
    wire signed [DATA_WIDTH-1:0] x, y;

    //gpio controls
    always @(posedge clk) begin
        rst <= gpio_in[31];
    end
   
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

    
    // Pipeline for coefficient registers
    always @(posedge clk) begin
        if (rst) begin
            alpha_reg <= 0;
            beta_reg <= 0;
            gainP_reg <= 0;
            gainQ_reg <= 0;
            
        end else begin
            alpha_reg <= alpha;
            beta_reg <= beta;
            gainP_reg <= gainP;
            gainQ_reg <= gainQ;
            
        end
    end

    // Pipeline filter states
    always @(posedge clk)
      if (rst) begin
        u <= 0;
        v <= 0;    
      end else if (counter_clk) begin   //IMPORTANT!
        u <= u_new;
        v <= v_new;
      end
        
            
    // Combinational multiplications
    assign alpha_u = alpha * u >>> LOG_A0;  //[20*30] ---> 30
    assign beta_v = beta * v >>> LOG_A0;
    assign alpha_v = alpha * v >>> LOG_A0;
    assign beta_u = beta * u >>> LOG_A0;
    

    //Filter equation 
    assign u_new = x0 + alpha_u  - beta_v;
    assign v_new = beta_u + alpha_v;
    

    
    // output pipeline
    always @(posedge clk) begin
        if (rst) begin
            u_norm <=0;
            v_norm <= 0;
            u_out <=0;
            v_out <= 0;
            y_out <= 0;

        end else begin
            //Normalization
             u_norm <= c * u_new  >>> LOG_A0;  //[20x30] ---> 16
             v_norm <= c * v_new >>> LOG_A0;
            //Gain 
             u_out <= gainP * u_norm >>> LOG_UNITY_GAIN; // 16*10-10= 16
             v_out <= gainQ * v_norm >>> LOG_UNITY_GAIN;
            //Output
             y_out <= x0;//u_out + v_out >>> DATA_SHIFT_OUT;
        end
    end
    
endmodule