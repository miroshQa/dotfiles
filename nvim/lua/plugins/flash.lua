return {
  "folke/flash.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    modes = {
      char = {
        enabled = false,
      }
    },
    jump = {
      inclusive = false,
    }
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
}
