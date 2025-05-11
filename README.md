# `gfortran` config

The script to automatically build and run Fortran code in `gfortran` environment

![](https://shields.io/badge/dependencies-MinGW--w64_|_gfortran-green)
![](https://shields.io/badge/dependencies-CMake-green)
![](https://shields.io/badge/OS-Ubuntu_22.04_LTS-orange)

## Usage

### Build & run

To build and run Fortran program, run the following command in terminal.

```
build_run.sh $folder
```

Arguments:

| Name      | Description                                                 | Required?                                  |
| --------- | ----------------------------------------------------------- | ------------------------------------------ |
| `$folder` | The root directory of the Fortran program to build and run. | *Optional*  default: the current directory |

