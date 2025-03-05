vim.keymap.set('n',  '<Esc>', "<ESC>:noh<CR>:lua require('notify').dismiss()<CR>", {silent = true})
-- The main purpose of this plugin for me is to replace default nvim messages when you have to press <CR> to continue editing
-- And by the way command line pop up completion menu with borders is also very nice
-- It also adds search labels for / and ?, *, #, n N, , so I can delete hlslens
-- That is such a amazing plugin!!! I should't never delete it!

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
      -- Hide written messages
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
    })
  end,
}
