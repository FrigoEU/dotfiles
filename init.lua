require('impatient') -- Needs to run before other plugins

vim.g.mapleader = ' '

vim.api.nvim_set_option("clipboard", "unnamed") -- This + xclip is necessary for flawless copy-paste
vim.opt.guifont = { "PragmataPro Liga", ":h11" } -- Somehow, PragmataPro Mono didn't work...

vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_animation_length=0.0
vim.g.neovide_cursor_trail_length=0.0
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

-- Easily move between windows
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

function _set_terminal_esc()
  vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
end

vim.api.nvim_create_autocmd("TermOpen", {
  command = "lua _set_terminal_esc()",
})

-- Indentation
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.scrolloff = 8

vim.opt.ignorecase = true

require("telescope").setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-s>"] = "select_horizontal",
        ["<C-v>"] = "select_vertical",
        ["<C-h>"] = "which_key", -- help
      }
    }
  },
  extensions = {
    fzf = {}
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')

-- require('neogit').setup {}

local wk = require("which-key")
wk.setup {}
wk.register({
  ["<leader>"] = {
    ["/"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
    ["*"] = { "<cmd>Telescope grep_string<cr>", "Find string under cursor" },
    ["-"] = { "<cmd>Telescope resume<cr>", "Resume previous telescope" },
    [" "] = { "<cmd>Telescope help_tags<cr>", "Help list" },
    -- ["'"] = { "<cmd>1ToggleTerm<cr>", "Toggle terminal" },
    ["'"] = { "<cmd>lua _fixedterm_toggle()<cr>", "Toggle terminal" },
    b = {
      name = "+buffer",
      b = { "<cmd>Telescope buffers<cr>", "Buffer list" },
      p = { "<cmd>bprevious<cr>", "Previous" },
      n = { "<cmd>bnext<cr>", "Next" },
      d = { "<cmd>Bdelete!<cr>", "Delete" },
    },
    g = {
      name = "+git",
      -- s = { "<cmd>lua require('neogit').open({ kind = 'split' })<cr>", "Git status" },
      l = { "<cmd>lua _lazygit_toggle()<CR>", "Lazygit" },
      u = { "<cmd>lua _gitui_toggle()<CR>", "Gitui" },
      d = { "<cmd>Telescope git_status<CR>", "Diffs" },
      t = { "<cmd>Telescope git_bcommits<CR>", "Time machine" },
    },
    p = {
      name = "+project",
      p = { "<cmd>Telescope projects<cr>", "Project list" },
      t = { "<cmd>NvimTreeFindFileToggle<cr>", "File tree" },
    },
    f = {
      name = "+file",
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
      t = { "<cmd>Telescope colorscheme<cr>", "Theme" },
      n = { "<cmd>enew<cr>", "New File" },
    },
    w = {
      name = "+window",
      ["="] = { "<C-w>=", "Equal" },
      ["H"] = { "<C-w>H", "Move left" },
      ["J"] = { "<C-w>J", "Move down" },
      ["K"] = { "<C-w>K", "Move up" },
      ["L"] = { "<C-w>L", "Move right" },
      ["V"] = { "<cmd>vsplit<cr>", "Split vertically" },
      ["S"] = { "<cmd>split<cr>", "Split horizontally" },
      ["1"] = { "1<c-w>w", "1"},
      ["2"] = { "2<c-w>w", "2"},
      ["3"] = { "3<c-w>w", "3"},
      ["4"] = { "4<c-w>w", "4"},
      ["5"] = { "5<c-w>w", "5"},
      ["6"] = { "6<c-w>w", "6"},
      ["7"] = { "7<c-w>w", "7"},
      ["8"] = { "8<c-w>w", "8"},
      ["m"] = { "<cmd>only<cr>", "Maximize"},
    },
    h = {
      name = "+help",
      h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
      m = { "<cmd>Telescope man_pages<cr>", "Man pages" },
      p = { "<cmd>Telescope builtin<cr>", "Telescope pickers" },
    },
  },
})

require("project_nvim").setup {}

require("toggleterm").setup {
  start_in_insert = false,
}
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ 
  cmd = "lazygit", 
  hidden = true, 
  direction = "float",   
  close_on_exit = true,
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", '<esc>', "<cmd>close<CR>", {silent = false, noremap = true})
    if vim.fn.mapcheck("<esc>", "t") ~= "" then
      vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
    end
  end,
})
function _lazygit_toggle()
  lazygit:toggle()
end

local gitui = Terminal:new({ 
  cmd = "gitui", 
  hidden = true, 
  direction = "float",   
  close_on_exit = true,
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", '<esc>', "<cmd>close<CR>", {silent = false, noremap = true})
    if vim.fn.mapcheck("<esc>", "t") ~= "" then
      vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
    end
  end,
})
function _gitui_toggle()
  gitui:toggle()
end

local fixedterm = Terminal:new({ cmd = "", hidden = true })
function _fixedterm_toggle()
  fixedterm:toggle()
end

require("surround").setup {mappings_style = "surround"}
require("nvim-autopairs").setup {}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  command = "Neoformat prettier",
})

require("nvim-tree").setup {}

vim.cmd[[colorscheme tokyonight]]

-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


-- require("telescope").setup {}
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
