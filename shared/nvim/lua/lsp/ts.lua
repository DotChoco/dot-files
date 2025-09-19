local M = require("lsp.utils")

local capabilities, on_attach = M.get_common()
local bin_ext = M.get_bin_ext()
local bin_path = M.get_bin_path()
local ts_path = bin_path .. "typescript-language-server" .. bin_ext

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { ts_path, '--stdio' },
  init_options = {
    disableSuggestions = true,
  }
})

