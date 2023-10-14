return {
	"kylechui/nvim-surround",
	version = "*",   -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "hs",
				normal_cur = "hss",
				normal_line = "hS",
				normal_cur_line = "hSS",
				visual = "S",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
			},
		})
	end
}
