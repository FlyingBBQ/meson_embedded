# Build system for Embedded projects

This project offers a complete build environment using [Meson](https://mesonbuild.com/index.html), specifically for C/C++ projects in embedded systems.
Using this project should make it easy to cross-compile on different platforms, with minimal effort to build and test your code.

## Table of Contents

1. [About](#about)
1. [Status](#status)
1. [Getting Started](#getting-started)
    1. [Dependencies](#dependencies)
    1. [Installation](#installation)
        1. [Linux](#linux)
        1. [Windows](#windows)
1. [Usage](#usage)
    1. [Building](#building)
    1. [Testing](#testing)
1. [Additional information](#additional-information)

## About

This project acts as an example/guide to build stm32 with [Meson](https://mesonbuild.com/index.html).
Meson is a modern build system, based on python, which uses [Ninja](https://ninja-build.org) as backend.
The reason for using Meson is because it's fast, multi-platform, supports cross-compiling, and is easy to maintain because of its good documentation.
In addition to Meson, this project uses [Doxygen](www.doxygen.nl) for automatic documentation generation, and [CppUTest](https://cpputest.github.io/manual.html) as unit test framework.

Other build systems that have been evaluated are CMake and Make.
CMake lacks documentation and good examples. 
The syntax is not intuitive, especially before modern CMake 3.0.
Make is still a powerfull tool, but implementing non-recursive Make for large projects, especially with multiple targets, becomes complex, and maintaining it is a nightmare.

Goals of this project:
* Build speed is king
* Configuring and maintaining the build system should take minimal time
* Cross-platform support (windows/linux)
* Cross-compiling
* Easy integration of submodules or third-party software
* Includes unit test framework
* Documentation with doxygen
* Auto-formatting code

**[Back to top](#table-of-contents)**

## Getting Started

This sections describes how to get started with this project by installing the right dependencies.
Since Meson supports multiple platforms, some subsections contain instructions for both Linux(recommended) and Windows.

If you have git installed, start with cloning this repository:
```
git clone https://github.com/FlyingBBQ/stm32_meson.git
```

**[Back to top](#table-of-contents)**

### Dependencies

The project has the following dependencies:
* Meson
* Ninja
* GNU Arm Embedded toolchain
* Doxygen

Optional for debugging and flashing
* gdb
* openocd
* STM32CubeProgrammer

**[Back to top](#table-of-contents)**

### Installation

In this section the installation of the dependencies is explained for both Linux and Windows

#### Linux

**For Arch based systems:**

Meson and Ninja
```
sudo pacman -S meson ninja
```

GNU Arm Embedded toolchain
```
sudo pacman -S arm-none-eabi-binutils arm-none-eabi-gcc arm-none-eabi-newlib
```

Doxygen
```
sudo pacman -S doxygen graphiz
```

Debugging
```
sudo pacman -S arm-none-eabi-gdb openocd
```

**For APT based systems:**

Meson and Ninja
```
sudo apt-get install python3 python3-pip python3-setuptools \
                       python3-wheel ninja-build
```
Then install Meson with pip
```
pip3 install --user meson
```

GNU Arm Embedded toolchain
```
sudo apt-get install gcc-arm-none-eabi binutils-arm-none-eabi
```

Debugging
```
sudo apt-get install gdb-arm-none-eabi openocd
```

Doxygen
```
sudo apt-get install doxygen graphiz
```

**Intalling STM32CubeProgrammer:**
Download [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) from ST (make an account in case you do not have one).
```
unzip en.stm32cubeprog.zip -d <destination_dir>
```

Run the installer
```
./SetupSTM32CubeProgrammer-2.1.0.linux
```

**[Back to top](#table-of-contents)**

### Windows

The easiest way to intall Meson and Ninja on windows is by using the MSI installer:
[MSI installer](https://github.com/mesonbuild/meson/releases)

The GNU Arm Embedded toolchain can be downloaded from arm (win32-sha2 is recommended):
[GNU Arm Embedded toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads)
Check the box to add the toolchain to your path!

Doxygen can be downloaded from the official website:
[Doxygen](http://www.doxygen.nl/download.html)
Check the box to add Doxygen to your path!

In order to generate graphs with Doxygen, graphiz is needed, which can be downloaded from here:
[Graphiz](https://graphviz.gitlab.io/download/)

Download [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) from ST (make an account in case you do not have one).

**[Back to top](#table-of-contents)**

## Testing

The current test framework is Doctest, a single header C++ unit testing framework. ~~It was added as a `git subtree` as we will only pull from this repository. If we would like to push as well, it should be added as `submodule`. Adding the test repository was done with the following command:~~
```
git subtree add --prefix test/framework https://github.com/onqtam/doctest.git master --squash
```
~~Updating the test framework is simply done by using the same command, but this time a pull:~~
```
git subtree pull --prefix test/framework https://github.com/onqtam/doctest.git master --squash
```
It is not easy to see which parts of the project are git subtrees. Doctest does come with its own `meson.build` file. Additionally, meson has built-in support for including subprojects; either from files or git repositories by using a [wrap-file](https://mesonbuild.com/Wrap-dependency-system-manual.html).
If testing is enabled from the `meson_options.txt`, doctest is automatically pulled from git and included in the project. Test can easily be added by adding the sources to the `test_src` object in `meson.build` files.
To run the test, simply use:
```
ninja test
```

