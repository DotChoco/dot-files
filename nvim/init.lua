-- vim.wo.number = true
-- vim.opt.relativenumber = true

local opt = vim.opt
local opt_local = vim.opt_local
local api = vim.api
local indent = vim.o

opt.shell = "pwsh"
opt.shellcmdflag = "-NoExit -Command -"

require("config.lazy")
require("mappings.genmap")
require("mappings.lspmap")
require("mappings.treemap")
require("mappings.telemap")
require("mappings.buffermap")

-- Erease the search history
opt.shada = ""

-- Buffers line
opt.termguicolors = true
require("bufferline").setup{}


--Indentation Config
indent.expandtab = true   -- expand tab input with spaces characters
indent.smartindent = true -- syntax aware indentations for newline inserts
indent.tabstop = 2        -- num of space characters per tab
indent.shiftwidth = 2     -- spaces per indentation level

api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    opt_local.shiftwidth = 2
    opt_local.tabstop = 2
    opt_local.softtabstop = 2
    opt_local.expandtab = true
  end,
})



-- Copy to Clipboard
api.nvim_set_option("clipboard","unnamed")



require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


local default_lualine_config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {--[[ 'encoding' ]]},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


local nvimtree_lualine_config = {
  options = {
    theme = 'auto',
    section_separators = '',
    component_separators = '',
    disabled_filetypes = { 'NvimTree' }, -- También puedes simplemente ocultarlo
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}

require('lualine').setup(default_lualine_config)
-- AutoCmds para cambiar la config según el buffer activo
api.nvim_create_autocmd("BufEnter", {
  pattern = "NvimTree_*",
  callback = function()
    require('lualine').setup(nvimtree_lualine_config)
  end
})

api.nvim_create_autocmd("BufLeave", {
  pattern = "NvimTree_*",
  callback = function()
    require('lualine').setup(default_lualine_config)
  end
})

local bufferline = require('bufferline')
bufferline.setup {
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers ="none",
        close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
        indicator = { style = 'none' },
        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false, -- only applies to coc
        diagnostics_update_on_event = true, -- use nvim's diagnostic handler
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = false,
       offsets = {{
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
          separator = true
        }},
        color_icons = false, -- whether or not to add the filetype icon highlights
        get_element_icon = function(element)
          -- element consists of {filetype: string, path: string, extension: string, directory: string}
          -- This can be used to change how bufferline fetches the icon
          -- for an element e.g. a buffer or a tab.
          -- e.g.
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        show_buffer_icons = false, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        show_duplicate_prefix = false, -- whether to show duplicate buffer prefix
        duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
        persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
        move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        auto_toggle_bufferline = false,
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },
        pick = { alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890" },
    }
}
