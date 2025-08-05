



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


