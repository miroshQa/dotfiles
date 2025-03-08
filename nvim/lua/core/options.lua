vim.cmd("colorscheme gruvboxbaby")

-- Leader 
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better UX
vim.opt.autowriteall = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 20

-- Indents settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- UI
vim.opt.showcmd = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showtabline = 1
vim.opt.signcolumn = "yes"
vim.opt.breakindent = true
vim.g.termguicolors = true
vim.opt.updatetime = 250
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.fillchars = { eob = " "}

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
