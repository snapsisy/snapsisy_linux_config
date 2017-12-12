sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sudo echo "deb https://mirrors.ustc.edu.cn/ubuntu xenial-proposed main restricted universe multiverse" >> /etc/apt/sources.list
sudo apt -y update && sudo apt -y full-upgrade && sudo apt -y install vim-nox emacs git curl wget axel aria2 python-all-dev python3-all-dev python-dev python3-dev python-pip python3-pip python-setuptools python3-setuptools libncursesw5-dev libncurses5-dev libsqlite3-dev libbz2-dev libzip-dev libreadline-dev make build-essential libssl-dev zlib1g-dev llvm xz-utils tk-dev clang cmake cmake-curses-gui cmake-qt-gui shadowsocks
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
curl -fLo "https://raw.githubusercontent.com/snapsisy/snapsisy_dot_files/master/.tmux.conf.local"
export HTTP_PROXY=127.0.0.1:1080
export HTTPS_PROXY=127.0.0.1:1080
export SOCK5=127.0.0.1:1080
vim +PlugInstall
