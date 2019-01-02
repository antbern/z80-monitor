# Z80 Monitor

This is the code for my Z80 monitor program, running on my homemade Z80 breadboard computer. It currently has the following features:

* Dumping memmory contents
* Reset (Cold/Warm)
* Breaking into the monitor using a ``rst 30H`` breakpoint instruction
* Viewing the register contents at the time of breaking
* Exiting the monitor and continuing execution

As of now, there is no way of loading and executing code other than the monitor. Testing the break functionallity thus involves breaking out of the monitor into the monitor (...) and checking the register values.

The assembly code is compiled using a custom Makefile and a windows version of TASM (Telemark Assembler). The compiled binary is then uploaded to the Z80 using a custom Java program to an Arduino Nano acting as a programmer and bus supervisor.

Communication with the PC (other than uploading code) is handled by the SIO/2 serial interface chip and a simple USB-to-Serial bridge.

Here is a (short!) list of what features I'd like to implmement in the future

* CF-card interface and functions to read and write to the card
* A way to load and execute programs from my PC, possibly using the SIO serial chip