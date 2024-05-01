# Smart Parking System with Ultrasonic Sensors
**Team members:**
- Jan Obšivač is responsible for creating schema and functional model
- Pavel Misinský is responsible for creating schema and functional model
- Lukáš Michalík is responsible for working on the code
- Ondřej Beránek is responsible for working on the code
## Theoretical description and explanation
The challenge is to develop a system that accurately detects the presence and distance of vehicles in parking spaces using ultrasonic sensors (HS-SR04). The data from these sensors need to be processed to determine parking space availability, which will then be displayed visually using LEDs and numerically on a 7-segment display on the Nexys A7 FPGA board.
## Hardware description of demo application
hand-drawn component wiring diagram
![zapojeni_nakres](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/e17b9082-eb5e-48d2-90bc-48d223a61b78)
1. Pulse generation:
    - The button (BTNC) resets the pulse generator (part of "trigger_instance"), which generates pulses to trigger the ultrasonic sensor.
    - The generator uses a clock (CLK100MHZ) that is divided into the desired frequency (output "clk" of "clock_instance").
2. Emitting the ultrasonic signal:
    - When the generator is started, the sensor emits ultrasonic waves into the space.
3. Reflected signal detection:
    - The sensor also keeps track of the time when these waves are returned back as echoes (input "echo_in" to the "DistanceCalculation" block).
    - The time between sending and receiving the signal is measured, allowing distance calculation. This time is converted to distance based on the speed of sound in air.
4. Distance calculation and display:
    - The calculated distance is then processed and displayed on the seven-segment display and LED
## Software description
![schema](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/dbc87e6d-cc1c-43ba-a0de-394e238cb112)
- ```clock_instance``` - changes clock frekvency
- ```trigger_instance``` - sends out short pulses
- ```driver_instance``` - seven-segment display and LED control
- ```distance_instance``` - solves the echo response and calculates the measured distance
- ```top_level``` - connects the individual components
## Simulations
testbench where the trigger works, but only generates short pulses of 10ns and we need 10us
![TB1](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/3dfdc7b8-fd3a-484f-8e4f-7bcc0ad043a5)

testbench of the clockConvert module, which changes the frequency and the output signal is 10us
![TB2](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/bcab58ba-b9cf-429c-ad50-13a51ca10506)

testbench again of the trigger to which the converted clock is connected and the output of the trigger works again and produces the correct long trigger pulses of 10us
![TB3](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/6aef8f97-3d93-4952-9a33-fdd8293ab495)
## List of components
### Nexys A7 50T - Main component
The Nexys A7-50T board is Digilent's popular development platform, designed primarily for electronics and digital design education and projects. This board is based on an FPGA (Field-Programmable Gate Array) chip from Xilinx, specifically the Artix-7 FPGA model.
![nexys-a7-artix-50t](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/b9445729-dcc6-4188-ad44-b0c76d7a86e5)
### HC-SR04
The HC-SR04 is an ultrasonic sensor with a transmitter and receiver, measuring distances without physical contact using sound waves within a range of two to four centimeters. It's efficient and affordable, making it ideal for battery-powered robots. Emitting ultrasonic signals, it can detect objects up to 13 feet away. It's suitable for various applications like obstacle avoidance and navigation.
![hc-sr04-ultrasonic-sensor-distance-measuring-module-3-3v---5v-compatible-for-arduino-nodemcu-1571976572471-removebg-preview](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/affd5518-7d9f-488a-b47e-fa10a32b3437)
### Arduino Uno
A microcontroller board, the Arduino Uno, is built around the ATmega328 chip. It boasts 14 digital input/output pins, with 6 capable of PWM output, along with 6 analog inputs. Additionally, it includes a 16 MHz ceramic resonator, USB connectivity, a power jack, an ICSP header, and a reset button. In this project, the Arduino Uno is used to supply the necessary 5V power supply for the HC-SR04 ultrasonic sensors.
![59-1_foto-2-removebg-preview](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/0dc996b5-aa50-4e85-822d-718d9cc1dde5)
### Ultrasonic level shifter
A component connected to a non-soldering field that sends a modified voltage from the Arduino Uno to the sensor.

![ultrasonic_level-shifters-removebg-preview](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/c68d6c44-6647-4ff8-9440-bfbe2dc02237)
## Instructions
![IMG_7279](https://github.com/janobsivac/BPC-DE1-parking_system/assets/159461221/29c5c66d-a88f-455d-b63b-23012cf0997b)
Link to video: https://youtube.com/shorts/ET7igXIws9A
## References
- https://github.com/tomas-fryza/vhdl-course/tree/master/lab8-project
- https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual
