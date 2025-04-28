# Projekt DE1
> [!IMPORTANT]
> Funkční projekt se nachází ve branchi/složce [project_v1](project_v1). Doděláváme ještě lepší user input pro lepší ovládání a přidáme ještě jedno servo a funkčnost na více kanálech.
# Team members
Jan Baňař - Hlavní programátor, vedoucí skupinky\
Filip Hojer - Hlavní programátor,\
Filip Křivánek - Pomocný programátor, readme\
František Kajtár - Pomocný programátor, readme

# PWM Generator ve VHDL
## Popis
Jako projekt do předmětu DE1 jsme se rozhodli pro vytvoření PWM pro řízení servomotoru ve VHDL. Projekt se zaměřuje na návrh a implementaci **PWM (Pulse Width Modulation)** pro **nezávislé** řízení dvou servomotorů. Každé servo je ovládáno samostatně v rozsahu **0-90°** změnou šířky PWM pulzů. Námi vytvořený VHDL kód generuje signál s pevnou periodou a proměnnou délkou pulzu, která určuje požadovanou polohu serva.

Ovládání mezi servama se bude přepínat pomocí spínače. Na dvou sedmisegmentových displejích budeme zobrazovat zvolené servo, jeho aktuální stav a uživatelem zadávaný úhel. Konkrétní ovládání bude vysvětleno [níže](#Instrukce). V plánu bylo zprovoznit i ovládání jasu LED, ale z časových důvodů jsme to již nestihli. 

## Hardware
Pro realizaci a ověření funkčnosti je využíván FPGA vývojový kit Nexys A7-50T. viz. [Instrukce](#Instrukce)

**Jako servomotory použijeme dva SG90.**\
<img src="https://github.com/user-attachments/assets/729a2219-6d19-4bb1-9bec-48f4823f098a" alt="Sample Image" align="center" width="500" height="300">

**Zapojení obou serv a pinout desky**\
<img src="https://github.com/user-attachments/assets/7d748c2d-951e-407e-a203-209422bdae0c" alt="Sample Image" align="center" width="500" height="300">

## Software
**TOPLEVEL**\
![Image](https://github.com/user-attachments/assets/7c69c288-4522-4382-9dbc-83bab11b0f2d)
> **TOPLEVEL VYGENEROVANÉ SCHÉMA Z VIVADA**

## Komponenty a simulace
`top_level.vhd` - **Top Level Module**:\
> **OBRAZEK SIMULACE**

`pwm.vhd` - Generuje PWM signál závislý na vstupních parametrech.\
> **OBRAZEK SIMULACE**

`buff.vhd` - **POPIS**\
![Image](https://github.com/user-attachments/assets/f36f3e4c-be09-484a-a2e0-9e6049aaaabf)

`dec2seg.vhd` - Využije hodnotu úhlu v decimálním čísle a posune ho do `bin2seg.vhd`. Ovládá jednotlivé číslice.\
> **OBRAZEK SIMULACE**

`dec2duty.vhd` - Převádní úhel v decimálním čísle na střídu.\
> **OBRAZEK SIMULACE**

`sw_input.vhd` - Převede binární vstup na úhel.\
> **OBRAZEK SIMULACE**

`bin2seg.vhd` - Využitý sobor ze cvičení. Ovládá jednotlivé číslice.\
> **OBRAZEK SIMULACE?**

`clk_enable.vhd` - Využitý soubor ze cvičení. Hodiny s nastavitelnou frekvencí.\
> **OBRAZEK SIMULACE?**

# Instrukce
## Stažení projektu
Celý projekt se nachází [zde](#Instrukce).
> Přidat odkaz na finální projekt

## Ovládání na desce
**Schéma boardy Nexys A7-50T s popisky**
![Image](https://github.com/user-attachments/assets/55e20161-78bc-406a-9e87-5a19a81831d8)
## Popis ovládání
1) Levým spínačem (SW16) vybereme servo, které chceme ovládat. Pozicí nahoře (1. servo), nebo dole (2. servo).\ 
2) Pro nastavení úhlu využíváme 6 spínačů zprava (SW1-6). Hodnota na spínačích se zadává binárně, ovšem na displeji sledujeme aktuální decimální hodnotu zadávaného úhlu v pravé části displeje.
3) Potvrzujeme pravým tlačítkem (BTNR). Aktuální úhel serva vidíme vpravo od čísla určující ovládané servo.
4) Sledujeme natočení serva na potvrzený úhel a změnění aktuální hodnoty na displeji.
5) Pro vyresetování úhlu stiskneme prostřední tlačítko (BTNC). Servo se otočí zpět na pozici 0°.
6) Pro zvolení druhého serva, přepneme spínač do druhé pozice a ovládáme stejnými kroky.

> [!WARNING]
> Následující obrázky jsou pořízeny při zkoušce základní verze funkčnosti. Je zde pouze jedno servo a neimplementované resetovací a potvrzovací tlačítko. Také zde máme 8 switchů pro zadání úhlu, to jsme ve finálním projektu snížili na 6.

**Žádný spínač zapnut -> hodnota úhlu 0 -> servo v pozici 0**\
![Image](https://github.com/user-attachments/assets/f082ccab-d9e6-4929-9762-d1935d66112c)

**Sepnuty 2 spínače -> hodnota úhlu 48° -> servo natočeno do poloviny**\
![Image](https://github.com/user-attachments/assets/ca2c3236-e8b3-4b97-a3d9-47d5bc19127e)

**Sepnut levý spínač -> hodnota na binárním vstupu je větší jak 90° -> servo natočeno na maximální hodnotu, neboli 90°**\
![image](https://github.com/user-attachments/assets/a5af292a-2637-41b7-ba3d-2f771a808d0c)

**Sepnuty všechny spínače -> hodnota na binárním vstupu je pořád větší jak 90° -> servo natočeno na maximální hodnotu, neboli 90°**\
![image](https://github.com/user-attachments/assets/f33889f9-4dd4-4979-a1bf-fd7095cfbb49)


## References
https://www.studiopieters.nl/tower-pro-micro-servo-s9-sg90/
