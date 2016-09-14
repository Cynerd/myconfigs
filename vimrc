" For git mergetool
" :diffg RE  " get from REMOTE
" :diffg BA  " get from BASE
" :diffg LO  " get from LOCAL
execute pathogen#infect()
syntax on
filetype plugin indent on

set exrc
set secure
set title

set hidden
set undofile
set undodir=~/.cache/vim-undo//
set hlsearch
set foldmethod=syntax

colorscheme elflord

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

set tags=.tags,./tags
" Setup autotag to look for .tags file
let g:autotagTagsFile=".tags"

" Some fast shortcuts
map <F2> :call InitBase()<cr>
nmap <F9> :TagbarOpen fc<cr>
map <F10> :setlocal spell! spelllang=en_us<cr>
map <F11> :setlocal spell! spelllang=cs<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function InitBase()
	set number
	set colorcolumn=82
	set textwidth=82
	highlight ColorColumn ctermbg=darkgray
endfunction

function InitBash()
	call InitBase()

	" Format current file with indent
	map <F2> gg=G2<c-o>

	map <F3> :w<cr>
	map <F4> :wa<cr>
endfunction

function InitPython()
	call InitBase()
	set colorcolumn=79
	set textwidth=79
	
	unmap <F2>
	map <F3> :w<cr>
	map <F4> :wa<cr>
endfunction

function InitC()
	call InitBase()

	map <F2> gggqG2<c-o>
	map <F3> :w<cr>
	map <F4> :wa<cr>
	map <F5> :w<cr>:make<cr>
	map <F6> :cp<cr>
	map <F7> :cn<cr>
	map <F8> :cl<cr>

	" TODO check if .tags exists and alternativelly generate

	autocmd BufNewFile,BufRead *.c set formatprg=indent\ -kr\ -cp1\ -cd1\ -ts4\ -nut\ -brf
	autocmd BufNewFile,BufRead *.cpp set formatprg=indent\ -kr\ -cp1\ -cd1\ -ts4\ -nut\ -brf
	autocmd BufNewFile,BufRead *.h set formatprg=indent\ -kr\ -cp0\ -cd1\ -ts4\ -nut\ -brf
	autocmd BufNewFile,BufRead *.hpp set formatprg=indent\ -kr\ -cp1\ -cd1\ -ts4\ -nut\ -brf
endfunction 

let g:ycm_path_to_python_interpreter="/usr/bin/python3"
let g:ycm_global_ycm_extra_conf = "~/.ycm_c_conf.py"
