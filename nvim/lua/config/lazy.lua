-- Bootstrap lazy.nvim
local csc = "colorscheme "
local theme = ""
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)



-- Remove Spaces at the end in every line
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Elimina espacios en blanco al final de las líneas
    vim.cmd([[%s/\s\+$//e]])
  end,
})



-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- theme = "kanagawa"
theme = "gruvbox-material"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    { import = "themes" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "kanagawa" } },
  install = { colorscheme = { theme } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.o.background = "dark" -- or "light" for light mode
vim.cmd(csc .. theme )


require("mason").setup()
require("lsp")


require("mason-lspconfig").setup {
 automatic_enable = {
    "lua_ls",
    "csharp_ls",
    "powershell_es",
    -- "rust_analyzer",
    -- "gopls",
    -- "clangd",
    -- "tsserver"
  },
  ensure_installed = {
    "lua_ls",
    "csharp_ls",
    -- "rust_analyzer",
    -- "gopls",
    -- "clangd",
    -- "tsserver"
  },
}


