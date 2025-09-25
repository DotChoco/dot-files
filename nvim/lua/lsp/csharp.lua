local M = require("lsp.utils")
local util = require("lspconfig.util")

local capabilities, on_attach = M.get_common()
local bin_ext = M.get_bin_ext()
local bin_path = M.get_bin_path()

---@type vim.lsp.Config
return {
  cmd = { 'csharp-ls' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(util.root_pattern '*.sln'(fname) or util.root_pattern '*.slnx'(fname) or util.root_pattern '*.csproj'(fname))
  end,
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'cs' },
  init_options = {
    AutomaticWorkspaceInit = true,
  },
  handlers = {
    ["textDocument/definition"] = require('csharpls_extended').handler,
    ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
  },
}
