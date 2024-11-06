#!/bin/bash

# Check if a file location was provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file-location>"
    exit 1
fi

# Get the file location from the input argument
FILE_LOCATION=$1

# Compile the C program
gcc -lm -std=c99 -o simulate lc3bsim3.c
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

# Convert the file to Unix format
dos2unix $FILE_LOCATION
if [ $? -ne 0 ]; then
    echo "dos2unix conversion failed."
    exit 1
fi

# Assemble the input file
./assembler.linux $FILE_LOCATION ${FILE_LOCATION%.asm}.obj
if [ $? -ne 0 ]; then
    echo "Assembler failed."
    exit 1
fi

# Run the simulation
./simulate ucode3 ${FILE_LOCATION%.asm}.obj
if [ $? -ne 0 ]; then
    echo "Simulation failed."
    exit 1
fi

echo "Process completed successfully."


