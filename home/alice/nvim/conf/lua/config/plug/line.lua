L = {}

-- git status base by coc-git
function GitInfo()
	local branch = vim.g.coc_git_status or ""
	local diff = vim.b.coc_git_status or ""
	return (string.len(branch) > 0 and string.format(" %s ", branch) or " none ")
		.. (string.len(diff) > 0 and string.format("%s ", vim.fn.trim(diff)) or "")
end
-- diagnostic info base by coc
function CocErrCount()
	local coc_diagnostic_info = vim.b.coc_diagnostic_info or { error = 0 }
	return string.format(" E%d ", coc_diagnostic_info.error)
end
-- show ft
function GetFt()
	local ft = vim.api.nvim_eval("&ft")
	return string.format(" %s ", string.len(ft) > 0 and ft or "~")
end

function L.before()
	vim.g.powerline_symbols = { light_right = "▷ ", dark_right = "▶ ", light_left = "◁ ", dark_left = "◀ " }
	vim.g.line_powerline_enable = 1
	vim.g.line_nerdfont_enable = 1
	vim.g.line_unnamed_filename = "~"
	vim.g.line_statusline_getters = { "v:lua.GitInfo", "v:lua.CocErrCount", "v:lua.GetFt" }
	vim.g.line_hl = { none = "NONE", light = "NONE", dark = "NONE", ["break"] = "244", space = 238 }
	vim.cmd("au VimEnter * hi VimLine_Dark ctermfg=245")
	vim.cmd("au VimEnter * hi VimLine_Buf_Dark ctermfg=245")
	vim.cmd("au VimEnter * hi VimLine_Other ctermfg=245")
end
return L
