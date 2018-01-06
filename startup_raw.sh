#!/bin/bash
# uncomment to output the running command
# set -x
# output error in the program excution
set -e

function setup_tmux() {
	cd ~
	if [[ -d .tmux ]]; then
		rm -rf .tmux
	fi
	git clone https://github.com/gpakosz/.tmux.git
	ln -s -f .tmux/.tmux.conf
}
setup_tmux
