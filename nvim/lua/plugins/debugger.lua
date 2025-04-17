return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jbyuki/one-small-step-for-vimkind",
    },
    lazy = true,
    config = function()
      local dap = require("dap")
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'blue' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'orange' })
      vim.fn.sign_define('DapStopped', { text = '󰁕', texthl = 'green' })
    end,
  },
  {
    dir = "~/repos/debugmaster.nvim",
    config = function()
      local dm = require("debugmaster")
      vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, {
        nowait = true,
        desc = "Debug mode toggle"
      })
    end
  }
}
