#!/bin/bash
clear
export PS1="[\W]\$ "
ls -R | grep ":$" | grep -v inventory | sed -e 's/:$//' -e 's/[^-][^\/]*\//---/g' -e 's/-/|/'
