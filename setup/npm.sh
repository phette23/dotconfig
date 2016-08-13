#!/usr/bin/env bash
# install global NPM packages
npm install -g --quiet \
  babel-cli \
  generator-h5bp \
  generator-node \
  generator-reveal \
  grunt-cli \
  http-server \
  jshint \
  trash-cli \
  uglify-js \
  yo

# if any of my personal utilities exist, link them
projects="~/code/dogedc ~/code/equella-cli"
for project in ${projects}; do
    # if dir exists, move into it & link
    [ -d ${project} ] && cd ${project} && npm link
done
