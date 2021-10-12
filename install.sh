#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# git
ln -sfn ${BASEDIR}/gitconfig ~/.gitconfig

#zsh
ln -sfn ${BASEDIR}/zshrc ~/.zshrc