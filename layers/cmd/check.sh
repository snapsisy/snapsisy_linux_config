#!/bin/bash
## vim
if [[ -f ~/.vimrc ]]; then
	mv ~/.vimrc ~/.vimrc.bak
fi
if [[ -d ~/.vim ]]; then
	rm -rf ~/.vim
fi
######################################################

## zsh
if [[ -f ~/.zshrc ]]; then
	mv ~/.zshrc ~/.zshrc.bak
fi
if [[ -d ~/.oh-my-zsh ]]; then
	rm -rf ~/.oh-my-zsh
fi
######################################################

## tmux
if [[ -f ~/.tmux.conf ]]; then
	mv ~/.tmux.conf ~/.tmux.conf.bak
fi
if [[ -f ~/.tmux.conf.local ]]; then
	rm ~/.tmux.conf.local
fi
if [[ -d ~/.tmux ]]; then
	rm -rf ~/.tmux
fi
######################################################
