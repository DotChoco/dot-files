local bin_path = "C:/Users/carlo/AppData/Local/nvim-data/mason/bin/"

local lspconfig = require("lspconfig")
local blink_cmp = require("blink.cmp")

local util = require ('lspconfig').util
local capabilities = blink_cmp.get_lsp_capabilities()
local function on_attach(client, bufnr)
end


lspconfig.csharp_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "cs" },
  cmd = { bin_path .. "csharp-ls.cmd" },
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { bin_path .. "lua-language-server.cmd" },
})

-- lspconfig.rust_analyzer.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "rust" },
--   cmd = { bin_path .. "rust-analyzer.cmd" },
--   root_dir = util.root_pattern("Cargo.toml"),
--   settings = {
--     ['rust_analyzer'] = {
--       cargo = {
--         allFeatures = true,
--       },
--     },
--   },
-- })

lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  cmd = { bin_path .. "gopls.cmd" },
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
  cmd = { bin_path .. "clangd.cmd" },
})

lspconfig.cmake.setup({
  filetypes = { 'cmake' },
  root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
  init_options = {
    buildDirectory = 'build',
  },
  cmd = { bin_path .. "cmake-language-server" },
})



-- Typescript conf

local ts_path = bin_path .. "typescript-language-server.cmd"

lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { ts_path, '--stdio' },
  init_options = {
    disableSuggestions = true,
  }
})



