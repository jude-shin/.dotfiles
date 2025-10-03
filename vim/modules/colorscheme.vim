if (has("termguicolors"))
	set termguicolors
endif

colorscheme gruvbox
set background=dark

" Easier to see the highlighted portions
hi Search cterm=bold
hi Visual cterm=bold

" Spelling highlight
hi SpellBad cterm=underline,bold ctermfg=Red ctermbg=none

" Warnings and errors for coc
hi CocErrorHighlight cterm=underline,bold ctermfg=Red ctermbg=none
hi CocWarningHighlight cterm=underline,bold ctermfg=Yellow ctermbg=none

