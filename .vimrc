set number
set relativenumber
set tabstop=4
set ignorecase
set smartcase
set linebreak

syntax on

map <Leader><Space> :noh<CR>

augroup wayland_clipboard
  au!
  au TextYankPost * call system("wl-copy", @")
augroup END

set termbidi
set arabicshape
