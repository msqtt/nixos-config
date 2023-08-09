local packer_bootstrap = false

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_repo = "https://github.com/wbthomason/packer.nvim"

if vim.fn.empty(vim.fn.finddir(install_path)) > 0 then
	print("Start to install packer.nvim...")
	vim.fn.system({ "git", "clone", "--depth", "1", packer_repo, install_path })
	vim.cmd([[packadd packer.nvim]])
	packer_bootstrap = true
end

local packer = require("packer")

packer.startup(function(use)
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim" })

	use({ "rockerBOO/boo-colorscheme-nvim", config = require("config.plug.theme-boo").after })

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = require("config.plug.treesitter").after,
		event = "BufRead",
	})

	require("config.plug.coc").before()
	use({ "neoclide/coc.nvim", branch = "release" })

	require("config.plug.line").before()
	use({ "yaocccc/nvim-lines.lua" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = require("config.plug.telescope").after,
	})

	use({
		"kylechui/nvim-surround",
		tag = "main",
		config = require("config.plug.surround").after,
		-- event = "CursorHold",
	})

	use({
		"numToStr/Comment.nvim",
		config = require("config.plug.comment").after,
		event = "CursorHold",
	})

	require("config.plug.carbon").before()
	use({ "SidOfc/carbon.nvim", config = require("config.plug.carbon").after })

	require("config.plug.hop").before()
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = require("config.plug.hop").after,
		event = "CursorHold",
	})

	require("keymap.packkeys").suda()
	use({ "lambdalisue/suda.vim" })

	require("config.plug.venn").before()
	use("jbyuki/venn.nvim")

	use({
		"stevearc/aerial.nvim",
		config = require("config.plug.aerial").after,
	})

	use({
		"lervag/vimtex",
		config = require("config.plug.vimtex").after,
	})
end)

if packer_bootstrap then
	packer.sync()
end

-- coc plugin
vim.g.coc_global_extensions = {
	"coc-git",
	"coc-highlight",
	"coc-pairs",
	"coc-json",
	"coc-marketplace",
	"coc-lua",
	"coc-snippets",
	"coc-prettier",
	"@statiolake/coc-stylua",
}
