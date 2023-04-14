function open_main_terminal() vim.cmd(":botright 1Topen") end

return {
  "kassio/neoterm",
  config = function(_, opts)
    function set_terminal_esc()
      vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', '<C-n>', { noremap = false, silent = true })
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', '<C-p>', { noremap = false, silent = true })
    end

    vim.api.nvim_create_autocmd(
      "TermOpen",
      { callback = set_terminal_esc }
    )

    vim.api.nvim_create_autocmd(
      "TermOpen",
      { command = "startinsert" }
    )

    vim.g.neoterm_autoinsert = true
    vim.g.neoterm_callbacks = {
      before_create_window = function (instance)
        -- print(vim.inspect(instance))
        -- print(vim.cmd(":Tls"))
        if instance.mod == "botright" then
          vim.g.neoterm_size = vim.fn.round(vim.o.lines / 4.0)
        else
          vim.g.neoterm_size = ''
        end
        if (instance.id == 1) then
          vim.api.nvim_buf_set_name(instance.buffer_id, "project-term")
        end
      end
    }
  end,
  keys = {
    { "<leader>'", open_main_terminal, desc = "Toggle terminal" },
    { "<leader>tt", "<cmd>Tnew<CR>" , desc = "New terminal" },
  }
}
