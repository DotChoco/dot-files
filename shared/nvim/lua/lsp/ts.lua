



local ts_path = bin_path .. "typescript-language-server" .. bin_ext

lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { ts_path, '--stdio' },
  init_options = {
    disableSuggestions = true,
  }
})
