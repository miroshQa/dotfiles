-- https://github.com/letieu/wezterm-move.nvim/blob/master/lua/wezterm-move/init.lua

local maps = { Left = "h", Right = "l", Up = "k", Down = "j" }
---@param direction "Left" | "Right" | "Down" | "Up"
local function at_edge(direction)
  return vim.fn.winnr() == vim.fn.winnr(maps[direction])
end

local function wezterm_exec(cmd)
  local command = vim.deepcopy(cmd)
  if vim.fn.executable("wezterm.exe") == 1 then
    table.insert(command, 1, "wezterm.exe")
  else
    table.insert(command, 1, "wezterm")
  end
  table.insert(command, 2, "cli")
  return vim.fn.system(command)
end

---@param direction "Left" | "Right" | "Down" | "Up"
local function move(direction)
  if at_edge(direction) then
    wezterm_exec({ "activate-pane-direction", direction })
  else
    vim.cmd("wincmd " .. maps[direction])
  end
end

vim.keymap.set("n", "<S-down>", function() move "Down" end)
vim.keymap.set("n", "<S-up>", function() move "Up" end)
vim.keymap.set("n", "<S-right>", function() move "Right" end)
vim.keymap.set("n", "<S-left>", function() move "Left" end)
