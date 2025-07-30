return {
  "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    dependencies = { "OXY2DEV/markview.nvim"},
    opts = function()
      return require "config.treesitter"
    end,
    --config = function(_, opts)
    --  require("nvim-treesitter.configs").setup(opts)
    --end,
}
