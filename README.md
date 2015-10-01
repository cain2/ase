### vm-auto-config
Auto pre-config for Linux (now just on Ubuntu Server)

Author: [cain](mailto:cain@f5workshop.com)
Version: 0.01 *(build 45)*

#### system environment:
OS: Ubuntu Server LTS 14.04.3
Kernel: 3.19.0-25-generic

#### installation:
##### via CURL
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cain2/vm-auto-config/master/vm-auto-config.sh)"
```

##### via WGET
```bash
sh -c "$(wget https://raw.githubusercontent.com/cain2/vm-auto-config/master/vm-auto-config.sh -O -)"
```

#### features:
0. install git-core software-properties-common htop tree zsh
+ libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev for __pyenv environment__
+ enable ssh root login
+ apt sources change to cuhk.edu.hk
+ preset vim display setting through .vimrc
+ touch the authroized_keys file for ssh-copy-id
+ install [powerline-shell](https://github.com/milkbikis/powerline-shell) both for bash & zsh from github repo
+ install [pyenv](https://github.com/yyuu/pyenv) & [pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv) from github repo
+ fix locale setting to en_US.UTF-8
+ add time record for bash_history
+ change localtime to Asia/Hong_Kong
+ install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and change theme to agnoster

#### todo:
+ more os supporting
+ installing from direct-link from github
+ researching

#### latest update:
1 October 2015 (18:46:47)
