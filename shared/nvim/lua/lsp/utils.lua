local M = {}

-- Detect binary extention
function M.get_bin_ext()
  if vim.fn.has("win32") == 1 then
    return ".cmd"
  else
    return ""
  end
end

-- Get base path of binary installed from mason
function M.get_bin_path()
  return vim.fn.stdpath("data") .. "/mason/bin/"
end

-- Get base path of binary installed from mason
function M.get_nvim_data()
  return vim.fn.stdpath("data")
end



-- Capabilities and on_attach
function M.get_common()
  local blink_cmp = require("blink.cmp")
  local capabilities = blink_cmp.get_lsp_capabilities()

  local function on_attach(client, bufnr)
    -- Configure here the LSP mappings
  end

  return capabilities, on_attach
end

return M
