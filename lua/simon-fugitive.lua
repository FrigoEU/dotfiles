-- git
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "fugitive",
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     vim.keymap.set("n", "P", function()
--       vim.cmd('Git! push')
--     end, {buffer = bufnr, remap = false, desc= 'Push'})

--     vim.keymap.set("n", "F", function()
--       vim.cmd('Git! fetch --all -v')
--     end, {buffer = bufnr, remap = false, desc= 'Fetch'})

--     vim.keymap.set("n", "q", "gq", {buffer = bufnr, remap = true, desc= 'Quit'})
--     vim.keymap.set("n", "<tab>", "=", {buffer = bufnr, remap = true, desc= 'Toggle'})
--     vim.keymap.set("n", "cc", function()
--       vim.cmd('Git commit --quiet')
--     end, {buffer = bufnr, remap = false, desc= 'commit'})

--   end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "floggraph",
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()

--     vim.keymap.set("n", "F", function()
--       vim.fn['flog#run_command']('Git! fetch --all')
--     end, {buffer = bufnr, remap = false, desc = "Fetch"})

--     vim.keymap.set("n", "q", "gq", {buffer = bufnr, remap = true, desc= 'Quit'})
--   end,
-- })

