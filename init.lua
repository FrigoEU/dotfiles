vim.g.mapleader = ' '

vim.api.nvim_set_option("clipboard", "unnamed") -- This + xclip is necessary for flawless copy-paste
vim.opt.guifont = { "PragmataPro Liga", ":h12" } -- Somehow, PragmataPro Mono didn't work...

-- advised by nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_animation_length=0.0
vim.g.neovide_cursor_trail_length=0.0 
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

-- Indentation
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.timeoutlen = 200 -- How fast which-key will show up

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", opts)
