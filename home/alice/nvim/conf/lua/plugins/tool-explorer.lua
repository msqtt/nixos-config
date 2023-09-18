return {
	'stevearc/oil.nvim',
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	keys = {
		{ '<leader>o',  mode = { 'n' }, ":vsp | Oil<CR>" },
	},
}
