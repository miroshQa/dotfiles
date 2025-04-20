local wezterm = require("wezterm")

local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Dark (Gogh)"
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = true
config.audible_bell = "Disabled"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.use_fancy_tab_bar = true
config.window_background_opacity = 1
config.max_fps = 240
config.initial_rows = 36
config.initial_cols = 140
config.adjust_window_size_when_changing_font_size = false
config.default_cursor_style = 'SteadyBar'
config.cursor_thickness = "1.3pt"

config.window_padding = {
  left = "1cell",
  right = "1cell",
  top = "0.5cell",
  bottom = "0cell",
}

local function close_copy_mode()
  return act.Multiple({
    act.CopyMode("ClearSelectionMode"),
    act.CopyMode("ClearPattern"),
    act.CopyMode("Close"),
    act.CopyMode("MoveToScrollbackBottom"),
  })
end

local function is_vim(pane)
  local process_info = pane:get_foreground_process_info()
  local process_name = process_info and process_info.name
  return process_name == "nvim" or process_name == "vim"
end

---@param key string
local function split_nav(key)
  return {
    mods = "SHIFT",
    key = key,
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({ SendKey = { key = key, mods = "SHIFT" }, }, pane)
      else
        local dir = key:match("([%a]+)Arrow")
        win:perform_action({ ActivatePaneDirection = dir }, pane)
      end
    end),
  }
end

config.keys = {
  split_nav("LeftArrow"),
  split_nav("DownArrow"),
  split_nav("UpArrow"),
  split_nav("RightArrow"),
  { key = "t",     mods = "ALT",  action = act.SpawnTab("CurrentPaneDomain") },
  { key = "q",     mods = "ALT",  action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  { key = "h",     mods = "ALT",  action = act.ActivateTabRelativeNoWrap(-1) },
  { key = "l",     mods = "ALT",  action = act.ActivateTabRelativeNoWrap(1) },
  { key = "H",     mods = "ALT",  action = act.MoveTabRelative(-1) },
  { key = "L",     mods = "ALT",  action = act.MoveTabRelative(1) },
  { key = "Enter", mods = "CTRL", action = act.ToggleFullScreen },
  { key = "v",     mods = "ALT",  action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "x",     mods = "ALT",  action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "a",     mods = "ALT",  action = wezterm.action.ActivateCopyMode },
  { mods = "ALT",  key = "r",     action = wezterm.action.RotatePanes("Clockwise") },
  { key = "w",     mods = "ALT",  action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  { key = "o",     mods = "ALT",  action = act.TogglePaneZoomState },
  { key = 'z',     mods = 'ALT',  action = wezterm.action.ShowDebugOverlay },
}

config.key_tables = {
  copy_mode = {
    -- All possible keymaps are available here: https://wezfurlong.org/wezterm/copymode.html#configurable-key-assignments
    { key = "i", mods = "NONE", action = close_copy_mode() },
    { key = "a", mods = "NONE", action = close_copy_mode() },
    {
      key = "Escape",
      mods = "NONE",
      action = act.Multiple({ act.CopyMode("ClearSelectionMode"), act.CopyMode("ClearPattern") }),
    },

    { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

    {
      key = "/",
      mods = "NONE",
      action = act.Multiple({ act.CopyMode("ClearPattern"), act.Search({ CaseInSensitiveString = "" }) }),
    },
    {
      key = "?",
      mods = "SHIFT",
      action = act.Multiple({ act.CopyMode("ClearPattern"), act.Search({ CaseInSensitiveString = "" }) }),
    },
    { key = "n", mods = "NONE",  action = wezterm.action({ CopyMode = "NextMatch" }) },
    { key = "N", mods = "SHIFT", action = wezterm.action({ CopyMode = "PriorMatch" }) },

    { key = "h", mods = "NONE",  action = wezterm.action({ CopyMode = "MoveLeft" }) },
    { key = "j", mods = "NONE",  action = wezterm.action({ CopyMode = "MoveDown" }) },
    { key = "k", mods = "NONE",  action = wezterm.action({ CopyMode = "MoveUp" }) },
    { key = "l", mods = "NONE",  action = wezterm.action({ CopyMode = "MoveRight" }) },

    { key = "b", mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },
    { key = "w", mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
    { key = "e", mods = "NONE",  action = act.CopyMode("MoveForwardWordEnd") },
    { key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
    { key = "G", mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
    { key = "g", mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },
    { key = "o", mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
    { key = "0", mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
    { key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
    { key = "d", mods = "CTRL",  action = act.CopyMode({ MoveByPage = 0.5 }) },
    { key = "u", mods = "CTRL",  action = act.CopyMode({ MoveByPage = -0.5 }) },
    {
      key = "y",
      mods = "NONE",
      action = act.Multiple({
        { CopyTo = "ClipboardAndPrimarySelection" },
        act.CopyMode("Close"),
        act.CopyMode("MoveToScrollbackBottom"),
      }),
    },
    { key = ",", mods = "NONE",  action = act.CopyMode("JumpReverse") },
    { key = ";", mods = "NONE",  action = act.CopyMode("JumpAgain") },
    { key = "f", mods = "NONE",  action = act.CopyMode({ JumpForward = { prev_char = false } }) },
    { key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
    { key = "t", mods = "NONE",  action = act.CopyMode({ JumpForward = { prev_char = true } }) },
    { key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
  },
  search_mode = {
    { key = "Escape", mods = "NONE", action = act.Multiple({ "ActivateCopyMode" }) },
    { key = "Enter",  mods = "NONE", action = "ActivateCopyMode" },
    { key = "u",      mods = "CTRL", action = act.CopyMode("ClearPattern") },
  },
}

config.unix_domains = {
  {
    name = "unix",
  },
}

return config
