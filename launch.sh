#!/bin/bash

CONFIG_LOCAL=./config.txt
BINARY_DIR=./target/debug
PROGRAM=project1_rust

cargo build || exit 1


n=0
cat $CONFIG_LOCAL | sed -e "s/#.*//" | sed -e "/^\s*$/d" |
(
    read i
    while [[ $n -lt $i ]]
    do
        read line
        p=$( echo $line | awk '{ print $1 }' )
        host=$( echo $line | awk '{ print $2 }' )
        kitty --hold -e $BINARY_DIR/$PROGRAM $p $CONFIG_LOCAL &
        n=$(( n + 1 ))
    done
    wait
)
