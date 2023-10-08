return {
	'lewis6991/gitsigns.nvim',
	event = { "UIEnter" },
	config = function()
		require('gitsigns').setup()
	end
}
