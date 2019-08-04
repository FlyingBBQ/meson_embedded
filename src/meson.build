project_inc = [
  include_directories('application'),
  include_directories('BSP'),
  include_directories('drivers/CMSIS/Include'),
  include_directories('drivers/CMSIS/Device/ST/STM32H7xx/Include'),
  include_directories('drivers/STM32H7xx_HAL_Driver/Inc'),
  include_directories('drivers/STM32H7xx_HAL_Driver/Inc/Legacy'),
  include_directories('middlewares/FreeRTOS/Source/include'),
  include_directories('middlewares/FreeRTOS/Source/CMSIS_RTOS_V2'),
  include_directories('middlewares/FreeRTOS/Source/portable/GCC/ARM_CM4F'),
]

subdir('application') 
subdir('BSP') 
subdir('drivers') 
subdir('middlewares') 

project_src += application_src
project_src += bsp_src
project_src += drivers_src
project_src += middlewares_src
