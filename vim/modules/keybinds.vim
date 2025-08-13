" time between the remaps
" (like the time between 'k' and 'j' when I am trying to escape)
set timeoutlen=400

" ESCAPE REMAP
inoremap kj <esc>
vnoremap kj <esc>
cnoremap kj <C-C>


" TOGGLE coc on and off easily
" TODO: test this
function! CocToggle()
  if exists('g:coc_ready') && g:coc_ready
    " coc.nvim is enabled, so disable it
    CocDisable
    echo "coc.nvim disabled"
  else
    " coc.nvim is disabled, so enable it
    CocEnable
    echo "coc.nvim enabled"
  endif
endfunction

nnoremap `` :call CocToggle()<CR>
inoremap `` <Esc>:call CocToggle()<CR>

" BRACKET COMPLETION
" inoremap { {}<Esc>ha
" inoremap ( ()<Esc>ha
" inoremap [ []<Esc>ha
" inoremap " ""<Esc>ha
" inoremap ' ''<Esc>ha
" inoremap ` ``<Esc>ha
" inoremap < <><Esc>ha
