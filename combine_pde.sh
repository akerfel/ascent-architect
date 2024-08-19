#!/bin/bash

# Name of the output file
output_file="combined.pde"

# Clear the output file if it already exists
> "$output_file"

# Loop through all .pde files in the current directory
for file in *.pde; do
    if [[ -f "$file" ]]; then
        # Add the file name as a comment to the output file
        echo "// $file" >> "$output_file"
        # Append the contents of the file to the output file
        cat "$file" >> "$output_file"
        # Add a new line to separate contents from different files
        echo -e "\n" >> "$output_file"
    fi
done

echo "All .pde files have been combined into $output_file."