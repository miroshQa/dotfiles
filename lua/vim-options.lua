vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.autowriteall = true

vim.opt.swapfile = false
vim.opt.showcmd = false -- symbols in the bottom right corner
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2 -- Установка количества пробельных символов при сдвиге с "<", ">"
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.smartindent = true -- Подстравивать новые строки под предыдущий отступ
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.cursorline = true
vim.opt.scrolloff = 20
vim.opt.hlsearch = true
vim.opt.autoread = true
vim.opt_local.formatoptions:remove("cro")
vim.g.termguicolors = true
vim.opt.showtabline = 0
vim.opt.wrap = true
