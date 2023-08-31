return {
	'nvim-telescope/telescope.nvim',
	branch = 'master',
	event = "VeryLazy",
	keys = {
		{ '<leader>fg', mode = { 'n' }, function() require('telescope.builtin').live_grep() end },
		{ '<leader>ff', mode = { 'n' }, function() require('telescope.builtin').find_files() end },
		{ '<leader>fb', mode = { 'n' }, function() require('telescope.builtin').buffers() end },
		{ '<leader>fc', mode = { 'n' }, function() require('telescope.builtin').commands() end },
		{ '<leader>fh', mode = { 'n' }, function() require('telescope.builtin').help_tags() end },
		{ '<leader>fl', mode = { 'n' }, function() require('telescope.builtin').treesitter() end },
		{ '<leader>fz', mode = { 'n' }, function() require('telescope.builtin').current_buffer_fuzzy_find() end },
	},
	dependencies = { 'nvim-lua/plenary.nvim', lazy = true }
}
