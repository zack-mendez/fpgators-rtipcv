# Real-Time Image Processing on FPGA — Implementation 2

### Author: Zack Mendez  
### Project: RTIPCV  
### Platform: **Basys 3 FPGA** + OV7670 Camera  
### Toolchain: Vivado 2024.1  

---

## Overview

This project is the **second implementation** of a real-time image processing system built for the **Basys 3 FPGA** board. Building upon the foundational grayscale framebuffer design of Implementation 1, this version introduces **real-time thresholding**, **edge detection**, and **pseudocolor visualization** using a dynamic hardware pipeline.

New features include convolution-based filters, dynamic threshold control using a **rotary encoder**, pseudocolor mapping, and interactive controls — making this system a full-featured visual processing demo at 640×480 @ 60Hz VGA output.

---

## What This Implementation Adds

- ✅ 3×3 convolution filters: **Sobel X, Sobel Y, Emboss, Debug**
- ✅ Combined Sobel X/Y for stronger edge extraction
- ✅ Binary thresholding on edge results (`0x0` or `0xF`)
- ✅ **Rotary encoder** for:
  - Turning right: increase threshold
  - Turning left: decrease threshold
  - Pressing down: reset threshold to 0
- ✅ **Mode switch**: toggle edge detection mode (with threshold) or passthrough
- ✅ **Pseudocolor mapping** via switches:
  - `00`: Grayscale
  - `01`: Rainbow
  - `10`: Heatmap
  - `11`: Retro
- ✅ Modular and extensible design with streamlined kernel and color selection
- ✅ Debug-friendly identity kernel mode for passthrough verification

---

## Project Structure

```
impl2/
├── constraints/         # XDC constraints for Basys 3 pin mapping
├── ip/                  # IP cores (PLL, etc.)
├── vhdl/                # VHDL source files
│   ├── top_level.vhd
│   ├── convolution_3x3.vhd
│   ├── thresholding.vhd
│   ├── rotary_encoder.vhd
│   ├── pseudocolor.vhd
│   ├── kernel_pkg.vhd
│   └── ...
└── README.md
```

---

## Hardware Requirements

- **FPGA Board:** Digilent **Basys 3** (`xc7a35tcpg236-1`)
- **Camera:** OV7670 (without FIFO)
- **Display:** VGA-compatible monitor
- **Controls:** Rotary Encoder (with push), Pushbuttons, Switches
- **Power/Data:** MicroUSB + VGA cable

---

## Rotary Encoder Wiring (PMOD JA)

Connect the **rotary encoder module** to the **PMOD JA header** on the Basys 3 (bottom edge):

| Encoder Pin | Connect To |
|-------------|------------|
| GND         | JA12       |
| VCC (3.3V)  | JA11       |
| SWT         | JA10       |
| BTN         | JA9        |
| B           | JA8        |
| A           | JA8        |

Update the `.xdc` constraints file to match these assignments.

---

## How to Use in Vivado

1. **Create Project**
   - Open **Vivado 2024.1**
   - Create a new RTL project, target device: `xc7a35tcpg236-1`

2. **Add Design Sources**
   - Add all `.vhd` files from `impl2/vhdl/` to the project

3. **Add IP Cores**
   - Regenerate any IP cores from `impl2/ip/` (e.g., `clk_wiz_0`)

4. **Apply Constraints**
   - Add `.xdc` file from `impl2/constraints/`
   - Confirm pin mappings for:
     - Camera (SIOC, SIOD, PCLK, VSYNC, HREF, XCLK, DATA[7:0])
     - VGA output
     - Rotary encoder (PMOD JA)
     - Pushbuttons and switches

5. **Build and Program**
   - Run Synthesis → Implementation → Bitstream Generation
   - Program Basys 3 via USB using the **Hardware Manager**

---

## Controls

- `btnR` — Global reset
- `btnC` — Trigger default OV7670 configuration
- **Rotary Encoder:**
  - **Turn Right**: Increase threshold (max = 15)
  - **Turn Left**: Decrease threshold (min = 0)
  - **Press Button**: Reset threshold to 0
- **Mode Switch**: Selects between:
  - **Edge detection mode** (Sobel X + Y + thresholding)
  - **Passthrough mode** (no thresholding)
- **Basys 3 SW[1:0]** — Pseudocolor scheme:
  - `00`: Grayscale
  - `01`: Rainbow
  - `10`: Heatmap
  - `11`: Retro

---

## Example Use Case

To run edge detection with color enhancement:

1. Set mode switch to **edge detection**
2. Choose a **pseudocolor style** using `SW[1:0]`
3. Use the **rotary encoder** to tune the threshold
4. Press encoder button to reset threshold as needed
5. Toggle back to passthrough mode for raw image view

---

## Notes and Limitations

- Gaussian blur was tested but not included due to LUT limitations
- Grayscale compression (4-bit) is still used to save BRAM
- Additional enhancements (region labeling, motion highlighting) are in progress

---

## Coming Next (Implementation 3 Ideas)

- Efficient Gaussian filtering using resource sharing
- Connected-component labeling and bounding boxes
- Region-of-interest detection for movement or shape
- UART-based debug overlays or HDMI video capture

---

## Contributing / Contact

Open to PRs, feedback, and collaboration.  
Reach me at [zacharymendez@ufl.edu](mailto:zacharymendez@ufl.edu) or through GitHub Issues.

---
