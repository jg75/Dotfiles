"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .gvimrc
"  James G.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_macvim")
  let macvim_skip_colorscheme=1         " Set to 1 to allow custom color schemes
endif

colorscheme ir_black                    " Colorscheme (~/.vim/colors)

set guifont=Monaco:h14                  " Set the font
set antialias                           " Enable antialiasing
set title                               " Enable title
set titlestring=\%-25.55F\ %a%r%m       " Title string
set titlelen=70                         " Title string length
