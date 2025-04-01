# Real-Time Image Processing on FPGA — Implementation 1

### Author: Zack Mendez  
### Project: RTIPCV  
### Platform: **Basys 3 FPGA** + OV7670 Camera  
### Toolchain: Vivado 2024.1  
---

## Overview

This project is the **first implementation** of a real-time image processing system built for the **Basys 3 FPGA** board. It captures live video from the **OV7670** camera, converts the color feed to **grayscale**, and displays the processed video via **VGA output** on a monitor.

The design uses full 640×480 VGA resolution at 60Hz, with pixel data stored in a dual-port block RAM framebuffer.

Due to the limited BRAM on the Basys 3, the system stores 4-bit grayscale values per pixel instead of full 12-bit RGB. This allows a full frame to fit in memory while maintaining clean image quality — and opens the door for efficient image processing in future implementations.

This implementation serves as the foundation for future real-time video processing effects.

---

## What This Implementation Achieves

- ✅ OV7670 camera initialization over SCCB (I2C)
- ✅ Real-time video capture and frame buffering
- ✅ RGB444 to grayscale conversion
- ✅ VGA output with sync timing generation (640x480 @ 60Hz)
- ✅ Grayscale image display using a dual-port framebuffer
- ✅ Button-controlled configuration and manual override via switches

---

## 📂 Project Structure

impl1/  ├── constraints/                                        # XDC constraints file for Basys 3 pin mapping 
        ├── ip/                                                 # IP cores (PLL for clock generation, etc.) 
        ├── vhdl/                                               # All VHDL source files 
        │ └── top_level.vhd
        ├── README.md                                           # You are here!

---

## Hardware Requirements

- **FPGA Board:** Digilent **Basys 3** (`xc7a35tcpg236-1`)
- **Camera:** OV7670 (without FIFO)
- **Display:** VGA-compatible monitor
- **Resolution:** 640×480 @ 60Hz
- **Power/Data:** MicroUSB + standard male-male VGA cable

---

## How to Use in Vivado (Basys 3 Setup)

### 1. Create a New Vivado Project

- Open **Vivado 2024.1**
- Create a new RTL project with:
  - **Target device:** Basys 3 (Part: `xc7a35tcpg236-1`)
  - No default sources

### 2. Add Design Sources

- Go to `impl1/vhdl/`
- Add all `.vhd` files as design sources to the project

### 3. Add IP Cores

- If using IP cores (like `clk_wiz_0`):
  - Go to `impl1/ip/`
  - Add and regenerate IP cores as needed
  - In Vivado, use **Tools → IP Catalog** to repackage or update

### 4. Add Constraints

- Go to `impl1/constraints/`
- Add the provided `.xdc` file for the **Basys 3**
- Verify all pin assignments:
  - Camera pins (SIOC, SIOD, PCLK, VSYNC, HREF, XCLK, DATA[7:0])
  - VGA output pins
  - Button and switch mappings

### 5. Synthesize, Implement, and Program

- Run Synthesis → Implementation → Bitstream Generation
- Connect Basys 3 via USB and use the **Hardware Manager** to program the board

---

## Controls

- `btnC` — Triggers default OV7670 configuration
- `btnL` — Loads manual register settings from `SW[15:0]`
- `SW`   — 16-bit camera register + value (when btnL pressed)
- `btnR` — Global reset (mapped to `rst`)

**Fun Switch Configuration:**
> Set `SW = 0011101000100000` (Hex: `0x3A20`) and press `btnL`  
> This writes `0x20` to the **TSLB** register, enabling **negative image mode** —  

---

## Coming Next (Implementation 2)

The next implementation will support:

> **⚡ Real-Time Thresholding for Pseudocolor Imaging**

This will apply dynamic pixel thresholding to the grayscale feed, mapping values to colors for segmenting intensity levels — useful for things like motion detection, thermal visualization, or basic object highlighting.

---

## Contributing / Questions?

Pull requests, improvements, and issues are welcome. This project is part of a larger effort to build affordable real-time image processing systems for education and experimentation.

---



