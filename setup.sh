#!/bin/sh

# 1. Set the right dpi for you monitor on .Xresources
cp $HOME/.Xresources $HOME/.XresourcesBAK
sed 's/Xft.dpi:       95/Xft.dpi:       150/' $HOME/.Xresources


