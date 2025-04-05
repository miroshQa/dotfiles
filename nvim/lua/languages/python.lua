
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
vim.dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = vim.get_mason_bin("debugpy-adapter"),
      options = {
        source_filetype = 'python',
      },
    })
  end
end

vim.dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    program = "${file}", -- This configuration will launch the current file if used.
    console = "integratedTerminal"
  },
}
