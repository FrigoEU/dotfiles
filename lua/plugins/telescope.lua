
-- layouts/sessions/workspaces custom solution
function findLayouts(opts)
  local opts = opts or require("telescope.themes").get_dropdown({})

  local prompt = {
    prompt_title = 'Workspaces',
    finder = require("telescope.finders").new_table({
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
            name = "4. dotfiles",
            cwd = "~/dotfiles",
            main = "init.lua"
          },
          {
            name = "9. alacritty",
            command = string.format("silent !jumpapp -e neovide")
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
    sorter = require("telescope.config").values.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      require("telescope.actions").select_default:replace(function()
          require("telescope.actions").close(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          -- print(vim.inspect(selection))
          local jumpcmd = selection.value.command or string.format(
            "silent !cd %s && NEOVIDE_TITLE='%s' jumpapp -t '%s' neovide %s", 
            selection.value.cwd,
            selection.value.name, 
            selection.value.name,
            selection.value.main
                                                                  )
          -- print(jumpcmd)
          vim.cmd(jumpcmd)
      end)
      return true
    end,
  }

  require("telescope.pickers").new(opts, prompt):find()
end

function find_files_in_project()
  require('telescope.builtin').git_files( {show_untracked = true})
end

return {
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    opts = {
      manual_mode = false
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
      { "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" },
      { "<leader> ", "<cmd>Telescope help_tags<cr>", desc = "Help list" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>rl", "<cmd>Telescope resume<cr>", desc = "Resume telescope" },
      { "<leader>ry", "<cmd>Telescope yank_history<cr>", desc = "Kill ring" },
      -- find
      { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Swoop" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "Filebrowser" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>ft", "<cmd>Telescope colorscheme<CR>", desc = "Theme" },
      -- git
      { "<leader>gT", "<cmd>Telescope git_bcommits<CR>", desc = "status" },
      -- projects
      { "<leader>pp", "<cmd>Telescope projects<CR>", desc = "Find project" },
      { "<leader>pf", find_files_in_project, desc = "Find file in project" },
      -- help
      { "<leader>hh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>hm", "<cmd>Telescope man_pages<CR>", desc = "Man pages" },
      { "<leader>ht", "<cmd>Telescope builtin<CR>", desc = "Pickers" },
      { "<leader>hk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      -- layouts
      { "<leader>l", findLayouts, desc = "Layouts" },
    },
    config = function()
      require("telescope").setup(
        {
          defaults = {
            file_ignore_patterns = { 
              "/.git" ,
              ".vscode"
            },
            mappings = {
              i = {
                ["<esc>"] = require("telescope.actions").close,
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
                ["<C-s>"] = require("telescope.actions").select_horizontal,
                ["<C-v>"] = require("telescope.actions").select_vertical,
                ["<C-h>"] = require("telescope.actions").which_key, -- help
              },
              n = {
              },
            },
          },
          pickers = {
            git_bcommits = {
              mappings = {
                i = {
                  ["<cr>"] = function(prompt_bufnr)
                    require("telescope.actions").close(prompt_bufnr)
                    local sha = action_state.get_selected_entry().value
                    vim.cmd("DiffviewOpen " .. sha )
                  end,
                }
              }
            },
          },
          extensions = {
            fzf = {},
            file_browser = {
              theme = "ivy",
              -- disables netrw and use telescope-file-browser in its place
              hijack_netrw = true,
              mappings = {
                ["i"] = {
                  -- ["<esc>"] = function () vim.cmd("stopinsert") end,
                  ["<C-h>"] = require("telescope.actions").which_key, -- help
                },
                --[[ ["n"] = {
                  ["<C-h>"] = actions.which_key, -- help
                  }, ]]
              },
            },
          }
        }
                                )

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('projects')
      require('telescope').load_extension('file_browser')
      require('telescope').load_extension('yank_history')
    end,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },

      {
        "ahmedkhalf/project.nvim",
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
      },
      {
        "gbprod/yanky.nvim",
      }
    }
  },
}
