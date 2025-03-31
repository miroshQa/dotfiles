return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = {},
    terminal = {},
  },
  config = function ()
    vim.keymap.set({"n", "t"}, "<C-/>", function() Snacks.terminal.toggle(vim.o.shell) end)
  end
}
