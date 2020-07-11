#!/bin/sh

cp ~/.vimrc .
cp ~/.eslintrc .

git add .vimrc .eslintrc
git commit -m "updated .vimrc and .eslintrc"
git push origin master

