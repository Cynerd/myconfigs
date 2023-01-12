let b:ale_linters = ['clangd', 'cppcheck', 'flawfinder']
let b:ale_fixers = ['clang-format', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_c_parse_compile_commands = 1
let g:ale_c_clangd_options = '--header-insertion=never'

nmap <F8> :ALENext<cr>
nmap <F7> :ALEPrevious<cr>
