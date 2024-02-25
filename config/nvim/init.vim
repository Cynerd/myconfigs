augroup user_config
  autocmd!
  autocmd BufWritePost init.vim source <afile>
augroup end

lua require('plugins')
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end


set exrc
set secure
set title

set hidden
set undofile
set undodir=~/.cache/nvim-undo//
set directory=$HOME/.cache/nvim//
set hlsearch
set wildmode=longest:full,full
set wildmenu
set modeline
set encoding=utf-8


set backspace=indent,eol,start

colorscheme nord
let g:lightline = { 'colorscheme': 'nord' }

set number
set colorcolumn=80
set textwidth=80


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
nnoremap <c-c><CR> :Explore<cr>
nnoremap <c-c>l :bnext<cr>
nnoremap <c-c>h :bprev<cr>

" Setup gitgutter
set updatetime=100
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

" Setup table-mode to markdown compliant
" Note: to start use "\ t m"
let g:table_mode_corner='|'

" Open tagbar with <F9>
nmap <F9> :TagbarOpen fc<cr>

" Spell checking
map <F10> :setlocal spell!<cr>
function LangToggle()
	if &spelllang !=? 'en_us'
		setlocal spelllang=en_us
		echo 'spelllang=en_us'
	else
		setlocal spelllang=cs
		echo 'spelllang=cs'
	endif
endfunction
setlocal spelllang=en_us
map <F11> :call LangToggle()<cr>

" NERDCommenter
let g:NERDCreateDefaultMappings = 1

" UltiSnips triggers
let g:UltiSnipsExpandTrigger='<c-h>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" ALE
let g:ale_set_baloons = 1
let g:ale_floating_preview = 1
let g:ale_use_neovim_diagnostics_api = 1
nmap <leader>f <Plug>(ale_fix)

" Telescope
nnoremap <c-c><c-c> :Telescope buffers<cr>
nnoremap <expr> <c-p> ":lua require'telescope.builtin'.git_files{}<cr>".expand('%:h')."/"
nnoremap <c-s-p> :Telescope lsp_document_symbols<cr>
nmap <leader>] :Telescope lsp_definitions<cr>
nmap <leader><leader>] :Telescope lsp_type_definitions<cr>
nmap <leader>[ :Telescope lsp_implementations<cr>
nmap <leader><leader>[ :Telescope lsp_references<cr>

" Copy line location
" TODO this should work but it doesn't for some reason
" nmap <leader><leader>c :let @+=expand("%:p") . ":" . line(".")<cr>
nmap <leader><leader>c :exec "!wl-copy '" . expand("%:p") . ":" . line(".") . "'"<cr><cr>

