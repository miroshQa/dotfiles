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


vim.dap.adapters.nlua = (function()
  local id = "nvimdebug"
  local buf = -1
  local dap = require("dap")
  dap.listeners.after.disconnect[id] = function()
    pcall(vim.api.nvim_buf_delete, buf, { force = true, unload = true })
  end
  return function(callback)
    local port = math.random(49152, 65535)
    local cmd = table.concat({
      -- You can remove the two lines below if you are not planning to debug your neovim config on startup.
      -- (also change --cmd flag to -c in this case)
      -- You may also want to adjust the file paths if you're using a package manager other than lazy.nvim.
      "vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/lazy/nvim-dap')",
      "vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/lazy/one-small-step-for-vimkind')",
      string.format("require('osv').launch({port = %d, blocking = true})", port),
    }, "; ")
    vim.cmd(string.format([[split | terminal nvim --cmd "lua %s"]], cmd))
    buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_win_close(0, true)
    dap.listeners.after.initialize[id] = function()
      local state = require("debugmaster.state")
      state.terminal:attach_terminal_to_current_session(buf)
      state.sidepanel:set_active(state.terminal)
      dap.listeners.after.initialize[id] = nil
    end
    callback({
      type = 'server',
      host = "127.0.0.1",
      port = port,
    })
  end
end)()

vim.dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Debug neovim (lua)",
  }
}

vim.ftplugin.lua = function()
  vim.keymap.set("v", "r", ":'<,'>lua<CR>", {buffer = 0, silent = true})
end
