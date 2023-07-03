RED="\e[31m"
CYAN="\e[36m"
GREEN="\e[32m"
GREY="\e[37m"
YELLOW="\e[33m"
BOLD="\e[1m"
FAINT="\e[2m"
ITAL="\e[3m"
UNDER="\e[4m"
ENDCOLOR="\e[0m"

echo -e "${RED}Red text${ENDCOLOR}"

cd ~
cd os
cd initrd

echo -e "${UNDER} --- BlueBerryOS configurator --- ${ENDCOLOR}"
echo -e "${BOLD}press enter for the defaults${ENDCOLOR}"

# themes 
echo -e "${ITAL}-- theme selection --${ENDCOLOR}"
echo what theme would you like? \( check theme guide.md for the option\'s colors and previews of theme\)

echo light or dark?
read mode

if [ "$mode" = "dark" ]; then
echo -e "the dark mode options are: ${CYAN}BLUE, ${GREEN}TERM, ${FAINT}PINK, ${GREY}BORE, ${RED}ANGER, FIRE, ${GREEN}RETRO${ENDCOLOR}"
read theme
if [["${theme,,}" = "blue" || "${theme,,}" = "term" || "${theme,,}" = "pink" || "${theme,,}" = "bore" || "${theme,,}" = "anger" || "${theme,,}" = "fire" || "${theme,,}" = "retro" ]]; then
"${theme^^}"> color.conf
fi
if  ["$theme" = ""]; then
"BLUE">color.conf
fi
fi

if [ "$mode" = "light" ]; then
echo the light mode options are coming soon, so let\'s just go for the default blue dark theme so you don\'t get a defensive BSOD
echo you can always edit your terminal colours to be light mode \( or even dark mode! \) as you want with make term
# this is for later:
# read theme
# "${theme^^}"> color.conf
fi

if [ "$mode" = "" ]; then
echo DEAFAULT BLUE\!\!\!\!
# write to config
fi

clear
echo -e "${UNDER} --- BlueBerryOS configurator --- ${ENDCOLOR}"
echo -e "${BOLD}press enter for the defaults${ENDCOLOR}"

# username
echo -e "${ITAL}-- User selection --${ENDCOLOR}"
echo -e "what username would you like to have? \( root is the root account -- RECOMMENDED ONLY FOR TESTING\!\! \)"
read user
"$user"> user.conf

if [ "$mode" = "" ]; then
echo YOU\'RE A BLUEBERRY\!\!\!\!
"blueberry"> user.conf
fi

if [ "$mode" = "root" ]; then
echo you like to take risks, don\'t you? 
"root"> user.conf
fi

clear
echo -e "${UNDER} --- BlueBerryOS configurator --- ${ENDCOLOR}"
echo thank you for using this configurator to make BlueBerryOS work to your preferences!
echo to re-run enter: bash os_config.sh in the main os directory