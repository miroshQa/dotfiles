return {
  { "williamboman/mason.nvim", opts = { ui = { backdrop = 100, } } },
  { "williamboman/mason-lspconfig.nvim", },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "Lsp restart" })
      vim.keymap.set("n", "<leader>lm", "<cmd>Mason<CR>", { desc = "Mason" })
      require("mason").setup()
      require("mason-lspconfig").setup()
      -- still can install and setup servers manually without mason
      -- rust analyzer ships with rustup so we don't want to install it with mason)
      -- just install it manually and then enable it via vim.lsp
      vim.lsp.enable("rust_analyzer")
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
}
