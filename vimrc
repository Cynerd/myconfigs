" For git mergetool
" :diffg RE  " get from REMOTE
" :diffg BA  " get from BASE
" :diffg LO  " get from LOCAL
set nocompatible

" Ale (completion enablement has to be before plugin load)
let g:ale_completion_enabled = 1
let g:ale_set_highlights = 0
set completeopt=menu,menuone,preview,noselect,noinsert

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'VundleVim/Vundle.vim'
Plugin 'jasonccox/vim-wayland-clipboard'
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
Plugin 'tpope/vim-fugitive'
" Movement, format and others
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'dhruvasagar/vim-table-mode'
" Syntax
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-scripts/iptables'
Plugin 'nfnty/vim-nftables'
Plugin 'sirtaj/vim-openscad'
Plugin 'tmhedberg/SimpylFold'
Plugin 'fedorenchik/qt-support.vim'
Plugin 'chr4/nginx.vim'
Plugin 'LnL7/vim-nix'
Plugin 'gisphm/vim-gitignore'
Plugin 'aliou/bats.vim'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'jamespeapen/swayconfig.vim'
" Files navigation
Plugin 'kien/ctrlp.vim'
" Grammer
Plugin 'rhysd/vim-grammarous'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call vundle#end()
filetype plugin indent on

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
highlight Folded ctermbg=Black ctermfg=Yellow
set foldtext=FoldText()
function FoldText()
	return getline(v:foldstart) . '  '
endfunction


set backspace=indent,eol,start

set number
set colorcolumn=80
set textwidth=80
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

" Translate word under cursor
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
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+,'
function GitIgnore()
	" Possibly find and include all lower .gitignore files?
	let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+,' . netrw_gitignore#Hide()
endfunction
command GitIgnore call GitIgnore()
" Some fast buffer switching and opening of new files
nnoremap <C-C><CR> :Explore<CR>
nnoremap <C-C>l :bnext<CR>
nnoremap <C-C>h :bprev<CR>
nnoremap <C-C><C-C> :buffers<CR>:buffer<Space>

" CtrlP
let g:ctrlp_user_command = {
\ 'types': {
\    1: ['.git', 'cd %s && git ls-files . -c --recurse-submodules && git ls-files . -o --exclude-standard'],
\  },
\  'fallback': 'find %s -type f'
\ }
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_arg_map = 1
let g:ctrlp_default_input = 1

" Directory where *.swp files will be stored
" Note that double slash is intensional, it tells vim to build complete path.
set directory=$HOME/.cache/vim//

" Setup gitgutter
set updatetime=100
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

" Setup table-mode to markdown compliant
" Note: to start use "\ t m"
let g:table_mode_corner="|"

set tags=./.tags,.tags
" Setup autotag to look for .tags file
let g:autotagTagsFile=".tags"

" Enable mouse
set mouse=a
set ttymouse=sgr
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

" NERDCommenter
let g:NERDCreateDefaultMappings = 1

" UltiSnips triggers
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" ALE bidings
nmap <leader>[ <Plug>(ale_go_to_definition)
nmap <leader>] <Plug>(ale_go_to_definition_in_tab)

" LanguageTool
let g:grammarous#languagetool_cmd = 'languagetool'
