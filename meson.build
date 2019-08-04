# general project settings
project('stmh7', 'c', 'cpp',
        version : '1.0',
        default_options: ['c_std=c99', 'cpp_std=c++11'],
        meson_version : '>=0.5')

# global variables tracking sources and includes
project_src = []
project_inc = []
test_src = []
test_inc = []

# microcontroller options
defines = [
  '-DUSE_HAL_DRIVER',
  '-DSTM32H743xx',
]

linkerfile = files('config/STM32H743ZITx_FLASH.ld')
startupfile = files('config/startup_stm32h743xx.s')

# include other meson.build files
subdir('src')

main = executable(
            'main',
            [srcs, stm32cube_srcs, 'main.c', startupfile] ,
            name_suffix         : 'elf',
            c_args              : [c_args ],
            link_args           : [link_args, '-Wl,--gc-sections'],
            dependencies        : link_deps,
            include_directories : [incdirs, stm32cube_incdirs] )
