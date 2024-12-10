module led_toggle (
    input  logic [2:0] sw,
    output logic [7:0] led
);

  always_comb begin
    case (sw)
      3'b000: led = 8'b0000_0000;
      3'b001: led = 8'b0000_0001;
      3'b010: led = 8'b0000_0010;
      3'b011: led = 8'b0000_0100;
      3'b100: led = 8'b0000_1000;
      3'b101: led = 8'b0001_0000;
      3'b110: led = 8'b0010_0000;
      3'b111: led = 8'b0100_0000;
    endcase
  end

endmodule
