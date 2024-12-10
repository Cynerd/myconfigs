local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

local treesitter_formaters = {
	"c",
	"lua",
	"kconfig",
	"make",
	"markdown",
	"markdown_inline",
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
}

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	-- Visual ------------------------------------------------------------------
	use("shaunsingh/nord.nvim")
	use("MunifTanjim/nui.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = treesitter_formaters,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			local highlight = { "CursorColumn", "Whitespace" }
			require("ibl").setup({
				indent = { highlight = highlight, char = "" },
				whitespace = {
					highlight = highlight,
					remove_blankline_trail = false,
				},
				scope = { enabled = false },
			})
		end,
	})
	use("itchyny/lightline.vim")
	use("josa42/nvim-lightline-lsp")
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("mytelescope")
		end,
	})
	-- Git ---------------------------------------------------------------------
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
		config = function()
			require("diffview").setup()
			require("gitlab").setup()
		end,
	})
	-- Programming -------------------------------------------------------------
	use("neovim/nvim-lspconfig")
	use("p00f/clangd_extensions.nvim")
	use({
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				c = { "clangtidy", "editorconfig-checker" },
				lua = { "selene", "editorconfig-checker" },
				markdown = { "vale" },
				nix = { "statix", "deadnix", "nix", "editorconfig-checker" },
				python = { "ruff", "mypy", "editorconfig-checker" },
				sh = { "shellcheck", "editorconfig-checker" },
			}
			lint.linters.deadnix = {
				cmd = "deadnix",
				stdin = false,
				args = { "--output-format", "json" },
				stream = "stdout",
				parser = function(output)
					local lines = vim.fn.split(output, "\n")
					local diagnostics = {}
					for _, line in ipairs(lines) do
						local ok, decoded = pcall(vim.json.decode, line)
						if ok and decoded.file ~= nil then
							for _, result in ipairs(decoded.results) do
								if result.line ~= nil then
									table.insert(diagnostics, {
										lnum = result.line - 1,
										end_lnum = result.line - 1,
										col = result.column,
										end_col = result.endColumn,
										severity = vim.diagnostic.severity.HINT,
										source = "deadnix",
										message = result.message,
									})
								end
							end
						end
					end
					return diagnostics
				end,
			}
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWrite", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	})
	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					c = { "clang-format", "trim_newlines", "twim_whitespace" },
					json = { "jq", "trim_newlines", "twim_whitespace" },
					lua = { "stylua", "trim_newlines", "twim_whitespace" },
					nix = { "alejandra", "trim_newlines", "twim_whitespace" },
					python = { "ruff_fix", "ruff_format", "trim_newlines", "twim_whitespace" },
					sh = { "shfmt", "trim_newlines", "twim_whitespace" },
					typst = { "typstfmt", "trim_newlines", "twim_whitespace" },
					yaml = { "yq", "trim_newlines", "twim_whitespace" },
				},
			})
		end,
	})
	use("SirVer/ultisnips")
	use("honza/vim-snippets")
	use("craigemery/vim-autotag")
	use("scrooloose/nerdcommenter")
	-- Additional integrations -------------------------------------------------
	use({
		"chomosuke/typst-preview.nvim",
		tag = "v0.1.*",
		run = function()
			require("typst-preview").update()
		end,
	})
	-- Movement, format and others ---------------------------------------------
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("dhruvasagar/vim-table-mode")
	-- Filetypes ---------------------------------------------------------------
	use("tmhedberg/SimpylFold")
	use("LnL7/vim-nix")
	use("kaarmu/typst.vim")
	use("aliou/bats.vim")

	-- LSP ---------------------------------------------------------------------
	local lspconfig = require("lspconfig")
	lspconfig.bashls.setup({})
	lspconfig.clangd.setup({})
	lspconfig.nil_ls.setup({})
	lspconfig.pylsp.setup({})
	lspconfig.tinymist.setup({})
end)
