# Dotfiles

This setup is based on a dotfile configuration management method originally
posted by user [StreakyCobra](https://news.ycombinator.com/user?id=StreakyCobra)
to a [HackerNews thread](https://news.ycombinator.com/item?id=11070797) and
further detailed in [this blog post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

## Install

### Vim

In order to make use of [gundo](https://github.com/sjl/gundo.vim), we need a
version of [Vim](https://www.vim.org/) that includes Python2 and in order to
many other plugins, we need a version of Vim that includes Python3, so in order
to get a version of Vim that supports both (plus a host of other extras)
without building from source, we use the
[pi-rho PPA](https://launchpad.net/~pi-rho/+archive/ubuntu/dev) and follow
[this guide](https://askubuntu.com/a/775073).

Run the following commands (or their equivalent):
```bash
# Purge other vim versions
$ sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
# Add the pi-rho PPA
$ sudo add-apt-repository -y ppa:pi-rho/dev
$ sudo apt update
# Check the available pi-rho version using this command
$ sudo apt-cache policy vim-gtk
# Run (something like) the following to install
$ sudo apt install libruby # Add Ruby support as a bonus
$ sudo apt install libperl-dev # Add Perl support as a bonus
$ sudo apt install vim-common=2:8.0.0134-1ubuntu1~ppa1~x vim-gui-common=2:8.0.0134-1ubuntu1~ppa1~x vim-runtime=2:8.0.0134-1ubuntu1~ppa1~x vim-gtk=2:8.0.0134-1ubuntu1~ppa1~x
```
