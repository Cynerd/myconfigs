local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	-- Visual
	use("shaunsingh/nord.nvim")
	use("MunifTanjim/nui.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("lukas-reineke/indent-blankline.nvim")
	use("itchyny/lightline.vim")
	-- Files navigation
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	-- Git
	use("tpope/vim-fugitive")
	use("airblade/vim-gitgutter")
	use({
		"harrisoncramer/gitlab.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
			"nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
		},
		run = function()
			require("gitlab.server").build(true)
		end,
	})
	-- Programming
	use("neovim/nvim-lspconfig")
	use("p00f/clangd_extensions.nvim")
	use("w0rp/ale")
	use("maximbaz/lightline-ale")
	use("SirVer/ultisnips")
	use("honza/vim-snippets")
	use("craigemery/vim-autotag")
	use("scrooloose/nerdcommenter")
	-- Movement, format and others
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("dhruvasagar/vim-table-mode")

-- Indent blanklike character specificaiton
local highlight = { "CursorColumn", "Whitespace" }
require("ibl").setup({
	indent = { highlight = highlight, char = "" },
	whitespace = {
		highlight = highlight,
		remove_blankline_trail = false,
	},
	scope = { enabled = false },
})
-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"kconfig",
		"make",
		"markdown",
		"meson",
		"ninja",
		"ini",
		"gitcommit",
		"git_rebase",
		"git_config",
		"nix",
		"python",
		"toml",
		"vim",
		"vimdoc",
		"yaml",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- LSP
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.rnix.setup({})
lspconfig.pylsp.setup({})
lspconfig.bashls.setup({})

-- Telescope
require('mytelescope')

-- Gitlab
require("diffview").setup()
require("gitlab").setup()
