V = {}

function V.after()
	vim.g.vimtex_view_method = "general"
	vim.g.vimtex_view_general_viewer = "okular"
	vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
	vim.g.vimtex_compiler_method = "latexmk"
end

return V
