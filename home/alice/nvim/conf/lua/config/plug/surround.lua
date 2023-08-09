S = {}

function S.before() end
function S.after()
	local surround = require("pack.utils").getPlug("nvim-surround")
	if surround then
		surround.setup({
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "hs",
				normal_cur = "hss",
				normal_line = "hS",
				normal_cur_line = "hSS",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
			},
		})
	end
end

return S
