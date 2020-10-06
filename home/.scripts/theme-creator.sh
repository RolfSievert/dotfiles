#! /bin/sh
#
# Create Theme
#   - select image
#   - name theme
#   - create theme folder under ~/Media/Themes/ and copy image to there
#   - test & select colorscheme(s)
#   - copy selected colorschemes to theme folder

THEMES_FOLDER="$HOME/Media/Themes/"

# select image
IMG_FOLD=`$HOME/.scripts/select-folder-prompt.sh $HOME`
IMAGE=$(~/.scripts/background-tester.sh "$IMG_FOLD")
IMAGE=$(basename -- "$IMAGE")

IMAGE_PATH="${IMG_FOLD}/${IMAGE}"
echo Selected "$IMAGE_PATH"

# name theme
THEME_NAME=$(rofi -i -dmenu -p "Enter theme name")
echo Named theme: "$THEME_NAME"
THEME_PATH="${THEMES_FOLDER}${THEME_NAME}"

# create folder and copy image to there
if [ ! -d "$THEME_PATH" ]; then
    mkdir "$THEME_PATH"
fi
cp "$IMAGE_PATH" "$THEME_PATH"

# select colorschemes and copy to folder
COLORSCHEMES=($(~/.scripts/colorscheme-selector.sh))
echo Selected themes:
for c in "${COLORSCHEMES[@]}"; do
    echo " - $c"
    cp "$c" "$THEME_PATH"
done
