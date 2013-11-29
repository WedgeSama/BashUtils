#!/bin/bash

# Function echo style
function echoS {
    aide="Syntaxe : echoS [-c color] [-f color] [-s style] [-e] [-n] \"text\"\n
Style text.\n\n
  -c : text color\n
  -f : background color\n
    color : b (black) R (red) G (green) B (blue) M (maganta) C (cyan) W (white)\n
  -s : text style\n
    style : N (normal) B (bold) U (underline)\n
  -e : frame\n
  -n : do not add newline\n"
    if [ $# -lt 1 ] ; then
        echo -e $aide
        return 1
    fi
    
    color_txt=0
    color_font=0
    style=0
    enca=false
    ret=true
    txt=""
    
    while [ $# -gt 0 ] ; do
        var=$1
        
        if [ "$var" == "-c" ] ; then
            case $2 in
                "b")
                    color_txt=30;;
                "R")
                    color_txt=31;;
                "G")
                    color_txt=32;;
                "Y")
                    color_txt=33;;
                "B")
                    color_txt=34;;
                "M")
                    color_txt=35;;
                "C")
                    color_txt=36;;
                "W")
                    color_txt=37;;
                *)
                    echo -e $aide;
                    return 1;;
            esac
            shift
        elif [ "$var" == "-f" ] ; then
            case "$2" in
                "b")
                    color_font=40;;
                "R")
                    color_font=41;;
                "G")
                    color_font=42;;
                "Y")
                    color_font=43;;
                "B")
                    color_font=44;;
                "M")
                    color_font=45;;
                "C")
                    color_font=46;;
                "W")
                    color_font=47;;
                *)
                    echo -e $aide;
                    return 1;;
            esac
            shift
        elif [ "$var" == "-s" ] ; then
            case "$2" in
                "N")
                    style=0;;
                "B")
                    style=1;;
                "U")
                    style=4;;
                *)
                    echo -e $aide;
                    return 1;;
            esac
            shift
        elif [ "$var" == "-e" ] ; then
            enca=true
        elif [ "$var" == "-n" ] ; then
            ret=false
        else
            txt="$txt$var "
        fi
        
        shift
    done
    
    color="\033[$style"
    
    if [ $color_txt -ne 0 ] ; then
        color="$color;$color_txt"
    fi
    
    if [ $color_font -ne 0 ] ; then
        color="$color;$color_font"
    fi
    
    color=$color"m"
    
    
    sep=""
    
    if $enca ; then
        sep="\n"
        for ((i=0 ; $i < ${#txt} ; i++))
        do
            sep="$sep-"
        done
        sep="$sep\n"
    fi
    
    if $ret ; then
        echo -e "$color$sep$txt$sep\033[0m"
    else
        echo -en "$color$sep$txt$sep\033[0m"
    fi
}

export -f echoS
