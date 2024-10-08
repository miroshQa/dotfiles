-- Leader 
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better UX
vim.opt.autowriteall = true
vim.opt.autoread = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.scrolloff = 20

-- Indents settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.smartindent = true

-- UI
vim.opt.showcmd = false
vim.opt.wrap = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showtabline = 0
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.breakindent = true
vim.g.termguicolors = true
vim.opt.updatetime = 250

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Folds
-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldnestmax = 3
vim.opt.foldtext = ""
vim.opt.foldlevelstart = 99

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- disable new line autocomment
