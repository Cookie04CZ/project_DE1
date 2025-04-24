# project_DE1
Projekt do předmětu DE1

https://www.studiopieters.nl/tower-pro-micro-servo-s9-sg90/

# PWM Generator in VHDL

## Overview
This project implements a **Pulse Width Modulation (PWM)** signal generator using **VHDL**. The PWM signal can be used for various applications such as controlling the brightness of LEDs, motor speed control, or other hardware that requires a modulated signal. The design can be synthesized and deployed to FPGA or similar hardware platforms.

## Features
- Generates a PWM signal with configurable frequency and duty cycle.
- Parameterized for different clock sources and output requirements.
- Simple and efficient VHDL code that is easy to integrate into larger designs.

## Components
- **PWM Generator**: The main entity that generates the PWM signal based on input parameters (frequency, duty cycle).
- **Top Level Module**: A simple wrapper to instantiate and connect the PWM generator to the rest of the system (clock input, output signals, etc.).

## Requirements
- **VHDL-2008** (or compatible VHDL standard)
- FPGA development environment (e.g., Xilinx Vivado, Intel Quartus)
- **Clock frequency**: Input clock (typically 50 MHz or higher, depending on your design requirements)

## Files
- `pwm_generator.vhdl`: VHDL code for the PWM generator module.
- `top_module.vhdl`: Top-level wrapper module connecting the PWM generator to the input/output ports.
- `testbench.vhdl`: A testbench to simulate and verify the functionality of the PWM generator.
- `Makefile`: Build automation script (optional, depending on your environment).
- `README.md`: Project documentation.

## Installation
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/pwm-vhdl.git
