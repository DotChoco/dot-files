local diagnostic = vim.diagnostic
local bin_ext

function get_bin_path()
  if linux == true then
    bin_ext = ""
  end
  bin_ext = ".cmd"
  return vim.fn.stdpath("data") .. "\\mason\\bin\\"
end

local linux = true
local bin_path = get_bin_path()

local lspconfig = require("lspconfig")
local blink_cmp = require("blink.cmp")

local util = require ('lspconfig').util
local capabilities = blink_cmp.get_lsp_capabilities()
local function on_attach(client, bufnr)
end

-- Diagnostics config
diagnostic.config(
  {
    underline = true,
    virtual_text = false,
    severity_sort = true,
    signs = false,
  }
)

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

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { bin_path .. "lua-language-server" .. bin_ext },
})

lspconfig.rust_analyzer.setup({
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

lspconfig.gopls.setup({
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


lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  cmd = { bin_path .. "clangd" .. bin_ext },
})

lspconfig.cmake.setup({
  filetypes = { 'cmake' },
  root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
  init_options = {
    buildDirectory = 'build',
  },
  cmd = { bin_path .. "cmake-language-server" .. bin_ext },
})



-- Typescript conf

local ts_path = bin_path .. "typescript-language-server" .. bin_ext

lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { ts_path, '--stdio' },
  init_options = {
    disableSuggestions = true,
  }
})



