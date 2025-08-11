-- Configuración de clangd para PSP
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local base = require("nvchad.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

-- Paths para PSPDEV
local pspdev_path = "/usr/local/pspdev"
local psp_gcc = pspdev_path .. "/bin/psp-g++"
local psp_includes = {
  pspdev_path .. "/psp/include",      -- Directorio de headers de PSP
  pspdev_path .. "/psp/sdk/include"     -- Headers comunes
}

lspconfig.clangd.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--query-driver=" .. psp_gcc,       -- Usar compilador de PSPDEV
    "--background-index",
    "--clang-tidy",
    "--offset-encoding=utf-16",
    "--header-insertion=never"
  },
  filetypes = { "c" , "cpp" },
  root_dir = function(fname)
    -- Se puede ajustar la detección a un archivo de configuración propio de PSP
    local data = lspconfig.util.root_pattern("psp.conf")(fname) or vim.fn.getcwd()
    vim.notify(data)
    return data
  end,
  settings = {
    clangd = {
      arguments = {
        "--target=mips-psp",                         -- Target para PSP (arquitectura MIPS)
        "--sysroot=" .. pspdev_path .. "/psp",       -- Sysroot ajustado a la carpeta correcta
        "-DPSP",                                     -- Define para habilitar código PSP
        "-DNULL=0",                                  -- Solución para NULL
        "-I" .. psp_includes[1],                     -- Directorio de includes de PSP
        "-I" .. psp_includes[2]                      -- Directorio de includes común
      }
    }
  }
}

lspconfig.csharp_ls.setup({
  capabilities =capabilities,
  on_attach = on_attach,
  filetypes = { "cs" },
})


