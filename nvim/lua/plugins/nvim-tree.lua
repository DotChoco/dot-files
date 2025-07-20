return {
	'nvim-tree/nvim-tree.lua',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	opts = {
		actions = {
			open_file = {
				window_picker = {
					enable = false
				},
			}
		},
    view = {
      side = "right",
      width = 25,
    },
    renderer = {
      full_name = false,
      root_folder_label = ":t",
      decorators = { "Git", "Open", "Hidden", "Modified", "Bookmark", "Diagnostics", "Copied", "Cut", },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    },
	},
	config = function(_, opts)
		vim.g.loaded = 1
		vim.g.loaded_netrwPlugin = 1
		require("nvim-tree").setup(opts)
	end

}
