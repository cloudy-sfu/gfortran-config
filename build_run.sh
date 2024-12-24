#!/bin/bash
# OS: Ubuntu 22.04 LTS

# user input
program_root="${1:-$(pwd)}"

# check gfortran
if ! command -v gfortran &> /dev/null; then
    sudo apt update
    sudo apt install build-essential gfortran
fi

# check cmake
if ! command -v cmake &> /dev/null; then
    sudo apt update
    sudo apt install build-essential cmake
fi

curdir=$(pwd)
cd "$program_root"

all_scripts_list=$(find . -type f -name "*.f90" | sed 's/ /\\ /g')
program_name="main"
# Loop through all .f90 files recursively
for f in $all_scripts_list; do
    # Read each line in the file
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Remove any text after an exclamation mark (comment in Fortran)
        line="${line%%!*}"
        # Trim leading and trailing whitespace
        line=$(echo "$line" | xargs)
        # Check if the line is not empty
        if [[ -n "$line" ]]; then
            # Read the first two words of the line
            read -r word1 word2 <<< "$line"
            # If the first word is "program", capture the second word as program name
            word1_lower=$(echo "$word1" | tr '[:upper:]' '[:lower:]')
            if [[ "$word1_lower" == "program" && -n "$word2" ]]; then
                program_name="$word2"
            fi
        fi
    done < "$f"
done

rm -f CMakeLists.txt
rm -f $program_name
cat << EOF > CMakeLists.txt
cmake_minimum_required(VERSION 3.22)
set(CMAKE_Fortran_COMPILER gfortran)
project($program_name Fortran)
enable_language(Fortran)
add_executable($program_name$(printf " \"%s\"" $all_scripts_list))
EOF

cmake .
make

# clean cmake and make files
rm -f CMakeLists.txt CMakeCache.txt cmake_install.cmake Makefile *.mod
rm -rf CMakeFiles

echo ""
./$program_name

cd $curdir
