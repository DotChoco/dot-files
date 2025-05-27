---@diagnostic disable: undefined-global
return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false,
  ['rust-analyzer'] = {
    cargo = {
      allFeatures = true,
    },
  },



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
}
