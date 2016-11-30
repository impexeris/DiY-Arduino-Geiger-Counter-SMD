For easier readability schematics is divided to five functional parts:

- Power supply
- High Voltage Generator
- Detector
- Microcontroller and LCD
- LCD contrast and brightness controls

Colour coding

Colour coding is used in schematics to highlight certain nets:
Red 	- input power DC (6.5V to 15V)
Rose 	- +5V (VDD) - primary positive working power 	  voltage of the device
Blue	- Ground (GND)
Green	- all other nets of the device

Net connections

Some of net connections are shown as arrows with definition of the net to which they connect. I.e. blue arrow with GND means that it is connected to Ground net.

The wide green line is a buss-connection it assumes many separate connections within itself. Every connection at “entrance/exit” to the buss is labeled so for example D2 “entrance/exit”in the Detector part of schematics is connected to D2 in the Microcontroller and LCD part of the schematics. The light green circle with a uC label above simply denotes the buss connection between different sheets of the schematics.

It should be noted that one connection called “Detector input” does not have any arrows but nevertheless means that this net in the Detector part of the schematics is joined with the “Detector input” net of the High Voltage Generator part of the schematics.


Power supply

Main component of the power supply is a linear 5V regulator which is used to step down the voltage from a 9V battery or alternatively 6.5V to 15V DC power source to 5V DC which is the primary working voltage of the whole design.

The input is limited to max 15V because of the max. 16V rating of the used input capacitor C7.

C(U2) and C(U3) are filter capacitors for U2 and U3 chips correspondingly and though they are displayed in this part o the schematics, they are placed close to power pins of chips they are serving.

s7, s8 and s9 are PCB-pad-jumpers where s7 and s9 are both closed and s8 by default open.

These jumpers are useful if instead of 6.5V to 15V DC  powering from a regulated 5V power source is intended.
In example:

- if your use assumes permanent connection to a power-source and there is a suitable 5V DC regulated power available.
- if a portable 5V DC power solution is available. For example a rechargeable or non-rechargable lower voltage battery(-ies) with a step-up converter will be used. 

If step-down from hither DC voltage to 5V and regulation is not required it is reasonable to bypass the installed 78L05 regulator. It simplifies powering of the device and provides battery power saving which, though rather small, is always a positive thing for a portable device.

Too bypass the 78L05 regulator the s7 and s9 should be cut-open and s8 should be soldered-close 