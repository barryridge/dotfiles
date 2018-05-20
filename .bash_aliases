#==============================================================================
# .bash_aliases
#
# Author: Barry Ridge
# Source: https://github.com/barryridge/dotfiles
#==============================================================================

# Create an alias 'config' to be used instead of 'git'
# when interacting with dotfile configuration repository.
# 
# See: https://news.ycombinator.com/item?id=11071754
#      https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Map `tmux` to `tmux-next`
alias tmux='tmux-next'
