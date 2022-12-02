#!/bin/bash
# setting color variables
BG_CYAN="$(tput setab 6)"
BG_BLACK="$(tput setab 0)"
FG_GREEN="$(tput setaf 2)"
FG_MAGENTA="$(tput setaf 5)"

if [ ! -f ./currenPlayer.dat ]
	then echo "placeholder" > ./.currentPlayer.dat
	echo "Created .currentPlayer.dat"; sleep 2;
fi

function resetVar() {
	echo "Resetting Lark Environment for new game, $userName "
	sleep 2
	# reset variables for new game
	# Unsetting and declaring variables
	unset home
	unset notes
	unset inventory
	unset commands
	unset quit
	unset originalPS1
}

function map {
             ls -R | grep ":$" | grep -v inventory | sed -e 's/:$//' -e 's/[^-][^\/]*\//---/g' -e 's/-/|/'
        }
originalPS1=$PS1
home=$(pwd)
notes=$home/inventory/notes
inventory=$home/inventory
commands="cat $home/.commands"
quit="cd $home && export PS1=originalPS1 && clear"

# Save Screen
tput smcup

# Display menu until selection == 0
	while [[ $REPLY != 0 ]]; do
		echo -n ${BG_CYAN}${FG_MAGENTA}
		clear
		cat <<EOF
			Please Select:

			1. Log into Lark Game
			2. Start Lark game script
			0. Quit
EOF

read -p "Enter selection [0-2] > " selection
	# Clear area beneath menu
	tput cup 10 0 # Positions the cursor
	echo -n ${BG_BLACK}${FG_GREEN}
	tput ed # Clears cursor to end of line
	tput cup 11 0

# act on selection
case $selection in
	1) read -p "What is your name? " userName
		if [ $(gawk '{print $1}' ./currentPlayer.dat) = $userName ]
			then
				echo "Welcome back $userName"
				sleep 2
			else
				echo $userName > ./.currentPlayer.dat
				new=true
				echo "Welcome to The LARK Files!"
		fi
	;;
	2) if [ new ]
		then resetVar
		if [[ -e "entrance" ]]; then
		rm -rf entrance
		fi
		cp -rf .entrance entrance
	   fi
	   clear
	   
           # Changing PS1 (Command Line Prompt)
           export PS1="[ \W ]\$ "
	   cd entrance
	   clear
	   map

	;;
	0) break
	;;
	*) echo "Invalid entry."
	;;
esac
printf "\n\nPress any key to continue,"
read -n 1
done

# Restore saved screen
tput rmcup
echo "Program terminated"
clear
