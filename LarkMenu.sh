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
	home=$(pwd)
	notes=$home/inventory/notes
	inventory=$home/inventory
	commands="cat $home/.commands"
	#map function
	
	# Changing PS1 (Command Line Prompt)
	export PS1="[ \W ]\$ "	
	}

function map {
             ls -R | grep ":$" | grep -v inventory | sed -e 's/:$//' -e 's/[^-][^\/]*\//---/g' -e 's/-/|/'
        }

# Save Screen
tput smcup

# Display menu until selection == 0
	while [[ $REPLY != 0 ]]; do
		echo -n ${BG_CYAN}${FG_MAGENTA}
		clear
		cat <<EOF
			Please Select:

			1. Log into Lark Game
			2. Set game difficulty level
			3. Start Lark game script
			0. Quit
EOF

read -p "Enter selection [0-3] > " selection
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
		fi
	;;
	2) echo "Press 1 for easy or 2 for hard "
	   read -n 1 difficulty
	   echo "diff=$difficulty" >> .currentPlayer.dat # Source script for this to work
	   if [ $difficulty -eq 1 ]
		then echo "	You selected easy"
		sleep 2
	   elif [ $difficulty -eq 2 ]
		then echo "	You selected hard"
		sleep 2
	   else echo "		Your selection doesn't match"
		sleep 2
	   fi
	;;
	3) if [ new ]
		then resetVar
	   fi
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
map
