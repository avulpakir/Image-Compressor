# Convert PNG to JPEG Under 150 KB (Linux CLI)

## Prerequisites

Install ImageMagick:

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install imagemagick
```

### Fedora

```bash
sudo dnf install imagemagick
```

### Arch Linux

```bash
sudo pacman -S imagemagick
```

Verify installation:

```bash
convert --version
```

---

## Create the Compression Script

Create a file named `compress.sh`:

```bash
nano compress.sh
```

Paste the following content:

```bash
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
```

Save and exit:

* `Ctrl + O`, then `Enter`
* `Ctrl + X`

---

## Verify the PNG File Exists

```bash
ls -lh output.png
```

If the file has a different name, update the `input` variable in the script.

---

## Make the Script Executable

```bash
chmod +x compress.sh
```

---

## Run the Script

```bash
./compress.sh
```

Example output:

```text
Success: quality=80 size=145321 bytes
```

---

## Verify the Output File Size

Human-readable size:

```bash
ls -lh output.jpg
```

Size in bytes:

```bash
stat -c%s output.jpg
```

---

## View the Result

```bash
xdg-open output.jpg
```

or

```bash
eog output.jpg
```

---

## Troubleshooting

### `convert: command not found`

Install ImageMagick and verify:

```bash
convert --version
```

### `stat: cannot stat 'output.jpg'`

The conversion failed before the JPEG was created. Check:

```bash
ls -lh output.png
```

and verify that the input file exists.

### Output is Still Larger Than 150 KB

Reduce image dimensions slightly:

```bash
convert output.png -resize 85% -strip -quality 85 output.jpg
```

Then rerun the script:

```bash
./compress.sh
```
