vim.g.mapleader = ","
vim.g.maplocalleader = '\\'


-- ---------------------------------------------------
-- Appearance
-- ---------------------------------------------------

vim.keymap.set("n", "<leader>h", vim.cmd.noh)  -- Un-highlight search results
vim.keymap.set("n", "<leader>H", ":set invhls<CR>")  -- Toggle search results highlighting
vim.keymap.set("n", "<leader>w", ":set invwrap<CR>")  -- Toggle word wrap


-- ---------------------------------------------------
-- Clipboard
-- ---------------------------------------------------

vim.keymap.set("n", "<leader>y", "\"+y")  -- Copy to system clipboard (accept motion)
vim.keymap.set("v", "<leader>y", "\"+y")  -- Copy selected text to system clipboard


-- ---------------------------------------------------
-- Editing
-- ---------------------------------------------------

vim.keymap.set({"v","i"}, "qq", "<C-Bslash><C-n>")  -- Back to normal mode from insert or visual modes

vim.keymap.set("v", "<C-j>", ":'<,'>m '>+1<CR>gv")  -- Move selected lines down
vim.keymap.set("v", "<C-k>", ":'<,'>m '<-2<CR>gv")  -- Move selected lines up

vim.keymap.set("n", "<leader>d", ":copy .<CR>")  -- Duplicate current line
vim.keymap.set("v", "<leader>d", ":'<,'>copy '><CR>'>j")  -- Duplicate selected lines

vim.keymap.set("n", "<leader>D", ":copy .<CR>:.-1Commentary<CR>")  -- Comment and duplicate current line
vim.keymap.set("v", "<leader>D", ":'<,'>copy '><CR>:'<,'>:Commentary<CR>'>j")  -- Comment and duplicate selected lines

vim.keymap.set("v", "<leader>f", ":<C-u>'<insert<CR><CR>----------- ↓↓ START FOCUS HERE ↓↓<CR>.<CR>:'>append<CR>----------- ↑↑ END FOCUS HERE ↑↑<CR><CR>.<CR>'<")  -- Focus on selected lines


-- ---------------------------------------------------
-- Code navigation
-- ---------------------------------------------------

vim.keymap.set("n", "]l", ":lnext<CR>") -- next line in location list
vim.keymap.set("n", "[l", ":lprev<CR>") -- previous line in location list

vim.keymap.set("n", "]L", ":lnfile<CR>") -- next file in location list
vim.keymap.set("n", "[L", ":lpfile<CR>") -- previous file in location list

vim.keymap.set("n", "gr", ":silent lgrep -rIw <cword> ./ <CR>:lopen<CR>")  -- Show references to symbol in location list

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)  -- Go to symbol definition
vim.keymap.set("n", "gD", ":split<CR>:lua vim.lsp.buf.definition()<CR>")  -- Go to symbol definition in split screen


-- ---------------------------------------------------
-- Buffers, windows, and tabpages
-- ---------------------------------------------------

vim.keymap.set("n", "<C-w>TT", ":tab split<CR>")  -- Open copy of current buffer in new tab page
vim.keymap.set("n", "<C-w>CC", ":-close<CR>")  -- Close previous window

vim.keymap.set("n", "<leader>1", ":NERDTreeToggle<CR>") -- Show/Hide file navigator
vim.keymap.set("n", "<leader>FF", ":NERDTreeFind<CR>")  -- Show file navigator with current file highlighted
vim.keymap.set("n", "<leader>4", ":TagbarToggle<CR>") -- Toggle Tagbar window


-- ---------------------------------------------------
-- LSP
-- ---------------------------------------------------

vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<leader>LA", function() vim.lsp.buf.code_action() end)  -- Choose action on code
vim.keymap.set("n", "<leader>LR", function() vim.lsp.buf.rename() end)  -- Rename symbol
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end) -- help with function signature
vim.keymap.set("n", "<leader>LL", ":lua =vim.diagnostic.setloclist()<CR>")  -- Show lsp diagnostics in location list


-- ---------------------------------------------------
-- Telescope
-- ---------------------------------------------------

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})  -- Telescope fuzzy find window for open buffers
vim.keymap.set('n', '<leader>FB', ":lua require('telescope.builtin').live_grep({ grep_open_files = true })<CR>", {})  -- Telescope live grep in open buffers
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})  -- Telescope fuzzy find window
vim.keymap.set('n', '<leader>fg', telescope_builtin.git_files, {})  -- Telescope fuzzy find window for files in git repository


-- ---------------------------------------------------
-- Git
-- ---------------------------------------------------

vim.keymap.set("n", "<leader>ga", vim.cmd.Gwrite)  -- Git add current buffer
vim.keymap.set("n", "<leader>gc", ":Git commit -v<CR>")  -- Git commit
vim.keymap.set("n", "<leader>gd", ":keepalt Git diff %<CR>:resize<CR>")  -- Git diff on current buffer in full screen
vim.keymap.set("n", "<leader>gD", vim.cmd.Gdiffsplit)  -- Git diff on current buffer to patch changes with `do` and `dp`
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);  -- Show git status window
