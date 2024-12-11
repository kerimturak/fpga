`timescale 1ns / 10ps
module project_2 #(
    parameter SELECTOR,
    parameter BITS     = 16
) (
    input wire [BITS-1:0] sw,
    input wire            BTNC,
    input wire            BTNU,
    input wire            BTNL,
    input wire            BTNR,
    input wire            BTND,

    output logic signed [BITS-1:0] led
);

  logic [$clog2(BITS):0] LO_LED;
  logic [$clog2(BITS):0] NO_LED;
  logic [      BITS-1:0] AD_LED;
  logic [      BITS-1:0] SB_LED;
  logic [      BITS-1:0] MULT_LED;

  leading_ones #(
      .SELECTOR(SELECTOR),
      .BITS(BITS)
  ) u_lo (
      .*,
      .led(LO_LED)
  );
  add_sub #(
      .SELECTOR("ADD"),
      .BITS(BITS)
  ) u_ad (
      .*,
      .led(AD_LED)
  );
  add_sub #(
      .SELECTOR("SUB"),
      .BITS(BITS)
  ) u_sb (
      .*,
      .led(SB_LED)
  );
  num_ones #(
      .BITS(BITS)
  ) u_no (
      .*,
      .led(NO_LED)
  );
  mult #(
      .BITS(BITS)
  ) u_mt (
      .*,
      .led(MULT_LED)
  );

  always_comb begin
    led = '0;
    case (1'b1)
      BTNC: led = MULT_LED;
      BTNU: led = LO_LED;
      BTND: led = NO_LED;
      BTNL: led = AD_LED;
      BTNR: led = SB_LED;
    endcase
  end
endmodule
