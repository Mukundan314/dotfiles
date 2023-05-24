vim.o.clipboard = "unnamedplus"
vim.o.colorcolumn = "80,120"
vim.o.cursorline = true
vim.o.number = true
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.timeout = true
vim.o.timeoutlen = 300

if os.getenv("ASDF_DATA_DIR") then
  vim.g.python3_host_prog = os.getenv("ASDF_DATA_DIR") .. "/shims/python"
end

vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<Leader><Space>", ":nohlsearch<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank() end })

vim.diagnostic.config({ virtual_text = false, update_in_insert = true })
vim.keymap.set(
  "n",
  "<leader>e",
  function() vim.diagnostic.open_float({ scope = "cursor" }) end,
  { noremap = true, silent = true, buffer = bufnr, desc = "View diagnostic" }
)


local configure = require("configure")

configure.catppuccin()
configure.bufferline()
configure.lualine()
configure.nvim_cmp()
configure.nvim_lspconfig()
configure.nvim_treesitter()
configure.vim_sleuth()
configure.gitsigns()
configure.which_key()
