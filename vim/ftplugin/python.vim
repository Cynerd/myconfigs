setlocal colorcolumn=80
setlocal textwidth=80

let b:ale_linters = ['pylsp', 'pylint', 'mypy', 'pydocstyle']
let b:ale_fixers = ['isort', 'black', 'remove_trailing_lines', 'trim_whitespace']
