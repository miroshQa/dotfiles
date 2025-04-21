return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    config = vim.schedule_wrap(function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true,
        }
      })
    end),
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    config = vim.schedule_wrap(function()
      local swap = require("nvim-treesitter.textobjects.swap")
      vim.keymap.set("n", "{", function() swap.swap_previous("@parameter.inner") end)
      vim.keymap.set("n", "}", function() swap.swap_next("@parameter.inner") end)
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
        },
      }
    end)
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "js", "html", "javascriptreact", "ts", "jsx", "tsx" },
    opts = {},
  },
  {
    'Wansmer/treesj',
    keys = {
      { "gs", function() require('treesj').toggle() end,                                 mode = "n" },
      { "gS", function() require('treesj').toggle({ split = { recursive = true } }) end, mode = "n" }
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('treesj').setup({
        max_join_length = 1000000,
        use_default_keymaps = false,
      })
    end,
  }
}
