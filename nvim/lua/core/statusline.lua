-- https://www.reddit.com/r/neovim/comments/tz6p7i/how_can_we_set_color_for_each_part_of_statusline/
local function applyHl(str, hlGroup)
  return "%#" .. hlGroup .. "#" .. str .. "%*"
end

-- https://www.reddit.com/r/neovim/comments/1hr3hh7/nativevim_updates_stable_neovim_support/
local function diagnostics()
  local res = ""
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  if errors > 0 then
    res = res .. applyHl("  " .. errors, "DiagnosticError")
  end
  if warns > 0 then
    res = res .. applyHl("   " .. warns, "DiagnosticWarn")
  end
  return res
end

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

function _G.statusline()
  return table.concat({
    "%f",
    "%h%w%m%r",
    diagnostics(),
    "%=",
    lsp_status(),
    "%y",
    " %-14(%l,%c%V%)",
    "%P",
  }, " ")
end

vim.o.statusline = "%{%v:lua._G.statusline()%}"
