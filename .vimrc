"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc
"  James G.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global and Local settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = '-'
let maplocalleader = '\'

" Enable syntax and indent by filetype
filetype plugin indent on
syntax on

if has("macunix")
  " Enable mouse
  set mouse=a
endif

" Colors
colorscheme ir_black
set t_Co=256
set background=dark
set antialias
set encoding=utf-8

" Reset options
set nocompatible
set sessionoptions-=options

" File management
set hidden
set confirm
set undofile
set undodir=~/.vim/temp
set undolevels=1000
set undoreload=10000
set directory=~/.vim/temp
set backupdir=~/.vim/backup

" Enable search highlighting and smart case search
set hlsearch
set incsearch
set ignorecase
set smartcase
set infercase

" Enable backspace and indent
set backspace=indent,eol,start
set autoindent
set nostartofline

" Enable status and command bar
set laststatus=2
set cmdheight=1

" Disable error bells
set noerrorbells
set visualbell t_vb=

" Set keywords
set iskeyword+=_,$,@,%,#

" Line numbers
set number

" Don't wrap lines
set nowrap

" Disable timeouts
set notimeout
set ttimeout ttimeoutlen=200

" Spaces for tabs
set expandtab
set tabstop=8
set shiftwidth=2
set softtabstop=2

" Split pane buffer defaults
set splitbelow
set splitright

" Enable Omni command completion
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,longest,preview
highlight Pmenu ctermbg=8 ctermfg=15
highlight PmenuSel ctermbg=191 ctermfg=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function definitions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! AirlineInit()
  let g:airline_theme = 'luna'
  let g:airline_powerline_fonts=1

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#tmuxline#enabled = 1
endfunction


" function! TmuxlineInit()
  " Match Airline theme
  " let g:tmuxline_theme = 'airline'
" endfunction


function! SyntasticInit()
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_enable_signs = 1
  let g:syntastic_error_symbol = "✗"
  let g:syntastic_warning_symbol = "⚠"
  let g:syntastic_style_error_symbol = "S✗"
  let g:syntastic_style_warning_symbol = "S⚠"
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_typescript_checkers = ['tslint']
  let g:syntastic_json_checkers = ['jsonlint']
  let g:syntastic_yaml_checkers = ['yaml-lint']
  let g:syntastic_python_checkers = ['pep8', 'pyflakes', 'pycodestyle', 'pydocstyle']
  let g:syntastic_cpp_compiler = 'g++'
  let g:syntastic_cpp_checkers = [ 'gcc', 'clang' ]
  let g:syntastic_go_checkers = [ 'golint' ]
  let g:syntastic_disabled_filetypes=['html', 'jinja2']
  let g:syntastic_mode_map = { 'passive_filetypes': ['java', 'html', 'jinja2', 'cpp', 'go'] }
endfunction


function! SuperTabInit()
  let g:SuperTabDefaultCompletionType = "context"
endfunction


function! MakeDir(dir)
  " Ensure the directory exists
  if !isdirectory(a:dir) && exists("*mkdir")
    call mkdir(a:dir)
  endif
endfunction


function! SetTab(n)
  " Change the number of spaces in tabs and indents
  let &shiftwidth=a:n
  let &softtabstop=a:n
endfunction


function! ToggleColorColumn()
  if &colorcolumn
    set colorcolumn=
    set nolist
    set listchars=
    set nospell
    set number
    set norelativenumber
  else
    highlight ColorColumn ctermbg=DarkCyan ctermfg=White
    set list
    set listchars=trail:┊,tab:»·
    set colorcolumn=80
    set spell spelllang=en_us
    set number
    set relativenumber
  endif
endfunction


function! FixColorColumn()
  highlight ColorColumn ctermbg=DarkRed ctermfg=black
  exec 'set colorcolumn=' . join(range(2, 80, 3), ',')
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
call MakeDir($HOME . '/.vim')
call MakeDir($HOME . '/.vim/temp')
call MakeDir($HOME . '/.vim/backup')
call MakeDir($HOME . '/.vim/bundle')
call MakeDir($HOME . '/.vim/autoload')
call MakeDir($HOME . '/.vim/colors')
call MakeDir($HOME . '/.vim/snippets')

" Load modules
call pathogen#infect()
call pathogen#helptags()
call AirlineInit()
" call TmuxlineInit()
call SyntasticInit()
call SuperTabInit()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <C-U> to toggle upper / lower case on word
nnoremap <C-U> viw~

" Clear last search by hitting return
nnoremap <CR> :noh<CR><CR>

" Map Y to act like D and C
noremap Y y$

" Map H and L to move to the beginning and end of line respectively
noremap H 0
noremap L $

" Mappings for switching panes
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Map <Space> to NERDTree
noremap <silent> <Space> :NERDTreeToggle<CR>

" Mappings to change the number of spaces in tabs and indent
" nnoremap <Leader>2 :call SetTab(2)<CR>
" nnoremap <Leader>4 :call SetTab(2)<CR>
nnoremap <Leader><Leader> :call ToggleColorColumn()<CR>
nnoremap <LocalLeader><LocalLeader> :Autoformat<CR>


" Airline Tabline extension mappings
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Use these mappings to surround words and/or selections
" with the following characters '' "" () {} []
" with optional spaces e.g. 'word' or ' word '.
" These mappings work well with the vim surround plugin.
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
" Auto commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup filetype_python
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4
  autocmd FileType python set omnifunc=python3complete#Complete
augroup END


augroup filetype_ruby
  autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
augroup END


augroup filetype_java
  autocmd FileType java setlocal shiftwidth=4 softtabstop=4
augroup END


augroup filetype_cpp
  autocmd BufNewFile,BufRead *.h,*.c,*.cpp set filetype=cpp
  autocmd BufNewFile,BufRead *.h,*.c,*.cpp set omnifunc=omni#cpp#complete#Main
  autocmd FileType cpp setlocal shiftwidth=4 softtabstop=4
augroup END

augroup filetype_go
  autocmd BufNewFile,BufRead *.h,*.c,*.cpp set filetype=go
  autocmd FileType go setlocal omnifunc=gocomplete#Complete
  autocmd FileType cpp setlocal shiftwidth=8 softtabstop=8
augroup END


augroup filetype_sh
  autocmd FileType sh setlocal shiftwidth=4 softtabstop=4
augroup END


"augroup filetype_javascript
"  autocmd FileType javascript setlocal shiftwidth=4 softtabstop=4
"augroup END


augroup filetype_typescript
  autocmd BufRead,BufNewFile *.ts set filetype=typescript
  autocmd BufNewFile,BufRead *.ts set ft=typescript
  autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2
augroup END


augroup filetype_json
  autocmd BufRead,BufNewFile *.json set filetype=json
  autocmd BufNewFile,BufRead *.json set ft=json
  autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2
augroup END


autocmd BufReadPost * call LastCursorPosition()
