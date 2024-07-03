return {
	"L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
    require("luasnip.loaders.from_vscode").load { include = { "javascript", "typescript", "csharp"}, }

    require("luasnip").config.setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })

    for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/snippets/*.lua", true)) do
      loadfile(ft_path)()
    end

  end,
  keys = {
    { "<right>",   function() require("luasnip").jump(1) end,  mode = {"i", "s"}},
    { "<left>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    -- Таб плох тем что в инсерт моде нельзя прыгать вперед после того как отошел от области сниппета
  },
}
