-- https://github.com/mfussenegger/nvim-dap/issues/786
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("PromptBufferCtrlwFix", {}),
  pattern = {"dap-repl"},
  callback = function()
    vim.keymap.set("i", "<C-w>", "<C-S-w>", {buffer = true})
  end
})

return {
  "mfussenegger/nvim-dap",
  lazy = true,
  keys = {

    {"<C-n>", "<cmd>DapStepOver<CR>", "Debug: step over (next line)"},
    {"<C-p>", "<cmd>DapStepOut<CR>", "Debug: step out (prev func call)"},
    {"<C-g>", "<cmd>DapStepInto<CR>", "Debug: step into (Go deeper)"},
    {"<C-c>", "<cmd>DapContinue<CR>", "Debug: continue"},
    {"<C-s>", function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes) end, "Scopes"},
    {"U", function() pcall(require('dap.ui.widgets').hover) end},

    {"<leader>b", "<cmd>DapToggleBreakpoint<CR>", desc = "Debug: toggle breakpoint"},
    {"<leader>db", "<cmd>FzfLua dap_breakpoints<CR>", desc = "Debug: search breakpoints"},
    {"<leader>df", function() require('dap').focus_frame() end, desc = "Debug: focus current frame"},
    {"<leader>dr", function() require('dap').run_to_cursor() end, desc = "Debug: run to cursor"},
    {"<leader>dt", "<cmd>DapTerminate<CR>", "Termniate"},
  },
  config = function()
    local dap = require("dap")
    dap.defaults.fallback.terminal_win_cmd = '50vsplit new'

    vim.fn.sign_define('DapBreakpoint',          { text='', texthl='red'})
    vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='blue'})
    vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='orange'})
    vim.fn.sign_define('DapStopped',             { text='󰁕', texthl='green'})
    vim.fn.sign_define('DapLogPoint',            { text='.>', texthl='yellow', linehl='DapBreakpoint', numhl='DapBreakpoint' })

    vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'
  end,
}
