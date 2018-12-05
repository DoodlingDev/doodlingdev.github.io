#!/usr/bin/env bash

cd ~/dev/doodlingdev.github.io

jekyll build

cp -r _site ../temp

git checkout master

if [ $? -ne 0 ]; then
  echo "checkout to master failed. aborting."
  exit
fi

trash ./**

mv ../temp/_site/** .

git add .

git commit -m "new post $(date)"

git push origin master --force

git checkout dev
