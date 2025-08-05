-- Global Configuration of diagnostics
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  severity_sort = true,
  signs = false,
})

-- Load each configuration of LSP
require("lsp.csharp")
require("lsp.lua_ls")
require("lsp.rust")
require("lsp.go")
require("lsp.clang")
require("lsp.cmake")
require("lsp.ts")




-- local diagnostic = vim.diagnostic
-- local bin_ext
--
-- function get_bin_path()
--   if linux == true then
--     bin_ext = ""
--   end
--   bin_ext = ".cmd"
--   return vim.fn.stdpath("data") .. "\\mason\\bin\\"
-- end
--
-- local linux = true
-- local bin_path = get_bin_path()
--
-- local lspconfig = require("lspconfig")
-- local blink_cmp = require("blink.cmp")
--
-- local util = require ('lspconfig').util
-- local capabilities = blink_cmp.get_lsp_capabilities()
-- local function on_attach(client, bufnr)
-- end
--
-- -- Diagnostics config
-- diagnostic.config(
--   {
--     underline = true,
--     virtual_text = false,
--     severity_sort = true,
--     signs = false,
--   }
-- )
--
