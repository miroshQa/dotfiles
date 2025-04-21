return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>",                                                                    "n",         desc = "Reset hunk" },
      { "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>",                                                                  mode = "n",  desc = "Reset Buffer" },
      { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>",                                                               mode = "n",  desc = "Undo stage hunk" },
      { "<leader>hU", "<cmd>Gitsigns reset_buffer_index<CR>",                                                            mode = "n",  desc = "Undo buffer staging" },
      { "H",          "<cmd>Gitsigns preview_hunk<CR>",                                                                  mode = "n",  desc = "Preview hunk" },
      { "L",          function() require("gitsigns").blame_line({ full = true }) end,                                    mode = "n",  desc = "Line blame" },
      { "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>",                                                                    mode = "n",  desc = "Stage hunk" },
      { "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>",                                                                  mode = "n",  desc = "Stage Buffer" },
      { "[h",         function() require("gitsigns").nav_hunk("prev", { preview = true, navigation_message = false }) end, mode = "n", desc = "Prev hunk" },
      { "]h",         function() require("gitsigns").nav_hunk("next", { preview = true, navigation_message = false }) end, mode = "n", desc = "Next hunk" },
    },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      { "<leader>v", "<cmd>Neogit<CR>", mode = "n", desc = "Open vsc (git)" }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true
  }
}
