`timescale 1ns / 1ps  // `timescale <time unit>/<time precision>

module tb_led_toggle ();

  logic [2:0] sw;
  logic [7:0] led;

  led_toggle u_led_toggle (
      .sw (sw),
      .led(led)
  );

  initial begin
    $printtimescale(tb_led_toggle);
    sw = '0;
    for (int i = 0; i < 8; i++) begin
      $display("Switch state is : %-5d", i[2:0]);
      sw = i[2:0];
      #10;
    end

    $stop;
  end
endmodule
