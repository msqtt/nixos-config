return {
	'tomiis4/BufferTabs.nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons',     -- optional
	},
	lazy = false,
	config = function()
		require('buffertabs').setup({
			-- config
		})
		require('buffertabs').toggle()
		vim.keymap.set("n", "<leader>b", ":BufferTabsToggle<CR>", {})
	end
}
