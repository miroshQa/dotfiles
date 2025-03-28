return {
  "neovim/nvim-lspconfig",
  event = {"BufReadPost", "BufNewFile"},
  cmd = {"Mason"},
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "ibhagwan/fzf-lua",
  },
  keys = {
    { "cd",         vim.lsp.buf.rename,                  mode = "n"},
    { "<C-s>",      function() vim.lsp.buf.signature_help({border = "rounded"}) end,      mode = "i"},
    { '[d',         function() vim.diagnostic.jump({severity = "ERROR", count = -1, float = true}) end,            mode = 'n'},
    { ']d',         function() vim.diagnostic.jump({severity = "ERROR", count = 1, float = true}) end,            mode = 'n'},
    { "M",          vim.diagnostic.open_float,           mode = "n"},
    { "K",          function() vim.lsp.buf.hover({border = "rounded"}) end},
    { "<leader>lr", "<cmd>LspRestart<CR>",               mode = "n"},
    { "<leader>lf", vim.lsp.buf.format,                  mode = "n"},
  },
  config = function()
    local servers = {}

    require("mason").setup()
    require("mason-lspconfig").setup()
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        local server = servers[server_name] or {}
        require("lspconfig")[server_name].setup(server)
      end,
    })

    -- still can install and setup servers manually without mason
    -- (just for future reference, because it useful someitmes, for example
    -- rust analyzer ships with rustup so we don't want to install it with mason yet)
    require("lspconfig")["rust_analyzer"].setup({})
  end,
}
