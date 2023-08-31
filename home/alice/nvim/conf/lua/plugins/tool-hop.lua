return {
	'phaazon/hop.nvim',
	event = "VeryLazy",
	keys = {
		{
			'f',
			mode = { 'n' },
			function()
				require('hop').hint_char1({
					direction = require('hop.hint').HintDirection.AFTER_CURSOR,
					current_line_only = false
				})
			end
		},

		{
			'F',
			mode = { 'n' },
			function()
				require('hop').hint_char1({
					direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
					current_line_only = false
				})
			end
		},
		{
			't',
			mode = { 'n' },
			function()
				require('hop').hint_char1({
					direction = require('hop.hint').HintDirection.AFTER_CURSOR,
					current_line_only = false,
					hint_offset = -1
				})
			end
		},

		{
			'T',
			mode = { 'n' },
			function()
				require('hop').hint_char1({
					direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
					current_line_only = false,
					hint_offset = 1
				})
			end
		}
	},
	config = function()
		-- you can configure Hop the way you like here; see :h hop-config
		require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
	end
}
