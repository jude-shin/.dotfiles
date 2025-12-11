augroup writing
	autocmd! 
	" set spelling for english
	autocmd FileType text,markdown,tex setlocal spell

	" dictionary set to some text file
	autocmd FileType text,markdown,tex setlocal dictionary+=/usr/share/dict/cracklib-small

	" navigation for long lines
	autocmd FileType text,markdown,tex nnoremap j gj
	autocmd FileType text,markdown,tex nnoremap k gk

	" (don't break up a word on a line wrap)
	autocmd FileType text,markdown,tex setlocal linebreak
	
	" Highlight the lstlisting sections
	autocmd FileType tex syntax region texZone start='\\begin{lstlisting}' end='\\end{lstlisting}'

augroup END

augroup c
	autocmd! 
  autocmd BufEnter *.c,*.h setlocal expandtab
  autocmd BufEnter *.c,*.h setlocal showmatch matchtime=1
augroup END

" augroup tex
" 	autocmd! 
" 	autocmd FileType tex setlocal spell
" 	autocmd FileType tex map j gj
" 	autocmd FileType tex map k gk
" 	autocmd FileType tex syntax region texZone start='\\begin{lstlisting}' end='\\end{lstlisting}'
" augroup END
