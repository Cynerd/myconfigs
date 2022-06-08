let b:ale_linters = ['ccls', 'cppcheck', 'flawfinder']
let b:ale_fixers = ['clang-format', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_c_ccls_init_options = {'cache': {'directory': '/tmp/ccls/cache'}, 'compilationDatabaseDirectory': 'build'}
let g:ale_c_parse_compile_commands = 1

nmap <F8> :ALENext<cr>
nmap <F7> :ALEPrevious<cr>
