// Minimal PID controller in a similar style to iir_filter2ndorder_3.v

`timescale 1 ns / 1 ps

module pid_controller #(
    parameter IN_DATA_WIDTH  = 16,
    parameter OUT_DATA_WIDTH = 16,
    parameter COEFF_WIDTH    = 32,
    parameter DATA_WIDTH     = 18
)(
    input  wire clk,
    input  wire rst,

    // Reference (setpoint) and measured signals
    input  wire signed [IN_DATA_WIDTH-1:0] ref,
    input  wire signed [IN_DATA_WIDTH-1:0] meas,

    // PID coefficients
    input  wire signed [COEFF_WIDTH-1:0] kp,
    input  wire signed [COEFF_WIDTH-1:0] ki,
    input  wire signed [COEFF_WIDTH-1:0] kd,

    // PID output
    output reg  signed [OUT_DATA_WIDTH-1:0] control_out
);

    // Internal registers
    reg  signed [DATA_WIDTH-1:0] error, error_prev;
    reg  signed [DATA_WIDTH-1:0] integrator;
    reg  signed [DATA_WIDTH-1:0] derivative;
    reg  signed [COEFF_WIDTH-1:0] kp_reg, ki_reg, kd_reg;
    reg  signed [COEFF_WIDTH+DATA_WIDTH-1:0] p_term, i_term, d_term, control_accum;

    // Coefficient pipeline
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            kp_reg <= 0;
            ki_reg <= 0;
            kd_reg <= 0;
        end else begin
            kp_reg <= kp;
            ki_reg <= ki;
            kd_reg <= kd;
        end
    end

    // Compute error, integrator, derivative
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            error       <= 0;
            error_prev  <= 0;
            integrator  <= 0;
            derivative  <= 0;
        end else begin
            error       <= ref - meas;
            error_prev  <= error;
            integrator  <= integrator + error;
            derivative  <= error - error_prev;
        end
    end

    // Multiply by coefficients
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            p_term     <= 0;
            i_term     <= 0;
            d_term     <= 0;
            control_accum <= 0;
        end else begin
            p_term     <= kp_reg * error;
            i_term     <= ki_reg * integrator;
            d_term     <= kd_reg * derivative;
            control_accum <= p_term + i_term + d_term;
        end
    end

    // Final PID output
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            control_out <= 0;
        end else begin
            // Shift or downscale if needed, here just truncate to fit OUT_DATA_WIDTH
            control_out <= control_accum[DATA_WIDTH+COEFF_WIDTH-1 -: OUT_DATA_WIDTH];
        end
    end

endmodule