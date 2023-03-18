#! /bin/sh
#
# modify-hsv.sh
# Copyright (C) Rolf Sievert
#
# Distributed under terms of the MIT license.
#

bold="\033[1m"
normal="\033[0m"

options="${bold}OPTIONS${normal}
      --help
          Print script description.

      -h, --hue [=100]
          Hue percentage (meaning 0 and 200 is a negation of 100).

      -s, --saturation [=100]
          Saturation percentage.

      -v, --value, --brightness, --lightness [=100]
          Brightness percentage."

requirements="${bold}REQUIREMENTS${normal}
      - ImageMagick"

printHelp()
{
    echo -e "$(basename $0)\n"
    echo -e "$options\n"
    echo -e "$requirements\n"
}

parseFloat()
{
    floatRegex="\d+(\.\d+)?"
    res=$(echo $1 | grep -Po "^$floatRegex$")

    if [ -z "$res" ]; then
        echo ""
    else
        echo "$res"
    fi
}

printError()
{
    error="\033[91m"
    echo
	printHelp
    echo
	echo -e "${error}ERROR: $1${normal}"
	exit 1
}

hue="100"
saturation="100"
brightness="100"

inputImage=""
outputImage=""

if [ $# -eq 0 ]; then
    echo ""
    printHelp
    exit 0
else
    # step through arguments
    while [ $# -gt 0 ]; do
        case "$1" in
            --help)
                echo ""
                printHelp
                exit 0
                ;;
            -h|--hue)
                shift # step to value

                hue="$(parseFloat $1)"
                if [ -z "$hue" ]; then
                    printError "Invalid hue \"$1\""
                fi
                ;;
            -s|--saturation)
                shift # step to value

                saturation="$(parseFloat $1)"
                if [ -z "$saturation" ]; then
                    printError "Invalid saturation \"$1\""
                fi
                ;;
            -v|--value|--brightness|--lightness)
                shift # step to value

                brightness="$(parseFloat $1)"
                if [ -z "$brightness" ]; then
                    printError "Invalid brightness \"$1\""
                fi
                ;;

            *) # read input and output image path
                imgPath="$1"
                if [ -z "$inputImage" ]; then
                    if [ -f "$imgPath" ]; then
                        inputImage=$imgPath
                    else
                        printError "\"${imgPath}\" is not a path to an image"
                    fi
                elif [ -z "$outputImage" ]; then
                    outputImage=$imgPath
                else
                    printError "Too many paths provided"
                fi
                ;;
        esac

        shift # next argument
	done
fi

verifyImage()
{
    imagePath="$1"
    if [ ! -f $imagePath ]; then
        printError "\"$imagePath\" does not exist or is not a file"
    elif [[ "$(identify $imagePath &> /dev/null; echo $?)" == "1" ]]; then
        printError "\"$imagePath\" is not a valid image"
        exit 1
    elif [[ "$(convert +repage $imagePath /dev/null &> /dev/null ; echo $?)" == "1" ]]; then
        printError "Cannot parse image \"$imagePath\""
        exit 1
    fi
}

# check image validity
verifyImage $inputImage

magick "$inputImage" -modulate $brightness,$saturation,$hue "$outputImage"
