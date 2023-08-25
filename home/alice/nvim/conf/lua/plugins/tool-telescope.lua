return {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		lazy = true,
		keys = "<leader>f",
		dependencies = { 'nvim-lua/plenary.nvim', lazy = true},
		config = function ()
				local builtin = require('telescope.builtin')
				vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
				vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
				vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
				vim.keymap.set('n', '<leader>fc', builtin.commands, {})
				vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
				vim.keymap.set('n', '<leader>fl', builtin.treesitter, {})
		end
}
