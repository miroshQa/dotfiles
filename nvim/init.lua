vim.g._ts_force_sync_parsing = true
vim.cmd("colorscheme gruvboxbaby")
require("vim._extui").enable {}
require("core.options")
require("core.autocommands")
require("core.keymaps")

local files = vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true)
for _, path in ipairs(files) do
  loadfile(path)()
end
require("languages")
