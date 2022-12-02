#!/bin/bash
clear
unset home
unset notes
unset inventory
home=$(pwd)
notes=$home/inventory/notes
inventory=$home/inventory
export PS1="[ \W ]\$ "
ls -R | grep ":$" | grep -v inventory | sed -e 's/:$//' -e 's/[^-][^\/]*\//---/g' -e 's/-/|/'
