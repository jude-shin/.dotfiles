augroup rkt 
	autocmd! 
	autocmd FileType racket set expandtab
	autocmd FileType racket set showmatch matchtime=1
augroup END

autocmd FileType ada setlocal expandtab shiftwidth=2 softtabstop=2

augroup md 
	autocmd! 
	autocmd FileType text,markdown setlocal spell
	autocmd FileType text,markdown map j gj
	autocmd FileType text,markdown map k gk
augroup END
