# general project settings
project('stmh7', 'c', 'cpp',
  version : '1.0',
  default_options: ['c_std=c99', 'cpp_std=c++11'],
  meson_version : '>=0.50')

# global variables tracking sources and includes
c_args = []
c_link_args = []
project_src = []
project_inc = []
test_src = []
test_inc = []
link_deps = []

# find external programs from path (OS independant)
size = find_program('arm-none-eabi-size')
objcopy = find_program('arm-none-eabi-objcopy')

# retrieve c and linker arguments for cross compiling
if meson.is_cross_build()
  c_args = meson.get_cross_property('c_cross_args')
  c_link_args = meson.get_cross_property('c_cross_link_args')
endif

# microcontroller options + extra files
defines = [
  '-DUSE_HAL_DRIVER',
  '-DSTM32H743xx',
]

linkerfile = files('config/STM32H743ZITx_FLASH.ld')
startupfile = files('config/startup_stm32h743xx.s')

# add defines to the c_args
c_args += defines

# add the linker script to flags
c_link_args += '-T@0@/@1@'.format(meson.current_source_dir(), linkerfile[0])

# include other meson.build files
subdir('src')

# compile the main executable
main = executable('main',
  [project_src, startupfile],
  name_suffix : 'elf',
  c_args : c_args,
  link_args : [c_link_args, '-Wl,--gc-sections'],
  dependencies : link_deps,
  include_directories : [project_inc] )

# cutom target to always convert main.elf to binary
mainbin = custom_target('main.bin',
  output : 'main.bin',
  build_by_default : true,
  command : [objcopy, ['-O', 'binary', '-S', main.full_path(), 'main.bin']], 
  depends : main )
