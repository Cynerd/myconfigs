setlocal colorcolumn=120
setlocal textwidth=120

let b:ale_linters = ['flake8', 'pylint', 'pyls']
let b:ale_fixers = ['autopep8', 'isort', 'black', 'add_blank_lines_for_python_control_statements', 'remove_trailing_lines', 'trim_whitespace']
