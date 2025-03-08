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

---Allows you to pick any file in your current directory and return it as a string
---@async
---@return string
vim.pick_file = function()
  local co = coroutine.running()
  require("fzf-lua").files({
    cmd = "find .",
    git_icons = false,
    file_icons = false,
    actions = {
      default = function(selected)
        coroutine.resume(co, selected[1])
      end
    }
  })
  return coroutine.yield()
end

for _, path in ipairs(vim.api.nvim_get_runtime_file("lua/languages/*.lua", true)) do
  if not vim.endswith(path, "init.lua") then
    local config = loadfile(path)()
  end
end
