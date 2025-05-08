" In normal mode, Ctrl-J opens a terminal in a horizontal split at the bottom
nnoremap <C-j> :botright terminal<CR>

" In terminal mode, Ctrl-J exits terminal mode and closes the terminal buffer
tnoremap <C-j> <C-\><C-n>:bd!<CR>


