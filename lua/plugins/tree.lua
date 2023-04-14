return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
    keys = {
      {
        "<leader>pt",
        "<cmd>NvimTreeFindFileToggle<CR>",
        desc = "Explorer NeoTree (root dir)",
      },
    },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
  end,
}
