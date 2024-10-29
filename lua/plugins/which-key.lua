return  {
  'folke/which-key.nvim',
  event = "VeryLazy",
  version = "3.x.x",
  config = function()
    require('which-key').setup({
      preset = "helix",
      notify = false,
      triggers = { "<auto>", mode = "nioc" },
      sort = {"desc"},
    })

    require('which-key').add {
      { "<leader>d", group = "Debug" },
      { "<leader>s", group = "Search"},
      { "<leader>h", group = "Hunks", icon = {icon = "", color = "red"} }, -- NvimWebDeviconsHiTest
      { "<leader>l", group = "Lsp", icon = {icon = "", color = "blue"} },
      { "<leader>u", group = "Ui/Update", icon = {icon = "", color = "blue"}},
    }
  end,
}
