# Projekt DE1
> [!IMPORTANT]
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
Jako servo motor použijeme SG90 spojený s deskou Nexys A7-50T.\
<img src="https://github.com/user-attachments/assets/729a2219-6d19-4bb1-9bec-48f4823f098a" alt="Sample Image" width="500" height="300">

Pinout serva SG90\
![Image](https://github.com/user-attachments/assets/a287a20f-ef4b-4c7a-b373-06122f760d76)\
Zapojení obou serv\
![Image](https://github.com/user-attachments/assets/59f5241e-ee04-40ba-9dab-9566e1c3ea06)\

## Software popis
**TOPLEVEL**\
![Image](https://github.com/user-attachments/assets/7c69c288-4522-4382-9dbc-83bab11b0f2d)

## Komponenty a simulace
`top_level.vhd` - **Top Level Module**:\
**OBRAZEK SIMULACE**

`pwm.vhd` - Generuje PWM signál závislý na vstupních parametrech.\
**OBRAZEK SIMULACE**

`buff.vhd` - **POPIS**\
![Image](https://github.com/user-attachments/assets/f36f3e4c-be09-484a-a2e0-9e6049aaaabf)

`dec2seg.vhd` - Využije hodnotu úhlu v decimálním čísle a posune ho do `bin2seg.vhd`. Ovládá jednotlivé číslice.\
**OBRAZEK SIMULACE**

`dec2duty.vhd` - Převádní úhel v decimálním čísle na střídu.\
**OBRAZEK SIMULACE**

`sw_input.vhd` - Převede binární vstup na úhel.\
**OBRAZEK SIMULACE**

`bin2seg.vhd` - Využitý sobor ze cvičení. Ovládá jednotlivé číslice.\
**OBRAZEK SIMULACE?**

`clk_enable.vhd` - Využitý soubor ze cvičení. Hodiny s nastavitelnou frekvencí.\
**OBRAZEK SIMULACE?**

## Instrukce
**Schéma boardy Nexys A7-50T s popisky**
![Image](https://github.com/user-attachments/assets/55e20161-78bc-406a-9e87-5a19a81831d8)
1) Pro zadání úhlu pro konkrétní servo vybereme levým spínačem (SW16) pozici nahoře (1. servo), nebo dole (2. servo).\ 
2) Pro nastavení úhlu využíváme 6 spínačů zprava (SW1-6). Hodnota na spínačích se zadává binárně, ovšem na displeji sledujeme aktuální decimální hodnotu úhlu.
3) Potvrzujeme pravým tlačítkem (BTNR). Aktuální úhel serva vidíme v pravé části 7-segmentového displeje.
4) Sledujeme natočení serva na potvrzený úhel a změnění aktuální hodnoty na displeji.
5) Pro druhé servo přepneme spínač do opačné polohy

## References
https://www.studiopieters.nl/tower-pro-micro-servo-s9-sg90/
