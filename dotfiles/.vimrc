"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" John L Conway IV
" ~/.vimrc 
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backspace=indent,eol,start

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" c: automatically wrap comments
" q: allow rewrapping of comments w/ gq
" r: automatically insert comment character
" l: don't break previously long lines
" o: automatically insert comment character after hitting o or O
" n: recognize numbered lists
set formatoptions=cqrlon

""
" General 
""
set nu
set ts=4
set sw=4
set softtabstop=4
set cin
set et
set is
set tw=80
set sh=/bin/bash
set switchbuf=usetab,useopen,newtab
set textwidth=80

"" 
" Searching
""
set ignorecase
set smartcase

""
" Syntax Highlighting
""
if &t_Co > 2 || has("gui_running") 
    colorscheme desert
    syntax on
    set hlsearch

    " Set background color
    hi Normal ctermfg=grey ctermbg=black
    set t_ut=

    match ErrorMsg /\%>80v.\+/
    hi ErrorMsg ctermbg=red ctermfg=white
    hi Error ctermbg=red ctermfg=white
endif

""
" Mouse
""
if v:version >= 700
    set mouse=a
endif

runtime macros/matchit.vim

"" 
" Super Tab
""
"source $VIMHOME/supertab.vim

"" 
" C Style Includes
"" 
set def=^\\s*#\\s*define
set inc=^\\s*#\\s*include

"" 
" TODO 
"" 
command! TODO stselect /^todo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("vms")  
    set nobackup
else
    set backup
    set backupdir=~/.vimbackups,~/tmp/,/tmp/
    set backupcopy=yes
    set viewdir=$VIMHOME/views/
 
    " TODO: Make this only for a valid filename before running these. 
    " au BufWinLeave *.* mkview
    " au BufWinEnter *.* silent loadview
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax
set fml=1 " Min # lines for a fold to be folded
set foldcolumn=5
set foldtext=MyFoldText()
" comment to let comments fold
let c_no_comment_fold = 1
"uncomment to stop ifs from folding
let c_no_if0_fold = 1

hi Folded ctermbg=black ctermfg=grey guibg=darkgrey guifg=grey cterm=bold gui=bold
hi FoldedColumn ctermbg=black ctermfg=blue guibg=darkgrey guifg=blue 

" Show the actual folded line 
function! MyFoldText()
    let line = getline(v:foldstart)
    let numlines = v:foldend - v:foldstart
    return line . '    ' . numlines . ' Lines '
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Max Tab Pages
set tpm=50 

" This will number the tabs and rename them to be useful. 
if exists("+showtabline")

    function! MyTabLine() 
        let s = ''
        let t = tabpagenr()
        let last = tabpagenr('$')
        let groupsize = 6
        let i = 1
        let max = t / groupsize + 1
        let max = max * groupsize
        let tabsepleft='['
        let tabsepright=']'

        " Loop through each tab
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let bufnr = buflist[winnr - 1] 

            " Get The File Name
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')

            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else 
                let file = fnamemodify(file, ':p:t')
            endif

            if file == ''
                let file = '[No Name]'
            endif

            " Build the tab string for this tab
            let s .= '%' . i . 'T'
            let s .= ( i == t ? '%1*' : '%2*')
            let s .= ' ' 
            let s .= ( i == t ? '%#TabLineSel#' : '%#TabLine#')
            let s .= tabsepleft . i . ':'
            let s .= file
            let s .= tabsepright
            let i = i + 1
            if i > max
                break
            endif
        endwhile

        let s .= "%T%#TabLineFill#%="
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')

        return s
    endfunction

    set stal=2
    set tabline=%!MyTabLine()
    hi TablineSel ctermbg=blue ctermfg=white
    hi TabLineFill ctermbg=white ctermfg=black
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
"set statusline=%{fugitive#statusline()} 
set statusline=%y\ %f\ %m\ %r%h%w%=[ASCII=\%03.3b]\ [HEX=\$02.2B]\ %5l,%-5v\ %4P
set ruler

" Basic Status Line Highlighting
hi StatusLine ctermbg=DarkBlue ctermfg=white cterm=bold
hi StatusLine guibg=DarkBlue guifg=white gui=bold

"" Changes the color of the status line for the buffer depending on what mode
"" you are currently in and which buffer you are in. 
if has("autocmd") 
    " Only Highlight the active buffer so return to normal black on white when
    " buffer is not active
    au BufLeave * hi StatusLine ctermbg=white ctermfg=black cterm=none
    au BufLeave * hi StatusLine guibg=white guifg=black gui=none

    " Highlight with white on DarkBlue when this is the active buffer
    au BufEnter * hi StatusLine ctermbg=DarkBlue ctermfg=white cterm=bold
    au BufEnter * hi StatusLine guibg=DarkBlue guifg=white gui=bold

    " Also change the color when entering insert mode. This is a version 7 or
    " higher function
    if v:version >= 700
        " Return to normal highlight when leaving insert mode
        au InsertLeave * hi StatusLine ctermbg=DarkBlue ctermfg=white cterm=bold
        au InsertLeave * hi StatusLine guibg=DarkBlue guifg=white gui=bold

        " highlight magenta when in insert mode
        au InsertEnter * hi StatusLine ctermbg=magenta ctermfg=white cterm=bold
        au InsertEnter * hi StatusLine guibg=magenta guifg=white gui=bold
    endif

endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session Storage
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions+=winpos " Window Position
set sessionoptions+=localoptions " Mapps and local window options
set sessionoptions+=resize " Size of the window

" Saves the session 
function! SaveSession()
    execute 'mksession! $VIMHOME/sessions/session.vim'
endfunction

" Loads the session by trying session.vim in the local directory then going to
" VIMHOME/sessions/session.vim
function! LoadSession()
    if filereadable('./session.vim') 
        execute 'source ./session.vim'
    else 
        if filereadable('$VIMHOME/sessions/session.vim') 
            execute 'source $VIMHOME/sessions/session.vim'
        endif
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the locations of the tags files
set tags=./tags,tags,../tags

" Ensures that going to a tag will first try to find an open buffer 
" with the file and go there, otherwise, open a new buffer
function! GotoTag()
    let num = bufnr("%")
    let t=expand("<cword>")
    try 
        exe ":tag " . t
    catch /.*/
        echo "No Tags Found"
    endtry 

    let pos=getpos('.')
    if bufnr("%") != num
        e #
        tab sb #
    endif 

    call setpos('.', pos)
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy open and apply vimrc
map <LEADER>v :vs $MYVIMRC<CR>
map <silent> <LEADER>V :source $MYVIMRC<CR>

" Session storage 
map <LEADER>s :mksession! $VIMHOME/sessions/
map <LEADER>l :source $VIMHOME/sessions/

" Movement through splits
noremap <LEADER>w <C-w><C-w> 
noremap <LEADER>W <C-w>W 

" Useful script headers
noremap <LEADER>pl <ESC>gg0#!/usr/bin/perl<ESC>:set ft=perl<CR> 
noremap <LEADER>py <ESC>gg0#!/bin/bash<ESC>:set ft=sh<CR>
noremap <LEADER>b <ESC>gg0#!/usr/bin/python<ESC>:set ft=python<CR>


"Run make and the current test
nnoremap <LEADER>r :!make && ./test<CR>

" Tags
nmap <C-]> :call GotoTag()<CR>

" Build systems
noremap <LEADER>m :make
noremap <LEADER>c :cn

" Format Highlighted Section
vnoremap <LEADER>q gq

" Bring up TODO window
noremap <LEADER>t :TODO<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NetRW
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_browse_split = 2 " Default open files in a vsplit not split

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Diffs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set diffopt=vertical
hi DiffAdd ctermbg=green ctermfg=white
hi DiffChange ctermbg=cyan ctermfg=black
hi DiffText ctermbg=cyan ctermfg=green
hi DiffDelete ctermbg=red ctermfg=white

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDChristmasTree=1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$','\.swp$','\.swo$']
let NERDTreeShowBookmarks=1
let NERDTreeWinSize=55
noremap <LEADER>n :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('autocmd') 
    " Enable FileType Detection
    filetype on
    filetype plugin on
    filetype plugin indent on

    augroup vimrcEx
    au!

    " SCons files should be interpreted as Python
    autocmd BufRead,BufNewFile SConstruct set ft=python
    autocmd BufRead,BufNewFile SConscript set ft=python

    " Load templates if found in VIMHOME/templates
    autocmd BufNewFile * silent! 0r $VIMHOME/templates/%:e.tpl

    " Always return to last known position if reopening a file
    autocmd BufReadPost * 
        \ if line("'\"") > 0 && line("'\"") <= line("$") | 
        \   exe "normal g`\"" | 
        \ endif
    augroup END
    
    " Automatically save session on exit
    autocmd VimLeave * call SaveSession()

    " Start NERDTree by default
    "autocmd VimEnter * NERDTree
else 
    set autoindent
endif

