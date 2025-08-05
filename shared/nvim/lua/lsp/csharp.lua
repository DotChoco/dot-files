local lspconfig = require("lspconfig")
local M = require("lsp.utils")

local capabilities, on_attach = M.get_common()
local bin_ext = M.get_bin_ext()
local bin_path = M.get_bin_path()

lspconfig.csharp_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "cs" },
  handlers = {
    ["textDocument/definition"] = require('csharpls_extended').handler,
    ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
  },
  cmd = { bin_path .. "csharp-ls" .. bin_ext },
})
