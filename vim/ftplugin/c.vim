let b:ale_linters = ['cppcheck', 'ccls', 'flawfinder']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
"let g:ale_c_parse_compile_commands = 1

nmap <F8> :ALENext<cr>
nmap <F7> :ALEPrevious<cr>
