#!/bin/bash

# export password="your_own_password"

echo "=====-=====-=====-=====-=====-=====-=====-====="
echo "Installation start..."

# echo "changing root password..."
# echo -e "$password\n$password" | sudo passwd root

echo "changing ssh setting..."
sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

echo "restarting ssh service..."
service ssh restart

echo "ip address:"
ifconfig | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}'

echo "updating apt source..."
apt -y update
apt -y upgrade

echo "installing core packages..."
apt install -y curl wget htop make git
apt install -y python python-dev
apt install -y build-essential
apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev

echo "installing powerline-shell..."
mkdir -p /server/git
cd /server/git
git clone https://github.com/milkbikis/powerline-shell /server/git/powerline-shell
cd /server/git/powerline-shell && ./install.py

ln -s /server/git/powerline-shell/powerline-shell.py ~/powerline-shell.py

echo "installing oh-my-zsh..."
apt install -y zsh
echo -e "exit" | sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" >/dev/null 2>&1
sed -i "s/robbyrussell/agnoster/g" ~/.zshrc
sed -i "s/plugins=(git)/plugins=(git pyenv)/g" ~/.zshrc

echo "installing pyenv & pyenv-virtualenv..."
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

echo "binding pyenv with oh-my-zsh..."
echo 'function powerline_precmd() {' >> ~/.zshrc
echo '    PS1="$(~/powerline-shell.py $? --shell zsh 2> /dev/null)"' >> ~/.zshrc
echo '}' >> ~/.zshrc
echo '' >> ~/.zshrc
echo 'function install_powerline_precmd() {' >> ~/.zshrc
echo '  for s in "${precmd_functions[@]}"; do' >> ~/.zshrc
echo '    if [ "$s" = "powerline_precmd" ]; then' >> ~/.zshrc
echo '      return' >> ~/.zshrc
echo '    fi' >> ~/.zshrc
echo '  done' >> ~/.zshrc
echo '  precmd_functions+=(powerline_precmd)' >> ~/.zshrc
echo '}' >> ~/.zshrc
echo '' >> ~/.zshrc
echo 'if [ "$TERM" != "linux" ]; then' >> ~/.zshrc
echo '    install_powerline_precmd' >> ~/.zshrc
echo 'fi' >> ~/.zshrc
echo '' >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo '' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

echo "binding pyenv with oh-my-zsh..."
echo 'export LANG="en_US.UTF-8"' >> ~/.zshrc
echo 'export LANGUAGE="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_CTYPE="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_NUMERIC="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_TIME="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_COLLATE="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_MONETARY="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_MESSAGES="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_PAPER="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_NAME="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_ADDRESS="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_TELEPHONE="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_MEASUREMENT="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_IDENTIFICATION="en_US.UTF-8"' >> ~/.zshrc
echo 'export LC_ALL="en_US.UTF-8"' >> ~/.zshrc

echo "misc setting..."
echo 'set number' > ~/.vimrc
echo 'syntax on' >> ~/.vimrc

echo "ssh setting up..."
apt install -y openssh-server
mkdir ~/.ssh -p
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

echo "remove myself..."
rm -Rf ~/1604.sh
echo "done!"
sudo reboot -h now
# exec $SHELL
