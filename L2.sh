#!/bin/zsh

# =========================================================
# 中文：重入載入SHELL
# Eng:  reload the SHELL
# =========================================================
source $HOME/.zshrc
# exec $SHELL

# ---------------------------------------------------------
# 中文：使用pyenv-installer安裝pyenv
# Eng:  install pyenv with pyenv-installer
# ---------------------------------------------------------
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshrc
echo 'if command -v pyenv 1>/dev/null 2>&1; then' >> $HOME/.zshrc
echo '  eval "$(pyenv init -)"' >> $HOME/.zshrc
echo '  eval "$(pyenv virtualenv-init -)"' >> $HOME/.zshrc
echo 'fi' >> $HOME/.zshrc

export PATH="/home/test2/.pyenv/bin:$PATH"

# ---------------------------------------------------------

# =========================================================
# 中文：重入載入SHELL
# Eng:  reload the SHELL
# =========================================================
source $HOME/.zshrc
# exec $SHELL

# 中文：安裝系統層python
# ---------------------------------------------------------
sudo apt-get install -y python python-dev python-pip

# ---------------------------------------------------------
# 中文：安裝python 2.7.15及3.7.0
# Eng:  install python 2.7.15 and 3.7.0
# ---------------------------------------------------------
pyenv global system

pip install --upgrade pip

# ---------------------------------------------------------
# 中文：安裝nvm
# Eng:  install nvm and node v8.9.4
# ---------------------------------------------------------
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> $HOME/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> $HOME/.zshrc

echo 'autoload -U add-zsh-hook' >> $HOME/.zshrc
echo 'load-nvmrc() {' >> $HOME/.zshrc
echo '  local node_version="$(nvm version)"' >> $HOME/.zshrc
echo '  local nvmrc_path="$(nvm_find_nvmrc)"' >> $HOME/.zshrc
echo '  if [ -n "$nvmrc_path" ]; then' >> $HOME/.zshrc
echo '    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")' >> $HOME/.zshrc
echo '    if [ "$nvmrc_node_version" = "N/A" ]; then' >> $HOME/.zshrc
echo '      nvm install' >> $HOME/.zshrc
echo '    elif [ "$nvmrc_node_version" != "$node_version" ]; then' >> $HOME/.zshrc
echo '      nvm use' >> $HOME/.zshrc
echo '    fi' >> $HOME/.zshrc
echo '  elif [ "$node_version" != "$(nvm version default)" ]; then' >> $HOME/.zshrc
echo '    echo "Reverting to nvm default version"' >> $HOME/.zshrc
echo '    nvm use default' >> $HOME/.zshrc
echo '  fi' >> $HOME/.zshrc
echo '}' >> $HOME/.zshrc
echo 'add-zsh-hook chpwd load-nvmrc' >> $HOME/.zshrc
echo 'load-nvmrc' >> $HOME/.zshrc

# =========================================================
# 中文：重入載入SHELL
# Eng:  reload the SHELL
# =========================================================
source $HOME/.zshrc
# exec $SHELL

nvm install v8.9.4
nvm alias default v8.9.4
nvm use default

# ---------------------------------------------------------
# 中文：安裝ruby
# Eng:  instlal ruby
# ---------------------------------------------------------

sudo apt-get install -y ruby ruby-dev libpam-dev
sudo gem install rpam-ruby19

mkdir -p $HOME/tmp

# ---------------------------------------------------------
# 中文：安裝go
# Eng:  instlal go language
# ---------------------------------------------------------

cd $HOME/tmp
wget -q https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x installer_linux
./installer_linux

# =========================================================
# 中文：重入載入SHELL
# Eng:  reload the SHELL
# =========================================================
source $HOME/.zshrc
# exec $SHELL


echo 'export GOPATH=$HOME/go' >> $HOME/.zshrc
echo 'export PATH=$PATH:$HOME/go/bin' >> $HOME/.zshrc
echo 'export PATH=$PATH:$HOME/.go/bin' >> $HOME/.zshrc

# =========================================================
# 中文：重入載入SHELL
# Eng:  reload the SHELL
# =========================================================
source $HOME/.zshrc
# exec $SHELL


go get -u github.com/jingweno/ccat
echo 'alias cat="ccat"' >> $HOME/.zshrc

# ---------------------------------------------------------
# 中文：安裝powerline-shell
# Eng:  install powerline-shell
# ---------------------------------------------------------
cd $HOME/tmp
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
sudo python setup.py install

echo 'function powerline_precmd() {' >> $HOME/.zshrc
echo '    PS1="$(powerline-shell --shell zsh $?)"' >> $HOME/.zshrc
echo '}' >> $HOME/.zshrc
echo 'function install_powerline_precmd() {' >> $HOME/.zshrc
echo '  for s in "${precmd_functions[@]}"; do' >> $HOME/.zshrc
echo '    if [ "$s" = "powerline_precmd" ]; then' >> $HOME/.zshrc
echo '        return' >> $HOME/.zshrc
echo '    fi' >> $HOME/.zshrc
echo '  done' >> $HOME/.zshrc
echo '  precmd_functions+=(powerline_precmd)' >> $HOME/.zshrc
echo '}' >> $HOME/.zshrc
echo 'if [ "$TERM" != "linux" ]; then' >> $HOME/.zshrc
echo '    install_powerline_precmd' >> $HOME/.zshrc
echo 'fi' >> $HOME/.zshrc

mkdir -p $HOME/.config/powerline-shell
powerline-shell --generate-config > $HOME/.config/powerline-shell/config.json

echo '{' > $HOME/.config/powerline-shell/config.json
echo '  "segments": [' >> $HOME/.config/powerline-shell/config.json
echo '    "hostname",' >> $HOME/.config/powerline-shell/config.json
echo '    "virtual_env",' >> $HOME/.config/powerline-shell/config.json
echo '    "aws_profile",' >> $HOME/.config/powerline-shell/config.json
echo '    "time",' >> $HOME/.config/powerline-shell/config.json
echo '    "ssh",' >> $HOME/.config/powerline-shell/config.json
echo '    "cwd",' >> $HOME/.config/powerline-shell/config.json
echo '    "git",' >> $HOME/.config/powerline-shell/config.json
echo '    "git_stash",' >> $HOME/.config/powerline-shell/config.json
echo '    "jobs",' >> $HOME/.config/powerline-shell/config.json
echo '    "set_term_title",' >> $HOME/.config/powerline-shell/config.json
echo '    "newline",' >> $HOME/.config/powerline-shell/config.json
echo '    "node_version",' >> $HOME/.config/powerline-shell/config.json
echo '    "root"' >> $HOME/.config/powerline-shell/config.json
echo '  ],' >> $HOME/.config/powerline-shell/config.json
echo '  "mode":"flat",' >> $HOME/.config/powerline-shell/config.json
echo '  "cwd": {' >> $HOME/.config/powerline-shell/config.json
echo '    "mode": "plain",' >> $HOME/.config/powerline-shell/config.json
echo '    "max_depth": 3' >> $HOME/.config/powerline-shell/config.json
echo '  },' >> $HOME/.config/powerline-shell/config.json
echo '  "time": {' >> $HOME/.config/powerline-shell/config.json
echo '  }' >> $HOME/.config/powerline-shell/config.json
echo '}' >> $HOME/.config/powerline-shell/config.json

# =========================================================
# 中文：重入載入SHELL
# Eng:  reload the SHELL
# =========================================================
source $HOME/.zshrc
# exec $SHELL

# ---------------------------------------------------------
# 中文：安裝brew
# Eng:  install brew
# ---------------------------------------------------------
# echo -e "\n" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
# test -d $HOME/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
# test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
# test -r $HOME/.zshrc && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >> $HOME/.zshrc
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

# git clone https://github.com/Linuxbrew/brew.git ~/.linuxbrew
# echo 'PATH="$HOME/.linuxbrew/bin:$PATH"' >> $HOME/.zshrc
# echo 'export MANPATH="$(brew --prefix)/share/man:$MANPATH"' >> $HOME/.zshrc
# echo 'export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"' >> $HOME/.zshrc

# =========================================================
# 中文：重入載入SHELL
# Eng:  reload the SHELL
# =========================================================
source $HOME/.zshrc
# exec $SHELL

# brew install glances # something like htop

# ---------------------------------------------------------
# =========================================================
# 中文：取得所有語言版本號
# Eng:  get version of all of the package
# =========================================================
# ---------------------------------------------------------
mkdir -p $HOME/.pyenv/cache
cd $HOME/.pyenv/cache
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
wget https://www.python.org/ftp/python/2.7.15/Python-2.7.15.tar.xz

echo -e "N" | pyenv install 2.7.15 -v 
echo -e "N" | pyenv install 3.7.0 -v
pyenv rehash
pyenv global 2.7.15

clear
echo "# ========================================================="
echo "# ASE Environment (build 1062)"
echo "# ========================================================="
echo 
echo "Ruby version:\t$(ruby -v)"
echo "Gem version:\t$(gem -v)"
echo "Go version:\t$(go version)"
echo "NVM version:\t$(nvm --version)"
echo "Node version:\t$(nvm current)"
echo "PYENV version:\t$(pyenv -v)"
echo "Python versions:\n$(pyenv versions)"
echo 
echo "# ========================================================="

# =========================================================
# 壓
# tar cf - 2.7.15 | xz -z - > 2.7.15.tar.xz
# tar cf - 3.7.0 | xz -z - > 3.7.0.tar.xz

# 解
# tar xvJf 2.7.15.tar.xz
# tar xvJf 3.7.0.tar.xz
# =========================================================
