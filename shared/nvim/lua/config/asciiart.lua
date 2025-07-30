local api = vim.api
local previous_bufnr = nil -- Save the last buffer
local M = {}

function M.read_ascii_file(path)
    local file = io.open(path, "r")
    if not file then return {} end
    local content = {}
    for line in file:lines() do
        table.insert(content, line)
    end
    file:close()
    return content
end

function M.show_ascii_art()
    -- Save the current buffer
    previous_bufnr = api.nvim_get_current_buf()

    local buf = api.nvim_create_buf(false, true)
    api.nvim_set_current_buf(buf)

    vim.bo[buf].buftype = 'nofile'
    vim.bo[buf].swapfile = false
    vim.bo[buf].bufhidden = 'wipe'
    vim.bo[buf].modifiable = true

    local ascii_path = vim.fn.stdpath("config") .. "/ascii.txt"
    local content = M.read_ascii_file(ascii_path)

    local win_width = api.nvim_win_get_width(0)
    local win_height = api.nvim_win_get_height(0)

    local empty_lines = math.floor((win_height - #content) / 2)
    local lines = {}

    for _ = 1, empty_lines do
        table.insert(lines, "")
    end

    for _, line in ipairs(content) do
        local visual_width = vim.fn.strdisplaywidth(line)
        local padding = math.floor((win_width - visual_width) / 2)
        table.insert(lines, string.rep(" ", math.max(0, padding)) .. line)
    end

    api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].modified = false

    local close_keys = { 'q', '<Esc>', '<CR>' }
    for _, key in ipairs(close_keys) do
        api.nvim_buf_set_keymap(buf, 'n', key, '', {
            callback = function()
                -- Usar una copia local del buffer ID
                local ascii_buf = buf

                -- Cambiar al buffer anterior si es válido
                if previous_bufnr and api.nvim_buf_is_valid(previous_bufnr) then
                    api.nvim_set_current_buf(previous_bufnr)
                end

                -- Borrar el buffer de arte solo si sigue siendo válido
                if api.nvim_buf_is_valid(ascii_buf) then
                    api.nvim_buf_delete(ascii_buf, { force = true })
                end
            end,
            noremap = true,
            silent = true
        })
    end
end

function M.back_to_previous()
    if previous_bufnr and api.nvim_buf_is_valid(previous_bufnr) then
        api.nvim_set_current_buf(previous_bufnr)
    else
        vim.notify("No hay buffer anterior disponible", vim.log.levels.WARN)
    end
end

return M
