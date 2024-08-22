vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "Search in current working directory" })
vim.keymap.set("n", "<leader>'", "<cmd>Telescope resume<cr>", { desc = 'Search resume' })
vim.keymap.set("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = 'Search command history' })
vim.keymap.set("n", "<leader>sp", "<cmd>Telescope builtin<cr>", { desc = "Search telescope picker" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope git_branches<cr>", { desc = "Search branches" })
vim.keymap.set("n", "<leader>se", function () require("telescope.builtin").symbols({sources = {"emoji", "gitmoji"}}) end, { desc = "Search emoji" })
vim.keymap.set("n", "<leader>sn", "<cmd>Telescope notify<cr>", { desc = "Search notification" })
vim.keymap.set("n", "<leader>.", "<cmd>Telescope oldfiles<cr>", { desc = 'Search old files ("." for repeat)' })
vim.keymap.set("n", "<leader>k", "<cmd>Telescope help_tags<cr>", { desc = 'Search help tags' })
vim.keymap.set("n", "<leader>c", "<cmd>Telescope git_bcommits<cr>", { desc = 'Search commits for current buffer' })
vim.keymap.set("n", "<leader>C", "<cmd>Telescope git_commits<cr>", { desc = 'Search commits' })
vim.keymap.set("n", "<leader>g", function() require('telescope.builtin').git_status({path_display = {'tail'}}) end,
  { desc = 'Search edited / added files' })
vim.keymap.set("n", "<leader><leader>", function() require('telescope.builtin').buffers{path_display = {'tail'}, sort_mru = true, ignore_current_buffer = true} end, { desc = "Search open buffers" })

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
  },
  config = function()
    require("telescope").setup(
      {
        defaults = {
          file_ignore_patterns = { "%.png", "%.pdf", },

          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
              ["<C-s>"] = require("telescope.actions").select_horizontal,
              ['<c-x>'] = require('telescope.actions').delete_buffer,
              ["<c-f>"] = require("telescope.actions").complete_tag,
            },
          },

        },

        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },

        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

    local is_success, _ = pcall(require('telescope').load_extension, 'fzf')
    if not is_success then
      print("Telescope native is not installed")
    end
    require("telescope").load_extension("ui-select")
  end,
}
