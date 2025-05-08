" time between the remaps
" (like the time between 'k' and 'j' when I am trying to escape)
set timeoutlen=400

" ESCAPE REMAP
inoremap kj <esc>
vnoremap kj <esc>
cnoremap kj <C-C>

" " ALE NEXT ERROR
" nnoremap <C-k> :ALENextWrap<CR>
" COC TAB COMPLETION
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-r>=coc#refresh()\<CR>"
" inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : coc#refresh()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" TERMINAL REMAP
" nnoremap <C-j> :terminal<CR>
" tnoremap <C-j> <C-\><C-n>:bd!<CR>

" LINE NUMBER TOGGLE REMAP
" TODO: doesn't work
" inoremap `` <Esc>:set nonumber! norelativenumber!<Esc>`q

" BRACKET COMPLETION
" inoremap { {}<Esc>ha
" inoremap ( ()<Esc>ha
" inoremap [ []<Esc>ha
" inoremap " ""<Esc>ha
" inoremap ' ''<Esc>ha
" inoremap ` ``<Esc>ha
" inoremap < <><Esc>ha
