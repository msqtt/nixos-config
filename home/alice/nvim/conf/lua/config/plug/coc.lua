C = {}

function C.before()
	-- Autocomplete
	function _G.check_back_space()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
	end
	-- keymap
	require("keymap.packkeys").cockey()
end

return C
