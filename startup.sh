#!/bin/bash
# output the running command
set -x
# output error in the program excution
set -e

# get ubuntu code name
code_name=$(lsb_release -cs)

# check if running in root
in_root=$(($(whoami)==root))

# modify the mirror source, choose ustc mirror
# make sure the ubuntu proposed repo is invoked
function set_up_source() {
	if [[!${in_root}]]; then
		sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
		sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
		sudo echo "deb http://mirrors.ustc.edu.cn/ubuntu ${code_name}-proposed main restricted universe multiverse" >> /etc/apt/sources.list
	else
		sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
		sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
		echo "deb http://mirrors.ustc.edu.cn/ubuntu ${code_name}-proposed main restricted universe multiverse" >> /etc/apt/sources.list
	fi
}

# install the needed packages for my development
function install_packages() {
	if [[!${in_root}]]; then
		sudo apt -y update && sudo apt -y full-upgrade && sudo apt -y install vim-nox emacs-nox git curl wget axel aria2 python-all-dev python3-all-dev python-dev python3-dev python-pip python3-pip python-setuptools python3-setuptools libncursesw5-dev libncurses5-dev libsqlite3-dev libbz2-dev libzip-dev libreadline-dev make build-essential libssl-dev zlib1g-dev llvm xz-utils tk-dev clang cmake cmake-curses-gui shadowsocks
	else
		apt -y update && sudo apt -y full-upgrade && sudo apt -y install vim-nox emacs-nox git curl wget axel aria2 python-all-dev python3-all-dev python-dev python3-dev python-pip python3-pip python-setuptools python3-setuptools libncursesw5-dev libncurses5-dev libsqlite3-dev libbz2-dev libzip-dev libreadline-dev make build-essential libssl-dev zlib1g-dev llvm xz-utils tk-dev clang cmake cmake-curses-gui  shadowsocks
	fi
}

# start a proxy server as a daemon
function start_proxy_server() {
	sslocal -c '/etc/shadowsocks/config.json' -d start
}

# set proxy variables for command line use
function set_proxy_variables() {
	export HTTP_PROXY=127.0.0.1:1080
	export HTTPS_PROXY=127.0.0.1:1080
	export SOCK5_PROXY=127.0.0.1:1080
}

# start proxy server and set proxy variables
function proxy_on() {
	start_proxy_server
	set_proxy_variables
}

# stop proxy server and remove proxy variables
function proxy_off() {
	unset HTTP_PROXY
	unset HTTPS_PROXY
	unset SOCK5_PROXY
}

function download_dot_files() {
	cd ~ && git clone https://github.com/snapsisy/snapsisy_dot_files.git
	mv ~/.vimrc ~/.vimrc.bak
	mv ~/.emacs ~/.meacs.bak
	mv ~/.tmux.conf ~/.tmux.conf.bak
	cp ~/snapsisy_dot_files/.vimrc ~/.vimrc
	cp ~/snapsisy_dot_files/.emacs ~/.emacs
	cp ~/snapsisy_dot_files/.tmux.conf.local ~/.tmux.conf.local
	rm -rf snapsisy_dot_files
}

# some setup functions for the command line tools that i need
function setup_vim() {
	proxy_on
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall
	proxy_off
}
function setup_ohmyzsh() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}
function set_up_tmux() {
	cd ~ && git clone https://github.com/gpakosz/.tmux.git
	ln -s -f .tmux/.tmux.conf
}

