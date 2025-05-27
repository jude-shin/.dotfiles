filetype plugin on
filetype indent on
syntax on

" saves folds and loads folds automatically
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" relative line numbers
set relativenumber
set invnumber 

" the size of the tabs 
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2

" the cursor is always 5 lines away from the bottom or the top of the page
set scrolloff=5

" sets the clipboard to the systems with x11 only
set clipboard=unnamedplus

" stops the comments from showing up when you hit the return key
autocmd FileType * setlocal formatoptions-=cro 

" searching settings 
set incsearch
set hlsearch 
set shortmess-=S
" set ignorecase 


