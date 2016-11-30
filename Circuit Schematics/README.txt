Description

For easier readability schematics is divided into five functional parts:

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

The wide green line is a buss-connection it assumes many separate connections within itself. Every connection at “entrance/exit” to the buss is labeled. So for example D2 “entrance/exit” in the Detector part of schematics is connected to D2 in the Microcontroller and LCD part of the schematics.
The light green circle with a uC label above simply denotes the buss connection between different sheets of the schematics.

One connection called “Detector input” in the Detector part of the schematics does not have any arrows. Nevertheless this net in the Detector part of the schematics is joined with the “Detector input” net of the High Voltage Generator part of the schematics.

Power supply

Main component of the power supply is a linear 5V regulator which is used to step down the voltage from a 9V battery or alternatively 6.5V to 15V DC power source to 5V DC which is the primary working voltage of the whole design.

The input is limited to max 15V because of the max. 16V rating of the used input capacitor C7.

C(U2) and C(U3) are filter capacitors for U2 and U3 chips correspondingly and though they are displayed in this part o the schematics, they are placed close to power pins of chips they are serving.

s5, s7, s8 and s9 are PCB-pad-jumpers where s5, s7 and s9 are closed and s8 by default open.

These jumpers are useful if instead of 6.5V to 15V DC  powering from a regulated 5V power source is intended.
In example:

- if your use assumes permanent connection to a power-source and there is a suitable 5V DC regulated power available.
- if a portable 5V DC power solution is available. For example a rechargeable or non-rechargeable lower voltage battery(-ies) with a step-up converter will be used. 

If step-down from hither DC voltage to 5V and regulation is not required it is reasonable to bypass the installed 78L05 regulator. It simplifies powering of the device and provides battery power saving which, though rather small, is always a positive thing for a portable device.

Too bypass the 78L05 regulator the s5, s7 and s9 should be cut-open and s8 should be soldered-close.

Jumper J6 is introduced for future use - add-on boards to facilitate single battery/or DC power supply connection to a composite device. 

High Voltage Generator

This part of the schematics generates High Voltage at very low power which is necessary for Geiger-Müller tube operation. The generated Voltage can be adjusted between < than 150V and more > than 1KV (1000V) by turning the knob of the multi-turn potentiometer (trimmer) counter -clockwise.

When the maximum possible generated voltage is reached and potentiometer is further counter-clockwise adjusted, then the voltage shall start to drop. It is a normal situation. To get back to working state of the HV generator the knob of the potentiometer has to be turned clockwise and the HV generation shall resume.

It should be noted that High Voltage can only measured with a high impedance Voltmeter (a voltmeter which has high internal resistance. >1 Giga Ohm). Otherwise readings shall be incorrectly low. Practically all popular voltmeters have resistance ranging from 5MΩ to 10MΩ and are not suitable for proper measurements in this case. 
One of the possible solutions is  to do a measurement by connecting a 1 GΩ  resistor in series to such low impedance voltmeter and then recalculating the correct voltage according to the formula: Vactual = Vread x ((Rmeter + Rprobe) / Rmeter).
Where:
- Vactual is the actual measured voltage
- Vread is the voltage reading on the voltmeter display
- Rmeter is the internal resistance of the voltmeter (5MΩ to 10MΩ)

R7 reistor is an anode resistor for the Geiger-Müller tube. The 5.1M is a recommended value for most popular low voltage Geiger-Müller tubes produced in Russia/Ukraine.
Such are for example all modifications or sbm-20, si29bg, sbt9 or sbt11.
For some other tubes the value of this resistor has to be around 10MΩ. For example LND 712, LND 7317, SBT10 and si8B.

Generally the higher the anode resistor the lower current goes through the tube but pulses produced are longer. When anode resistor is lower pulses are shorter but the tube wear increases. So in addition to the specification recommendations for a particular tube (this value is either explicitly defined or can be calculated from the specified recommended working current and voltage) there has to be a compromise sought when choosing this resistor. As a rule of thumb for the “low working voltage” Geiger-Müller tubes (“low” here means up to 1KV)  the value should stay within 4.7MΩ to 20MΩ.

Detector part

This part of the device receives (detects) pulses coming from the Geiger-Müller tube on the voltage divider formed by R8 and R9. The pulse polarity is then inverted and amplified by Q3.
Further pulse is shaped and limited for the micro-controller input by C10 and by the rest of the schematics for visual/audible detection indication.

PCB-pad-jumpeers s10 and s4 are generally not used but provides a possibility of more convenient hardware disconnect of the detector from micro-controller input and separation of the “analog” audible indication circuit from the micro-controller.






