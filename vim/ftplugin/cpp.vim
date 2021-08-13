" This is for C but vim defines *.h as cpp type so here we have it
let b:ale_linters = ['ccls', 'cppcheck', 'flawfinder']
let b:ale_fixers = ['clang-format', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_cpp_ccls_init_options = {'cache': {'directory': '/tmp/ccls/cache'}}
let g:ale_cpp_parse_compile_commands = 1

nmap <F8> :ALENext<cr>
nmap <F7> :ALEPrevious<cr>
