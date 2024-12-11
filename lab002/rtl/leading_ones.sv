`timescale 1ns / 10ps
module leading_ones #(
    parameter SELECTOR,
    parameter BITS     = 16
) (
    input  wire  [      BITS-1:0] sw,
    output logic [$clog2(BITS):0] led
);

  generate
    if (SELECTOR == "UNIQUE_CASE") begin : g_UNIQUE_CASE
      always_comb begin
        led = '0;

        unique case (1'b1)
          sw[15]:  led = 16;
          sw[14]:  led = 15;
          sw[13]:  led = 14;
          sw[12]:  led = 13;
          sw[11]:  led = 12;
          sw[10]:  led = 11;
          sw[9]:   led = 10;
          sw[8]:   led = 9;
          sw[7]:   led = 8;
          sw[6]:   led = 7;
          sw[5]:   led = 6;
          sw[4]:   led = 5;
          sw[3]:   led = 4;
          sw[2]:   led = 3;
          sw[1]:   led = 2;
          sw[0]:   led = 1;
          default: led = 0;
        endcase
      end

    end else if (SELECTOR == "CASE") begin : g_CASE

      always_comb begin
        led = '0;

        case (1'b1)
          sw[15]:  led = 16;
          sw[14]:  led = 15;
          sw[13]:  led = 14;
          sw[12]:  led = 13;
          sw[11]:  led = 12;
          sw[10]:  led = 11;
          sw[9]:   led = 10;
          sw[8]:   led = 9;
          sw[7]:   led = 8;
          sw[6]:   led = 7;
          sw[5]:   led = 6;
          sw[4]:   led = 5;
          sw[3]:   led = 4;
          sw[2]:   led = 3;
          sw[1]:   led = 2;
          sw[0]:   led = 1;
          default: led = 0;
        endcase
      end

    end else if (SELECTOR == "DOWN_FOR") begin : g_UP_IF
      always_comb begin
        led = '0;
        for (int i = $high(sw); i >= $low(sw); i--) begin
          if (sw[i]) begin
            led = i + 1;
            break;
          end
        end
      end
    end else if (SELECTOR == "UP_FOR") begin : g_DOWN_IF
      always_comb begin
        led = '0;
        for (int i = $low(sw); i <= $high(sw); i++) begin
          if (sw[i]) begin
            led = i + 1;
          end
        end
      end
    end
  endgenerate
endmodule
