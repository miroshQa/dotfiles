---@diagnostic disable: missing-fields
local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- significantly increase startup time
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "rcarriga/cmp-dap"
    },
    config = function()
      local cmp = require("cmp")
      local types = require('cmp.types')
      local luasnip = require("luasnip")
      local compare = cmp.config.compare
      local opts = {
        enabled = function()
          return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
              or require("cmp_dap").is_dap_buffer()
        end,
        performance = {
          debounce = 0,
          throttle = 0,
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "",
              luasnip = "",
              nvim_lua = "",
              latex_symbolc = "",
            })[entry.source.name]
            return vim_item
          end,
          expandable_indicator = false,
          fields = { "abbr", "kind", "menu" },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = {
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Down>"] = {
            i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
          },
          ["<Up>"] = {
            i = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
          },
          ["<C-space>"] = function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" }, -- type ./ to activate
          { name = "dap",     max_item_count = 10 }
        }),

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        matching = {
          disallow_partial_fuzzy_matching = false,
        },
        sorting = {
          comparators = {
            compare.offset,
            compare.exact,
            compare.kind,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
      }

      opts.window.completion.scrolloff = 5
      cmp.setup(opts)
    end,
  },
  {
    'windwp/nvim-autopairs',
    dependency = {
      "hrsh7th/nvim-cmp",
    },
    event = 'InsertEnter',
    config = function()
      require("nvim-autopairs").setup({})

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").config.setup({ history = true })
    end,
    keys = {
      { "<c-n>", function() require("luasnip").jump(1) end,  mode = { "i", "s" } },
      { "<c-p>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } } },
  }
}
