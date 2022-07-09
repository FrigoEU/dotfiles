-- require('telescope').setup {
--   extensions = {
--       ["ui-select"] = {
--         require("telescope.themes").get_dropdown {
--           -- even more opts
--         }
--      }
--   }
-- }

-- require("telescope").load_extension("ui-select")
-- require("telescope").load_extension('project')

-- require("which-key").setup {}

-- require("project_nvim").setup {
--       -- your configuration comes here
--       -- or leave it empty to use the default settings
--       -- refer to the configuration section below
--     }

-- require("surround").setup {mappings_style = "surround"}

-- require"termwrapper".setup {
--     -- these are all of the defaults
--     open_autoinsert = true, -- autoinsert when opening
--     toggle_autoinsert = true, -- autoinsert when toggling
--     autoclose = true, -- autoclose, (no [Process exited 0])
--     winenter_autoinsert = false, -- autoinsert when entering the window
--     default_window_command = "belowright 13split", -- the default window command to run when none is specified,
--                                                    -- opens a window in the bottom
--     open_new_toggle = true, -- open a new terminal if the toggle target does not exist
--     log = 1, -- 1 = warning, 2 = info, 3 = debug
-- }

-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

--   -- Mappings.
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   local bufopts = { noremap=true, silent=true, buffer=bufnr }
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--   vim.keymap.set('n', '<space>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, bufopts)
--   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--   vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
-- end

-- require('lspconfig')['tsserver'].setup{
--  --  on_attach = on_attach,
-- }

-- vim.cmd[[colorscheme tokyonight]]