vim.opt.termguicolors = true
vim.opt.background = "light"
vim.cmd.colorscheme("simple")

vim.opt.guicursor = ''

vim.opt.number = true

vim.opt.shiftwidth = 0
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- vim.opt.timeoutlen = 400

vim.diagnostic.config({virtual_text = false})  -- no inline diagnostic messages
