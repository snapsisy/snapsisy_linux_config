#!/bin/bash
set -e

setup_tmux
setup_zsh
setup_vim

if [ $pick_emacs = $chosen_install ]; then
	setup_emacs
fi

