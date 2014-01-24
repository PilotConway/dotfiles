#!/bin/bash

# Gets the Status of Caps lock and num locks and prints out a string for
# consumption by tmux
coloroff=$1
coloron=$2
caps=`xset -q | grep Caps | awk '{print $4}'`
num=`xset -q | grep Caps | awk '{print $8}'`
string="#[nobold]"

if [[ $caps == "on" ]]; then 
    string+="#[bold,fg=$coloron]Caps#[nobold,fg=$coloroff]"
else 
    string+="Caps"
fi

if [[ $num == "on" ]]; then 
    string+="#[bold,fg=$coloron]Num#[nobold,fg=$coloroff]"
else 
    string+="Num"
fi

echo $string
