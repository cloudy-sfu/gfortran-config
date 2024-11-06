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
set "all_scripts_list="
for /R %%f in (*.f90) do (
    set "all_scripts_list=!all_scripts_list! %%f"

    @REM search program name begin
    for /F "usebackq delims=" %%l in ("%%f") do (
        set "line=%%l"
        for /F "delims=!" %%a in ("!line!") do set "line=%%a"
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

del Makefile 2>nul
(
    for %%L in (
        " FC = gfortran"
        " FFLAGS = -O2"
        " TARGET = !program_name!.exe"
        " SRCS = !all_scripts_list!"
        " OBJS = $(SRCS:.f90=.o)"
        " DEPS = $(SRCS:.f90=.d)"
        "."
        " all: $(TARGET)"
        "."
        " $(TARGET): $(OBJS)"
        " 	$(FC) $(FFLAGS) -o $(TARGET) $(OBJS)"
        "."
        " %%.o: %%.f90"
        " 	$(FC) $(FFLAGS) -c $< -o $@"
        " 	$(FC) -MM $< > $*.d"
        "."
        " -include $(DEPS)"
        "."
        " clean:"
        " 	del /Q $(OBJS) $(DEPS) $(TARGET)"
    ) do (
        echo%%~L
    )
) > Makefile

%mingw_bin_dir%\mingw32-make.exe
@REM %program_name%
endlocal
cd %curdir%
