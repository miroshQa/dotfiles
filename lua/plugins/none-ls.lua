return {
  "nvimtools/none-ls.nvim",
    event = "VeryLazy",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })

    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {desc = "LSP! Format my code!"})
  end,
}
