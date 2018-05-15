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
    " set guifont=-BIZNET-Terminal-Medium-R-Normal--16-140-100-100-C-110-ISO8859-2
    " set guifont=-misc-console-medium-r-normal--16-160-72-72-c-iso10646-1
    " set guifont=-*-console-*-*-*--*-*-*-*-*-*-*
    " set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
    " set guifont=ProggyCleanTT\ 12
    set guifont=Inconsolata\ Medium\ 10
    " set guifont=-Misc-Fixed-Bold-R-Normal--15-120-75-75-C-70-ISO8859-1
    " set guifont=monospace 11
        
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
" Syntax / Lint
"------------------------------------------------------------------------------
" Enable syntax highlighting (see: https://stackoverflow.com/a/33380495)
if !exists("g:syntax_on")
    syntax enable
endif
