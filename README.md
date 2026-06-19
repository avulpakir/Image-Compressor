Assuming:

Your PNG file is named output.png
You saved the script as compress.sh
convert is installed

Run these commands in order:

1. Check ImageMagick is installed
convert --version

If you get "command not found", install it:

sudo apt update
sudo apt install imagemagick
2. Save the script

Create the file:

nano compress.sh

Paste your script, then:

Press Ctrl+O → Enter (save)
Press Ctrl+X (exit)
3. Verify the PNG exists
ls -lh output.png

You should see the file listed.

If not, either move into the correct directory:

cd /path/to/image

or change:

input="output.png"

to the correct filename.

4. Make the script executable
chmod +x compress.sh
5. Run the script
./compress.sh

Expected output:

Success: quality=80 size=145321 bytes
6. Verify the resulting JPEG size
ls -lh output.jpg

or

stat -c%s output.jpg
7. Open the image to inspect quality
xdg-open output.jpg

or

eog output.jpg
If you get "Could not reach target size"

The image is too detailed. Try shrinking dimensions slightly:

convert output.png -resize 85% -strip -quality 85 output.jpg

Then rerun the script.

If you paste:

ls -lh output.png

I can estimate what JPEG quality will likely be needed to get below 150 KB.
