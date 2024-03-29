local configure = {}

function configure.catppuccin()
  vim.cmd("packadd! catppuccin")

  vim.g.catppuccin_flavour = "mocha"
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

  vim.cmd("colorscheme catppuccin")
end

function configure.bufferline()
  vim.cmd("packadd! bufferline.nvim")
  require("bufferline").setup({
    options = {
      diagnostics = "nvim_lsp",
      show_buffer_close_icons = false,
      separator_style = "slope",
      always_show_bufferline = false,
      hover = {
        enabled = true,
        delay = 10,
        reveal = { "close" },
      },
    },
  })
end

function configure.lualine()
  vim.cmd("packadd! lualine")
  require("lualine").setup()
end

function configure.nvim_web_devicons()
  vim.cmd("packadd! nvim-web-devicons")
  require('nvim-web-devicons').setup()
end

function configure.nvim_lspconfig()
  vim.cmd("packadd! nvim-lspconfig")
  local lspconfig = require("lspconfig")

  function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = "Hover" })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { noremap = true, silent = true, buffer = bufnr, desc = "Format" })
  end


  vim.cmd("packadd! cmp-nvim-lsp")

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  lspconfig.pylsp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = { pylsp = { plugins = { black = { enabled = true } } } },
  })

  lspconfig.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })

  lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })

  lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })
end

function configure.nvim_treesitter()
  vim.cmd("packadd! nvim-treesitter")
  require("nvim-treesitter.configs").setup({
     highlight = {
       enable = true,
       additional_vim_regex_highlighting = true,
     },
  })
end

function configure.nvim_cmp()
  vim.cmd("packadd! nvim-cmp")
  vim.cmd("packadd! vim-vsnip")

  local cmp = require("cmp")

  cmp.setup({
    snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
    }),
  })
end

function configure.vim_sleuth()
  vim.cmd("packadd! vim-sleuth")
end

function configure.gitsigns()
  vim.cmd("packadd! gitsigns.nvim")

  require("gitsigns").setup({
    current_line_blame = true,
  })
end

function configure.which_key()
  vim.cmd("packadd! which-key.nvim")
  require("which-key").setup({})
end

return configure
