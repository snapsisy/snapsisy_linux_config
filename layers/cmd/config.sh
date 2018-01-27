#!/bin/bash

echo =========================================================================================
echo "you will need to install powerline fonts "
echo "and set it default in your favorite terminal"
echo "my recommedation is the Iosevka font"
echo "press enter to continue"
echo =========================================================================================
read

config_ycm() {
	echo =========================================================================================
	echo what do you wanna use vim for?
	echo python is included by default
	echo =========================================================================================
	read -p "c/c++? (y/N) " config_ycm0
	read -p "go? (y/N) " config_ycm1
	read -p "typescript? (y/N) " config_ycm2
	read -p "javascript? (y/N) " config_ycm3
	read -p "rust? (y/N) " config_ycm4
	export config_ycm0
	export config_ycm1
	export config_ycm2
	export config_ycm3
	export config_ycm4
}
config_zsh() {
	echo =========================================================================================
	echo press enter and then choose from the listed themes, none for default
	echo =========================================================================================
	read
	if [[ -d ~/.oh-my-zsh/themes ]]; then
		THEMES=`ls ~/.oh-my-zsh/themes`
	fi
	count=0
	for theme in $THEMES; do
		count_4=`expr $count % 3`
		if [[ $count_4 != 0 ]]; then
			echo -n "$count) $theme "
		else
			echo "$count) $theme "
		fi
		count=$((count+1))
	done
	echo
	echo =========================================================================================
	echo "your choice"
	read choice
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
