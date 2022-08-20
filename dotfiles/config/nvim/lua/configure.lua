local configure = {}

function configure.catppuccin()
  vim.cmd("packadd! catppuccin")

  require("catppuccin").setup({
    integrations = {
      native_lsp = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
    },
  })

  vim.g.catppuccin_flavour = "mocha"
  vim.cmd("colorscheme catppuccin")
end

function configure.lualine()
  vim.cmd("packadd! lualine")
  require("lualine").setup()
end

function configure.nvim_lspconfig()
  vim.cmd("packadd! nvim-lspconfig")
  local lspconfig = require("lspconfig")

  function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, { noremap = true, silent = true, buffer = bufnr })
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  vim.cmd("packadd! cmp-nvim-lsp")
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  lspconfig.pylsp.setup({ on_attach = on_attach, capabilities = capabilities })
  lspconfig.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
end

function configure.nvim_cmp()
  vim.cmd("packadd! nvim-cmp")
  local cmp = require("cmp")

  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
    }),
  })
end

return configure
