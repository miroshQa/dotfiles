return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup {}
    vim.keymap.set("n", "<leader>r", "<cmd>GrugFar<CR>", { desc = "Start search and replace" })
  end
}
