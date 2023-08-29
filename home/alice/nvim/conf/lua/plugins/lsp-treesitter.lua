return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				-- config
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"make",
				"nix",

				-- develop
				"python",
				"go",
				"java",
				"rust",

				"vue",
				"tsx",
				"typescript",
				"javascript",
				"html",
				"css",

				"sql",

				-- serialization
				"yaml",
				"toml",
				"json",
				"graphql",
				"proto",

				-- misc
				"diff",
				"fish",
				"bash",
				markdown,
				markdown_lines,
			},

			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
