return {
  "sbdchd/neoformat",
  config = function()
    vim.api.nvim_create_autocmd(
      "BufWritePre",
      {
        pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        command = "Neoformat prettier",
    })
  end
}
