-- 1. Snippets
-- 2. Lsp server
-- 3. Debugger
-- 4. Indents and other specific language options

vim.snippet.add("au", [[
vim.api.nvim_create_autocmd("${1:Event}", {
  callback = function(args)
    $0
  end
})
]], { ft = "lua" })


vim.snippet.add("cl", [[
---@class ${1:namespace}.${2:ClassName}
local $2 = {}

function $2.new()
  ---@class $1.$2
  local self = setmetatable({}, {__index = $2})
  return self
end

function $2:${3:some_method}()
  $4
end
]], { ft = "lua" })

-- http://lua-users.org/wiki/StringsTutorial (check about [= syntax)
vim.snippet.add("sa", [=[
vim.snippet.add("${1:trigger}", [[
${2:snippet}
]], {ft = "${3:filetype}"})
]=], { ft = "lua" })


vim.snippet.add("k", [[
vim.keymap.set("${1:mode}", "${2:key}", ${3:action})
]], { ft = "lua" })


vim.dap.adapters.nlua = {
  type = 'server',
  host = "127.0.0.1",
  port = 8086,
}

vim.dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    init = (function()
      local id = "nvimdebug"
      local buf = -1
      local dap = require("dap")
      dap.listeners.after.event_exited[id] = function()
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true, unload = true })
        end
      end
      dap.listeners.after.event_terminated[id] = dap.listeners.after.event_exited[id]
      return function()
        vim.cmd([[split | terminal nvim -c 'lua require("osv").launch({ port = 8086 })']])
        buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_win_close(0, true)
        dap.listeners.after.initialize[id] = function()
          require("debugmaster.state").terminal:attach_terminal_to_current_session(buf)
          dap.listeners.after.initialize[id] = nil
        end
      end
    end)()
  }
}
