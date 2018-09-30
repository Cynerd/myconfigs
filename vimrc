" For git mergetool
" :diffg RE  " get from REMOTE
" :diffg BA  " get from BASE
" :diffg LO  " get from LOCAL
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Visual
Plugin 'itchyny/lightline.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'airblade/vim-gitgutter'
" Programming
Plugin 'w0rp/ale'
Plugin 'maximbaz/lightline-ale'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'craigemery/vim-autotag'
Plugin 'scrooloose/nerdcommenter'
" Movement, format and others
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'dhruvasagar/vim-table-mode'
" Syntax
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-scripts/iptables'
Plugin 'neomutt/neomutt.vim'
Plugin 'sirtaj/vim-openscad'
Plugin 'tmhedberg/SimpylFold'

call vundle#end()
filetype plugin indent on

colorscheme elflord
syntax on

set exrc
set secure
set title

set hidden
set undofile
set undodir=~/.cache/vim-undo//
set hlsearch
set wildmode=longest:full,full
set wildmenu
set modeline
set encoding=utf-8

set foldmethod=syntax
highlight Folded ctermbg=Black ctermfg=LightBlue
set foldtext=FoldText()
function FoldText()
	return getline(v:foldstart) . '  '
endfunction


set number
set colorcolumn=82
set textwidth=82
highlight ColorColumn ctermbg=DarkGray

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

nnoremap <leader>d :! sdcv -n <cword><cr>

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=8
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=232
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233

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

" Setup gitgutter
set updatetime=100

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

" UltiSnips triggers
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {'c': ['cppcheck', 'gcc']}
let g:ale_fixers = {
\	'c': ['remove_trailing_lines', 'trim_whitespace'],
\ 'python': ['autopep8', 'isort', 'add_blank_lines_for_python_control_statements', 'remove_trailing_lines', 'trim_whitespace'],
\}

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_path_to_python_interpreter="/usr/bin/python3"
let g:ycm_global_ycm_extra_conf = ".ycm_conf.py"
