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

return configure
