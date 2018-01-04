#!/bin/bash

echo "you will need to install powerline fonts "
echo "and set it default in your favorite terminal"
echo "my recommedation is the Iosevka font"

config_ycm() {
	echo what do you wanna use vim for?
	echo python is included by default
	read -p "c/c++? (y/N) " config_ycm0
	read -p "go? (y/N) " config_ycm1
	read -p "typescript? (y/N) " config_ycm2
	read -p "javascript? (y/N) " config_ycm3
	read -p "rust? (y/N) " config_ycm4
}

config_zsh() {
	echo choose one theme, none for default
	if [[ -d ~/.oh-my-zsh/themes ]]; then
		THEMES=`ls ~/.oh-my-zsh/themes`
	fi
	count=0
	for theme in $THEMES; do
		echo "$count) $theme"
		count=$((count+1))
	done
	read -p "your choice" choice
	count=0
	for theme in $THEMES; do
		split="$(cut -d'.' -f1 <<<"$theme")"
		if [[ $count == $choice ]]; then
			CHOSEN_THEME=$split
		fi
		count=$((count+1))
	done
	export CHOSEN_THEME
}		
