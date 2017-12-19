#!/bin/bash
# uncomment to output the running command
# set -x
# output error in the program excution
set -e

# get ubuntu code name
code_name=$(lsb_release -cs)

# check if running in root
function check_root () {
	if [[ $(whoami) == "root" ]]; then
		return 1
	else
		return 0
	fi
}
in_root=$(check_root)

# modify the mirror source, choose ustc mirror
# make sure the ubuntu proposed repo is invoked
function setup_source() {
	if [[ $in_root ]]; then
		sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
		sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
		echo "deb http://mirrors.ustc.edu.cn/ubuntu ${code_name}-proposed main restricted universe multiverse" >> /etc/apt/sources.list
	else
		sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
		sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
		sudo sh -c "echo 'deb http://mirrors.ustc.edu.cn/ubuntu ${code_name}-proposed main restricted universe multiverse' >> /etc/apt/sources.list"
	fi
}

# install the needed packages for my development
function install_package() {
	if [[ $in_root ]]; then
		apt -y update && apt -y full-upgrade && apt -y install vim-nox emacs git curl wget axel aria2 python-all-dev python3-all-dev python-dev python3-dev python-pip python3-pip python-setuptools python3-setuptools libncursesw5-dev libncurses5-dev libsqlite3-dev libbz2-dev libzip-dev libreadline-dev make build-essential libssl-dev zlib1g-dev llvm xz-utils tk-dev clang cmake cmake-curses-gui shadowsocks zsh tmux
	else
		sudo apt -y update && sudo apt -y full-upgrade && sudo apt -y install vim-nox emacs-nox git curl wget axel aria2 python-all-dev python3-all-dev python-dev python3-dev python-pip python3-pip python-setuptools python3-setuptools libncursesw5-dev libncurses5-dev libsqlite3-dev libbz2-dev libzip-dev libreadline-dev make build-essential libssl-dev zlib1g-dev llvm xz-utils tk-dev clang cmake cmake-curses-gui shadowsocks zsh tmux
	fi
}

# set proxy variables for command line use
function proxy_on() {
	export ALL_PROXY=socks5://127.0.0.1:1080
}

# stop proxy server and remove proxy variables
function proxy_off() {
	unset ALL_PROXY
}

# some setup functions for the command line tools that i need

# set up oh-my-zsh
function setup_ohmyzsh() {
	cd ~
	if [[ -d .oh-my-zsh ]]; then
		rm -rf .oh-my-zsh
	fi
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	echo "please exit this session and logout for the settings to make effect"
}

# get my dot files
function get_dotfiles() {
	cd ~
	if [[ -d snapsisy_dot_files ]]; then
		rm -rf snapsisy_dot_files
	fi
	git clone https://github.com/snapsisy/snapsisy_dot_files.git
	echo "no content" >> .vimrc
	mv ~/.vimrc ~/.vimrc.bak
	echo "no content" >> .tmux.conf.local
	mv ~/.tmux.conf.local ~/.tmux.conf.local.bak
	echo "no content" >> .zshrc
	mv ~/.zshrc ~/.zshrc.bak
	cp ~/snapsisy_dot_files/vim/.vimrc ~/.vimrc
	cp ~/snapsisy_dot_files/tmux/.tmux.conf.local ~/.tmux.conf.local
	cp ~/snapsisy_dot_files/zsh/.zshrc ~/.zshrc
	rm -rf snapsisy_dot_files
}

# set tmux
function setup_tmux() {
	cd ~
	if [[ -d .tmux ]]; then
		rm -rf .tmux
	fi
	git clone https://github.com/gpakosz/.tmux.git
	ln -s -f .tmux/.tmux.conf
}

# set up vim
function setup_vim() {
	if [[ -d .vim ]]; then
		rm -rf .vim
	fi
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall
	proxy_on
	cd ~/.vim/plugged/YouCompleteMe && ./install.py --clang-complete
	proxy_off
}

setup_source
install_package
setup_ohmyzsh
get_dotfiles
setup_tmux
setup_vim
