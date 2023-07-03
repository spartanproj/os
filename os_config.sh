cd ~
cd os
cd initrd

echo --- BlueBerryOS configurator ---
echo press enter for the defaults

# themes 
echo -- theme selection --
echo what theme would you like? \( check theme guide.md for the option\'s colors and previews of theme\)

echo light or dark?
read mode

if [ "$mode" = "dark" ]; then
echo the dark mode options are: BLUE, TERM, PINK, BORE, ANGER, FIRE, RETRO
read theme
if [["${theme,,}" = "blue" || "${theme,,}" = "term" || "${theme,,}" = "pink" || "${theme,,}" = "bore" || "${theme,,}" = "anger" || "${theme,,}" = "fire" || "${theme,,}" = "retro" || ]]; then
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

# username
echo -- User selection --
echo what username would you like to have? \( root is the root account -- RECOMMENDED ONLY FOR TESTING\!\! \)
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


echo thank you for using this configurator to make BlueBerryOS work to your preferences!
