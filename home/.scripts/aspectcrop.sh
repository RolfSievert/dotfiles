#!/bin/bash
#
# Copyright © Rolf Sievert
#
# Distributed under terms of the MIT license.
#

bold="\033[1m"
normal="\033[0m"

description="${bold}DESCRIPTION${normal}
      crops an image to specified aspect ratio."
usage="${bold}USAGE${normal}
      aspectcrop [-a aspect] [-g gravity] infile outfile"
options="${bold}OPTIONS${normal}
      -a, --aspect[=1:1]
          Width to height ratio; values can be either a float or two floats
          separated by a colon.
          Example:
              2 or 2:1 (landscape)
              0.5 1:2 (portrait)

      -g, --gravity[=center]
          Gravity alignment for cropping; any ImageMagick -gravity value.
          Options are:
              c [center], n [north], n [north], s [south], e [east], w [west],
              nw [northwest], ne [northeast], sw [southwest], se [southeast]

      -h, --help
          Print help string."
requirements="${bold}SYSTEM REQUIREMENTS${normal}
      - ImageMagick"


# default values
aspectRatio="1:1"
gravity="center"

printHelp()
{
    echo -e "$(basename $0):\n"
    echo -e "$description\n"
    echo -e "$usage\n"
    echo -e "$options\n"
    echo -e "$requirements\n"
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

parseAspectRatio()
{
    height="1"

    aspect="$1"
    if [[ $aspect == *":"* ]]; then
        floatRegex="\d+(\.\d+)?"
        width=$(echo $aspect | grep -Po "^$floatRegex(?=:)")
        height=$(echo $aspect | grep -Po "(?<=:)$floatRegex$")
    else
        width=$(echo $aspect | grep -Po "^$floatRegex$")
    fi

    # check that width and height was found
    if [ -z "$width" ]; then
        echo ""
    elif [ -z "$height" ]; then
        echo ""
    else
        echo "$width:$height"
    fi
}

parseGravity()
{
    gravity="$1"
    gravity=$(echo "$gravity" | tr "[:upper:]" "[:lower:]")

    case "$gravity" in
         center|c) gravity="center" ;;
         north|n) gravity="north" ;;
         west|w) gravity="west" ;;
         south|s) gravity="south" ;;
         east|e) gravity="east" ;;
         northeast|ne) gravity="northeast" ;;
         northwest|nw) gravity="northwest" ;;
         southwest|sw) gravity="southwest" ;;
         southeast|se) gravity="southeast" ;;
         *) gravity="" ;;
     esac

     echo "$gravity"
}

inputImage=""
outputImage=""

# check script arguments
if [ $# -eq 0 ]; then
    echo ""
    printHelp
    exit 0
elif [ $# -gt 6 ]; then
	printError "Too many arguments provided"
else
    # step through arguments
    while [ $# -gt 0 ]; do
        case "$1" in
            -h|--help)
                echo ""
                printHelp
                exit 0
                ;;
            -a|--aspect)
                shift # step to value

                aspectRatio="$(parseAspectRatio $1)"
                if [ -z "$aspectRatio" ]; then
                    printError "Invalid aspect ratio \"$1\""
                fi
                ;;
            -g|--gravity)
                shift # step to value

                gravity="$(parseGravity $1)"
                if [ -z "$gravity" ]; then
                    printError "Invalid gravity value \"$1\""
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

# +repage is recommended for png for some reason
convert $inputImage -gravity $gravity -crop $aspectRatio +repage $outputImage

exit 0
