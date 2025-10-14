#!/bin/sh

# 1. Define the directory to search for images.
#    Change "~/Pictures" to your desired folder.
IMAGE_DIR=~/Imagens

# 2. Define your preferred Wayland-native image viewer.
#    Examples: imv, swayimg, loupe, geeqie, etc.
VIEWER=imv

# 3. Find image files, pipe them to fuzzel for selection.
#    - The `find` command searches recursively.
#    - `-type f` ensures we only get files, not directories.
#    - The `\( ... \)` block with `-o` (OR) finds common image extensions.
#    - `fuzzel -d` runs it in dmenu mode, reading from stdin.
selected_file=$(find "$IMAGE_DIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.gif" -o \
    -iname "*.webp" -o \
    -iname "*.avif" \
\) | fuzzel --dmenu --prompt '📷 View Image: ')

# 4. If a file was selected (i.e., the user didn't press Esc),
#    open it with the viewer.
if [ -n "$selected_file" ]; then
    # The `nohup ... &` part runs the viewer in the background
    # so it doesn't block your terminal or the script.
    nohup "$VIEWER" "$selected_file" >/dev/null 2>&1 &
fi
