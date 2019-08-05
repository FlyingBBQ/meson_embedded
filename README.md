#Meson build system for stm32

This project acts as an example/guide to build stm32 with Meson. The reason to use Meson is because of its good documentation, maintainability (readability), and cross platform support. What could be improved is IDE integration.

Other build systems that have been evaluated are CMake and Make. CMake lacks documentation and good examples. The syntax is not intuitive, especially before modern CMake 3.0. Make is still a powerfull tool, but implementing non-recursive Make for large projects, especially with multiple targets, becomes complex, and maintaining is a nightmare.

Goals of this project:
* Build speed is king
* Configuring and maintaining the build system should take minimal time
* Cross-platform
* Easy integration of submodules or third-party software
* Includes test framework
* Documentation with doxygen
* Auto-formatting code

##Installing

This project has the following dependencies:
* Meson
* Ninja
* GNU Arm Embedded toolchain
* Doxygen

###Linux

###Windows
