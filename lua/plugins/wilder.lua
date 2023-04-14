return {
  "gelguy/wilder.nvim",
  enabled = false,
  config = function(_, opts)
    -- Wilder = wildmenu completion. wildmenu = "command line" = ":" = "Ex" (and / and ?)
    local wilder = require("wilder")
    wilder.setup({modes = {':', '/', '?'}})
    wilder.set_option(
      'renderer',
      wilder.renderer_mux({
          [':'] = wilder.wildmenu_renderer({
              -- highlighter applies highlighting to the candidates
              highlighter = wilder.basic_highlighter(),
          }),
          ['/'] = wilder.wildmenu_renderer({
              highlighter = wilder.basic_highlighter(),
          }),
    }))
  end
}
