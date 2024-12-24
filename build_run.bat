@echo off
@REM --------------- USER INPUT BEGIN ---------------
set "mingw_bin_dir="
set "cmake_bin_dir="
@REM --------------- USER INPUT END   ---------------

if not defined mingw_bin_dir (
    echo Error: Variable "mingw_bin_dir" is not defined or is empty.
    exit /b 1
)
if not defined cmake_bin_dir (
    echo Error: Variable "cmake_bin_dir" is not defined or is empty.
    exit /b 1
)
set "program_root=%~1"
if not defined program_root (
    set "program_root=%cd%"
)
set "curdir=%cd%"
cd %program_root%
set "PATH=%mingw_bin_dir%;%PATH%"
set "mingw_gfortran_path=%mingw_bin_dir%\gfortran.exe"
set "mingw_gfortran_path_unix=%mingw_gfortran_path:\=/%"
setlocal enabledelayedexpansion
set "program_name=main"
set "all_scripts_list="
for /R %%f in (*.f90) do (
    set "escaped_path=%%f"
    set "escaped_path=!escaped_path:\=/!"
    set "escaped_path=!escaped_path: =\ !"
    set "all_scripts_list=!all_scripts_list! "!escaped_path!""

    @REM search program name begin
    @REM read the file path in loop variable line by line, and assigns each line to a loop variable.
    for /F "usebackq delims=" %%l in ("%%f") do (
        set "line=%%l"
        @REM set line to the first token before an exclamation mark (!).
        for /F "delims=!" %%a in ("!line!") do set "line=%%a"
        @REM trim any leading or trailing whitespace from line.
        for /F "tokens=*" %%b in ("!line!") do set "line=%%b"
        if not "!line!"=="" (
            for /F "tokens=1,2" %%c in ("!line!") do (
                set "word1=%%c"
                set "word2=%%d"
                if defined word2 (
                    if /I "!word1!"=="program" (
                        set "program_name=!word2!"
                    )
                )
            )
        )
    )
    @REM search program name end
)

del /Q CMakeLists.txt 2>nul
del /Q %program_name%.exe 2>nul
(
    echo cmake_minimum_required^(VERSION 3.29^)
    echo set^(CMAKE_Fortran_COMPILER "%mingw_gfortran_path_unix%"^)
    echo project^(%program_name% Fortran^)
    echo enable_language^(Fortran^)
    echo add_executable^(%program_name%%all_scripts_list%^)
) > CMakeLists.txt

%cmake_bin_dir%\cmake.exe -G "MinGW Makefiles"
%mingw_bin_dir%\mingw32-make.exe

@REM clean cmake and make files
del /Q CMakeCache.txt
del /Q cmake_install.cmake
del /Q CMakeLists.txt
del /Q Makefile
del /Q *.mod
rmdir /Q /S CMakeFiles

echo.
%program_name%

endlocal

cd %curdir%
