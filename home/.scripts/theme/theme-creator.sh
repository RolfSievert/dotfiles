#! /bin/sh
#
# Create Theme
#   - select image
#   - name theme
#   - create theme folder under ~/Media/Themes/ and copy image to there
#   - test & select colorscheme(s)
#   - copy selected colorschemes to theme folder

THEMES_FOLDER="$HOME/Media/Themes/"
SCRIPTS_FOLDER="$HOME/.scripts/"

# select image
IMG_FOLD=$($SCRIPTS_FOLDER/select-folder-prompt.sh $HOME "Select folder to search for images")
IMAGE=$($SCRIPTS_FOLDER/background-tester.sh "$IMG_FOLD")
IMAGE=$(basename -- "$IMAGE")

if [ -z "$IMAGE" ]; then
    exit
fi

IMAGE_PATH="${IMG_FOLD}/${IMAGE}"
echo Selected "$IMAGE_PATH"

# name theme
THEME_NAME=$(rofi -i -dmenu -p "Enter theme name")
echo Named theme: "$THEME_NAME"
THEME_PATH="${THEMES_FOLDER}${THEME_NAME}"

if [ -z "$THEME_NAME" ]; then
    exit
fi

# create folder and copy image to there
if [ ! -d "$THEME_PATH" ]; then
    mkdir "$THEME_PATH"
fi
cp "$IMAGE_PATH" "$THEME_PATH"

# select colorschemes and symlink to folder
COLORSCHEMES=($($SCRIPTS_FOLDER/colorscheme-selector.sh))
echo Selected themes:
for c in "${COLORSCHEMES[@]}"; do
    echo " - $c"
    ln -s "$c" "$THEME_PATH"
done

# TODO save names of colorschemes to colorschemes.txt under current theme
