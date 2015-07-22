#!/usr/bin/env bash

npm config set prefix ~/npm

# install global NPM packages
npm install -g --quiet \
  bower \
  cssmin \
  express-generator \
  generator-h5bp \
  generator-node \
  generator-reveal \
  grunt-cli \
  gulp \
  jshint \
  nodemon \
  phantomas \
  trash \
  uglify-js \
  yo
