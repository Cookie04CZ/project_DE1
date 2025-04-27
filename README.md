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

Schéma zapojení


## Software popis
**TOPLEVEL**\
![Image](https://github.com/user-attachments/assets/7c69c288-4522-4382-9dbc-83bab11b0f2d)

## Komponenty a simulace
`top_level.vhd` - **Top Level Module**:\
**OBRAZEK SIMULACE**

`pwm.vhd` - Generuje PWM signál závislý na vstupních parametrech.\
**OBRAZEK SIMULACE**

`dec2seg.vhd` - Využije hodnotu úhlu v decimálním čísle a zobrazí ho na 7 segmentovém displeji.\
**OBRAZEK SIMULACE**

`dec2duty.vhd` - Převádní úhel v decimálním čísle na střídu.\
**OBRAZEK SIMULACE**

`sw_input.vhd` - Převede binární vstup na úhel.\
**OBRAZEK SIMULACE**

`clk_enable.vhd`\
**OBRAZEK SIMULACE**

## Instructions

## References
https://www.studiopieters.nl/tower-pro-micro-servo-s9-sg90/
