#!/bin/bash

/home/derek/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI -c port=SWD -w ./build/main.bin 0x8000000
