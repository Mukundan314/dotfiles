set clipboard+=unnamedplus
set colorcolumn=80,120
set cursorline
set foldmethod=marker
set number
set relativenumber
set signcolumn=yes
set termguicolors
set updatetime=100
set inccommand=nosplit

let mapleader = ' '

let g:python3_host_prog = expand('~/.local/share/virtualenv/neovim/3.9/bin/python')
let g:ruby_host_prog = trim(system('ruby -e "puts Gem.user_dir"')) . '/bin/neovim-ruby-host'
let g:node_host_prog = expand('~/.npm-global/bin/neovim-node-host')

let g:loaded_python_provider = 1  " Disable Python 2 support
"let g:loaded_python3_provider = 1 " Disable Python 3 support
"let g:loaded_ruby_provider = 1    " Disable Ruby support
"let g:loaded_node_provider = 1    " Disable Node.js support

nnoremap <silent> <leader><Space> :nohlsearch<CR>

execute 'source' stdpath('config') . '/dein.vim'
