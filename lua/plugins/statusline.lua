local function zoomwintab_status()
  return vim.t.zoomwintab and ' ' or ''
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 
                   -- 'diff', 
      },
      lualine_c = {
        zoomwintab_status,
        'filename',
      },
      lualine_x = {
        -- 'encoding', 
        -- 'fileformat', 
        'filetype'},
      lualine_y = {
        -- 'progress'
        -- 'searchcount',
        'diagnostics'
      },
      lualine_z = {'location'}
    },
  }
}
