augroup md 
	autocmd! 
	autocmd FileType text,markdown setlocal spell
	autocmd FileType text,markdown map j gj
	autocmd FileType text,markdown map k gk
	" TODO: have words wrap by space delimiter,
	" (don't break up a word on a line wrap)
	autocmd FileType text,markdown set linebreak
augroup END
augroup c
	autocmd! 
  autocmd BufEnter *.c,*.h set expandtab
  autocmd BufEnter *.c,*.h set showmatch matchtime=1
augroup END
