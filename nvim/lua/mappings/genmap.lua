-- Leader key
vim.g.mapleader = ' '

vim.keymap.set('n', '<C-s>', '<cmd>write<CR>', { noremap = true, silent = true, desc = "Guardar archivo" })


-- Normal mode: comentar/descomentar linea
vim.keymap.set('n', '<Space>/', function()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle comment on current line', noremap = true, silent = true })

-- Visual mode: comentar/descomentar selección
vim.keymap.set('x', '<Space>/', '<ESC><Cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment selection', silent = true, noremap = true })


-- Mapea <leader>h para desactivar el resaltado de búsqueda
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

