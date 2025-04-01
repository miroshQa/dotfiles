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
    { "<leader>lr", "<cmd>LspRestart<CR>",               mode = "n"},
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
