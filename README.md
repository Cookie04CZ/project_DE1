# 🗒️Projekt DE1
> [!IMPORTANT]
> *Funkční projekt se nachází ve složce [project_v2](project_v2). Doděláváme ještě lepší user input pro lepší ovládání a přidáme ještě jedno servo a funkčnost na více kanálech.*
# 🙋🏻Team members
**Jan Baňař** - Hlavní programátor, vedoucí skupinky\
**Filip Hojer** - Hlavní programátor,\
**Filip Křivánek** - Pomocný programátor, readme\
**František Kajtár** - Pomocný programátor, readme

# PWM Generator ve VHDL
## 🗨️Popis
Jako projekt do předmětu DE1 jsme se rozhodli pro vytvoření PWM pro řízení servomotoru ve VHDL. Projekt se zaměřuje na návrh a implementaci **PWM (Pulse Width Modulation)** pro **nezávislé** řízení dvou servomotorů. Každé servo je ovládáno samostatně v rozsahu **0-90°** změnou šířky PWM pulzů. Námi vytvořený VHDL kód generuje signál s pevnou periodou a proměnnou délkou pulzu, která určuje požadovanou polohu serva.

Ovládání mezi servama se bude přepínat pomocí spínače. Na dvou sedmisegmentových displejích budeme zobrazovat zvolené servo, jeho aktuální stav a uživatelem zadávaný úhel. Konkrétní ovládání bude vysvětleno [níže](#Instrukce). 

## 🔩Hardware
Pro realizaci a ověření funkčnosti je využíván FPGA vývojový kit Nexys A7-50T. viz. [Instrukce](#Instrukce)\
**Schéma zapojeni**
> <img src="https://github.com/user-attachments/assets/8eee5a3d-383a-4678-bb91-292904599612" width="600px" height="280px">

## 👨🏻‍💻Software
**Schéma, které jsme navrhli před začátkem tvorby projektu**
> ![top_level_final](https://github.com/user-attachments/assets/c306c5c0-3875-416f-96cb-cd0d75f77a18)


**Schéma vygenerované pomocí VIVADO**
> ![image](https://github.com/user-attachments/assets/fcff67d7-281f-4702-8529-4f401baa814f)


## 📊Komponenty a simulace
`top_level.vhd` - TOPLEVEL projektu. Vidíme zde celou funkčnost obou serv. Postupně nastavujeme na obě serva 90° a potvrdíme tlačítkem BTNC. Dále nastavujeme úhel 5° a opět potvrzujeme tlačítkem. Následně resetujeme pravým tlačítkem BTNR a obě serva se nastaví na 0°.
> ![image](https://github.com/user-attachments/assets/0f87b83a-0b2d-4cf7-a2ac-53a2c624c129)

`pwm.vhd` - pwm1, pwm2 - Generuje PWM signál závislý na vstupních parametrech.
> **OBRAZEK SIMULACE**

`buff.vhd` - buff_in - Drží uživatelem nastavené hodnoty úhlu. Až po potvrzení pošle tento úhel do pwm.
> ![Image](https://github.com/user-attachments/assets/f36f3e4c-be09-484a-a2e0-9e6049aaaabf)

`dec2seg.vhd` - decadicToSegment - Využije hodnotu úhlu v decimálním čísle a posune ho do `bin2seg.vhd`. Ovládá jednotlivé číslice.\
> ![image](https://github.com/user-attachments/assets/981d5423-7560-439c-b689-02072d0ab441)


`dec2duty.vhd` - decadicToDuty - Převádní úhel v decimálním čísle na střídu.
![image](https://github.com/user-attachments/assets/f779fdbc-2a86-4a03-9805-76438b7ebb0b)

`sw_input.vhd` - switches_input - Převede binární vstup na úhel.
> ![image](https://github.com/user-attachments/assets/f2b50aee-df39-4c1e-b6bd-56d7212a12fd)


`bin2seg.vhd` - binaryToSegment - Využitý sobor ze cvičení. Ovládá jednotlivé číslice.

`clk_enable.vhd` - Využitý soubor ze cvičení. Hodiny s nastavitelnou frekvencí.

# ❗Instrukce
## Stažení projektu
Celý projekt se nachází [zde](project_v2).

## Ovládání na desce
**Schéma boardy Nexys A7-50T s popisky**
![Component 19](https://github.com/user-attachments/assets/9fc61ad9-ae97-4ec6-9cff-f90249423cd0)
## Popis ovládání
1) Levým spínačem (SW15) vybereme servo, které chceme ovládat. Pozicí nahoře (1. servo), nebo dole (2. servo).
2) Pro nastavení úhlu využíváme 6 spínačů zprava (SW0-6). Hodnota na spínačích se zadává binárně, ovšem na displeji sledujeme aktuální decimální hodnotu zadávaného úhlu v pravé části displeje.
3) Potvrzujeme pravým tlačítkem (BTNR). Aktuální úhel serva vidíme vpravo od čísla určující ovládané servo.
4) Sledujeme natočení serva na potvrzený úhel a změnění aktuální hodnoty na displeji.
5) Pro vyresetování úhlu stiskneme prostřední tlačítko (BTNC). Servo se otočí zpět na pozici 0°.
6) Pro zvolení druhého serva, přepneme spínač do druhé pozice a ovládáme stejnými kroky.

> [!WARNING]
> *Následující obrázky jsou pořízeny při zkoušce základní verze funkčnosti. Je zde pouze jedno servo a neimplementované resetovací a potvrzovací tlačítko. Také zde máme 8 switchů pro zadání úhlu, to jsme ve finálním projektu snížili na 6.*

**Žádný spínač zapnut -> hodnota úhlu 0 -> servo v pozici 0**
> ![Image](https://github.com/user-attachments/assets/f082ccab-d9e6-4929-9762-d1935d66112c)

**Sepnuty 2 spínače -> hodnota úhlu 48° -> servo natočeno do poloviny**
> ![Image](https://github.com/user-attachments/assets/ca2c3236-e8b3-4b97-a3d9-47d5bc19127e)

**Sepnut levý spínač -> hodnota na binárním vstupu je větší jak 90° -> servo natočeno na maximální hodnotu, neboli 90°**
> ![image](https://github.com/user-attachments/assets/a5af292a-2637-41b7-ba3d-2f771a808d0c)

**Sepnuty všechny spínače -> hodnota na binárním vstupu je pořád větší jak 90° -> servo natočeno na maximální hodnotu, neboli 90°**
> ![image](https://github.com/user-attachments/assets/f33889f9-4dd4-4979-a1bf-fd7095cfbb49)


## References
1. https://www.kjell.com/globalassets/mediaassets/701916_87897_datasheet_en.pdf?ref=4287817A7A
2. https://www.studiopieters.nl/tower-pro-micro-servo-s9-sg90/
3. https://www.edaplayground.com/

