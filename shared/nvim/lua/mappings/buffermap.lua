-- Next Buffer
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = "Next buffer" })

-- Previous Buffer
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = "Previous buffer" })

-- New Buffer
vim.keymap.set('n', '<leader>bn', ':enew<CR>', { desc = 'Nuevo buffer' })


-- Delete Current Buffer
vim.keymap.set('n', '<leader>bx', ':bdelete<CR>', { desc = 'Cerrar buffer actual' })




-- Terminal buffer
--
--
-- Función para abrir una terminal en un nuevo split horizontal
vim.api.nvim_create_user_command('TermNewSplit', function()
    vim.cmd('new')
    vim.cmd('terminal')
end, {
    desc = 'Open a new terminal in a horizontal split'
})

-- Función para abrir una terminal en un nuevo split vertical
vim.api.nvim_create_user_command('TermNewVSplit', function()
    vim.cmd('vnew')
    vim.cmd('terminal')
end, {
    desc = 'Open a new terminal in a vertical split'
})

-- Función para abrir una terminal en una nueva pestaña
vim.api.nvim_create_user_command('TermNewTab', function()
    vim.cmd('tabnew')
    vim.cmd('terminal')
end, {
    desc = 'Open a new terminal in a new tab'
})




-- Abrir terminal en un nuevo split horizontal
vim.keymap.set('n', '<leader>t', function()
    vim.cmd('new')
    vim.cmd('terminal')
end, { desc = 'Open new horizontal terminal' })

-- Abrir terminal en un nuevo split vertical
vim.keymap.set('n', '<leader>v', function()
    vim.cmd('vnew')
    vim.cmd('terminal')
end, { desc = 'Open new vertical terminal' })

-- Abrir terminal en una nueva pestaña
vim.keymap.set('n', '<leader>T', function()
    -- vim.cmd('tabnew')
    vim.cmd('terminal')
end, { desc = 'Open new terminal tab' })

-- Define tu tecla leader si no lo has hecho ya (ejemplo: espacio)
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '

