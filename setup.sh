#!/bin/bash
clear

DefPS1=$PS1

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
function map {
     ls -R | grep ":$" | grep -v inventory | sed -e 's/:$//' -e 's/[^-][^\/]*\//---/g' -e 's/-/|/'
}  

# Changing PS1 (Command Line Prompt)
export PS1="[ \W ]\$ "

# Map Command
map
