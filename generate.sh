# From ANSI wiki
# \x1b[
# All common sequences just use the parameters as a series of
# semicolon-separated numbers such as 1;2;3. Missing numbers
# are treated as 0 (1;;3 acts like the middle number is 0,
# and no parameters at all in ESC[m acts like a 0 reset code).

# Supported arguments

# 0  Reset / Normal  all attributes off
# 1  Bold or increased intensity
# 2  Faint (decreased intensity)
# 3  Italic  Not widely supported. Sometimes treated as inverse.
# 4  Underline
# 5  Slow Blink  less than 150 per minute
# 7  reverse video   swap foreground and background colors
# 21     Doubly underline or Bold off    Double-underline per ECMA-48.[22] See discussion
# 22     Normal color or intensity   Neither bold nor faint
# 23     Not italic, not Fraktur
# 24     Underline off   Not singly or doubly underlined
# 25     Blink off
# 27     Inverse off
# 30–37  Set foreground color    See color table below
# 39     Default foreground color    implementation defined (according to standard)
# 40–47  Set background color    See color table below
# 49     Default background color    implementation defined (according to standard)

# we don't need shell logic for this - just helps with insane regex
# this will just generate the highlighters and print to debug if called
generate () {
    ESC="\x1b\["
    code () {
        # concat args with alternator operator '|'
        ATOMS=$(local IFS="|"; echo "$*";)
        # ignore leading zeros, make RE be a single atom
        RE="(?:0*(${ATOMS}))"
        echo -n "${ESC}(?:[^m]*;)?${RE}(?:;[^m]*)?m"
    }

    RESET="(?:0|(?=m))"

    BOLD=1
    IBOLD=21

    DIM=2
    IINTENSE=22

    ITALIC=3
    IITALIC=23

    UNDERLINE=4
    IUNDERLINE=24

    BLINK=5
    IBLINK=25

    REVERSE=7
    IREVERSE=27

    FGBLACK=30
    FGRED=31
    FGGREEN=32
    FGYELLOW=33
    FGBLUE=34
    FGMAGENTA=35
    FGCYAN=36
    FGWHITE=37
    FGDEFAULT=39

    BGBLACK=40
    BGRED=41
    BGGREEN=42
    BGYELLOW=44
    BGBLUE=44
    BGMAGENTA=45
    BGCYAN=46
    BGWHITE=47
    BGDEFAULT=49

    BOLDANY=$(code ${RESET} ${BOLD} ${IBOLD} ${IINTENSE})
    NBOLD=$(code ${RESET} ${IBOLD} ${IINTENSE})
    BOLD=$(code $BOLD)

    DIMANY=$(code ${RESET} ${DIM} ${IINTENSE})
    NDIM=$(code ${RESET} ${IINTENSE})
    DIM=$(code $DIM)

    ITALICANY=$(code ${RESET} ${ITALIC} ${IITALIC})
    NITALIC=$(code ${RESET} ${IITALIC})
    ITALIC=$(code $ITALIC)

    UNDERLINEANY=$(code ${RESET} ${UNDERLINE} ${IUNDERLINE})
    NUNDERLINE=$(code ${RESET} ${IUNDERLINE})
    UNDERLINE=$(code $UNDERLINE)

    BLINKANY=$(code ${RESET} ${BLINK} ${IBLINK})
    NBLINK=$(code ${RESET} ${IBLINK})
    BLINK=$(code $BLINK)

    REVERSEANY=$(code ${RESET} ${REVERSE} ${IREVERSE})
    NREVERSE=$(code ${RESET} ${IREVERSE})
    REVERSE=$(code $REVERSE)

    FGANY=$(code ${RESET} ${FGBLACK} ${FGRED} ${FGGREEN} ${FGYELLOW} ${FGBLUE} ${FGMAGENTA} ${FGCYAN} ${FGWHITE} ${FGDEFAULT})
    NFGBLACK=$(code ${RESET} ${FGRED} ${FGGREEN} ${FGYELLOW} ${FGBLUE} ${FGMAGENTA} ${FGCYAN} ${FGWHITE} ${FGDEFAULT})
    NFGRED=$(code ${RESET} ${FGBLACK} ${FGGREEN} ${FGYELLOW} ${FGBLUE} ${FGMAGENTA} ${FGCYAN} ${FGWHITE} ${FGDEFAULT})
    NFGGREEN=$(code ${RESET} ${FGBLACK} ${FGRED} ${FGYELLOW} ${FGBLUE} ${FGMAGENTA} ${FGCYAN} ${FGWHITE} ${FGDEFAULT})
    NFGYELLOW=$(code ${RESET} ${FGBLACK} ${FGRED} ${FGGREEN} ${FGBLUE} ${FGMAGENTA} ${FGCYAN} ${FGWHITE} ${FGDEFAULT})
    NFGBLUE=$(code ${RESET} ${FGBLACK} ${FGRED} ${FGGREEN} ${FGYELLOW} ${FGMAGENTA} ${FGCYAN} ${FGWHITE} ${FGDEFAULT})
    NFGMAGENTA=$(code ${RESET} ${FGBLACK} ${FGRED} ${FGGREEN} ${FGYELLOW} ${FGBLUE} ${FGCYAN} ${FGWHITE} ${FGDEFAULT})
    NFGCYAN=$(code ${RESET} ${FGBLACK} ${FGRED} ${FGGREEN} ${FGYELLOW} ${FGBLUE} ${FGMAGENTA} ${FGWHITE} ${FGDEFAULT})
    NFGWHITE=$(code ${RESET} ${FGBLACK} ${FGRED} ${FGGREEN} ${FGYELLOW} ${FGBLUE} ${FGMAGENTA} ${FGCYAN} ${FGDEFAULT})

    FGBLACK=$(code $FGBLACK)
    FGRED=$(code $FGRED)
    FGGREEN=$(code $FGGREEN)
    FGYELLOW=$(code $FGYELLOW)
    FGBLUE=$(code $FGBLUE)
    FGMAGENTA=$(code $FGMAGENTA)
    FGCYAN=$(code $FGCYAN)
    FGWHITE=$(code $FGWHITE)
    FGDEFAULT=$(code $FGDEFAULT)

    BGANY=$(code ${RESET} ${BGBLACK} ${BGRED} ${BGGREEN} ${BGYELLOW} ${BGBLUE} ${BGMAGENTA} ${BGCYAN} ${BGWHITE} ${BGDEFAULT})
    NBGBLACK=$(code ${RESET} ${BGRED} ${BGGREEN} ${BGYELLOW} ${BGBLUE} ${BGMAGENTA} ${BGCYAN} ${BGWHITE} ${BGDEFAULT})
    NBGRED=$(code ${RESET} ${BGBLACK} ${BGGREEN} ${BGYELLOW} ${BGBLUE} ${BGMAGENTA} ${BGCYAN} ${BGWHITE} ${BGDEFAULT})
    NBGGREEN=$(code ${RESET} ${BGBLACK} ${BGRED} ${BGYELLOW} ${BGBLUE} ${BGMAGENTA} ${BGCYAN} ${BGWHITE} ${BGDEFAULT})
    NBGYELLOW=$(code ${RESET} ${BGBLACK} ${BGRED} ${BGGREEN} ${BGBLUE} ${BGMAGENTA} ${BGCYAN} ${BGWHITE} ${BGDEFAULT})
    NBGBLUE=$(code ${RESET} ${BGBLACK} ${BGRED} ${BGGREEN} ${BGYELLOW} ${BGMAGENTA} ${BGCYAN} ${BGWHITE} ${BGDEFAULT})
    NBGMAGENTA=$(code ${RESET} ${BGBLACK} ${BGRED} ${BGGREEN} ${BGYELLOW} ${BGBLUE} ${BGCYAN} ${BGWHITE} ${BGDEFAULT})
    NBGCYAN=$(code ${RESET} ${BGBLACK} ${BGRED} ${BGGREEN} ${BGYELLOW} ${BGBLUE} ${BGMAGENTA} ${BGWHITE} ${BGDEFAULT})
    NBGWHITE=$(code ${RESET} ${BGBLACK} ${BGRED} ${BGGREEN} ${BGYELLOW} ${BGBLUE} ${BGMAGENTA} ${BGCYAN} ${BGDEFAULT})

    BGBLACK=$(code $BGBLACK)
    BGRED=$(code $BGRED)
    BGGREEN=$(code $BGGREEN)
    BGYELLOW=$(code $BGYELLOW)
    BGBLUE=$(code $BGBLUE)
    BGMAGENTA=$(code $BGMAGENTA)
    BGCYAN=$(code $BGCYAN)
    BGWHITE=$(code $BGWHITE)
    BGDEFAULT=$(code $BGDEFAULT)

    echo "
    add-highlighter shared/termcolor/fg group
    add-highlighter shared/termcolor/bg group
    add-highlighter shared/termcolor/attr group

    add-highlighter shared/termcolor/fg/black regex \"%{${FGBLACK}.*?${NFGBLACK}}\" 0:black
    add-highlighter shared/termcolor/fg/red regex \"%{${FGRED}.*?${NFGRED}}\" 0:red
    add-highlighter shared/termcolor/fg/green regex \"%{${FGGREEN}.*?${NFGGREEN}}\" 0:green
    add-highlighter shared/termcolor/fg/yellow regex \"%{${FGYELLOW}.*?${NFGYELLOW}}\" 0:yellow
    add-highlighter shared/termcolor/fg/blue regex \"%{${FGBLUE}.*?${NFGBLUE}}\" 0:blue
    add-highlighter shared/termcolor/fg/magenta regex \"%{${FGMAGENTA}.*?${NFGMAGENTA}}\" 0:magenta
    add-highlighter shared/termcolor/fg/cyan regex \"%{${FGCYAN}.*?${NFGCYAN}}\" 0:cyan
    add-highlighter shared/termcolor/fg/white regex \"%{${FGWHITE}.*?${NFGWHITE}}\" 0:white

    add-highlighter shared/termcolor/bg/black regex \"%{${BGBLACK}.*?${NBGBLACK}}\" 0:default,black
    add-highlighter shared/termcolor/bg/red regex \"%{${BGRED}.*?${NBGRED}}\" 0:default,red
    add-highlighter shared/termcolor/bg/green regex \"%{${BGGREEN}.*?${NBGGREEN}}\" 0:default,green
    add-highlighter shared/termcolor/bg/yellow regex \"%{${BGYELLOW}.*?${NBGYELLOW}}\" 0:default,yellow
    add-highlighter shared/termcolor/bg/blue regex \"%{${BGBLUE}.*?${NBGBLUE}}\" 0:default,blue
    add-highlighter shared/termcolor/bg/magenta regex \"%{${BGMAGENTA}.*?${NBGMAGENTA}}\" 0:default,magenta
    add-highlighter shared/termcolor/bg/cyan regex \"%{${BGCYAN}.*?${NBGCYAN}}\" 0:default,cyan
    add-highlighter shared/termcolor/bg/white regex \"%{${BGWHITE}.*?${NBGWHITE}}\" 0:default,white

    add-highlighter shared/termcolor/attr/bold regex \"%{${BOLD}.*?${NBOLD}}\" 0:default+b
    add-highlighter shared/termcolor/attr/dim regex \"%{${DIM}.*?${NDIM}}\" 0:default+d
    add-highlighter shared/termcolor/attr/italic regex \"%{${ITALIC}.*?${NITALIC}}\" 0:default+i
    add-highlighter shared/termcolor/attr/underline regex \"%{${UNDERLINE}.*?${NUNDERLINE}}\" 0:default+u
    add-highlighter shared/termcolor/attr/blink regex \"%{${BLINK}.*?${NBLINK}}\" 0:default+B
    add-highlighter shared/termcolor/attr/reverse regex \"%{${REVERSE}.*?${NREVERSE}}\" 0:default+r
    "
}

generate
