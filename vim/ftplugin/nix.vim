let b:ale_linters = ['nix', 'rnix_lsp', 'statix']
let b:ale_fixers = ['alejandra', 'remove_trailing_lines', 'trim_whitespace']

nmap <F8> :ALENext<cr>
nmap <F7> :ALEPrevious<cr>
