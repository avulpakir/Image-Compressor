#!/bin/bash

input="output.png"
output="output.jpg"
target=$((150 * 1024))  # 150 KB

for q in $(seq 95 -5 20); do
    convert "$input" -strip -quality "$q" "$output"
    size=$(stat -c%s "$output")

    if [ "$size" -le "$target" ]; then
        echo "Success: quality=$q size=$size bytes"
        exit 0
    fi
done

echo "Could not reach target size"
