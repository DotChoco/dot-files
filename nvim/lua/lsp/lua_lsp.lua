local M = require("lsp.utils")

local capabilities, on_attach = M.get_common()
local bin_ext = M.get_bin_ext()
local bin_path = M.get_bin_path()

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { bin_path .. "lua-language-server" .. bin_ext },
})
