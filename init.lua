require('impatient') -- Needs to run before other plugins

-- vim.cmd("colorscheme onedark_vivid")
-- vim.cmd[[colorscheme kanagawa]]
--
require('onedark').setup { style = 'darker' }
require('onedark').load()

local actions = require("telescope.actions")
local config = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local action_state = require "telescope.actions.state"

vim.g.mapleader = ' '

vim.api.nvim_set_option("clipboard", "unnamed") -- This + xclip is necessary for flawless copy-paste
-- vim.opt.guifont = { "PragmataPro Liga", ":h11" } -- Somehow, PragmataPro Mono didn't work...

--[[ vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_animation_length=0.0
vim.g.neovide_cursor_trail_length=0.0 ]]
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.guicursor="n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- layouts/sessions/workspaces custom solution
function findLayouts(opts)
  local opts = opts or require("telescope.themes").get_dropdown({})

  pickers.new(opts, {
    prompt_title = 'Workspaces',
    finder = finders.new_table({
      results = {
        {
          name = "1. aperi_new",
          cwd = "~/projects/aperi-new",
          main = "package.json"
        }, 
        {
          name = "2. logs",
          cwd = "~/projects/aperi-new",
          main = ""
        }, 
        {
          name = "3. setup",
          cwd = "~/projects/aperi-setup-simon",
          main = "Makefile"
        },
        {
          name = "9. alacritty",
          command = string.format("silent !jumpapp -e alacritty")
        }, 
      },
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name
        }
      end
    }
    ),
    -- previewer = previewers.vim_buffer_cat.new(opts),
    sorter = config.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        -- print(vim.inspect(selection))
        local jumpcmd = selection.value.command or string.format(
          "silent !jumpapp -t '%s' alacritty --title '%s' --working-directory %s -e nvim %s", 
          selection.value.name, 
          selection.value.name,
          selection.value.cwd,
          selection.value.main
        )
        -- print(jumpcmd)
        vim.cmd(jumpcmd)
      end)
      return true
    end,
  }):find()
end

-- coc
require("simon-coc-config")

-- git
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.ft == "fugitive" then
      local bufnr = vim.api.nvim_get_current_buf()
      vim.keymap.set("n", "P", function()
        vim.cmd.Git('push')
      end, {buffer = bufnr, remap = false, desc= 'Push'})

      vim.keymap.set("n", "F", function()
        vim.cmd.Git('fetch --all')
      end, {buffer = bufnr, remap = false, desc= 'Fetch'})

      vim.keymap.set("n", "q", "gq", {buffer = bufnr, remap = true, desc= 'Quit'})
      vim.keymap.set("n", "<tab>", "=", {buffer = bufnr, remap = true, desc= 'Quit'})

    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "floggraph",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    vim.keymap.set("n", "F", function()
      vim.fn['flog#run_command']('Git fetch --all')
    end, {buffer = bufnr, remap = false, desc = "Fetch"})

    vim.keymap.set("n", "q", "gq", {buffer = bufnr, remap = true, desc= 'Quit'})
  end,
})

-- Wilder = wildmenu completion. wildmenu = "command line" = ":" = "Ex" (and / and ?)
local wilder = require("wilder")
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.wildmenu_renderer({
    -- highlighter applies highlighting to the candidates
    highlighter = wilder.basic_highlighter(),
  }),
  ['/'] = wilder.wildmenu_renderer({
    highlighter = wilder.basic_highlighter(),
  }),
}))

--
require("telescope").setup {
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- ["<esc>"] = function () vim.cmd("stopinsert") end,
          ["<C-h>"] = actions.which_key, -- help
        },
        --[[ ["n"] = {
          ["<C-h>"] = actions.which_key, -- help
        }, ]]
      },
    },
  },
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"

-- yank/kill ring
local mapping = require("yanky.telescope.mapping")
require("yanky").setup({
  picker = {
    telescope = {
      mappings = {
        default = mapping.put("p"),
        i = {
          ["<c-j>"] = actions.move_selection_next,
          ["<c-k>"] = actions.move_selection_previous,
        },
      }
    }
  }
})
vim.api.nvim_set_keymap("n", "p", "<Plug>(YankyPutAfter)", {noremap = false})
vim.api.nvim_set_keymap("n", "P", "<Plug>(YankyPutBefore)", {noremap = false})
require("telescope").load_extension("yank_history")

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
vim.api.nvim_create_autocmd("TermOpen", {
  command = "startinsert",
})

--[[ vim.api.nvim_create_autocmd("TermOpen", {
  callback = function (instance)
    print(vim.inspect(instance))
  end
}) ]]

require('nvim-web-devicons').setup({})

require('nvim-treesitter.configs').setup ({
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
})

-- require('lspconfig').sumneko_lua.setup{}

-- Indentation
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.timeoutlen = 200 -- How fast which-key will show up

require("telescope").setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    file_ignore_patterns = { 
      ".git" ,
      ".vscode"
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-h>"] = actions.which_key, -- help
      }
    }
  },
  pickers = {
    git_bcommits = {
      mappings = {
        i = {
          ["<cr>"] = function(prompt_bufnr)
            actions.close(prompt_bufnr)
            local sha = action_state.get_selected_entry().value
            vim.cmd("Git show -w " .. sha )
          end,
        }
      }
    },
  },
  extensions = {
    fzf = {}
  }
}

function find_files_in_project()
  require('telescope.builtin').git_files({show_untracked = true})
  -- require('telescope.builtin').find_files(require("telescope.themes").get_ivy())
end 

function find_files_full()
  vim.cmd('Telescope file_browser path=%:p:h select_buffer=true')
  --[[ require('telescope.builtin').find_files({
    hidden = true,
    cwd = "~/",
    search_file = "hello"
  }) ]]
end 


require("project_nvim").setup({ })
require("lualine").setup({ })

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
--[[ require("sessions").setup({
   events = { "BufEnter" },
   session_filepath = vim.fn.stdpath("data") .. "/sessions",
   absolute = true,
}) ]]

require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')

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

-- Reserving terminal with ID 1 as our "project" terminal
function open_main_terminal()
  vim.cmd(":botright 1Topen")
end

-- require('neogit').setup {}

local wk = require("which-key")
wk.setup {
  -- border = "shadow"
}
wk.register({
  ["<leader>"] = {
    ["/"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
    ["*"] = { "<cmd>Telescope grep_string<cr>", "Find string under cursor" },
    [" "] = { "<cmd>Telescope help_tags<cr>", "Help list" },
    ["'"] = { "<cmd>lua open_main_terminal()<cr>", "Toggle terminal" },
    r = { 
      name= "+resume",
      l = {"<cmd>Telescope resume<cr>", "Resume Telescope"} ,
      y = {"<cmd> Telescope yank_history<cr>", "Kill ring"},
      c = {"<cmd>lua require('telescope.builtin').command_history()<cr>", "Command history"}
    },
    b = {
      name = "+buffer",
      b = { "<cmd>Telescope buffers<cr>", "Buffer list" },
      p = { "<cmd>bprevious<cr>", "Previous" },
      n = { "<cmd>bnext<cr>", "Next" },
      d = { "<cmd>Bdelete!<cr>", "Delete" },
    },
    t = {
      name = "+terminal",
      t = {"<cmd>Tnew<CR>", "New terminal"}
    },
    g = {
      name = "+git",
      s = { "<cmd>Git<cr>", "Git status" },
      d = { "<cmd>Telescope git_status<CR>", "Diffs" },
      t = { "<cmd>Telescope git_bcommits<CR>", "Time machine" },
      l = { "<cmd>vertical Flogsplit-reflog<CR>", "Log" },
      b = { "<cmd>Git blame<CR>", "Blame" },
    },
    l = { findLayouts, "Telescope workspaces" },
    p = {
      name = "+project",
      p = { "<cmd>Telescope projects<cr>", "Project list" },
      t = { "<cmd>NvimTreeFindFileToggle<cr>", "File tree" },
      f = { find_files_in_project, "Files" },
      -- ["'"] = { "<cmd>ToggleTerm<cr>", "Toggle terminal" },
    },
    f = {
      name = "+file",
      f = { "<cmd>lua find_files_full()<cr>", "Files" },
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
      t = { "<cmd>Telescope builtin<cr>", "Pickers" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" }
    },
  },
})

require("project_nvim").setup {}

--[[ require("toggleterm").setup {
  start_in_insert = false,
} ]]

require("surround").setup({mappings_style = "surround"})
require("nvim-autopairs").setup({map_cr = false})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  command = "Neoformat prettier",
})

require("nvim-tree").setup {}


