vim.dap.adapters.coreclr = {
  type = 'executable',
  command = vim.get_mason_bin("netcoredbg"),
  args = {'--interpreter=vscode'}
}

vim.dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    console = "true",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
