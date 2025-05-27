-- vim.wo.number = true
-- vim.cmd('colorscheme retrobox')
-- vim.opt.relativenumber = true
local opt = vim.opt
local opt_local = vim.opt_local
local api = vim.api
local indent = vim.o

opt.shell = "pwsh"
opt.shellcmdflag = "-NoExit -Command -"

require("config.lazy")
require("mappings.genmap")
require("mappings.lspmap")
require("mappings.treemap")
require("mappings.telemap")
require("mappings.buffermap")


-- Buffers line
opt.termguicolors = true
require("bufferline").setup {}



--Indentation Config
indent.expandtab = true   -- expand tab input with spaces characters
indent.smartindent = true -- syntax aware indentations for newline inserts
indent.tabstop = 2        -- num of space characters per tab
indent.shiftwidth = 2     -- spaces per indentation level

api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    opt_local.shiftwidth = 2
    opt_local.tabstop = 2
    opt_local.softtabstop = 2
    opt_local.expandtab = true
  end,
})




require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
