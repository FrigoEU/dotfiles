return {
  {"nvim-lua/plenary.nvim", lazy = true},
  {
    "gbprod/yanky.nvim",
    config = function ()
      require("yanky").setup({
          picker = {
            telescope = {
              mappings = {
                default = require("yanky.telescope.mapping").put("p"),
                i = {
                  ["<c-j>"] = require("telescope.actions").move_selection_next,
                  ["<c-k>"] = require("telescope.actions").move_selection_previous,
                },
              }
            }
          }
                            })
    end,
    keys = {
      { "p", "<Plug>(YankyPutAfter)", desc = "put (Yanky)" },
      { "P", "<Plug>(YankyPutBefore)", desc = "put before (Yanky)" },
    }
  },
  {
    "kylechui/nvim-surround",
    opts = {
      mappings_style = "surround"
    }
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      map_cr = false
    }
  },
  { "b3nj5m1n/kommentary" },
  -- Better buffer delete: don't lose window layout
  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous" },
      { "<leader>bn", "<cmd>bnext<CR>", desc = "Next" },
      { "<leader>bd", "<cmd>Bdelete!<CR>", desc = "Delete" },
    }
  },
}
