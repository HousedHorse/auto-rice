filetype plugin on
set nocompatible

let g:jsx_ext_required = 0
let g:pandoc#syntax#conceal#use = 0

execute pathogen#infect()

" Indent settings
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

" blinking cursor
set guicursor=a:blinkwait700-blinkon400-blinkoff250

" path settings
set path+=**

" make tags
set tags=./.tags
command! MakeTags !ctags -R -f .tags .
nnoremap <C-]> g<C-]>

" netrw stuff
let g:netrw_banner=0
let g:netrw_liststyle=3

" only do this part when compiled with support for autocommands.
if has("autocmd")
    " use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " remove trailing whitespace
    autocmd BufWritePre * noh | let _save_pos=getpos(".") | %s/\s\+$//e | let _s=@/ | let @/=_s | noh | unlet _s | call setpos('.', _save_pos) | unlet _save_pos | noh

    " use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

    autocmd BufEnter * :syntax sync fromstart

    " syntax: autocmd BufNewFile *.rmd r /home/$(USER)/.vimskeletons/$(FILE)
    autocmd FileType rmd set spell
    autocmd FileType rmd set spelllang=en_us
    autocmd FileType markdown set spell
    autocmd FileType markdown set spelllang=en_us

    " rmarkdown stuff
    autocmd BufNewFile *.rmd :silent execute "r $HOME/.vimskeletons/rmd" | :silent execute "w"
    " autocompile
    autocmd BufWritePost *.rmd :silent execute "!(echo \"require(rmarkdown); render('\<afile>')\" | R --vanilla -q > /dev/null 2> /dev/null ; killall -SIGHUP mupdf > /dev/null 2> /dev/null) &"
    " automagically open mupdf for previewing (and compile once)
    autocmd FileType rmd :silent execute "!(echo \"require(rmarkdown); render('\<afile>')\" | R --vanilla -q > /dev/null 2> /dev/null ; mupdf $(basename -s .rmd \<afile>).pdf > /dev/null 2> /dev/null) &"
    " start cursor in the appropriate part of the skeleton
    autocmd BufReadPost,BufNewFile *.rmd :normal /--- nj}zz
    autocmd FileType rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%');"<space>\|<space>R<space>--vanilla<enter>

    " markdown stuff
    " autocompile
    autocmd BufWritePost *.md :silent execute "!(pandoc % -f gfm -o /tmp/%:t:r.pdf; killall -SIGHUP mupdf > /dev/null 2> /dev/null) &"
    " automagically open mupdf for previewing (and compile once)
    autocmd FileType markdown :silent execute "!(pandoc % -f gfm -o /tmp/%:t:r.pdf ; mupdf /tmp/%:t:r.pdf > /dev/null 2> /dev/null) &"
    autocmd FileType markdown map <F5> :!(pandoc % -f gfm -o /tmp/%:t:r . '.pdf')

    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " RMS for age of empires ii
    autocmd BufNewFile *.rms execute "r $HOME/.vimskeletons/rms" | execute "w"| execute "redraw!"

    " C++ stuff
    autocmd BufNewFile *.cc if @% != 'main.cc' | execute "r $HOME/.vimskeletons/cpp" | execute "%s/HEADERNAME/\\=expand('%:t:r') . '.h'/g" | execute "%s/CLASSNAME/\\=expand('%:t:r')/g" | execute "w" | execute "edit ".expand('%:t:r').'.h' | execute "r $HOME/.vimskeletons/cpph" | execute "%s/INCLUSIONGUARD/\\=toupper(expand('%:t:r')) . '\_H'/g" | execute "%s/CLASSNAME/\\=expand('%:t:r')/g" | execute "1d" | execute "w" | execute "edit ".expand('%:t:r').'.cc' | else | execute "r $HOME/.vimskeletons/maincpp" | endif | execute "1d" | execute "w" | execute "redraw!" | if @% == 'main.cc' | execute "call cursor(3,0)"
    " Qt stuff
    autocmd BufNewFile *.pro execute "r $HOME/.vimskeletons/pro" | execute "%s/APPNAME/\\=expand('%:t:r')" | execute "w" | execute "1d" | execute "w" | execute "redraw!" | execute "edit ".expand('%:t:r').'.qrc' | execute "r $HOME/.vimskeletons/qrc" | execute "1d" | execute "w" | execute "edit ".expand('%:t:r').'.pro' | execute "redraw!"

    " python stuff
    autocmd BufNewFile *.py :silent execute "r $HOME/.vimskeletons/py" | :silent execute "1d" | :silent execute "call cursor(4,3)"

    " prolog
    autocmd BufEnter *.pl set syntax=prolog

    " tags on write
    autocmd BufWritePost *.cc,*.c,*.cpp,*.h,*.py :silent execute "MakeTags"
    autocmd BufEnter .tags set syntax=tags
endif

" set line numbers to be on by default (I don't know why this isn't a default setting lol)
set number

" set line wrapping
set breakindent
set wrap lbr

" add filename at bottom
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set ls=2

" better tabs
inoremap <S-Tab> <C-d>
inoremap <Tab> <C-t>
nnoremap <S-Tab> <<
nnoremap <Tab> >>
vnoremap <S-Tab> <
vnoremap <Tab> >
" for command mode
" nnoremap <S-Tab> <<

" move up and down by visual line
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" get rid of annoying behavior on up and down arrow keys
inoremap <S-UP>   <UP>
nnoremap <S-UP>   <UP>
vnoremap <S-UP>   <UP>
inoremap <S-DOWN> <DOWN>
nnoremap <S-DOWN> <DOWN>
vnoremap <S-DOWN> <DOWN>

" get rid of annoying jump by word behavior on arrow keys
inoremap <S-RIGHT> <RIGHT>
nnoremap <S-RIGHT> <RIGHT>
vnoremap <S-RIGHT> <RIGHT>
inoremap <S-LEFT>  <LEFT>
nnoremap <S-LEFT>  <LEFT>
vnoremap <S-LEFT>  <LEFT>
inoremap <C-RIGHT> <RIGHT>
nnoremap <C-RIGHT> <RIGHT>
vnoremap <C-RIGHT> <RIGHT>
inoremap <C-LEFT>  <LEFT>
nnoremap <C-LEFT>  <LEFT>
vnoremap <C-LEFT>  <LEFT>

" I hate shift-q
nnoremap <S-Q> <NOP>

" I hate shift-z-z
nnoremap <S-Z><S-Z> <NOP>

" ignore case for searching and use smart case
" set ignorecase
" set smartcase

" syntax highlighting
syntax on

" I might get rid of this...
" sets default register to system clipboard
set clipboard=unnamedplus

" sudo writing
command W w !sudo tee "%" > /dev/null 2> /dev/null

" clear search on pressing escape
nnoremap <esc> :noh<return><esc>

" highlighting
hi StatusLine cterm=NONE ctermfg=15 ctermbg=NONE

hi Error cterm=underline ctermbg=NONE
hi SpellBad cterm=underline ctermbg=NONE
hi SpellCap cterm=underline ctermbg=NONE
hi SpellLocal cterm=underline ctermbg=NONE
hi SpellRare cterm=underline ctermbg=NONE

hi Underlined cterm=underline ctermfg=4 ctermbg=NONE

hi Type cterm=NONE ctermfg=6 ctermbg=NONE
hi PreProc cterm=NONE ctermfg=6 ctermbg=NONE
hi Constant cterm=NONE ctermfg=5 ctermbg=NONE
hi Comment cterm=NONE ctermfg=2 ctermbg=NONE
hi Special cterm=NONE ctermfg=7 ctermbg=NONE

hi MatchParen cterm=NONE ctermfg=0 ctermbg=6
hi Search cterm=NONE ctermfg=0 ctermbg=8

" fancy hack for leading whitespace
"set conceallevel=2 concealcursor=ni
"syn clear Conceal
"call matchadd('Conceal', '^\s+', 10, 99, {'conceal': '.'})
"hi Conceal cterm=NONE ctermfg=30 ctermbg=NONE
"hi Visual ctermbg=242
