# Real-Time Image Processing on FPGA

## Overview
This project, developed by FPGAtors at the University of Florida, focuses on real-time image processing using an FPGA-based system. We utilize the Basys3 board interfaced with an OV7670 camera to capture and process images using various 3x3 convolution filters, including gradient, Sobel, and Laplacian. The processed images are then output to a VGA display.

## Objectives
- Interface the OV7670 camera module with the Basys3 FPGA board.
- Implement real-time image processing algorithms using VHDL.
- Display processed images on a VGA monitor.
- Gain hands-on experience in digital image processing and hardware acceleration.

## System Architecture
The system consists of the following components:
1. **Camera Interface Module**: Captures images from the OV7670 camera and converts them to a format suitable for FPGA processing.
2. **Image Processing Module**: Applies 3x3 convolution filters in real-time, such as:
   - **Gradient Filter**: Detects changes in intensity.
   - **Sobel Filter**: Enhances edges in an image.
   - **Laplacian Filter**: Highlights regions of rapid intensity change.
3. **VGA Controller**: Outputs the processed frames to a VGA display.
4. **Memory Buffer**: Temporary storage for image frames.

## Hardware Components
- **Basys3 FPGA Board** (Xilinx Artix-7)
- **OV7670 Camera Module**
- **VGA Display**
- **Breadboard and Wires** (for additional interfacing)

## Implementation Details
### 1. Camera Interface
The OV7670 camera outputs image data in a YUV or RGB565 format. We configure the camera to output 8-bit grayscale images for simplified processing. The data is captured using the FPGA’s GPIO and stored in an internal frame buffer.

### 2. Image Processing Pipeline
Each pixel undergoes a 3x3 convolution operation, where the kernel is applied to extract features such as edges or gradients. The operations are implemented in hardware using parallelized logic to maintain real-time performance.

### 3. VGA Output
The processed image is sent to a VGA controller that formats it into RGB signals. A synchronization mechanism ensures proper display on the monitor.

## Project Workflow
1. **Set Up Camera Interface**:
   - Configure the OV7670 registers for desired resolution and output format.
   - Capture image data using the FPGA.
2. **Implement Convolution Filters**:
   - Design and simulate 3x3 filter operations.
   - Optimize for low-latency processing.
3. **Integrate VGA Output**:
   - Implement a framebuffer mechanism.
   - Send processed data to the VGA controller.
4. **Testing and Debugging**:
   - Validate output at each stage.
   - Optimize for performance.

## References
We are using the following sources for reference:
- **VGA and Camera Usage**: [Basys3 OV7670 Camera Interface](https://www.fpga4student.com/2018/08/basys-3-fpga-ov7670-camera.html)
- **Convolution Implementation**:
  - [Hardware Implementation of 2D Convolution on FPGA by Shefa Dawwd](https://www.researchgate.net/publication/369038700_Hardware_Implementation_of_2D_convolution_on_FPGA)【12†source】
  - **Implementation of 2D Convolution Algorithm on FPGA for Image Processing Application**, International Journal of Electrical, Electronics and Data Communication【13†source】

## Getting Started
### Prerequisites
- Xilinx Vivado Design Suite (for Basys3)
- Knowledge of VHDL
- Basic understanding of signals and systems

### Steps to Run the Project
1. Clone the repository:
   ```sh
   git clone https://github.com/imuncool/fpgators-rtipcv.git
   ```
2. Open Vivado and create a new project.
3. Add the provided VHDL files and constraints.
4. Synthesize and implement the design.
5. Program the Basys3 board.
6. Connect the OV7670 camera and VGA display.
7. Observe real-time image processing results on the monitor.

## Future Enhancements
- Support for additional filters (Gaussian blur, Canny edge detection).
- Implementing dynamic kernel selection.
- Enhancing resolution and color support.
- Optimizing memory and processing efficiency.

## Contributors
Developed by the **FPGAtors** team at the University of Florida.
