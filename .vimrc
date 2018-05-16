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

" Status / Tabline
" ----------------
" lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
" A collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'

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
" GUI Settings
"------------------------------------------------------------------------------
if has("gui_running")
    " Set background color (ANSI)
    set t_AB=^[[48;5;%dm
    " Set foreground color (ANSI)
    set t_AF=^[[38;5;%dm

    " Set the X11 font to use
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
        
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

    " Restore gVim screen size and position
    "
    " See: http://vim.wikia.com/wiki/Restore_screen_size_and_position
    "
    function! ScreenFilename()
        if has('amiga')
          return "s:.vimsize"
        elseif has('win32')
          return $HOME.'\_vimsize'
        else
          return $HOME.'/.vimsize'
        endif
    endfunction

    function! ScreenRestore()
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
  
    function! ScreenSave()
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

"------------------------------------------------------------------------------
" User Interface
"------------------------------------------------------------------------------
" Show relative line numbers.
set relativenumber

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
"
" Re-mapped to ,<space>
nnoremap <leader><space> :nohlsearch<CR>

"------------------------------------------------------------------------------
" Spaces / Tabs / Backspace
"------------------------------------------------------------------------------
" Number of visual spaces per tab.
"
" tabstop is the number of spaces a tab counts for.
" So, when Vim opens a file and reads a <TAB> character,
" it uses that many spaces to visually show the <TAB>.
set tabstop=2

" shiftwidth controls how many columns text is indented with the reindent
" operations (<< and >>).
set shiftwidth=2

" Number of spaces in tab when editing
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

" Have the usual indentation keystrokes still work in visual mode
" vnoremap <C-T> >
" vnoremap <C-D> <LT>
" vmap <Tab> <C-T>
" vmap <S-Tab> <C-D>
  
" Fix visual selection tabbing and shift-tabbing
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Fix issues with backspace
set backspace=indent,eol,start

"------------------------------------------------------------------------------
" Filetype Indentation
"------------------------------------------------------------------------------
" Load filetype-specific indent files
" 
" This both turns on filetype detection and allows loading of
" language specific indentation files based on that detection.
filetype indent on

" ROS launch files
autocmd FileType launch setlocal shiftwidth=2
autocmd FileType launch setlocal tabstop=2

"------------------------------------------------------------------------------
" Syntax / Lint
"------------------------------------------------------------------------------
" Enable syntax highlighting (see: https://stackoverflow.com/a/33380495)
if !exists("g:syntax_on")
    syntax enable
endif
