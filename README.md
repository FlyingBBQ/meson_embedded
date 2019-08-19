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
        1. [Docker](#docker)
1. [Usage](#usage)
    1. [Building](#building)
    1. [Debugging](#debugging)
    1. [Testing](#testing)
    1. [Subprojects](#subprojects)
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
* Cross-platform support (Linux/Windows)
* Easy integration of submodules or third-party software
* Includes tools for testing and analyzing code
* Wel documented

Features:
- [x] Cross-compiling
- [x] Unit testing framework
- [ ] Code coverage
- [ ] Static code analysis
- [x] Documentation with doxygen
- [ ] Auto-formatting code
- [x] Dockerfile for dependencies
- [ ] Jenkinsfile

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

Doxygen
```
sudo apt-get install doxygen graphiz
```

Debugging
```
sudo apt-get install gdb-arm-none-eabi openocd
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

#### Windows

1. The easiest way to intall Meson and Ninja on windows is by using the [MSI installer](https://github.com/mesonbuild/meson/releases)

1. A native compiler is needed to compile the test framework for the build machine (Windows). The Choice is either MinGW or Cygwin.

    * The MinGW installer can be downloaded from [here](https://osdn.net/projects/mingw/releases/). Use the MinGW setup to download at least the `mingw-base` and the `ming-pthread` library. Make sure to add [MinGW](http://mingw.org/wiki/Getting_Started) to your system path.

    * Cygwin...

1. The [GNU Arm Embedded toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads) can be downloaded from arm (win32-sha2 is recommended).
Check the box to add the toolchain to your path!

1. [Doxygen](http://www.doxygen.nl/download.html) can be downloaded from the official website.
Check the box to add Doxygen to your path!

    * In order to generate graphs with Doxygen, [Graphiz](https://graphviz.gitlab.io/download/) is needed.

1. Download [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) from ST (make an account in case you do not have one).

1. To debug your code OpenOCD is needed. [Download](https://github.com/gnu-mcu-eclipse/openocd/releases) the latest release (win32.zip recommended) and make sure to add the `bin` directory, containing the `openocd.exe`, to your path. For more information see [Debugging](#debugging).

**[Back to top](#table-of-contents)**

#### Docker

The complete build environment can also be build as Docker container.
This drastically reduces setup time for the build environment as the only dependency needed is Docker.
It is assumed Docker is already installed on your system.

To build and run the container:
```bash
cd <project_root>

# build the container from config/Dockerfile with the name "build_env"
docker build config/ -t build_env

# run the container and mount the <project_root> dir to /code
docker run -it -v $(pwd):/code build_env bash
```
You can now run meson and ninja from this container where your project can be found in the `/code` directory.

**[Back to top](#table-of-contents)**

## Usage

### Building

After cloning this project and installing the dependencies, it's time to build the project.
Meson only works from the Terminal / Command Line, which keeps usage on both Windows and Linux the same.

Start by navigating to the root directory of this project:
```
cd <root_directory>
```

Before you can compile your code, Meson needs to configure the project based on your system.
The syntax to do this looks as follows:
```
meson <source_dir> <build_dir> [options]
```

As an example, have a look at the command found in `build.sh`:
```
meson . build/debug --cross-file config/cross_linux.txt --buildtype=debugoptimized
```
This command will take the current directory `.` as source directory, which is the default if no source directory is given.
It will configure the project in the build directory `build/debug`.
The project will be cross-compiled with the `config/cross_linux.txt` file, which contains all the compiler settings for the GNU Arm Embedded toolchain.
The last option configures the [compiler optimization](https://mesonbuild.com/Builtin-options.html#core-options) for this project, which is `debugoptimized`.
It is strongly advised to always configure a new build directory when changing cross-compile or optimization settings. for example:
```
meson build/release --buildtype=release
```

After Meson has configured the project successfully, navigate to the build directory.
```
cd build/debug
```

From here, we can run Ninja to compile our code, similar to GNU Make:
```
ninja
ninja clean
```

Additional Ninja commands can be added by using [`run_target`](https://mesonbuild.com/Run-targets.html#page-description) from Meson.
```bash
ninja size
ninja flash  # if STM32CubeProgrammer is installed and added to path
```

**[Back to top](#table-of-contents)**

### Debugging

Writing good unit tests and using simple `printf()` over UART should catch 90% of your bugs.
The debugger should always be your last line of defence.
This sections describes how to debug your code using [VScode](https://code.visualstudio.com/) as graphical frontend.

Reasons to use VScode over, for example, IDE's like Eclipse:
* It's a simple text editor, no bloat
* Awesome extensions
* Integrates easily with external tools
* Can configure it as a full IDE

#### Windows

Assuming you have VScode, the GNU Arm Embedded toolchain, and OpenOCD installed, the following configuration is needed:

1. Open VScode and open the root folder of your Meson project
1. Install the `Cortex-Debug` extension
1. Go to _Debug > Add Configuration_ and pick _Cortex Debug: OpenOCD_
1. Make the configuration the following:
```json
   {
       "name": "Cortex Debug",
       "cwd": "${workspaceRoot}",
       "executable": "${workspaceRoot}/build/debug/main.elf",
       "request": "attach",
       "type": "cortex-debug",
       "servertype": "openocd",
       "configFiles": [
           "interface/stlink.cfg",
           "target/stm32h7x.cfg"
       ]
   }
```
Where `executable` and `configFiles` should match your board and `.elf`
You can find the available `.cfg` configFiles in the location where you installed OpenOCD in the _scripts_ directory.

Run the debugger!

#### Linux

The VScode debugging instructions for Windows are identical for Linux, since VScode is cross platform.
Debugging from the command line is also possible with the following commands:

1. Open a terminal and run `openocd -f interface/stlink.cfg -f target/stm32h7x.cfg -c "init"`
1. Open a new terminal, and `cd` to the directory of your `.elf`
1. run `arm-none-eabi-gdb` then:
    * `target remote localhost:3333`
    * `file <yourfile.elf>`
    * `monitor arm semihosting enable`
    * `monitor reset halt`
1. From this point you can set breakpoints, and step through your code.

Of course typing these commands every time is quite cumbersome.
Since we are on linux we can automate this with a simple shell script like:
```bash
#!/bin/sh

arm-none-eabi-gdb --eval-command="target remote localhost:3333" $1 \
                  --eval-command="monitor arm semihosting enable" \
                  --eval-command="monitor reset halt"
```
Let's assume this script is called `debug.sh`.
You could then run `debug.sh <yourfile.elf>` and start debugging!

**[Back to top](#table-of-contents)**

### Testing

The current test framework is CppUTest, a C++ unit testing framework desinged for embedded systems.
It was added as a `git subtree` as we will only pull from this repository.
If we would like to push as well, it should be added as `submodule`.
Adding the test repository was done with the following command:
```
git subtree add --prefix test/framework https://github.com/onqtam/doctest.git master --squash
```
Updating the test framework is simply done by using the same command, but this time a pull:
```
git subtree pull --prefix test/framework https://github.com/onqtam/doctest.git master --squash
```

Running the test can be done directly with Ninja:
```
ninja test
```

**[Back to top](#table-of-contents)**

### Subprojects

It is not easy to see which parts of the project are git subtrees.
The built-in solution Meson offers for this are **subprojects**; which can be included either from files or git repositories by using a [wrap-file](https://mesonbuild.com/Wrap-dependency-system-manual.html).

This does require the subproject to have a `meson.build` file.

**[Back to top](#table-of-contents)**

## Additional Information

Building a Test Framework as subproject in Meson:
[https://github.com/mesonbuild/meson/issues/4605#issuecomment-519918511](https://github.com/mesonbuild/meson/issues/4605#issuecomment-519918511)

Another good option for adding a Test Framework is to use it as a subproject that you build with a native configuration.
You could then install the Test Framework libraries, and search for them from other projects.
For example:
```
if not meson.is_cross_build()
    install test libraries
endif
```
Then build and install them with a non cross-build: `meson build/testframework`.
From your cross-builds you just search for the depencencies: `test_framework = dependency(test_libs)`.

**[Back to top](#table-of-contents)**
