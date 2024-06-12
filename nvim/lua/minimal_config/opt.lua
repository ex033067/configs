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
vim.opt.formatoptions = vim.opt.formatoptions + 'n' -- identify lists

vim.diagnostic.config({virtual_text = false})  -- no inline diagnostic messages

vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*.py",
  command = "checktime",
}) -- Update file changed outside vim
