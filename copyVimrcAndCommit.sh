#!/bin/sh

cp ~/.vimrc .
cp ~/.eslintrc .
cp ~/.vim/coc-settings.json ./.vim/

git add .vimrc .eslintrc ./.vim/ copyVimrcAndCommit.sh
git commit -m "updated .vimrc, .eslintrc and coc-settings.json"
git push origin master

