local function lsp_status()
  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #attached_clients == 0 then
    return ""
  end
  local names = vim.iter(attached_clients)
      :map(function(client)
        local name = client.name:gsub("language.server", "ls")
        return name
      end)
      :join(", ")
  return "LSP: " .. names
end

local function macro()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return "Recording macro in: " .. reg
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local dmode = require("debugmaster.debug.mode")
    require("lualine").setup({
      options = {
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              if dmode.is_active() == true then
                return "DEBUG"
              end
              return str
            end,

            color = function(tb)
              if dmode.is_active() then
                return {
                  bg = "#2da84f",
                }
              end
              return tb
            end,
          },
        },
        lualine_b = {},
        lualine_c = {
          { "filename",   path = 1 },
          { "branch" },
          { "diff" },
          { "diagnostics" },
          { macro },
        },
        lualine_x = {
          {lsp_status},
          { "filetype" },
        },
        lualine_y = { { "progress" }, { "location" } },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
