#!/bin/bash
# StartGame.sh

function resetVar() {
	echo "Resetting Variables and Game Environment"
	sleep 2
	# reset variables for new game
	# Unsetting and declaring variables
	unset home
	unset inventory
	unset commands
	unset originalPS1
	unset inventory
}

function map {
	ls -R | grep ":$" | grep -v inventory | sed -e 's/:$//' -e 's/[^-][^\/]*\//---/g' -e 's/-/|/'
        }

function quit {
	cd $home
	export PS1=$originalPS1
	resetVar
	clear
}

function take {
	cp $1 $home/.inventory
}

resetVar

originalPS1=$PS1
home=$(pwd)
commands="cat $home/.commands"
inventory="cat $home/.inventory"
export home
export commands
export originalPS1

if [[ -e "entrance" ]]; then
	rm -rf entrance
	fi
cp -rf .entrance entrance
clear
# Changing PS1 (Command Line Prompt)
export PS1="[ \W ]\$ "
cd entrance
clear
map
echo "Welcome to The LARK Files!"
