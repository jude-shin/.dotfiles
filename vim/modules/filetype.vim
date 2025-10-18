augroup md 
	autocmd! 
	autocmd FileType text,markdown setlocal spell
	autocmd FileType text,markdown map j gj
	autocmd FileType text,markdown map k gk
syntax region texZone start='\\begin{lstlisting}' end='\\end{lstlisting}'
	" TODO: have words wrap by space delimiter,
	" (don't break up a word on a line wrap)
	autocmd FileType text,markdown set linebreak
augroup END
augroup c
	autocmd! 
  autocmd BufEnter *.c,*.h set expandtab
  autocmd BufEnter *.c,*.h set showmatch matchtime=1
augroup END

augroup tex
	autocmd! 
	autocmd FileType tex setlocal spell
	autocmd FileType tex map j gj
	autocmd FileType tex map k gk
	autocmd FileType tex syntax region texZone start='\\begin{lstlisting}' end='\\end{lstlisting}'
augroup END
