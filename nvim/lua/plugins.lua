
return require('packer').startup(function()
	-- packer
    use 'wbthomason/packer.nvim'
	--utilities
	use 'Tpope/vim-surround'
	use 'yggdroot/indentline'
	use 'ap/vim-css-color'
	use 'MunifTanjim/nui.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'jbyuki/nabla.nvim'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = 'TSUpdate'
	}
	-- snippets
	use 'sirver/ultisnips'
	--use 'L3MON4D3/LuaSnip'
	-- syntax
	use 'scrooloose/syntastic'
	use 'sheerun/vim-polyglot'
	-- themes
	--use 'ghifarit53/tokyonight-vim'
	use 'srcery-colors/srcery-vim'
	use 'ayu-theme/ayu-vim'
	use 'vim-airline/vim-airline'
	use 'ryanoasis/vim-devicons'

	-- windowing
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'

	-- lsp
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'simrat39/symbols-outline.nvim'
	use 'windwp/nvim-autopairs'
	use 'tjdevries/nlua.nvim'

	-- personal plugins
	use 'elketron/elk-funcs'
	--use 'elketron/elk-manager'

end)

