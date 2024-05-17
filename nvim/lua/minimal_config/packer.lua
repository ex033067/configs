-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- file manager
  use 'preservim/nerdtree'

  -- fuzzy finder
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- colorscheme
  use 'ex033067/vim-simple-colorscheme'

  -- syntax highlighting
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  -- git integration
  use('tpope/vim-fugitive')

  -- comments
  use('tpope/vim-commentary')

  -- add, change, remove delimiters
  use('machakann/vim-sandwich')

  -- navigate classes
  use('majutsushi/tagbar')

  -- -----------------------------------------------------------
  -- LSP installation
  -- -----------------------------------------------------------
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
	  }
  }

end)
