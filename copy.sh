#!/usr/bin/env bash
rsync -avz --progress --exclude .DS_Store config/. ~
