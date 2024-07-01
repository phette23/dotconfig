#!/usr/bin/env fish

if command --query mise
    mise install node@latest
else
    echo "mise not found, run brew.sh first to install mise, then run this script again."
    exit 1
end

# get pnpm and switch to using it for global deps
npm i -g pnpm
set -Ux PNPM_HOME "$HOME/Library/pnpm"
fish_add_path "$PNPM_HOME"
pnpm setup
pnpm install -g \
    fx \
    trash-cli
