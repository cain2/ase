### ase
it's called [a]wesome [s]hell [e]nvironment.

author: [cain](mailto:cain@jitpo.com)

version: 0.1


#### tested environment:
OS: Ubuntu Server (16.04.1 LTS)

Kernel: 4.4.0-38-generic (x86_64)


#### dependency repo(s):
[powerline-shell](https://github.com/milkbikis/powerline-shell)

[pyenv](https://github.com/yyuu/pyenv)

[pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv)

[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

*(listed in no particular order)*


#### features:
0. install git-core software-properties-common htop tree zsh
+ libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev for __pyenv environment__
+ enable ssh root login
+ preset vim display setting through .vimrc
+ touch the authroized_keys file for ssh-copy-id
+ install [powerline-shell](https://github.com/milkbikis/powerline-shell) both for bash & zsh from github repo
+ install [pyenv](https://github.com/yyuu/pyenv) & [pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv) from github repo
+ fix locale setting to en_US.UTF-8
+ install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and change theme to agnoster


#### installation:
just run the following one-line script as root.


##### via curl
```bash
sudo sh -c "$(curl -fsSL https://raw.github.com/cain2/ase/master/ase.sh)"
```

##### via wget
```bash
sudo sh -c "$(wget https://raw.github.com/cain2/ase/master/ase.sh -O -)"
```


##### result
your screen should like this now:

<img src="https://raw.githubusercontent.com/cain2/ase/master/capture/capture-1.png" width="300px">

and you get the same shell environment as me now.


#### latest update:
30 September 2016


#### release note:
30 September 2016 - 0.1:
* Ubuntu 16.04.1 supported
* make the code more straight forward

1 October 2015 - 0.01 (build 55):
* Ubuntu 14.04.3 supported
* first release version

#### license:
MIT License

[!important] changed the licnese of this repo to MIT (follow with dependency repo(s)). - 30 September 2016

