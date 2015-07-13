"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .gvimrc
"  James G.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_macvim")
  " Set to 1 to allow custom color schemes
  let macvim_skip_colorscheme=1
endif

colorscheme ir_black                                " Colorscheme (~/.vim/colors)
set guifont=Source\ Code\ Pro\ for\ Powerline:h14   " GUI font
set antialias                                       " Enable antialiasing
set title                                           " Enable title
set titlestring=\%-25.55F\ %a%r%m                   " Title string
set titlelen=70                                     " Title string length
let g:airline_theme = 'luna'
