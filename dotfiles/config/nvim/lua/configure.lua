local configure = {}

function configure.catppuccin()
  vim.cmd([[
  packadd! catppuccin
  colorscheme catppuccin
  ]])
end

function configure.lualine()
  vim.cmd('packadd! lualine')
  require('lualine').setup()
end

function configure.nvim_lspconfig()
  vim.cmd('packadd! nvim-lspconfig')
  local lspconfig = require('lspconfig')

  function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.keymap.set(
      'n',
      'K',
      vim.lsp.buf.hover,
      { noremap = true, silent = true, buffer = bufnr }
    )

    vim.keymap.set(
      'n',
      '<leader>f',
      vim.lsp.buf.formatting,
      { noremap = true, silent = true, buffer = bufnr }
    )

    vim.keymap.set(
      'n',
      '<leader>e',
      function() vim.diagnostic.open_float({ scope = "cursor" }) end,
      { noremap = true, silent = true, buffer = bufnr }
    )
  end

  vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
  })

  lspconfig.pylsp.setup({ on_attach = on_attach })
end

return configure
