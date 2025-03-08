local ls = require("luasnip")

---Add vs code style snippet
---@param body string vs code style snippet string
---@param opts {ft: string}
vim.snippet.add = function(trig, body, opts)
  ls.add_snippets(opts.ft, {
    ls.parser.parse_snippet(
      trig,
      body
    )
  })
end

for _, path in ipairs(vim.api.nvim_get_runtime_file("lua/languages/*.lua", true)) do
  if not vim.endswith(path, "init.lua") then
    local config = loadfile(path)()
  end
end
