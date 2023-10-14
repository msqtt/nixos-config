return {
	"smoka7/multicursors.nvim",
	event = "VeryLazy",
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'smoka7/hydra.nvim',
	},
	opts = {},
	cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
	keys = {
		{
			mode = { 'v', 'n' },
			'<Leader>m',
			'<cmd>MCstart<cr>',
			desc = 'Create a selection for selected text or word under the cursor',
		},
	},
	config = function()
		local N = require 'multicursors.normal_mode'
		local E = require 'multicursors.extend_mode'
		local I = require 'multicursors.insert_mode'
		require('multicursors').setup {

			normal_keys = {
				['n'] = { method = N.create_down, opts = { desc = 'Create down' } },
				['e'] = { method = N.create_up, opts = { desc = 'Create up' } },
				['N'] = {
					method = N.skip_create_down,
					opts = { desc = 'Skip create down' },
				},
				['E'] = { method = N.skip_create_up, opts = { desc = 'Skip create up' } },
				['j'] = { method = N.find_next, opts = { desc = 'Find next' } },
				['J'] = { method = N.find_prev, opts = { desc = 'Find prev' } },
			},
			extend_keys = {
				['k'] = { method = E.e_method, opts = { desc = 'end word forward' } },
			},
			insert_keys = {
				['<c-h>'] = { method = I.BS_method, opts = { desc = 'backspace' } },
				['<c-d>'] = { method = I.Del_method, opts = { desc = 'delete char' } },
			}
		}
	end
}
