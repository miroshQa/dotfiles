return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>f", function() require('fzf-lua').files() end,                      desc = "Find files" },
    { "<leader>'", function() require("fzf-lua").resume() end,                     desc = "Resume last find" },
    { "<leader>k", function() require("fzf-lua").help_tags() end,                  desc = "Find help tags" },
    { "<leader>.", function() require("fzf-lua").oldfiles() end,                   desc = "Find old files" },
    { "<leader>/", function() require("fzf-lua").live_grep() end,                  desc = "Find string (livegrep)" },
    { "<leader>g", function() require("fzf-lua").git_status() end,                 desc = "Find changed" },
    -- { "<leader>b", function() require("fzf-lua").buffers() end },
    { "<leader>z", function() require("fzf-lua").zoxide() end,                     desc = "Find zoxide" },
    { "<leader>c", function() require("fzf-lua").git_bcommits() end,               desc = "Find buffer commits" },
    { "<leader>sb", function() require("fzf-lua").git_branches() end,               desc = "Find git branches" },
    { "<leader>C", function() require("fzf-lua").git_commits() end,                desc = "Find commits" },

    -- LSP
    { "<leader>j", function() require("fzf-lua").lsp_document_symbols() end, desc = "Find lsp symbols (jump)" },
    { "<leader>J", function() require("fzf-lua").lsp_live_workspace_symbols() end, desc = "Find lsp workspace symbols (Jump) "},
    { "<leader>i", function() require("fzf-lua").lsp_document_diagnostics() end, desc = "Find diagnosticss"},
    { "<leader>I", function() require("fzf-lua").lsp_workspace_diagnostics() end, desc = "Find workspace diagnostics"},
    { "gd",        function() require("fzf-lua").lsp_definitions() end, },
    { "gr",        function() require("fzf-lua").lsp_references() end, },
    { "go",        function() require("fzf-lua").lsp_code_actions() end },
    -- useful with rust
    {"gi", function () require("fzf-lua").lsp_implementations() end, desc = "lsp implementations"},
    {"gy", function () require("fzf-lua").lsp_typedefs() end, desc = "lsp implementations"}

  },
  config = function()
    require("fzf-lua").setup({
      "hide",
      fzf_opts = { ['--cycle'] = true },
      files = {
        git_icons = false,
      },
      winopts = {
        row = 0.5,
        width = 0.8,
        height = 0.8,
        title_flags = false,
        preview = {
          horizontal = 'right:50%',
          scrollbar = false,
        },
        backdrop = 100,
      },
      keymap = {
        builtin = {
          true,
          ["<esc>"] = "hide",
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        }
      }
    })
    require("fzf-lua").register_ui_select()
  end
}
