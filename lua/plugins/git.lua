return {
  {
    "rbong/vim-flog",
    dependencies = {
      { 'tpope/vim-fugitive' }
    },
    config = function ()
      vim.api.nvim_create_autocmd(
        "Filetype",
        {
          pattern = "floggraph",
          callback = function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set("n", "q", "<cmd>tabclose<cr>", {buffer = bufnr,desc= 'Close'})
            vim.keymap.set("n", "d", "<cmd>exec flog#Format('DiffviewOpen %h^!')<CR>", {buffer = bufnr,desc= 'Close'})
          end,
      })
    end
  },
  {
    "TimUntersberger/neogit",
    keys = {
      { "<leader>gs", "<cmd>Neogit<CR>" , desc = "Git status" },
    },
    dependencies = {
      {"nvim-lua/plenary.nvim"},
      {"sindrets/diffview.nvim"}
    },
    config = function(_, opts)
      -- Doesn't work!
      -- Also: use different keybinding! tab is actually super useful to go to the next commit
      vim.api.nvim_create_autocmd(
        "FilterWritePre",
        {
          pattern = "*",
          callback = function()
            if (vim.o.diff) then
              local bufnr = vim.api.nvim_get_current_buf()
              vim.keymap.set("n", "<tab>", "[c", {buffer = bufnr, remap = true, desc= 'Next hunk'})
              vim.keymap.set("n", "<s-tab>", "]c", {buffer = bufnr, remap = true, desc= 'Previous hunk'})
            end
          end,
      })

      -- Show Flog immediately
      vim.api.nvim_create_autocmd(
        "Filetype",
        {
          pattern = "NeogitStatus",
          callback = function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set("n", "q", "<cmd>tabclose<cr>", {buffer = bufnr,desc= 'Close'})

            vim.cmd("vert Flogsplit -all")
            vim.cmd("1wincmd w")
          end,
      })

      require("neogit").setup(opts)
    end,
    opts = {
      disable_signs = false,
      disable_hint = true,
      disable_context_highlighting = true,
      disable_commit_confirmation = true,
      -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
      -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
      auto_refresh = true,
      -- Value used for `--sort` option for `git branch` command
      -- By default, branches will be sorted by commit date descending
      -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
      -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
      sort_branches = "-committerdate",
      disable_builtin_notifications = false,
      use_magit_keybindings = false,
      -- Change the default way of opening neogit
      kind = "tab",
      -- The time after which an output console is shown for slow running commands
      console_timeout = 2000,
      -- Automatically show console if a command takes more than console_timeout milliseconds
      auto_show_console = true,
      -- Persist the values of switches/options within and across sessions
      remember_settings = true,
      -- Scope persisted settings on a per-project basis
      use_per_project_settings = true,
      -- Array-like table of settings to never persist. Uses format "Filetype--cli-value"
      --   ie: `{ "NeogitCommitPopup--author", "NeogitCommitPopup--no-verify" }`
      ignored_settings = {},
      -- Change the default way of opening the commit popup
      commit_popup = {
        kind = "split",
      },
      -- Change the default way of opening the preview buffer
      preview_buffer = {
        kind = "split",
      },
      -- Change the default way of opening popups
      popup = {
        kind = "split",
      },
      -- customize displayed signs
      signs = {
        -- { CLOSED, OPENED }
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
      },
      integrations = {
        -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
        -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
        --
        -- Requires you to have `sindrets/diffview.nvim` installed.
        -- use {
        --   'TimUntersberger/neogit',
        --   requires = {
        --     'nvim-lua/plenary.nvim',
        --     'sindrets/diffview.nvim'
        --   }
        -- }
        --
        diffview = true
      },
      -- Setting any section to `false` will make the section not render at all
      sections = {
        untracked = {
          folded = false
        },
        unstaged = {
          folded = false
        },
        staged = {
          folded = false
        },
        stashes = {
          folded = true
        },
        unpulled = {
          folded = true
        },
        unmerged = {
          folded = false
        },
        recent = false,
      },
      -- override/add mappings
      mappings = {
        -- modify status buffer mappings
        status = {
          -- Adds a mapping with "B" as key that does the "BranchPopup" command
          -- ["B"] = "BranchPopup",
           ["q"] = "", -- overwriting in autocmd
        }
      }
    }
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gt", "<cmd>DiffviewFileHistory %<CR>" , desc = "File history" },
    },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
          keymaps = {
            view = {
              -- The `view` bindings are active in the diff buffers, only when the current
              -- tabpage is a Diffview.
              --[[ { "n", "<tab>",       actions.select_next_entry,              { desc = "Open the diff for the next file" } },
                { "n", "<s-tab>",     actions.select_prev_entry,              { desc = "Open the diff for the previous file" } }, ]]
              { "n", "gf",          actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
              { "n", "<C-w><C-f>",  actions.goto_file_split,                { desc = "Open the file in a new split" } },
              { "n", "<C-w>gf",     actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
              { "n", "<leader>e",   actions.focus_files,                    { desc = "Bring focus to the file panel" } },
              { "n", "<leader>b",   actions.toggle_files,                   { desc = "Toggle the file panel." } },
              { "n", "g<C-x>",      actions.cycle_layout,                   { desc = "Cycle through available layouts." } },
              { "n", "[x",          actions.prev_conflict,                  { desc = "In the merge-tool: jump to the previous conflict" } },
              { "n", "]x",          actions.next_conflict,                  { desc = "In the merge-tool: jump to the next conflict" } },
              { "n", "<leader>co",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
              { "n", "<leader>ct",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
              { "n", "<leader>cb",  actions.conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
              { "n", "<leader>ca",  actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
              { "n", "dx",          actions.conflict_choose("none"),        { desc = "Delete the conflict region" } },
              { "n", "<leader>cO",  actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
              { "n", "<leader>cT",  actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
              { "n", "<leader>cB",  actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
              { "n", "<leader>cA",  actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
              { "n", "dX",          actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
            },
            file_panel = {
              { "n", "j",              actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
              { "n", "<down>",         actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
              { "n", "k",              actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
              { "n", "<up>",           actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
              { "n", "<cr>",           actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
              { "n", "o",              actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
              { "n", "l",              actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
              { "n", "<2-LeftMouse>",  actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
              { "n", "-",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
              { "n", "S",              actions.stage_all,                      { desc = "Stage all entries" } },
              { "n", "U",              actions.unstage_all,                    { desc = "Unstage all entries" } },
              { "n", "X",              actions.restore_entry,                  { desc = "Restore entry to the state on the left side" } },
              { "n", "L",              actions.open_commit_log,                { desc = "Open the commit log panel" } },
              { "n", "zo",             actions.open_fold,                      { desc = "Expand fold" } },
              { "n", "h",              actions.close_fold,                     { desc = "Collapse fold" } },
              { "n", "zc",             actions.close_fold,                     { desc = "Collapse fold" } },
              { "n", "za",             actions.toggle_fold,                    { desc = "Toggle fold" } },
              { "n", "zR",             actions.open_all_folds,                 { desc = "Expand all folds" } },
              { "n", "zM",             actions.close_all_folds,                { desc = "Collapse all folds" } },
              { "n", "<c-b>",          actions.scroll_view(-0.25),             { desc = "Scroll the view up" } },
              { "n", "<c-f>",          actions.scroll_view(0.25),              { desc = "Scroll the view down" } },
              --[[ { "n", "<tab>",          actions.select_next_entry,              { desc = "Open the diff for the next file" } },
                { "n", "<s-tab>",        actions.select_prev_entry,              { desc = "Open the diff for the previous file" } }, ]]
              { "n", "gf",             actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
              { "n", "<C-w><C-f>",     actions.goto_file_split,                { desc = "Open the file in a new split" } },
              { "n", "<C-w>gf",        actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
              { "n", "i",              actions.listing_style,                  { desc = "Toggle between 'list' and 'tree' views" } },
              { "n", "f",              actions.toggle_flatten_dirs,            { desc = "Flatten empty subdirectories in tree listing style" } },
              { "n", "R",              actions.refresh_files,                  { desc = "Update stats and entries in the file list" } },
              { "n", "<leader>e",      actions.focus_files,                    { desc = "Bring focus to the file panel" } },
              { "n", "<leader>b",      actions.toggle_files,                   { desc = "Toggle the file panel" } },
              { "n", "g<C-x>",         actions.cycle_layout,                   { desc = "Cycle available layouts" } },
              { "n", "[x",             actions.prev_conflict,                  { desc = "Go to the previous conflict" } },
              { "n", "]x",             actions.next_conflict,                  { desc = "Go to the next conflict" } },
              { "n", "g?",             actions.help("file_panel"),             { desc = "Open the help panel" } },
              { "n", "<leader>cO",     actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
              { "n", "<leader>cT",     actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
              { "n", "<leader>cB",     actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
              { "n", "<leader>cA",     actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
              { "n", "dX",             actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
              -- CUSTOM
              { "n", "?",             actions.help("file_panel"),             { desc = "Open the help panel" } },
              { "n", "q",     "<Cmd>tabclose<CR>",                 { desc = "Close the panel" } },
            },
            file_history_panel = {
              { "n", "g!",            actions.options,                     { desc = "Open the option panel" } },
              { "n", "<C-A-d>",       actions.open_in_diffview,            { desc = "Open the entry under the cursor in a diffview" } },
              { "n", "y",             actions.copy_hash,                   { desc = "Copy the commit hash of the entry under the cursor" } },
              { "n", "L",             actions.open_commit_log,             { desc = "Show commit details" } },
              { "n", "zR",            actions.open_all_folds,              { desc = "Expand all folds" } },
              { "n", "zM",            actions.close_all_folds,             { desc = "Collapse all folds" } },
              { "n", "j",             actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
              { "n", "<down>",        actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
              { "n", "k",             actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry." } },
              { "n", "<up>",          actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry." } },
              { "n", "<cr>",          actions.select_entry,                { desc = "Open the diff for the selected entry." } },
              { "n", "o",             actions.select_entry,                { desc = "Open the diff for the selected entry." } },
              { "n", "<2-LeftMouse>", actions.select_entry,                { desc = "Open the diff for the selected entry." } },
              { "n", "<c-b>",         actions.scroll_view(-0.25),          { desc = "Scroll the view up" } },
              { "n", "<c-f>",         actions.scroll_view(0.25),           { desc = "Scroll the view down" } },
              { "n", "<tab>",         actions.select_next_entry,           { desc = "Open the diff for the next file" } },
              { "n", "<s-tab>",       actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
              { "n", "gf",            actions.goto_file_edit,              { desc = "Open the file in the previous tabpage" } },
              { "n", "<C-w><C-f>",    actions.goto_file_split,             { desc = "Open the file in a new split" } },
              { "n", "<C-w>gf",       actions.goto_file_tab,               { desc = "Open the file in a new tabpage" } },
              { "n", "<leader>e",     actions.focus_files,                 { desc = "Bring focus to the file panel" } },
              { "n", "<leader>b",     actions.toggle_files,                { desc = "Toggle the file panel" } },
              { "n", "g<C-x>",        actions.cycle_layout,                { desc = "Cycle available layouts" } },
              { "n", "g?",            actions.help("file_history_panel"),  { desc = "Open the help panel" } },
              
              -- CUSTOM
              { "n", "?",            actions.help("file_history_panel"),  { desc = "Open the help panel" } },
              { "n", "q",     "<Cmd>tabclose<CR>",                 { desc = "Close the panel" } },
            }
          }
                               })
    end
  }
}
