


lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  cmd = { bin_path .. "clangd" .. bin_ext },
})
