setlocal colorcolumn=79
setlocal textwidth=79

let b:ale_linters = ['pyls']
let b:ale_fixers = ['autopep8', 'isort', 'black', 'add_blank_lines_for_python_control_statements', 'remove_trailing_lines', 'trim_whitespace']
