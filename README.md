# `gfortran` config

The script to automatically build and run Fortran code in `gfortran` environment

![](https://shields.io/badge/dependencies-MinGW--w64_|_gfortran-green)
![](https://shields.io/badge/dependencies-CMake-green)
![](https://shields.io/badge/OS-Windows_10_64--bit_|_Ubuntu_22.04_LTS-lightgrey)

## Install

In Windows, the user should assign the installed location of `gfortran` and `cmake`: open `build_run.bat` and fill in the following variables.

| Name            | Description                                          | Example                                   |
| --------------- | ---------------------------------------------------- | ----------------------------------------- |
| `mingw_bin_dir` | The path of the folder which contains `gfortran.exe` | `...\mingw64\bin`                         |
| `cmake_bin_dir` | The path of the folder which contains `cmake.exe`    | `...\cmake-3.31.0-rc3-windows-x86_64\bin` |

*`CMake` is used to automatically analyze dependencies.*

## Usage

### Build & run

Windows:

To build and run Fortran program, run the following command in Windows command prompt (CMD).

```
build_run.bat $folder
```

Ubuntu:

To build and run Fortran program, run the following command in terminal.

```
build_run.sh $folder
```

Arguments:

| Name      | Description                                                 | Required?                                  |
| --------- | ----------------------------------------------------------- | ------------------------------------------ |
| `$folder` | The root directory of the Fortran program to build and run. | *Optional*  default: the current directory |

