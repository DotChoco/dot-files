local lspconfig = require("lspconfig")
local M = require("lsp.utils")

local bin_ext = M.get_bin_ext()
local bin_path = M.get_bin_path()

lspconfig.cmake.setup({
  filetypes = { 'cmake' },
  root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
  init_options = {
    buildDirectory = 'build',
  },
  cmd = { bin_path .. "cmake-language-server" .. bin_ext },
})
