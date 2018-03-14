#!/bin/bash

################################################################################################
install_zsh() {
	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	config_zsh
	sed -i "s/robbyrussell/$CHOSEN_THEME/g" ~/.zshrc
}

install_node_workflow() {
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
	nvm install node && nvm use node
}

install_python_workflow() {
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
	echo 'export PATH="~/.pyenv/bin:$PATH"' >> .zshrc
	echo 'eval "$(pyenv init -)"' >> .zshrc
	echo 'eval "$(pyenv virtualenv-init -)"' >> .zshrc
}

install_golang_workflow() {
	git clone https://github.com/syndbg/goenv.git ~/.goenv
	echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.zshrc
	echo 'export PATH="$GOENV_ROOT/bin:$PATH"' >> ~/.zshrc
	echo 'eval "$(goenv init -)"' >> ~/.zshrc
	export GOENV_ROOT="$HOME/.goenv"
	export PATH="$GOENV_ROOT/bin:$PATH"
	echo 'the go dev environment is ok, run "goenv install (version)" to make your golang environment work'
}

install_rust_workflow() {
	curl https://sh.rustup.rs -sSf | sh
}

install_ycm() {
	config_ycm
	if [[ $config_ycm_cocpp == 'y' || $config_ycm_cocpp == 'Y' ]]; then
		CLANG=--clang-completer
	fi
	if [[ $config_ycm_python == 'y' || $config_ycm_python == 'Y' ]]; then
		install_python_workflow
	fi
	if [[ $config_ycm_go == 'y' || $config_ycm_go == 'Y' ]]; then
		if type go >/dev/null 2>&1; then
			GOLANG=--go-completer
		else
			install_golang_workflow
			GOLANG=--go-completer
		fi
	fi
	if [[ $config_ycm_ts == 'y' || $config_ycm_ts == 'Y' ]]; then
		if type npm >/dev/null 2>&1; then
			npm install -g typescript
		else
			install_node_workflow && npm install -g typescript
		fi
	fi
	if [[ $config_ycm_js == 'y' || $config_ycm_js == 'Y' ]]; then
		if type npm >/dev/null 2>&1; then
			JAVASCRIPT=--js-completer
		else
			install_node_workflow && JAVASCRIPT=--js-completer
		fi
	fi
	if [[ $config_ycm_rust == 'y' || $config_ycm_rust == 'Y' ]]; then
		if type rustc >/dev/null 2>&1; then
			RUST=--rust-completer
		else
			install_rust_workflow && RUST=--rust-completer
		fi
	fi
	cd ~/.vim/plugged/YouCompleteMe && ./install.py $CLANG $CSHARP $GOLANG $JAVASCRIPT $RUST
}

install_vim() {
	echo ===========================================================================================================
	echo "later you will need to exit vim by entering ':q RET'"
	echo "that means press ':' and then 'q', which is followed by RET"
	echo ===========================================================================================================
	ln -s ~/snapsisy_linux_config/layers/cmd/.vimrc ~/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	if [[ -f ~/.vim/autoload/plug.vim ]]; then
		vim +PlugInstall
		install_ycm
	fi
}

install_zsh
install_vim

chsh -s /bin/zsh
