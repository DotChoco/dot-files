return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    require "config.lspconfig"
  end,
}
