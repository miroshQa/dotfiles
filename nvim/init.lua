require("core.options")
require("core.autocommands")
require("core.pluginmanager")
require("core.keymaps")
require("languages")
require("core.wezterm")

local _ = (function()
  local default = "gruvboxbaby"
  local path = vim.fs.joinpath(vim.fn.stdpath("cache"), "/colorscheme")
  local file = io.open(path, "r")
  local colorscheme = file and file:read("*L") or default
  vim.cmd("colorscheme " ..  colorscheme)
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(args)
      io.open(path, "w+"):write(args.match)
    end
  })
end)()
