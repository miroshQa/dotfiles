-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/home/linuxbrew/.linuxbrew/bin/lldb-dap', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = vim.pick_file,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    initCommands = function()
      -- Find out where to look for the pretty printer Python module.
      local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
      assert(
        vim.v.shell_error == 0,
        'failed to get rust sysroot using `rustc --print sysroot`: '
        .. rustc_sysroot
      )
      local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
      local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
      return {
        ([[!command script import '%s']]):format(script_file),
        ([[command source '%s']]):format(commands_file),
      }
    end,
  },
}
