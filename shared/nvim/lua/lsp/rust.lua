

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


