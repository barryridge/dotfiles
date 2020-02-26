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
# alias tmux='env TERM=screen-256color /usr/bin/tmux-next'

# kitty icat - Display images in the terminal
# See: https://sw.kovidgoyal.net/kitty/kittens/icat.html
alias icat="kitty +kitten icat"

# kitty diff - A fast side-by-side diff tool with syntax highlighting and images
# See: https://sw.kovidgoyal.net/kitty/kittens/diff.html
alias d="kitty +kitten diff"
