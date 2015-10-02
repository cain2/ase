#!/bin/bash

# make the base directory if need
mkdir -p /server/repo
mkdir -p /server/cmd

# change apt sources to cuhk.edu.hk
cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty main restricted universe multiverse" > /etc/apt/sources.list
echo "deb http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://ftp.cuhk.edu.hk/pub/Linux/ubuntu trusty-proposed main restricted universe" >> /etc/apt/sources.list

# update apt source first
apt-get update
# some dependent packages
apt-get install -y git-core software-properties-common htop tree zsh python
# those packages for pyenv
apt-get install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev

# enable ssh root login
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cd /etc/ssh/ && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' sshd_config

# touch the authroized_keys file prepare for ssh-copy-id
mkdir -p $HOME/.ssh
touch $HOME/.ssh/authorized_keys

# install powerline-shell
git clone https://github.com/milkbikis/powerline-shell.git /server/repo/powerline-shell
cd /server/repo/powerline-shell && python install.py
rm -f $HOME/powerline-shell.py
ln -s /server/repo/powerline-shell/powerline-shell.py $HOME/powerline-shell.py

# install pyenv
git clone https://github.com/yyuu/pyenv.git /server/repo/pyenv
ln -s /server/repo/pyenv ~/.pyenv

# install pyenv-virtualenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# write pyenv script for /bin/bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' > /server/cmd/pyenv.sh
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /server/cmd/pyenv.sh
echo 'eval "$(pyenv init -)"' >> /server/cmd/pyenv.sh
echo 'eval "$(pyenv virtualenv-init -)"' >> /server/cmd/pyenv.sh

# remove old setting if exists
sed -i 's/^.*\s#pyenv_init//g' $HOME/.bashrc
sed -i 's/^.*\s#bash_powerline//g' $HOME/.bashrc
sed -i '/^$/N;/^\n$/D' $HOME/.bashrc
if [ -f $HOME/.zshrc ]; then
    sed -i 's/^.*\s#zsh_powerline//g' $HOME/.zshrc
    sed -i '/^$/N;/^\n$/D' $HOME/.zshrc
fi

# add powerline-shell init script
echo 'function _update_ps1() { #bash_powerline' >> $HOME/.bashrc
echo 'PS1="$(~/powerline-shell.py $? 2> /dev/null)" #bash_powerline' >> $HOME/.bashrc
echo '} #update_ps1 #bash_powerline' >> $HOME/.bashrc
echo 'if [ "$TERM" != "linux" ]; then #bash_powerline' >> $HOME/.bashrc
echo 'PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND" #bash_powerline' >> $HOME/.bashrc
echo 'fi #powerline-shell #bash_powerline' >> $HOME/.bashrc

# add pyenv & pyenv-virtualenv init script
echo "if [ -f /server/cmd/pyenv.sh ]; then #pyenv_init" >> $HOME/.bashrc
echo ". /server/cmd/pyenv.sh #pyenv_init" >> $HOME/.bashrc
echo "fi #pyenv #pyenv_init" >> $HOME/.bashrc

# fix .vimrc at $HOME
echo "set number" > $HOME/.vimrc
echo "syntax on" >> $HOME/.vimrc
echo "set ruler" >> $HOME/.vimrc
echo "set list" >> $HOME/.vimrc

# fix locale setting
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
locale-gen en_US en_US.UTF-8
dpkg-reconfigure locales

export HISTTIMEFORMAT="%d%m%y %T "
cp /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime

# restart ssh service
service ssh restart

# install oh-my-zsh and change theme to agnoster
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null;
sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME="agnoster"/g' $HOME/.zshrc

# for pyenv init script
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshrc

# oh-my-zsh + powerline shell integration
echo 'function powerline_precmd() { #zsh_powerline' >> $HOME/.zshrc
echo 'PS1="$(~/powerline-shell.py $? --shell zsh 2> /dev/null)" #zsh_powerline' >> $HOME/.zshrc
echo '} #zsh_powerline' >> $HOME/.zshrc
echo 'function install_powerline_precmd() { #zsh_powerline' >> $HOME/.zshrc
echo 'for s in "${precmd_functions[@]}"; do #zsh_powerline' >> $HOME/.zshrc
echo 'if [ "$s" = "powerline_precmd" ]; then #zsh_powerline' >> $HOME/.zshrc
echo 'return #zsh_powerline' >> $HOME/.zshrc
echo 'fi #zsh_powerline' >> $HOME/.zshrc
echo 'done #zsh_powerline' >> $HOME/.zshrc
echo 'precmd_functions+=(powerline_precmd) #zsh_powerline' >> $HOME/.zshrc
echo '} #zsh_powerline' >> $HOME/.zshrc
echo 'if [ "$TERM" != "linux" ]; then #zsh_powerline' >> $HOME/.zshrc
echo 'install_powerline_precmd #zsh_powerline' >> $HOME/.zshrc
echo 'fi #zsh_powerline' >> $HOME/.zshrc

# oh-my-zsh + pyenv & pyenv-virtualenv integration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshenv
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshenv
echo 'eval "$(pyenv init -)"' >> $HOME/.zshenv
echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.zshenv
