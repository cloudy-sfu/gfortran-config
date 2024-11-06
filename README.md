# Windows `gfortran` setup

Windows batch script to automatically build and run Fortran code in MinGW-w64 `gfortran` environment

![](https://shields.io/badge/dependencies-MinGW--w64-green)
![](https://shields.io/badge/dependencies-CMake-green)
![](https://shields.io/badge/OS-Windows_10_64--bit-lightgrey)

## Usage

Open `build_run.bat`, fill in the following variables.

| Name            | Description                                          | Example                                   |
| --------------- | ---------------------------------------------------- | ----------------------------------------- |
| `mingw_bin_dir` | The path of the folder which contains `gfortran.exe` | `...\mingw64\bin`                         |
| `program_root`  | The root folder of the Fortran program.              | `test1`                                   |
| `cmake_bin_dir` | The path of the folder which contains `cmake.exe`    | `...\cmake-3.31.0-rc3-windows-x86_64\bin` |

*`CMake` is used to automatically analyze dependencies.*

Run `build_run.bat`.
