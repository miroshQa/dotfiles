return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  version = "3.x.x",
  config = function()
    require("which-key").setup {
      preset = "helix",
      notify = false,
      triggers = { "<auto>", mode = "nioc" },
      sort = { "desc" },
    }

    require("which-key").add {
      -- <leader>s is a prefix for uncommon pickers, unlike live_grep and find_files
      { "<leader>s", group = "Search" },
      { "<leader>h", group = "Hunks", icon = { icon = "", color = "red" } },
      { "<leader>l", group = "Lsp", icon = { icon = "", color = "blue" } },
    }
  end,
}
