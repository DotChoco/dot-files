---@diagnostic disable: undefined-global
-- Asegúrate de tener Telescope instalado y cargado
local builtin = require('telescope.builtin')

-- Keymaps para modo normal
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Buscar archivos' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Buscar texto (grep)' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Listar buffers' })
vim.keymap.set('n', '<leader>fh', builtin.oldfiles, { desc = 'Archivos recientes' })

-- Git
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Commits de git' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Estado de git' })

-- LSP
vim.keymap.set('n', '<leader>td', builtin.lsp_definitions, { desc = 'Ir a definición' })
vim.keymap.set('n', '<leader>tr', builtin.lsp_references, { desc = 'Referencias' })
vim.keymap.set('n', '<leader>ts', builtin.lsp_document_symbols, { desc = 'Símbolos del documento' })

-- Otros útiles
vim.keymap.set('n', '<leader>km', builtin.keymaps, { desc = 'Mostrar keymaps' })
vim.keymap.set('n', '<leader>ht', builtin.help_tags, { desc = 'Ayuda' })
vim.keymap.set('n', '<leader>ma', builtin.marks, { desc = 'Marcadores' })

