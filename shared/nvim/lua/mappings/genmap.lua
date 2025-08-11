-- Leader key
vim.g.mapleader = ' '
local keymap= vim.keymap

keymap.set('n', '<C-s>', '<cmd>write<CR>', { noremap = true, silent = true, desc = "Guardar archivo" })


-- Normal mode: comment/uncomment line
keymap.set('n', '<Space>/', function()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle comment on current line', noremap = true, silent = true })

-- Visual mode: comment/uncomment selección
keymap.set('x', '<Space>/', '<ESC><Cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment selection', silent = true, noremap = true })


-- Desactivate search result highlights
keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlights' })


