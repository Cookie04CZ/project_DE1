# Projekt DE1
> *Funkční projekt se nachází ve branchi/složce [project_v1](project_v1). Doděláváme ještě lepší user input pro lepší ovládání a přidáme ještě jedno servo a funkčnost na více kanálech.*
# Team members
Jan Baňař - Hlavní programátor\
Filip Hojer - Hlavní programátor\
Filip Křivánek - Pomocný programátor, readme\
František Kajtár - Pomocný programátor, readme

# PWM Generator ve VHDL
## Popis
Jako projekt do předmětu DE1 jsme se rozhodli pro vytvoření PWM-servo motor ovladače (a ovládání jasu LED když budeme časově stíhat). Ovládání mezi servama (a ledkou) se bude přepínat pomocí spínače. Na dvou sedmisegmentových displejích budeme zobrazovat stav, neboli úhel natočení. Konkrétní ovládání bude vysvětleno [níže](#Instructions).

## Hardware popis
Jako servo motor použijeme SG90 spojený s deskou Nexys A7-50T.
![Image](https://github.com/user-attachments/assets/729a2219-6d19-4bb1-9bec-48f4823f098a)

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
