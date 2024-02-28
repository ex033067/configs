vim.opt.termguicolors = true
vim.opt.background = "light"
vim.cmd.colorscheme("simple")

vim.opt.guicursor = ''

vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.timeoutlen = 400

-- Diagnostics appearance
vim.diagnostic.config({virtual_text = false})  -- no inline diagnostic messages
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function()
	vim.diagnostic.setqflist({open = false})  -- show diagnostic in quickfix list
  end,
})
