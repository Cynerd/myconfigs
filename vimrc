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

function InitBase()
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set noexpandtab
	set number
	set hidden
	set undofile
	set undodir=.vimundo
	set colorcolumn=82
	set textwidth=82
	highlight ColorColumn ctermbg=darkgray
	set hlsearch

	set foldmethod=syntax

	execute 'GitGutterEnable'
endfunction

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

"let g:NERDTreeWinPos = "right"
"let g:NERDTreeWinSize = 30

let g:table_mode_corner="|"

colorscheme elflord

" Gitgutter colors change for dark theme match
" autocmd VimEnter * hi clear SignColumn
" autocmd VimEnter * hi GitGutterChangeDefault ctermfg=3 ctermbg=16 guifg=#bbbb00 guibg=Grey
" autocmd VimEnter * hi GitGutterChangeDefault ctermfg=3 ctermbg=16 guifg=#bbbb00 guibg=Grey
" autocmd VimEnter * hi GitGutterDeleteDefault ctermfg=1 ctermbg=16 guifg=#ff2222 guibg=Grey
" autocmd VimEnter * hi GitGutterAddDefault ctermfg=2 ctermbg=16 guifg=#009900 guibg=Grey

map <F2> :call InitBase()<cr>
map <F10> :setlocal spell! spelllang=en_us<cr>

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

	"execute 'NERDTree'
endfunction

function InitC()
	call InitBase()
	set expandtab

	"execute 'NERDTree'

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
