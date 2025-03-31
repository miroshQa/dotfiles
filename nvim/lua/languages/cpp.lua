vim.dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = vim.dap.utils.pick_file,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    runInTerminal = true,
  },
  {
    name = "Launch file (codelddb)",
    type = "codelldb",
    request = "launch",
    program = vim.dap.utils.pick_file,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },

}

vim.dap.configurations.c = vim.dap.configurations.cpp
