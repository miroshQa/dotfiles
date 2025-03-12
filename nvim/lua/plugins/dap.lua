
return {
  {
  "mfussenegger/nvim-dap",
  lazy = true,
  config = function()
    local dap = require("dap")
    vim.fn.sign_define('DapBreakpoint',          { text='', texthl='red'})
    vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='blue'})
    vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='orange'})
    vim.fn.sign_define('DapStopped',             { text='󰁕', texthl='green'})
    vim.fn.sign_define('DapLogPoint',            { text='.>', texthl='yellow', linehl='DapBreakpoint', numhl='DapBreakpoint' })
  end,
},
{
  dir = "~/repos/debugmaster.nvim/",
  config = function()
    require("debugmaster")
  end
}
}
