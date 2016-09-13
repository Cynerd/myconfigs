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

" GitGutterEnable

function InitBase()
	set number
	set colorcolumn=82
	set textwidth=82
	highlight ColorColumn ctermbg=darkgray
endfunction

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
	" Soft tab stop is here only for posibility of expandtab
endfunction
command TabToogle call TabToogle()

" Write as root
cmap w!! w !sudo tee >/dev/null %

cabbrev E Explore
nnoremap <C-C><CR> :Explore<CR>
nnoremap <C-C>l :bnext<CR>
nnoremap <C-C>h :bprev<CR>
nnoremap <C-C><C-C> :buffers<CR>:buffer<Space>
let g:netrw_banner=0
let g:netrw_liststyle=1
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'

let g:table_mode_corner="|"

colorscheme elflord

" Directory where *.swp files will be stored
set directory=$HOME/.cache/vim//

" Setup table-mode to markdown compliant
" Note: to start use "\ t m"
let g:table_mode_corner="|"

map <F2> :call InitBase()<cr>
map <F10> :setlocal spell! spelllang=en_us<cr>
map <F11> :setlocal spell! spelllang=cs<cr>

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
	nmap <F9> :TagbarOpen fc<cr>
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
	nmap <F9> :TagbarOpen fc<cr>

	autocmd BufNewFile,BufRead *.c set formatprg=indent\ -kr\ -cp1\ -cd1\ -ts4\ -nut\ -brf
	autocmd BufNewFile,BufRead *.cpp set formatprg=indent\ -kr\ -cp1\ -cd1\ -ts4\ -nut\ -brf
	autocmd BufNewFile,BufRead *.h set formatprg=indent\ -kr\ -cp0\ -cd1\ -ts4\ -nut\ -brf
	autocmd BufNewFile,BufRead *.hpp set formatprg=indent\ -kr\ -cp1\ -cd1\ -ts4\ -nut\ -brf

	execute ':silent !ctags -R -f .tags'
	autocmd VimLeave * !rm .tags

	execute ':silent !cscope -Rbq -f .cscope.out'
	execute 'cscope add .cscope.out'
	autocmd VimLeave * !rm .cscope*

	" cscope maping
	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


	execute ':redraw'
endfunction 

let g:ycm_path_to_python_interpreter="/usr/bin/python3"
let g:ycm_global_ycm_extra_conf = "~/.ycm_c_conf.py"
