# Lab 3: Seven-Segment Display and Button Interface

This repository contains the Verilog/SystemVerilog code and related files for Lab 3 of our FPGA series. The focus of this lab is implementing a seven-segment display controller with button inputs for counting and displaying values.

---

## Project Description

Lab 3 demonstrates the use of seven-segment displays and button interfaces to create an interactive counting application. It integrates:
- A seven-segment display controller (`seven_segment` module).
- Button logic for counting values (`counting_buttons` module).
- Encoding logic for seven-segment cathode outputs (`cathode_top` module).

---

## Files and Directory Structure

```
Lab3/
├── build/                # Build directory for output files
├── rtl/                  # Source files
│   ├── cathode_top.sv    # Seven-segment cathode encoder
│   ├── counting_buttons.sv  # Button interface with counting logic
│   ├── seven_segment.sv  # Seven-segment display controller
├── tb/                   # Testbenches
│   └── tb.sv             # Testbench for the integrated design
├── doc/image-1.png           # Timing diagram
├── doc/image.png             # Seven-segment display mapping
├── readme.md             # Documentation file
```

---

## Modules Description

### `cathode_top.sv`

This module encodes 4-bit input values (`encoded`) into seven-segment cathode signals (`cathode`). It also handles the decimal point (`digit_point`).

```verilog
module cathode_top (
    input wire         clk,
    input wire [3:0]   encoded,
    input wire         digit_point,
    output logic [7:0] cathode
);

  always_ff @(posedge clk) begin
    cathode[7] <= digit_point;
    case (encoded)
      4'h0: cathode[6:0] <= 7'b1000000;
      4'h1: cathode[6:0] <= 7'b1111001;
      4'h2: cathode[6:0] <= 7'b0100100;
      4'h3: cathode[6:0] <= 7'b0110000;
      4'h4: cathode[6:0] <= 7'b0011001;
      4'h5: cathode[6:0] <= 7'b0010010;
      4'h6: cathode[6:0] <= 7'b0000010;
      4'h7: cathode[6:0] <= 7'b1111000;
      4'h8: cathode[6:0] <= 7'b0000000;
      4'h9: cathode[6:0] <= 7'b0010000;
      4'hA: cathode[6:0] <= 7'b0001000;
      4'hB: cathode[6:0] <= 7'b0000011;
      4'hC: cathode[6:0] <= 7'b1000110;
      4'hD: cathode[6:0] <= 7'b0100001;
      4'hE: cathode[6:0] <= 7'b0000110;
      4'hF: cathode[6:0] <= 7'b0001110;
    endcase
  end
endmodule
```

### `counting_buttons.sv`

This module interfaces with a button (`BTNC`) and manages the counting logic. It outputs encoded values and controls the seven-segment display.

- Parameters include:
  - `MODE`: Specifies counting in decimal (`DEC`) or hexadecimal (`HEX`).
  - `NUM_SEGMENTS`: Number of segments in the display.
  - `CLK_PER`: Clock period in ns.
  - `REFR_RATE`: Refresh rate in Hz.

### `seven_segment.sv`

Controls the seven-segment display refresh logic and manages multiple digits. Handles the periodic update of active segments and multiplexing signals to the display.

---

## Testbench

The testbench (`tb.sv`) validates the integrated design:
- Simulates button presses to trigger counting.
- Monitors the output signals for the anode and cathode of the seven-segment display.

---

## Constraints File

### Clock Signal

```tcl
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]
```

### Seven-Segment Display

```tcl
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {cathode[0]}]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {cathode[1]}]
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {cathode[2]}]
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {cathode[3]}]
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {cathode[4]}]
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {cathode[5]}]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {cathode[6]}]
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {cathode[7]}]

set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {anode[0]}]
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {anode[1]}]
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {anode[2]}]
set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {anode[3]}]
```

### Buttons

```tcl
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports CPU_RESETN]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports BTNC]
```

---

## Hardware Requirements

- **FPGA Board**: Basys3 or equivalent
- **Inputs**: 1 button, 4 slide switches
- **Outputs**: 4 seven-segment display digits

---
