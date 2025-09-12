---@diagnostic disable: undefined-global
return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              -- closingBraceHints = { enable = true },
              closureReturnTypeHints = { enable = "always" },
              -- lifetimeElisionHints = { enable = "always", useParameterNames = true },
              maxLength = 25,
              parameterHints = { enable = true },
              -- reborrowHints = { enable = "always" },
              typeHints = { enable = true },
            },
            cargo = {
              allFeatures = true,
            },
          },
        },
      },
    }

    -- 🔹 habilitar inlay hints automáticamente
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
      end,
    })
  end,
}
-- Configuration for DAP
  --
  -- config = function()
  --   local mason_registry = require('mason-registry')
  --   local codelldb_path = mason_registry.get_package("codelldb")
  --   local extension_path = codelldb_path:get_install_path() .. "\\extension\\"
  --
  --
  --   local codelldb= extension_path.. "adapter\\codelldb.exe"
  --   local codelldb_lib = extension_path.. "lldb\\lib\\liblldb.lib"
  --   local cfg = require('rustaceanvim.config')
  --
  --   vim.g.rustaceanvim = {
  --     dap = {
  --       adapter = cfg.get_codelldb_adapter(codelldb, codelldb_lib)
  --     },
  --   }
  -- end
