vim.g.mapleader = ","
vim.g.maplocalleader = '\\'

vim.keymap.set("n", "<leader>h", vim.cmd.noh)  -- Un-highlight search results
vim.keymap.set("v", "<leader>y", "\"+y")  -- Copy to system clipboard


-- ---------------------------------------------------
-- Editing
-- ---------------------------------------------------

vim.keymap.set({"n","v","i"}, "qq", "<C-Bslash><C-n>")  -- Back to normal mode

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv")  -- Move selected lines down
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv")  -- Move selected lines up

vim.keymap.set("n", "<leader>d", ":copy .<CR>")  -- Duplicate current line
vim.keymap.set("v", "<leader>d", ":'<,'>copy '><CR>'>")  -- Duplicate selected lines

vim.keymap.set("v", "<leader>f", ":<C-u>'<insert<CR><CR>----------- ↓↓ START FOCUS HERE ↓↓<CR>.<CR>:'>append<CR>----------- ↑↑ END FOCUS HERE ↑↑<CR><CR>.<CR>'<")  -- Focus on selected lines


-- ---------------------------------------------------
-- Buffers, windows, and tabpages
-- ---------------------------------------------------

vim.keymap.set("n", "<C-w>t", ":tab split<CR>")  -- Open current buffer in new tab page
vim.keymap.set("n", "<C-w>C", ":-close<CR>")  -- Close previous window

-- LSP
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)  -- Go to symbol definition
vim.keymap.set("n", "gD", ":split<CR>:lua vim.lsp.buf.definition()<CR>", opts)  -- Go to symbol definition in split screen
vim.keymap.set("n", "gr", ":silent lgrep -rI <cword> ./ <CR>:lopen<CR>")  -- Show references to symbol in locallist
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
vim.keymap.set("n", "<leader>LA", function() vim.lsp.buf.code_action() end, opts)  -- Choose action on code
vim.keymap.set("n", "<leader>LR", function() vim.lsp.buf.rename() end, opts)  -- Rename symbol
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

-- ---------------------------------------------------
-- Auxiliary windows
-- ---------------------------------------------------

vim.keymap.set("n", "<leader>1", ":NERDTreeToggle<CR>") -- Show/Hide file navigator
vim.keymap.set("n", "<leader>FF", ":NERDTreeFind %<CR>")  -- Show file navigator with current file highlighted

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})  -- Telescope fuzzy find window
vim.keymap.set('n', '<leader>fg', telescope_builtin.git_files, {})  -- Telescope fuzzy find window for files in git repository

vim.keymap.set("n", "<leader>L", ":lua =vim.diagnostic.disable()<CR>:lua =vim.diagnostic.setloclist()<CR>")  -- Show lsp diagnostics in location list, instead of in-line messages

vim.keymap.set("n", "<leader>ga", vim.cmd.Gwrite)  -- Git add current buffer
vim.keymap.set("n", "<leader>gc", ":Git commit -v<CR>")  -- Git diff on current buffer
vim.keymap.set("n", "<leader>gd", ":keepalt Git diff %<CR>")  -- Git diff on current buffer
vim.keymap.set("n", "<leader>gD", vim.cmd.Gdiffsplit)  -- Git diff on current buffer to patch changes with `do` and `dp`
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);  -- Show git status window
