-- Windows / Tabs Navigation
vim.keymap.set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "[t", "<cmd>tabp<CR>", {desc = "Go to prev tab"})
vim.keymap.set("n", "]t", "<cmd>tabn<CR>", {desc = "Go to next tab"})

vim.keymap.set("n", "<leader>w", function() vim.cmd("silent! w") end)
vim.keymap.set("n", "ga", "<cmd>b#<CR>", {desc = "Go to last Accessed file (Ctrl + ^ synonim)"})
vim.keymap.set("x", "R", ":s##<left>", {desc = "Start replacement in selected range"})
vim.keymap.set("c", "<down>", "<C-n>")
vim.keymap.set("c", "<up>", "<C-p>")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>", {desc = "Go to prev quickfixlist entry"})
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", {desc = "Go to next quickfixlist entry"})

-- Improved motions (Visual mode)
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
