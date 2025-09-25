local M = require("lsp.utils")

local capabilities, on_attach = M.get_common()
local bin_ext = M.get_bin_ext()
local bin_path = M.get_bin_path()
local util = require ('lspconfig').util


vim.lsp.config("gopls", {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  cmd = { bin_path .. "gopls" .. bin_ext },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})
