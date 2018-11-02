#!/bin/bash

clear
echo -n "Enter your password: "
read password

# ---------------------------------------------------------
# 中文：修改Sudo指令為不用Password執行
# Eng:  change all sudoers to run sudo without password
# ---------------------------------------------------------
echo -e "$password" | sudo sed -i "s/ALL=(ALL:ALL) ALL/ALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers
sudo sed -i "s/auth       required   pam_shells.so/auth       sufficient   pam_shells.so/" /etc/pam.d/chsh


# ---------------------------------------------------------
# 中文：修改apt sources、更新及安裝基本軟件包
# Eng:  change all sudoers to run sudo without password
# ---------------------------------------------------------
sudo chmod 700 /etc/apt/sources.list

echo '' | sudo tee /etc/apt/sources.list && sudo cat /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu bionic main restricted' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://archive.ubuntu.com/ubuntu bionic main restricted' | sudo tee -a /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu bionic-updates main restricted' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://archive.ubuntu.com/ubuntu bionic-updates main restricted' | sudo tee -a /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu bionic universe' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://archive.ubuntu.com/ubuntu bionic universe' | sudo tee -a /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu bionic-updates universe' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://archive.ubuntu.com/ubuntu bionic-updates universe' | sudo tee -a /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu bionic multiverse' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://archive.ubuntu.com/ubuntu bionic multiverse' | sudo tee -a /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu bionic-updates multiverse' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://archive.ubuntu.com/ubuntu bionic-updates multiverse' | sudo tee -a /etc/apt/sources.list
echo 'deb http://archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list
echo 'deb http://security.ubuntu.com/ubuntu bionic-security main restricted' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://security.ubuntu.com/ubuntu bionic-security main restricted' | sudo tee -a /etc/apt/sources.list
echo 'deb http://security.ubuntu.com/ubuntu bionic-security universe' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://security.ubuntu.com/ubuntu bionic-security universe' | sudo tee -a /etc/apt/sources.list
echo 'deb http://security.ubuntu.com/ubuntu bionic-security multiverse' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://security.ubuntu.com/ubuntu bionic-security multiverse' | sudo tee -a /etc/apt/sources.list

sudo apt update
sudo apt upgrade -y
sudo apt-get install -y vim zsh git htop wget tree make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev

# ---------------------------------------------------------
# 中文：加入vim基本設定
# Eng:  add vim base setting
# ---------------------------------------------------------
echo 'set number' >> $HOME/.vimrc
echo 'syntax on' >> $HOME/.vimrc
cat $HOME/.vimrc

# ---------------------------------------------------------
# 中文：新建所需檔案夾及調整權限
# Eng:  make directory and adjust the permission
# ---------------------------------------------------------
mkdir -p $HOME/.ssh
touch $HOME/.ssh/authorized_keys
chmod 600 $HOME/.ssh/authorized_keys
sudo mkdir -p /server/{git,lab}
sudo chown -R $(whoami):$(whoami) /server

# ---------------------------------------------------------
# 中文：安裝zsh及oh-my-zsh
# Eng:  instlal zsh and oh-my-zsh
# ---------------------------------------------------------
echo "exit" | sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh::g' | sed 's:chsh -s .*$::g')"

sed -i "s/robbyrussell/agnoster/g" $HOME/.zshrc
sed -i ':a;N;$!ba;s/plugins=(\n  git\n)/plugins=(\n  git\n  pyenv\n)/g' $HOME/.zshrc

wget https://raw.githubusercontent.com/cain2/ase/master/L2.sh
/bin/zsh $(pwd)/L2.sh

rm -Rf L2.sh