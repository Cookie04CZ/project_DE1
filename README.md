# Projekt DE1
# Team members
Jan Baňař - Hlavní programátor\
Filip Hojer - Hlavní programátor\
Filip Křivánek - Pomocný programátor\
František Kajtár - Pomocný programátor

# PWM Generator ve VHDL
## Popis
Rozhodli jsme se pro vytvoření PWM-servo motor ovladače a ovládání jasu LED. Ovládání mezi servem a ledkou se bude přepínat pomocí spínače. Na dvou sedmisegmentových displejích budeme zobrazovat pro LED stav jasu v procentech a pro servo úhel natočení. Konkrétní ovládání bude vysvětleno níže.

## Hardware popis
Jako servo motor použijeme SG90 spojený s deskou Nexys A7-50T.

## Software popis


## Components
- **PWM Generator**: The main entity that generates the PWM signal based on input parameters (frequency, duty cycle).
- **Top Level Module**: A simple wrapper to instantiate and connect the PWM generator to the rest of the system (clock input, output signals, etc.).

## Files
- `pwm_generator.vhdl`: VHDL code for the PWM generator module.
- `top_module.vhdl`: Top-level wrapper module connecting the PWM generator to the input/output ports.
- `testbench.vhdl`: A testbench to simulate and verify the functionality of the PWM generator.
- `Makefile`: Build automation script (optional, depending on your environment).
- `README.md`: Project documentation.

## Instructions

## References
https://www.studiopieters.nl/tower-pro-micro-servo-s9-sg90/
