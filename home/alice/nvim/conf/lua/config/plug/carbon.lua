C = {}

function C.before()
	require("keymap.packkeys").carbon()
end

function C.after()
	local carbon = require("pack.utils").getPlug("carbon")
	if carbon then
		carbon.setup({
			setting = "value",
		})
	end
end

return C
