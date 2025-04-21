vim.dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.get_mason_bin("OpenDebugAD7"),
}

vim.dap.configurations.cpp = {
  {
    name = 'Launch file (lldb-dap)',
    type = 'lldb',
    request = 'launch',
    program = "${command:pickFile}",
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    runInTerminal = true,
    initCommands = {
      "process handle SIGWINCH -p true -s false -n false"
    }
  },
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "Attach to process (lldb-dap)",
    type = 'lldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
    request = 'attach',
    pid = vim.dap.utils.pick_process,
    args = {},
  },
  {
    name = "rr",
    type = "cppdbg",
    request = "launch",
    program = vim.dap.utils.pick_file,
    args = {},
    miDebuggerServerAddress = "127.0.0.1:50505",
    stopAtEntry = true,
    cwd = vim.fn.getcwd,
    environment = {},
    externalConsole = true,
    MIMode = "gdb",
    setupCommands = {
      {
        description = "Setup to resolve symbols",
        text = "set sysroot /",
        ignoreFailures = false
      },
      {
        description = "Enable pretty-printing for gdb",
        text = "-enable-pretty-printing",
        ignoreFailures = false
      }
    },
  },
}

vim.dap.configurations.c = vim.dap.configurations.cpp
-- vim.dap.configurations.rust = vim.dap.configurations.cpp
