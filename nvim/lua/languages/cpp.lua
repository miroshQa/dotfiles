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
}

vim.dap.configurations.c = vim.dap.configurations.cpp
