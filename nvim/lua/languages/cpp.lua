vim.dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.get_mason_bin('OpenDebugAD7'),
}

vim.dap.configurations.cpp = {
  {
    name = 'Launch file (lldb-dap)',
    type = 'lldb',
    request = 'launch',
    program = vim.dap.utils.pick_file,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    runInTerminal = true,
  },
  {
    name = "Launch file (cpptools)",
    type = "cppdbg",
    request = "launch",
    program = "${command:pickFile}",
    cwd = '${workspaceFolder}',
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "Attach to process",
    type = 'lldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
    request = 'attach',
    pid = vim.dap.utils.pick_process,
    args = {},
  },
}

vim.dap.configurations.c = vim.dap.configurations.cpp
