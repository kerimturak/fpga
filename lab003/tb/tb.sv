module tb ();
  logic                    clk = 0;
  logic                    BTNC;
  logic                    CPU_RESETN;
  logic [3:0] anode;
  logic [             7:0] cathode;

  counting_buttons u_counting_buttons (
      .clk       (clk),
      .BTNC      (BTNC),
      .CPU_RESETN(CPU_RESETN),
      .anode     (anode),
      .cathode   (cathode)
  );

  always #5 clk = ~clk;

  initial begin
    BTNC = 0;
    CPU_RESETN = 0;
    #10;
  end
endmodule
