# Create an alias 'config' to be used instead of 'git'
# when interacting with dotfile configuration repository.
# 
# See: https://news.ycombinator.com/item?id=11071754
#      https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
#
alias config='/usr/bin/git --git-dir=/home0/barry.ridge/.cfg/ --work-tree=/home0/barry.ridge'
