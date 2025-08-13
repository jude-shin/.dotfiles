
" TODO: remove racket
augroup rkt 
	autocmd! 
	autocmd FileType racket set expandtab
	autocmd FileType racket set showmatch matchtime=1
augroup END

" TODO: remove ada 
autocmd FileType ada setlocal expandtab shiftwidth=2 softtabstop=2



augroup md 
	autocmd! 
	autocmd FileType text,markdown setlocal spell
	autocmd FileType text,markdown map j gj
	autocmd FileType text,markdown map k gk
	" TODO: have words wrap by space delimiter, (don't break up a word on a line wrap)
augroup END
