`timescale 1ns / 10ps
module num_ones #(
    parameter BITS = 16
) (
    input  wire  [      BITS-1:0] sw,
    output logic [$clog2(BITS):0] led
);

  always_comb begin
    led = '0;
    for (int i = $low(sw); i <= $high(sw); i++) begin
      led += sw[i];
    end
  end
endmodule
