M = {}

function M.after()
	vim.g.substrata_italic_comments = true
	vim.g.substrata_italic_keywords = false
	vim.g.substrata_italic_booleans = false
	vim.g.substrata_italic_functions = true
	vim.g.substrata_italic_variables = false
	vim.g.substrata_transparent = false
	vim.cmd([[colorscheme substrata]])
end

return M
