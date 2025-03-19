return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local dmode = require("debugmaster.debug.mode")
    require("lualine").setup({
      options = {
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              if dmode.is_active() == true then
                return "DEBUG"
              end
              return str
            end,

            color = function(tb)
              if dmode.is_active() then
                return {
                  bg = "#2da84f",
                }
              end
              return tb
            end,
          },
        },
        lualine_b = {
        },
        lualine_c = {
          { "filename",   path = 1 },
          { "branch" },
          { "diff" },
          { "diagnostics" },
        },
        lualine_x = {
          { "filetype" },
        },
        lualine_y = {
          { "progress" },
          { "location" }
        },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
