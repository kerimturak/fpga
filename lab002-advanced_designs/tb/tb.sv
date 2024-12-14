`timescale 1ns/ 100ps;

module tb;
  parameter  SELECTOR     = "UP_FOR";
  parameter  UNIQUE_CASE  = "FALSE";
  parameter  TEST_CASE    = "LEADING_ONES";
  localparam BITS         = 16;
  localparam NUM_TEST     = 1000;

  logic [BITS-1:0]       sw;
  logic [BITS-1:0]       led;
  logic                  BTNC;
  logic                  BTNU;
  logic                  BTNL;
  logic                  BTNR;
  logic                  BTND;

  logic [$clog2(BITS):0] LO_LED;
  logic [$clog2(BITS):0] NO_LED;
  logic [BITS-1:0]       AS_LED;
  logic [BITS-1:0]       MULT_LED;
  logic [BITS-1:0]       LED_TB;

  leading_ones #(.SELECTOR(SELECTOR), .BITS(BITS)) u_lo (.*, .led(LO_LED));
  add_sub      #(.SELECTOR(SELECTOR), .BITS(BITS)) u_as (.*, .led(AS_LED));
  num_ones     #(                     .BITS(BITS)) u_no (.*, .led(NO_LED));
  mult         #(                     .BITS(BITS)) u_mt (.*, .led(MULT_LED));
  project_2    #(.SELECTOR(SELECTOR), .BITS(BITS)) u_alu
  (
   .*
   );

  always_comb begin
    LED_TB = '0;
    if (TEST_CASE == "LEADING_ONES") begin
      LED_TB[$clog2(BITS):0]  = LO_LED;
    end else if (TEST_CASE == "NUM_ONES") begin
      LED_TB = NO_LED;
    end else if (TEST_CASE == "ADD" || TEST_CASE == "SUB") begin
      LED_TB = AS_LED;
    end else if (TEST_CASE == "MULT") begin
      LED_TB = MULT_LED;
    end else begin
      LED_TB = led;
    end
  end

  logic                  set_zero;
  int                    button;

  // Stimulus
  initial begin
    $printtimescale(tb);
    //if ((TEST_CASE == "LEADING_ONES") || (TEST_CASE == "ALL")) begin
    for (int i = 0; i < NUM_TEST; i++) begin
      button = $urandom_range(0,4);
      BTNC = '0;
      BTNU = '0;
      BTNL = '0;
      BTNR = '0;
      BTND = '0;

      case (button)
        0: BTNC   = '1;
        1: BTNU   = '1;
        2: BTND   = '1;
        3: BTNL   = '1;
        4: BTNR   = '1;
      endcase // case (button)

      sw        = $random;
      set_zero  = '0;
      for (int j = BITS-1; j >= 0; j--) begin
        if (UNIQUE_CASE == "TRUE" &&
            !((TEST_CASE == "ADD") || (TEST_CASE == "SUB") ||
              (TEST_CASE == "MULT"))) begin
          // If we want to use unique values, execute this part of tb
          if (set_zero) sw[j] = '0;
          else if (sw[j] && j > 0) begin
            // if we find a 1 at a position other than in bit 0, set all lower
            // bits top 0. This ensures we will only have 1 bit at most set.
            set_zero = '1;
          end
        end
      end
      $display("Setting switches to %16b", sw);
        #100;
    end
    sw = '0;
    #100;
    $display("PASS: logic_ex test PASSED!");
    $stop;
    //end
  end

  int sw_pos;
  logic signed [15:0] sw_alu;

  // Checking
  always @(LED_TB) begin
    sw_pos  = '0;
    if (TEST_CASE == "ALL") begin
      case (1'b1)
        BTNU: begin
          if (lo_func(sw) != led[$clog2(BITS):0]) begin
            $display("FAIL: led != leading 1's position");
            $stop;
          end
        end
        BTND: begin
          if (no_func(sw) != led) begin
            $display("FAIL: led != number of ones represented by sw");
            $stop;
          end
        end
        BTNL: begin
          sw_alu = signed'(sw[15:8]) + signed'(sw[7:0]);
          if (sw_alu != led) begin
            $display("FAIL: led != sum of sw[15:8] + sw[7:0]");
            $stop;
          end
        end
        BTNR: begin
          sw_alu = signed'(sw[15:8]) - signed'(sw[7:0]);
          if (sw_alu != led) begin
            $display("FAIL: led != difference of sw[15:8] - sw[7:0]");
            $stop;
          end
        end
        BTNC: begin
          sw_alu = signed'(sw[15:8]) * signed'(sw[7:0]);
          if (sw_alu != led) begin
            $display("FAIL: led != product of sw[15:8] * sw[7:0]");
            $stop;
          end
        end
      endcase
    end else if (TEST_CASE == "LEADING_ONES") begin
      if (lo_func(sw) != LED_TB[$clog2(BITS):0]) begin
        $display("FAIL: led != leading 1's position");
        $stop;
      end
    end else if (TEST_CASE == "NUM_ONES") begin
      if (no_func(sw) != LED_TB) begin
        $display("FAIL: led != number of ones represented by sw");
        $stop;
      end
    end else if (TEST_CASE == "ADD") begin
      sw_alu = signed'(sw[15:8]) + signed'(sw[7:0]);
      if (sw_alu != LED_TB) begin
        $display("FAIL: led != sum of sw[15:8] + sw[7:0]");
        $stop;
      end
    end else if (TEST_CASE == "SUB") begin
      sw_alu = signed'(sw[15:8]) - signed'(sw[7:0]);
      if (sw_alu != LED_TB) begin
        $display("FAIL: led != difference of sw[15:8] + sw[7:0]");
        $stop;
      end
    end else if (TEST_CASE == "MULT") begin
      sw_alu = signed'(sw[15:8]) * signed'(sw[7:0]);
      if (sw_alu != LED_TB) begin
        $display("FAIL: led != product of sw[15:8] - sw[7:0]");
        $stop;
      end
    end // if ((TEST_CASE == "LEADING_ONES") || (TEST_CASE == "ALL"))
  end // always @ (LED_TB)

  function [$clog2(BITS):0] lo_func(input [BITS-1:0] sw);
    lo_func = '0;
    for (int i = $low(sw); i <= $high(sw); i++) begin
      if (sw[i]) begin
        lo_func  = i+1;
      end
    end
  endfunction

  function [$clog2(BITS):0] no_func(input [BITS-1:0] sw);
    no_func = '0;
    for (int i = $low(sw); i <= $high(sw); i++) begin
      no_func  += sw[i];
    end
  endfunction

endmodule // tb