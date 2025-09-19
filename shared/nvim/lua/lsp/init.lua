-- Global Configuration of diagnostics
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  severity_sort = true,
  signs = false,
})

-- Load each configuration of LSP
require("lsp.csharp")
require("lsp.lua_lsp")
require("lsp.pws")
-- require("lsp.rust")
-- require("lsp.go")
-- require("lsp.clang")
-- require("lsp.cmake")
-- require("lsp.ts")


-- Start each LSP
vim.lsp.enable("csharp_ls")
vim.lsp.enable("powershell_es")
-- lua print(vim.inspect(vim.lsp.get_clients()))



