-- https://stackoverflow.com/questions/75397223/can-i-configure-nvim-lspconfig-to-fail-silently-rather-than-print-a-warning
-- Since neovim 0.11 I probably will be able to delete these checks
local function lsp_binary_exists(server_config)
  local valid_config = server_config.config_def and
      server_config.config_def.default_config and
      type(server_config.config_def.default_config.cmd) == "table" and
      #server_config.config_def.default_config.cmd >= 1

  if not valid_config then
    return false
  end

  local binary = server_config.config_def.default_config.cmd[1]

  return vim.fn.executable(binary) == 1
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
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
    local lspconfig = require("lspconfig")

    vim.diagnostic.config({
      virtual_text = true,
      float = { border = "rounded" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    local servers = {}

    servers.lua_ls = {}
    servers.clangd = {}
    servers.rust_analyzer = {}
    servers.taplo = {}

    -- npm install -g typescript typescript-language-server
    servers.ts_ls = {}

    -- npm i -g bash-language-server
    servers.bashls = {}
    servers.gopls = {}

    -- npm i -g vscode-langservers-extracted
    servers.jsonls = {}
    servers.cssls = {}
    servers.html = {}
    servers.basedpyright = {}
    -- type :help lspconfig-all

    for name, opts in pairs(servers) do
      local conf = lspconfig[name]
      if lsp_binary_exists(conf) then
        conf.setup(opts)
      end
    end
  end,
}
