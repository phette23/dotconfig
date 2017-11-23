#!/usr/bin/env bash -x
# install global NPM packages
npm install -g --quiet \
  babel-cli \
  grunt-cli \
  gulp-cli \
  n \
  trash-cli \
  uglify-js

# if any of my personal utilities exist, link them
projects="~/code/dogedc ~/code/equella_cli"
for project in ${projects}; do
    # if dir exists, move into it & link
    [ -d ${project} ] && cd ${project} && npm link
done
