setlocal colorcolumn=120
setlocal textwidth=120

let b:ale_linters = ['pylsp', 'pylint']
let b:ale_fixers = ['isort', 'black', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_python_black_options = '-l 120'
