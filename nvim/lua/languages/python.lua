-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
vim.dap.adapters.python = {
  type = 'executable',
  command = vim.get_mason_bin("debugpy-adapter"),
  options = {
    source_filetype = 'python',
  },
}

vim.dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    console = "integratedTerminal",
  },
}
