local M = require("lsp.utils")

local bin_ext = M.get_bin_ext()
local bin_path = M.get_bin_path()

local capabilities = blink_cmp.get_lsp_capabilities()
local function on_attach(client, bufnr)
end

vim.lsp.config("clangd", {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  cmd = { bin_path .. "clangd" .. bin_ext },
})
