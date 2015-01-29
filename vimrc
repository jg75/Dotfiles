"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc
"  James G.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global and Local settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = '-'
let maplocalleader = '\'

colorscheme ir_black              " Colorscheme
filetype plugin indent on         " Enable syntax and indent by filetype and/or content
syntax on                         " Enable syntax highlighting

set nocompatible                  " Reset options while resourcing .vimrc
set background=dark               " Set the background
set hidden                        " Use swap history to move between unsaved files
set wildmenu                      " Enable command completion
set showcmd                       " Show partial commands in the last line of the screen
set nohlsearch                    " Disable search highlighting
set incsearch                     " Highlight searched text incrementally
set ignorecase                    " Case insensative search except when using capital letters
set smartcase                     " Case sensative search when using capital letters
set backspace=indent,eol,start    " Enable backspacing over autoindent, line breaks and start of action
set autoindent                    " Enable autoindent
set nostartofline                 " Stop certain movements from going to the first character of a line
set ruler                         " Display the cursor position on the last line of the screen
set laststatus=2                  " Always display the status line
set confirm                       " Enable the dialogue to save changed files
set noerrorbells                  " Disable the error bells
set visualbell t_vb=              " Enable visual bell
set iskeyword+=_,$,@,%,#          " Add these symbols to words
set mouse=a                       " Enable the mouse
set cmdheight=1                   " Set the height of the command bar at the bottom
set number                        " Show line numbers
set notimeout                     " Disable timeout (for mappings)
set ttimeout ttimeoutlen=200      " Timeout length (for keycodes)
set nowrap                        " Disable line wrap
set showmode                      " Show the mode at the bottom
set expandtab                     " Convert tabs to spaces
set tabstop=8                     " Set number of spaces when tab is pressed
set shiftwidth=2                  " Set the number of spaces on indent
set softtabstop=2                 " Set the number of columns in a tab
set splitbelow                    " Open new buffers below the current pane
set splitright                    " Open new buffers to the right of the current pane
set sessionoptions-=options       " Don't save session options
set undodir=~/.vim/temp           " Set the undodir
set directory=~/.vim/temp         " Set the directory for swaps
set backupdir=~/.vim/backup       " Set the backupdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function definitions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! FoodCritic()
  " Everyone's a food critic
  " Chef linter plugin
  if expand('%:p:h') =~# '.*/cookbooks/.*'
    setlocal makeprg=foodcritic\ $*\ %
    setlocal errorformat=%m:\ %f:%l
  endif
endfunction

function! MakeDir(dir)
  " Ensure the directory exists
  " If not then create it
  if !isdirectory(a:dir) && exists("*mkdir")
    call mkdir(a:dir)
  endif
endfunction

function! SetTab(n)
  " Change the number of spaces in tabs and indents
  let &shiftwidth=a:n
  let &softtabstop=a:n
endfunction

function! LastCursorPosition()
  " Jump to the last cursor position
  if line("'\"") > 1 && line("'\"") <= line("$") 
    execute "normal! g'\""
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ensure that .vim config directories exist
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call MakeDir($HOME . '/.vim/temp')
call MakeDir($HOME . '/.vim/backup')
call MakeDir($HOME . '/.vim/colors')
call MakeDir($HOME . '/.vim/bundle')
call MakeDir($HOME . '/.vim/autoload')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Execute pathogen to load modules
call pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <C-U> to toggle upper / lower case on word
nnoremap <C-U> viw~

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map Y to act like D and C
noremap Y y$

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map H and L to move to the beginning and end of line respectively
noremap H 0
noremap L $

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings for switching panes
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to NERDTree
noremap <Space> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings to change the number of spaces in tabs and indent
noremap <Leader>2 :call SetTab(2)<CR>
noremap <Leader>4 :call SetTab(4)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" We have you surrounded!
" Use thes mappings to surround words and/or selections
" with the following characters '' "" () {} []
" with optional spaces e.g. 'word' or ' word '.
" These mappings work with with the vim surround plugin.
noremap <Leader>' viw<ESC>a'<ESC>hbi'<ESC>lel
vnoremap <Leader>' <ESC>`>a'<ESC>`<i'<ESC>
noremap <Leader><Space>' viw<ESC>a '<ESC>hbi' <ESC>lel
vnoremap <Leader><Space>' <ESC>`>a '<ESC>`<i' <ESC>

noremap <Leader>" viw<ESC>a"<ESC>hbi"<ESC>lel
vnoremap <Leader>" <ESC>`>a"<ESC>`<i"<ESC>
noremap <Leader><Space>" viw<ESC>a "<ESC>hbi" <ESC>lel
vnoremap <Leader><Space>" <ESC>`>a "<ESC>`<i" <ESC>

noremap <Leader>( viw<ESC>a)<ESC>hbi(<ESC>lel
vnoremap <Leader>( <ESC>`>a)<ESC>`<i(<ESC>
noremap <Leader>) viw<ESC>a)<ESC>hbi(<ESC>lel
vnoremap <Leader>) <ESC>`>a)<ESC>`<i(<ESC>
noremap <Leader><Space>( viw<ESC>a )<ESC>hbi(<ESC>lel
vnoremap <Leader><Space>( <ESC>`>a )<ESC>`<i( <ESC>
noremap <Leader><Space>) viw<ESC>a )<ESC>hbi( <ESC>lel
vnoremap <Leader><Space>) <ESC>`>a )<ESC>`<i( <ESC>

noremap <Leader>{ viw<ESC>a}<ESC>hbi{<ESC>lel
vnoremap <Leader>{ <ESC>`>a}<ESC>`<i{<ESC>
noremap <Leader>} viw<ESC>a}<ESC>hbi{<ESC>lel
vnoremap <Leader>} <ESC>`>a}<ESC>`<i{<ESC>
noremap <Leader><Space>{ viw<ESC>a }<ESC>hbi{ <ESC>lel
vnoremap <Leader><Space>{ <ESC>`>a }<ESC>`<i{ <ESC>
noremap <Leader><Space>} viw<ESC>a }<ESC>hbi{ <ESC>lel
vnoremap <Leader><Space>} <ESC>`>a }<ESC>`<i{ <ESC>

noremap <Leader>[ viw<ESC>a]<ESC>hbi[<ESC>lel
vnoremap <Leader>[ <ESC>`>a]<ESC>`<i[<ESC>
noremap <Leader>] viw<ESC>a]<ESC>hbi[<ESC>lel
vnoremap <Leader>] <ESC>`>a]<ESC>`<i[<ESC>
noremap <Leader><Space>[ viw<ESC>a ]<ESC>hbi[ <ESC>lel
vnoremap <Leader><Space>[ <ESC>`>a ]<ESC>`<i[ <ESC>
noremap <Leader><Space>] viw<ESC>a ]<ESC>hbi[ <ESC>lel
vnoremap <Leader><Space>] <ESC>`>a ]<ESC>`<i[ <ESC>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change tab and indent space length for specific file types
augroup filetype_python
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4
augroup END

augroup filetype_java
  autocmd FileType java setlocal shiftwidth=4 softtabstop=4
augroup END

augroup filetype_sh
  autocmd FileType sh setlocal shiftwidth=4 softtabstop=4
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Restore the cursor position when reopening a file
augroup jvim
  autocmd BufReadPost * call LastCursorPosition()
  autocmd BufRead,BufNewFile * call FoodCritic()
augroup END

