#!/usr/bin/env bash

fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$0"
}

fancy_echo "beginning publish process..."
cd ~/dev/doodlingdev.github.io

fancy_echo "Trashing out-of-date build folder"
trash _site

fancy_echo "building..."
jekyll build

fancy_echo "recursively copying built site"
cp -r _site ../temp

fancy_echo "checking out master (published) branch"
git checkout master

if [ $? -ne 0 ]; then
  fancy_echo "master checkout failed. aborting"
fi

fancy_echo "trashing out-of-date non-hidden files"
trash *

fancy_echo "copying updated site"
cp -r ../temp/_site/** .

if [ $? -ne 0 ]; then
  fancy_echo "copying failed. aborting."
fi

fancy_echo "removing uneccessary _site/"
trash ./_site

fancy_echo "git adding folder"
git add .

fancy_echo "git committing update"
git commit -m "new content $(date)"

fancy_echo "force-pushing to origin master"
git push origin master --force

fancy_echo "checking out dev branch"
git checkout dev
