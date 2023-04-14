return {
  "folke/which-key.nvim",
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup {
      -- border = "shadow"
    }
    wk.register({
        ["<leader>"] = {
          g = {
            name = "+git",
            s = { "<cmd>Neogit kind=vsplit<cr>", "Git status" },
            t = { "<cmd>DiffviewFileHistory %<CR>", "Time machine" },
            -- l = { "<cmd>vertical Flogsplit-all<CR>", "Log" },
          },
        },
    })
  end
}
