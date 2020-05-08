#!/bin/sh

cp ~/.vimrc .

git add .vimrc 
git commit -m "updated .vimrc"
git push origin master

