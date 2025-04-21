-- Windows / Tabs Navigation
vim.keymap.set("n", "[t", "<cmd>tabp<CR>", { desc = "Go to prev tab" })
vim.keymap.set("n", "]t", "<cmd>tabn<CR>", { desc = "Go to next tab" })

vim.keymap.set("n", "<leader>w", function() vim.cmd("silent! w") end, { desc = "Write buffer" })
vim.keymap.set("n", "<leader>q", function() vim.cmd("silent! q") end, { desc = "Quit window" })
vim.keymap.set("n", "ga", "<cmd>b#<CR>", { desc = "Go to last Accessed file (Ctrl + ^ synonim)" })
vim.keymap.set("x", "R", ":s###g<left><left><left>", { desc = "Start replacement in selected range" })
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>")

-- Improved motions (Visual mode)
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })
vim.keymap.del("s", "<")
vim.keymap.del("s", ">")

vim.keymap.set('n', '<leader>ld', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { noremap = true, silent = true, desc = "Toggle vim diagnostics" })

vim.keymap.set("n", "<leader>lh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle lsp inlay hints" })

-- lua is so powerful damn... I love closures
vim.keymap.set({ "n", "t" }, "<C-t>", (function()
  local buf, win = nil, nil
  local was_insert = true
  local cfg = function()
    return {
      relative = 'editor',
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
      row = math.floor(vim.o.lines * 0.1),
      col = math.floor(vim.o.columns * 0.1),
      style = 'minimal',
      border = 'rounded',
    }
  end
  return function()
    buf = (buf and vim.api.nvim_buf_is_valid(buf)) and buf or nil
    win = (win and vim.api.nvim_win_is_valid(win)) and win or nil
    if not buf and not win then
      vim.cmd("split | terminal")
      buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
      win = vim.api.nvim_open_win(buf, true, cfg())
    elseif not win and buf then
      win = vim.api.nvim_open_win(buf, true, cfg())
    elseif win then
      was_insert = vim.api.nvim_get_mode().mode == "t"
      return vim.api.nvim_win_close(win, true)
    end
    if was_insert then vim.cmd("startinsert") end
  end
end)(), { desc = "Toggle float terminal" })

vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", '[e', function() vim.diagnostic.jump({ severity = "ERROR", count = -1, float = true }) end)
vim.keymap.set("n", ']e', function() vim.diagnostic.jump({ severity = "ERROR", count = 1, float = true }) end)
vim.keymap.set("n", '[w', function() vim.diagnostic.jump({ severity = "WARN", count = -1, float = true }) end)
vim.keymap.set("n", ']w', function() vim.diagnostic.jump({ severity = "WARN", count = 1, float = true }) end)
vim.keymap.set("n", ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set("n", '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)

vim.keymap.set("n", "cd", vim.lsp.buf.rename)
vim.keymap.set("n", "M", vim.diagnostic.open_float)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Lsp format buffer" })

local _ = (function()
  local maps = { Left = "h", Right = "l", Up = "k", Down = "j" }
  ---@param direction "Left" | "Right" | "Down" | "Up"
  local function at_edge(direction)
    return vim.fn.winnr() == vim.fn.winnr(maps[direction])
  end

  ---@param direction "Left" | "Right" | "Down" | "Up"
  local function move(direction)
    if at_edge(direction) then
      vim.fn.system({ "wezterm", "cli", "activate-pane-direction", direction })
    else
      vim.cmd("wincmd " .. maps[direction])
    end
  end

  vim.keymap.set("n", "<S-down>", function() move "Down" end)
  vim.keymap.set("n", "<S-up>", function() move "Up" end)
  vim.keymap.set("n", "<S-right>", function() move "Right" end)
  vim.keymap.set("n", "<S-left>", function() move "Left" end)
end)()
