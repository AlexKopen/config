#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

(sleep 2; run $HOME/.config/polybar/launch.sh && nitrogen --restore && xfce4-terminal --drop-down && xfce4-terminal --drop-down) &
