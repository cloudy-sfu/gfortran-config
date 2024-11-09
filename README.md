# `gfortran` config

The script to automatically build and run Fortran code in `gfortran` environment

## Usage

### Windows

![](https://shields.io/badge/dependencies-MinGW--w64-green)
![](https://shields.io/badge/dependencies-CMake-green)
![](https://shields.io/badge/OS-Windows_10_64--bit-lightgrey)

Open `build_run.bat`, fill in the following variables.

| Name            | Description                                          | Example                                   |
| --------------- | ---------------------------------------------------- | ----------------------------------------- |
| `mingw_bin_dir` | The path of the folder which contains `gfortran.exe` | `...\mingw64\bin`                         |
| `program_root`  | The root folder of the Fortran program.              | `test1`                                   |
| `cmake_bin_dir` | The path of the folder which contains `cmake.exe`    | `...\cmake-3.31.0-rc3-windows-x86_64\bin` |

*`CMake` is used to automatically analyze dependencies.*

Run `build_run.bat`.

### Ubuntu 22.04 LTS

![](https://shields.io/badge/dependencies-gcc-green)
![](https://shields.io/badge/dependencies-gfortran-green)
![](https://shields.io/badge/dependencies-cmake-green)
![](https://shields.io/badge/OS-Ubuntu_22.04_LTS-lightgrey)

To build and run Fortran program, run the following command with an optional `folder` argument.

```bash
bash build_run.sh [folder]
```

The argument `folder` is the root folder of Fortran program. If no argument is provided, the target is the current directory by default.
