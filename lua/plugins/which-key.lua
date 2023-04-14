return {
  "folke/which-key.nvim",
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup {
      -- border = "shadow"
    }
  end
}
