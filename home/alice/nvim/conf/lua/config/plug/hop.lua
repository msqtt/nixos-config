H = {}

function H.before()
	require("keymap.packkeys").hop()
end

function H.after()
	local hot = require("pack.utils").getPlug("hop")
	if hot then
		hot.setup({ keys = "etovxqpdygfblzhckisuran" })
	end
end

return H
