#!/bin/bash

################################################################################################
proxy_on() {
	export ALL_PROXY=socks5://127.0.0.1:1080
}

proxy_off() {
	unset ALL_PROXY
}

install_zsh() {
	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	config_zsh
	sed -i "s/robbyrussell/$CHOSEN_THEME/g" ~/.zshrc
	if [[ `tput colors` == 8 ]]; then
		sed -i '1 i export TERM=xterm-256colors' ~/.zshrc
	fi
}

install_node_workflow() {
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
	nvm install node && nvm use node
}

install_golang_workflow() {
	git clone https://github.com/syndbg/goenv.git ~/.goenv
	echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.zshrc
	echo 'export PATH="$GOENV_ROOT/bin:$PATH"' >> ~/.zshrc
	echo 'eval "$(goenv init -)"' >> ~/.zshrc
	export GOENV_ROOT="$HOME/.goenv"
	export PATH="$GOENV_ROOT/bin:$PATH"
	eval "$(goenv init -)"
	goenv install 1.9.0
}

install_rust_workflow() {
	curl https://sh.rustup.rs -sSf | sh
}

install_ycm() {
	config_ycm
	if [[ config_ycm0 == 'y' || config_ycm0 == 'Y' ]]; then
		$CLANG=--clang-completer
	fi
	if [[ config_ycm1 == 'y' || config_ycm1 == 'Y' ]]; then
		if type go >/dev/null 2>&1; then
			$GOLANG=--go-completer
		else
			install_golang_workflow
			$GOLANG=--go-completer
		fi
	fi
	if [[ config_ycm2 == 'y' || config_ycm2 == 'Y' ]]; then
		if type npm >/dev/null 2>&1; then
			npm install -g typescript
		else
			install_node_workflow && npm install -g typescript
		fi
	fi
	if [[ config_ycm3 == 'y' || config_ycm3 == 'Y' ]]; then
		if type npm >/dev/null 2>&1; then
			$JAVASCRIPT=--js-completer
		else
			install_node_workflow && $JAVASCRIPT=--js-completer
		fi
	fi
	if [[ config_ycm4 == 'y' || config_ycm4 == 'Y' ]]; then
		if type rustc >/dev/null 2>&1; then
			$RUST=--rust-completer
		else
			install_rust_workflow && $RUST=--rust-completer
		fi
	fi
	cd ~/.vim/plugged/YouCompleteMe && ./install.py $CLANG $CSHARP $GOLANG $JAVASCRIPT $RUST
}

install_vim() {
	echo "later you will need to exit vim by entering ':q RET'"
	echo "that means press ':' and then 'q', which is followed by RET"
	ln -s ~/snapsisy_linux_config/layers/cmd/.vimrc ~/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	if [[ -f ~/.vim/autoload/plug.vim ]]; then
		vim +PlugInstall
		install_ycm
	fi
}

install_tmux() {
	cd ~ && curl -fLo ~/.tmux/airline-dracula.tmux --create-dirs https://raw.githubusercontent.com/sei40kr/tmux-airline-dracula/master/airline-dracula.tmux
	echo "run-shell '. ~/.tmux/airline-dracula.tmux'" > ~/.tmux.conf
	if [[ -d ~/.tmux ]]; then
		tmux source ~/.tmux.conf
	fi
}

install_zsh
install_vim
install_tmux

chsh -s /bin/zsh
