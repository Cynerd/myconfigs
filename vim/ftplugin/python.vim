setlocal colorcolumn=120
setlocal textwidth=120

let b:ale_linters = ['pylsp']
let b:ale_fixers = ['isort', 'black', 'add_blank_lines_for_python_control_statements', 'remove_trailing_lines', 'trim_whitespace']
