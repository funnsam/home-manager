#!/usr/bin/env bash

input=$(fcitx5-remote -n | xargs)
case "$input" in
    "keyboard-us")
        echo -n "EN";
        ;;
    "rime")
        echo -n "ZH";
        ;;
    "mozc")
        echo -n "JP";
        ;;
    *)
        echo -n "$input";
        ;;
esac
