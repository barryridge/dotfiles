# Dotfiles

This setup is based on a dotfile configuration management method originally
posted by user [StreakyCobra](https://news.ycombinator.com/user?id=StreakyCobra)
to a [HackerNews thread](https://news.ycombinator.com/item?id=11070797) and
further detailed in [this blog post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

The following assumes a Ubuntu 16.04 setup.

## Install

### Prerequisites

#### Terminator

To get the latest version of [terminator](https://gnometerminator.blogspot.jp/),
use a PPA as follows:
```bash
$ sudo add-apt-repository ppa:gnome-terminator/nightly-gtk3
$ sudo apt update
```
and
```bash
$ sudo apt install terminator
```
or
```bash
$ sudo apt upgrade
```
if terminator is already installed.

#### Tmux

To get the latest version of [tmux](https://github.com/tmux/tmux/wiki),
we use the same PPA as above and install as follows:
```bash
$ sudo apt install tmux-next
```
An alias in `.bash_aliases` maps `tmux` to this version.

Install `xclip` in order to enable copying from the tmux buffer to the system
buffer (clipboard). See [here](http://www.rushiagr.com/blog/2016/06/16/everything-you-need-to-know-about-tmux-copy-pasting-ubuntu/)

#### Ranger

To get [Ranger](http://ranger.nongnu.org/) support in vim, it is necessary to
install Ranger:
```bash
sudo apt install ranger
```

#### Ctags

In order to use [tagbar](https://github.com/majutsushi/tagbar) for
[taskwiki](https://github.com/tbabej/taskwiki), a version of `ctags` needs
to be installed.  Follow the installation instructions for
[universal-ctags](https://github.com/universal-ctags/ctags):
```bash
$ git clone https://github.com/universal-ctags/ctags
$ cd ctags
$ ./autogen.sh
$ ./configure
$ make -j
$ sudo make install
```

#### Taskwarrior

To install [Taskwarrior](https://taskwarrior.org):

```bash
$ sudo apt install taskwarrior
```
To install [tasklib](https://github.com/tbabej/tasklib/tree/develop), a Python library for Taskwarrior:

```bash
pip2 install --user --upgrade git+git://github.com/tbabej/tasklib@develop
pip3 install --user --upgrade git+git://github.com/tbabej/tasklib@develop
```

To set up task syncing using the
[free taskcinc.com taskserver service](https://freecinc.com), follow the
instructions in `~/Sync/taskwarrior/freeinc.com/`.

#### Ruby on Rails

Follow the guide [here](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-16-04)
to install [Ruby on Rails](https://rubyonrails.org/) using
[rbenv](https://github.com/rbenv/rbenv).

[rbenv](https://github.com/rbenv/rbenv) and
[ruby-build](https://github.com/rbenv/ruby-build) are set to auto-install from
`.bashrc`.

After that, ruby may be installed as follows:
```bash
$ rbenv install 2.5.0
$ rbenv global 2.5.0
```
And rails may be installed with:
```bash
$ gem install rails
```

#### Node.js

Follow the guide [here](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04)
to install node.js using [nvm](https://github.com/creationix/nvm):
```bash
$ curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
$ bash install_nvm.sh
$ source ~/.bashrc
# List currently available node versions
$ nvm ls-remote
$ nvm install 8.11.2
$ nvm use 8.11.2
```

#### Vim

To install Vim 8.0+ in Ubuntu 16.04 without compiling from source, we use a PPA:
```bash
$ sudo add-apt-repository ppa:jonathonf/vim
$ sudo apt update
$ sudo apt install vim vim-gtk
```
In order to use the [vim-ros](https://github.com/taketwo/vim-ros) plugin,
a version of vim compiled with Python2 support is required. This can be
installed separately:
```bash
$ sudo apt install vim-nox vim-nox-py2
```

##### vimwiki_markdown

To use [vimwiki](https://github.com/vimwiki/vimwiki) with
[Markdown](https://en.wikipedia.org/wiki/Markdown) and be able to export to
HTML, we make use of the
[vimwiki_markdown](https://github.com/patrickdavey/vimwiki_markdown) package.

#### vim-instant-markdown

To install [instant-markdown](https://github.com/suan/vim-instant-markdown),
we need to run:
```bash
$ npm -g install instant-markdown-d
```
#### Spacemacs

To install [Spacemacs](http://spacemacs.org) (an "Emacs advanced Kit focused on Evil",
with the philosophy that "The best editor is neither Emacs nor Vim, it's Emacs and Vim!"):

1. Install [Emacs](https://www.gnu.org/software/emacs/) (Yes, yes, I know, I know...).
Version 25.1 can be acquired [via PPA](https://www.reddit.com/r/emacs/comments/55hnxo/best_way_to_update_on_ubuntu/d8b8jtg/):
```bash
$ sudo add-apt-repository ppa:kelleyk/emacs
$ sudo apt-get update
$ sudo apt-get install emacs26
$ sudo update-alternatives --config emacs
```
2. Back up any previous emacs config:
```bash
$ cd ~
$ mv .emacs.d .emacs.d.bak
$ mv .emacs .emacs.bak
```
3. Clone the Spacemacs repo and checkout the `develop` branch:
```bash
$ git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
$ cd ~/.emacs.d
$ git checkout develop
$ git pull --rebase
```
4. Install the [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) font:
```bash
$ curl https://gist.githubusercontent.com/lucasdavila/3875946/raw/1c100cae16a06bef154af0f290d665405b554b3b/install_source_code_pro.sh | sh
```
5. Launch emacs:
```bash

$ emacs
```
6. Restart emacs to complete the installation:
```bash
$ emacs
```

#### Python, Pip, Anaconda, Etc.

Ubuntu 16.04 should come with Python 2 and 3 out of the box.

`.local/bin` has been added to `$PATH` in `.bashrc`.

##### Pip

Pip 10 has been [known to cause issues](https://github.com/pypa/pip/issues/5221)
with Debian/Ubuntu systems. The following procedure **should** be robust for
getting local Python 2/3 pip installs.

First, remove system pip:
```bash
$ sudo apt remove python-pip
$ sudo apt remove python3-pip
```

Then install use `get-pip.py` to install local versions of pip:
```bash
$ wget https://bootstrap.pypa.io/get-pip.py
$ python get-pip.py --user --upgrade pip
$ python3 get-pip.py --user --upgrade pip
```
This might also be helpful:
```bash
$ python -m pip install --user --upgrade pip
$ python3 -m pip install --user --upgrade pip
```

##### Anaconda

Install Anaconda3:
```bash
$ wget https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh
$ bash Anaconda3-5.1.0-Linux-x86_64.sh
```

If Anaconda3 is present, `.bashrc` auto-installs a handy script called
[.anaconda_with_ros_wrapper.bash](https://gist.github.com/StefanFabian/17fa715e783cd2be6a32cd5bbb98acd9)
that allows a ROS-friendly Anaconda path setup to be invoked via
`release-the-snake` (or de-invoked via `cage-the-snake`).

#### Linters and Language Servers

##### Python

Install Python linters:
```bash
$ pip install --user pep8 flake8 pyflakes isort yapf
$ pip3 install --user pep8 flake8 pyflakes isort yapf
```

Install Python language server:
```bash
$ pip install --user python-language-server
$ pip3 install --user python-language-server
```

#### LaTeX

##### vimtex

Install [mupdf](https://mupdf.com):
```bash
$ sudo apt install mupdf
```
