"==============================================================================
" .vimrc
"
" Author: Barry Ridge
" Source: https://github.com/barryridge/dotfiles
"
" Disclaimer: Useful snippets and associated comments have been copied from
" various sources over the years and I no longer recall their precise origins.
" Credit has been preserved wherever possible. Much can be attributed to Doug
" Black's guide: https://dougblack.io/words/a-good-vimrc.html
"==============================================================================

" Initialization {{{
"------------------------------------------------------------------------------
" Set up modeline to allow vimrc to be automatically folded.
" See: https://dougblack.io/words/a-good-vimrc.html 
set modeline
set modelines=1

" }}}

" Auto Installations {{{
" See: https://github.com/bag-man/dotfiles/blob/master/vimrc
"------------------------------------------------------------------------------
" vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    auto VimEnter * PlugInstall
endif

" ripgrep in fzf directory
if !empty(glob("~/.fzf/bin/fzf"))
    if empty(glob("~/.fzf/bin/rg"))
      silent !curl -fLo /tmp/rg.tar.gz
            \ https://github.com/BurntSushi/ripgrep/releases/download/0.4.0/ripgrep-0.4.0-x86_64-unknown-linux-musl.tar.gz
      silent !tar xzvf /tmp/rg.tar.gz --directory /tmp
      silent !cp /tmp/ripgrep-0.4.0-x86_64-unknown-linux-musl/rg ~/.fzf/bin/rg
    endif
endif

" }}}

" Plugins {{{
"------------------------------------------------------------------------------
" Initialize vim-plug
call plug#begin()

" Basics / Bindings
" -----------------
" Defaults everyone can agree on
Plug 'tpope/vim-sensible'
" pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Colors
" ------
" one colorscheme pack to rule them all!
Plug 'flazz/vim-colorschemes'
" Miscellaneous auto-load Vim scripts (required by vim-colorscheme-switcher)
Plug 'xolox/vim-misc'
" Makes it easy to switch between color schemes in Vim
Plug 'xolox/vim-colorscheme-switcher'

" Syntax / Lint
" -------------
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" Markdown Vim Mode
Plug 'plasticboy/vim-markdown'

" User Interface
" --------------
" super simple vim plugin to show the list of buffers in the command bar
Plug 'bling/vim-bufferline'
" lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
" A collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'
" Graph your Vim undo tree in style.
" Hint: '<leader>u' to open (see leader bindings below).
Plug 'sjl/gundo.vim'

" File Management / Navigation
" ----------------------------
" vinegar.vim: Combine with netrw to create a delicious salad dressing
" Hints: '-' to open, '~' to go home, 'gh' to toggle hidden files.
Plug 'tpope/vim-vinegar'
" helpers for UNIX
Plug 'tpope/vim-eunuch'
" Ranger integration in vim and neovim  
Plug 'francoiscabrol/ranger.vim'
" Ranger file manager for Vim
" Plug 'rafaqz/ranger.vim'

" Fuzzy Finding
" -------------
" A command-line fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" fzf heart vim
Plug 'junegunn/fzf.vim'

" Version Control
" ---------------
" a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Deinitialize vim-plug
call plug#end()

" }}}

" Colors {{{
"------------------------------------------------------------------------------
" Set colour scheme.
" See: https://github.com/morhetz/gruvbox
colorscheme gruvbox
" Enable dark mode.
set bg=dark

" }}}

" GVim Settings {{{
"------------------------------------------------------------------------------
if has("gui_running")
    " Set the X11 font to use
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
        
    " Hide the toolbar
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L

    " Hide the menu
    set guioptions-=m

    " Hide the mouse pointer while typing
    set mousehide

    " Right mouse button brings up popup window
    set mousem=popup
    
    " Set character encoding	
    set encoding=utf-8

    " Restore gVim screen size and position.
    " See: http://vim.wikia.com/wiki/Restore_screen_size_and_position
    function! ScreenFilename() abort
        if has('amiga')
          return "s:.vimsize"
        elseif has('win32')
          return $HOME.'\_vimsize'
        else
          return $HOME.'/.vimsize'
        endif
    endfunction

    function! ScreenRestore() abort
        " Restore window size (columns and lines) and position
        " from values stored in vimsize file.
        " Must set font first so columns and lines are based on font size.
        let f = ScreenFilename()
        if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
            let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
            for line in readfile(f)
                let sizepos = split(line)
                if len(sizepos) == 5 && sizepos[0] == vim_instance
                    silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
                    silent! execute "winpos ".sizepos[3]." ".sizepos[4]
                    return
                endif
            endfor
        endif
    endfunction
  
    function! ScreenSave() abort
        " Save window size and position.
        if has("gui_running") && g:screen_size_restore_pos
            let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
            let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
                    \ (getwinposx()<0?0:getwinposx()) . ' ' .
                    \ (getwinposy()<0?0:getwinposy())
            let f = ScreenFilename()
            if filereadable(f)
                let lines = readfile(f)
                call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
                call add(lines, data)
            else
                let lines = [data]
            endif
            call writefile(lines, f)
        endif
    endfunction
  
    if !exists('g:screen_size_restore_pos')
        let g:screen_size_restore_pos = 1
    endif
    if !exists('g:screen_size_by_vim_instance')
        let g:screen_size_by_vim_instance = 1
    endif
    autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
    autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif 

endif

" }}}

" User Interface {{{
"------------------------------------------------------------------------------
" Set leader to comma key.
let mapleader=","

" Automatic toggling between line number modes.
" See: https://jeffkreeftmeijer.com/vim-number/
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Show command in bottom bar.
"
" showcmd shows the last command entered in the very bottom right of Vim.
set showcmd

" Highlight current line.
"
" cursorline draws a horizontal highlight
" (or underline, depending on your colorschem)
" on the line your cursor is currently on.
set cursorline

" Visual autocomplete for command menu
"
" Will provide a graphical menu of all the matches you can cycle through
" when autocompleting things like filenames.
set wildmenu

" Redraw only when we need to.
"
" Vim loves to redraw the screen during things it probably doesn't need to—
" like in the middle of macros. This tells Vim not to bother redrawing
" during these scenarios, leading to faster macros.
set lazyredraw

" Highlight matching [{()}]
set showmatch

" Make searches case-insensitive, unless they contain upper-case letters.
set ignorecase
set smartcase

" Search as characters are entered.
set incsearch

" Highlight matches.
set hlsearch

" Assume the /g flag on :s substitutions to replace all matches in a line.
set gdefault

" Turn off search highlight.
nnoremap <leader><space> :nohlsearch<CR>

" Configure Airline.
let g:airline_powerline_fonts = 1

" Toggle Gundo.
" http://sjl.bitbucket.org/gundo.vim/#installation
nnoremap <leader>u :GundoToggle<CR>

" }}}

" Spaces / Tabs / Backspace / Etc. {{{
"------------------------------------------------------------------------------
" Number of visual spaces per tab.
" See: https://www.reddit.com/r/vim/wiki/tabstop
" tabstop is the number of spaces a tab counts for.
" So, when Vim opens a file and reads a <TAB> character,
" it uses that many spaces to visually show the <TAB>.
set tabstop=8

" shiftwidth controls how many columns text is indented with the reindent
" operations (<< and >>).
set shiftwidth=2

" Number of spaces in tab when editing.
"
" softabstop is the number of spaces a tab counts for when editing.
" So this value is the number of spaces that is inserted when you
" hit <TAB> and also the number of spaces that are removed when you backspace.
set softtabstop=2

" Tabs are spaces.
"
" expandtab turns <TAB>s into spaces. That's it.
" So <TAB> just becomes a shortcut for 'insert two spaces'.
set expandtab

" Have the usual indentation keystrokes still work in visual mode.
" vnoremap <C-T> >
" vnoremap <C-D> <LT>
" vmap <Tab> <C-T>
" vmap <S-Tab> <C-D>
  
" Fix visual selection tabbing and shift-tabbing.
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Fix issues with backspace.
set backspace=indent,eol,start

" }}}

" Filetype Indentation {{{
"------------------------------------------------------------------------------
" Load filetype-specific indent files
" 
" This both turns on filetype detection and allows loading of
" language specific indentation files based on that detection.
filetype indent on

" ROS launch files
autocmd FileType launch setlocal shiftwidth=2
autocmd FileType launch setlocal tabstop=2

" }}}

" Code Width {{{
"------------------------------------------------------------------------------
" Add color column at column 80.
" See: https://stackoverflow.com/a/3765575
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Highlight lines that run over 80 columns.
" See: https://stackoverflow.com/a/3765575
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>80v.\+/

" }}}

" Syntax / Lint {{{
"------------------------------------------------------------------------------
" Enable syntax highlighting.
" See: https://stackoverflow.com/a/33380495
if !exists("g:syntax_on")
    syntax enable
endif

" }}}

" Folding {{{
"------------------------------------------------------------------------------
" Enable folding.
set foldenable

" Open most folds by default.
set foldlevelstart=10

" 10 nested fold max.
set foldnestmax=10

" Space open/closes folds.
nnoremap <space> za

" Fold based on indent level.
"
" Other acceptable values are marker, manual, expr, syntax, diff.
" Run :help foldmethod to find out what each of those do.
set foldmethod=indent

" }}}

" Movement {{{
"------------------------------------------------------------------------------
" Switch windows with CTRL + home keys.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move vertically by visual line.
"
" These two allow us to move around lines visually.
" So if there's a very long line that gets visually wrapped to two lines,
" j won't skip over the 'fake' part of the visual line in favor of the next
" 'real' line.
nnoremap j gj
nnoremap k gk

" Highlight last inserted text.
"
" This one is pretty cool. It visually selects the block of characters you
" added last time you were in INSERT mode.
nnoremap gV `[v`]

" }}}

" Buffers {{{
"------------------------------------------------------------------------------
" Automatically make unwritten files hidden when switching buffers (suppresses
" warning).
set hidden

" Go to next and previous buffers.
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" Delete current buffer and switch to previous.
noremap <leader>d :bprevious<CR>:bdelete #<CR>

" Fly between buffers (toggle buffer list & immediate buffer selection).
" See: https://stackoverflow.com/a/16084326
nnoremap gb :ls<CR>:b<Space>

" }}}

" File Management / Navigation {{{
"------------------------------------------------------------------------------
" Change directory to the file being edited.
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Change local directory to the file being edited.
" nnoremap <leader>lc :lc %:p:h<CR>

" Set up mapjings for ranger.vim (the 'francoiscabrol/ranger.vim' version).
" let g:ranger_map_keys = 0
" map <leader>r :Ranger<CR>

" Set up mappings for ranger.vim (the 'rafaqz/ranger.vim' version).
" map <leader>rr :RangerEdit<cr>
" map <leader>rv :RangerVSplit<cr>
" map <leader>rs :RangerSplit<cr>
" map <leader>rt :RangerTab<cr>
" map <leader>ri :RangerInsert<cr>
" map <leader>ra :RangerAppend<cr>
" map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@

" Set up mappings for ranger.
" See: https://github.com/ranger/ranger/blob/master/examples/vim_file_chooser.vim
function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    if has("gui_running")
        exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(temp)
    endif
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

" }}}

" Fuzzy Finding {{{
"------------------------------------------------------------------------------
" fzf + ripgrep
" See: http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
" Hint: ':F' to open.
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" Toggle fzf file search.
nnoremap <leader>f :Files<CR>

" Toggle fzf Buffers.
nnoremap <leader>b :Buffers<CR>

" }}}

" Dotfiles / Config / Session / Etc. {{{
"------------------------------------------------------------------------------
" Edit vimrc/bashrc and load vimrc bindings.
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Save session.
nnoremap <leader>s :mksession<CR>

" }}}

" vim:foldmethod=marker:foldlevel=0
