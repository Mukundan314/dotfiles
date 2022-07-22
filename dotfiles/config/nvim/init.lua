vim.o.clipboard = "unnamedplus"
vim.o.colorcolumn = "80,120"
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true

vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<Leader><Space>", ":nohlsearch<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank() end })

vim.cmd [[packadd! catppuccin]]
vim.cmd [[packadd! lualine]]

vim.cmd [[colorscheme catppuccin]]

require("lualine").setup()
