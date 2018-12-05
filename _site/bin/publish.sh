#!/usr/bin/env bash

cd ~/dev/doodlingdev.github.io

jekyll build

cp -r _site ../temp

git checkout master

trash ./**

mv ../temp/_site/** .

git add .

git commit -m "new post $(date)"

git push origin master --force

git checkout dev
