local M = require("lsp.utils")

local capabilities, on_attach = M.get_common()
local bin_ext = M.get_bin_ext()
local bin_path = M.get_bin_path()
local util = require ('lspconfig').util


vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "rust" },
  cmd = { bin_path .. "rust-analyzer" .. bin_ext },
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ['rust_analyzer'] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})

