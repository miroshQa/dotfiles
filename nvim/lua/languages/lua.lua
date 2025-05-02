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
    -- we can't capture even integers for the function we dump
    -- hence using this json trick
    ---@param vars init-vars
    local init = function(vars)
      vim.opt.rtp:prepend(vars.dap_path)
      vim.opt.rtp:prepend(vars.osv_path)
      require('osv').launch({ blocking = true, port = vars.port })
    end
    ---@class init-vars
    local vars = {
      port = math.random(49152, 65535),
      osv_path = assert(vim.go.rtp:match("[^,]+one%-small%-step%-for%-vimkind"), "abort: one-small-step-for-vimkind not installed!!!"),
      dap_path = assert(vim.go.rtp:match("[^,]+nvim%-dap"), "abort: nvim-dap not installed!!!"),
    }
    -- https://gist.github.com/veechs/bc40f1f39b30cb1251825f031cd6d978
    local cmd = string.format(
      [[split | terminal nvim --cmd "lua loadstring( vim.base64.decode('%s') )( vim.json.decode(vim.base64.decode('%s')) )"]],
      vim.base64.encode(string.dump(init)), vim.base64.encode(vim.json.encode(vars))
    )
    vim.cmd(cmd)
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
      port = vars.port,
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
  vim.keymap.set("v", "r", ":'<,'>lua<CR>", { buffer = 0, silent = true })
end
