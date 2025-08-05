






lspconfig.cmake.setup({
  filetypes = { 'cmake' },
  root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
  init_options = {
    buildDirectory = 'build',
  },
  cmd = { bin_path .. "cmake-language-server" .. bin_ext },
})
