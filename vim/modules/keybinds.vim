" time between the remaps
" (like the time between 'k' and 'j' when I am trying to escape)
set timeoutlen=400

" ESCAPE REMAP
inoremap kj <esc>
vnoremap kj <esc>
cnoremap kj <C-C>

" BRACKET COMPLETION
" inoremap { {}<Esc>ha
" inoremap ( ()<Esc>ha
" inoremap [ []<Esc>ha
" inoremap " ""<Esc>ha
" inoremap ' ''<Esc>ha
" inoremap ` ``<Esc>ha
" inoremap < <><Esc>ha
