" For git mergetool
" :diffg RE  " get from REMOTE
" :diffg BA  " get from BASE
" :diffg LO  " get from LOCAL
execute pathogen#infect()
syntax on
filetype plugin indent on

colorscheme elflord

set exrc
set secure
set title

set hidden
set undofile
set undodir=~/.cache/vim-undo//
set hlsearch
set foldmethod=syntax
set wildmode=longest:full,full
set wildmenu
set modeline

set number
set colorcolumn=82
set textwidth=82
highlight ColorColumn ctermbg=darkgray

" Tabs setting. In default we want 4 spaces tab, but allows also 8 spaced tabs
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
function TabToogle()
	if &tabstop != 4
		set tabstop=4
		set shiftwidth=4
		set softtabstop=4
		echom 'Tab stop set to 4'
	else
		set tabstop=8
		set shiftwidth=8
		set softtabstop=8
		echom 'Tab stop set to 8'
	endif
	" Soft tab stop is here only for possibility of expandtab
endfunction
command TabToogle call TabToogle()

" Write as root
cmap w!! w !sudo tee >/dev/null %

" netrw configuration
cabbrev E Explore
let g:netrw_banner=0
let g:netrw_liststyle=1
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
" Some fast buffer switching and opening of new files
nnoremap <C-C><CR> :Explore<CR>
nnoremap <C-C>l :bnext<CR>
nnoremap <C-C>h :bprev<CR>
nnoremap <C-C><C-C> :buffers<CR>:buffer<Space>

" Directory where *.swp files will be stored
" Note that double slash is intensional, it tells vim to build complete path.
set directory=$HOME/.cache/vim//

" Setup table-mode to markdown compliant
" Note: to start use "\ t m"
let g:table_mode_corner="|"

set tags=./.tags,.tags
" Setup autotag to look for .tags file
let g:autotagTagsFile=".tags"

" Enable mouse
set mouse=a
set ttymouse=urxvt
" We are always on fast tty (maybe remove this on servers?)
set ttyfast

" Open tagbar with <F9>
nmap <F9> :TagbarOpen fc<cr>

" Spell checking
map <F10> :setlocal spell!<cr>
function LangToggle()
	if &spelllang != "en_us"
		setlocal spelllang=en_us
		echo "spelllang=en_us"
	else
		setlocal spelllang=cs
		echo "spelllang=cs"
	endif
endfunction
setlocal spelllang=en_us
map <F11> :call LangToggle()<cr>

" TODO for python file type set:
" set colorcolumn=79
" set textwidth=79

" TODO for C file type set:
" TODO bind F2 to execute gnu ident on whole file and ensure that if it fails, no change is done.
" TODO check if .tags exists and alternativelly warn that it missing

let g:ycm_path_to_python_interpreter="/usr/bin/python3"
let g:ycm_global_ycm_extra_conf = ".ycm_conf.py"
