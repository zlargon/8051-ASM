8051 ASM Programming
============

Jimmy Lee 8051 course in July

### Create µVision Project

1. Project > New µVision Project...

2. Select `Atmel` > `AT89S51` > OK > NO

   ```
   8051 based Full Static CMOS controller with Three-Level Program
   Memory Lock, 32 I/O lines, 2 Timers/Counters, 6 Interrupts Sources,
   Watchdog Timer, 2 DPTRs 4K Flash, 128 Bytes On-chip RAM
   ```

3. File > New... > Save File (Ctrl + s) > `xxx.ASM`

   ```
   Target 1
   └── Source Group 1 > click right mouse > Add Existing Files to Group 'Source Group 1'... > select "xxx.ASM" > Add > Close
   ```

4. Click icon `Target Options...` > Output > choose `Create HEX File`
