`timescale 1ns / 10ps
module add_sub #(
    parameter SELECTOR,
    parameter BITS     = 16
) (
    input  wire         [BITS-1:0] sw,
    output logic signed [BITS-1:0] led
);

  logic signed [BITS/2-1:0] a_in;
  logic signed [BITS/2-1:0] b_in;

  always_comb begin
    {a_in, b_in} = sw;
    if (SELECTOR == "ADD") led = a_in + b_in;
    else led = a_in - b_in;
  end
endmodule
