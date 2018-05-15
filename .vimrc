"==============================================================================
" Barry Ridge's .vimrc
"==============================================================================

"------------------------------------------------------------------------------
" Plugins
"------------------------------------------------------------------------------
" Initialize vim-plug
call plug#begin()

" Basics
" ------
" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Colors
" ------
" one colorscheme pack to rule them all!
Plug 'flazz/vim-colorschemes'
" Miscellaneous auto-load Vim scripts (required by vim-colorscheme-switcher)
Plug 'xolox/vim-misc'
" Makes it easy to switch between color schemes in Vim
Plug 'xolox/vim-colorscheme-switcher'

" Syntax / Lint
" -----------
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" Markdown Vim Mode
Plug 'plasticboy/vim-markdown'

" Deinitialize vim-plug
call plug#end()

"------------------------------------------------------------------------------
" Colors
"------------------------------------------------------------------------------
" Set number of colors
set t_Co=256

" Set colour scheme (see: http://stevelosh.com/projects/badwolf/)
colorscheme badwolf

"------------------------------------------------------------------------------
" Syntax / Lint
"------------------------------------------------------------------------------
" Enable syntax highlighting (see: https://stackoverflow.com/a/33380495)
if !exists("g:syntax_on")
    syntax enable
endif
