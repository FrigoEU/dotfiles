-- Easily move between windows
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

return {
  { "troydm/zoomwintab.vim",
    lazy = false,
    keys = {
      { "<leader>w=", "<C-w>=", desc = "Equal" },
      { "<leader>wm", "<cmd>ZoomWinTabToggle<CR>", desc = "Maximize" },
      { "<leader>wS", "<cmd>split<CR>", desc = "Split horizontally" },
      { "<leader>wV", "<cmd>vsplit<CR>", desc = "Split vertically" },
      { "<leader>wH", "<C-w>H", desc = "Move window left" },
      { "<leader>wJ", "<C-w>J", desc = "Move window down" },
      { "<leader>wK", "<C-w>K", desc = "Move window up" },
      { "<leader>wL", "<C-w>L", desc = "Move window right" },
      { "<leader>1",  "1<c-w>w", desc = "Window 1" },
      { "<leader>2",  "2<c-w>w", desc = "Window 2" },
      { "<leader>3",  "3<c-w>w", desc = "Window 3" },
      { "<leader>4",  "4<c-w>w", desc = "Window 4" },
      { "<leader>5",  "5<c-w>w", desc = "Window 5" },
      { "<leader>6",  "6<c-w>w", desc = "Window 6" },
    }
  },
}
