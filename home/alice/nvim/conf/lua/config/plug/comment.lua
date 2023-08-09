C = {}

function C.after()
	local comment = require("pack.utils").getPlug("Comment")
	if comment then
		comment.setup({})
	end
end

return C
