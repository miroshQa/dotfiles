return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "LiadOz/nvim-dap-repl-highlights",
    },
    lazy = true,
    config = function()
      local dap = require("dap")
      require('nvim-dap-repl-highlights').setup()
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'blue' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'orange' })
      vim.fn.sign_define('DapStopped', { text = '󰁕', texthl = 'green' })
      vim.fn.sign_define('DapLogPoint', { text = '.>', texthl = 'yellow', linehl = 'DapBreakpoint', numhl =
      'DapBreakpoint' })
    end,
  },
  {
    dir = "~/repos/debugmaster.nvim/",
    config = function()
      local dm = require("debugmaster")
      vim.keymap.set("n", "<leader>d", dm.mode.toggle, { nowait = true })
    end
  }
}
