@echo off
@REM --------------- USER INPUT BEGIN ---------------
set "mingw_bin_dir="
set "program_root="
@REM --------------- USER INPUT END   ---------------

if not defined mingw_bin_dir (
    echo Error: Variable "mingw_bin_dir" is not defined or is empty.
    exit /b 1
)
if not defined program_root (
    echo Error: Variable "program_root" is not defined or is empty.
    exit /b 1
)
set "curdir=%cd%"
cd %program_root%
set "PATH=%mingw_bin_dir%;%PATH%"
set "mingw_gfortran_fn=gfortran.exe"
set "mingw_gfortran_path=%mingw_bin_dir%\%mingw_gfortran_fn%"
setlocal enabledelayedexpansion
set "program_name=main"
for /R %%f in (*.f90) do (
    set "found="
    for /F "usebackq delims=" %%l in ("%%f") do (
        if not defined found (
            set "line=%%l"
            rem Remove comments starting with '!'
            for /F "delims=!" %%a in ("!line!") do set "line=%%a"
            rem Trim leading and trailing spaces
            for /F "tokens=*" %%b in ("!line!") do set "line=%%b"
            if not "!line!"=="" (
                rem Split line into words
                for /F "tokens=1,2" %%c in ("!line!") do (
                    set "word1=%%c"
                    set "word2=%%d"
                    if defined word2 (
                        rem Check if the first word is 'program' (case-insensitive)
                        if /I "!word1!"=="program" (
                            set "program_name=!word2!"
                            set "found=1"
                        ) else if /I "!word1!"=="module" (
                            %mingw_gfortran_path% -c %%f
                        )
                    )
                )
            )
        )
    )
)
%mingw_gfortran_path% *.f90 *.o -o %program_name%
del /Q *.o
del /Q *.mod
%program_name%
endlocal
cd %curdir%
