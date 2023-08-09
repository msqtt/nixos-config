local api = vim.api

--global
api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "silent! mkview" })
api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! loadview" })

-- go
api.nvim_create_autocmd(
	"BufWritePre",
	{ pattern = "*.go", command = "silent call CocAction('runCommand', 'editor.action.organizeImport')" }
)
api.nvim_create_autocmd("FileType", { pattern = "go", command = "nmap gtj :CocCommand go.tags.add json<cr>" })
api.nvim_create_autocmd("FileType", { pattern = "go", command = "nmap gty :CocCommand go.tags.add yaml<cr>" })
api.nvim_create_autocmd("FileType", { pattern = "go", command = "nmap gtx :CocCommand go.tags.clear<cr>" })

-- markdown
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = "inoremap 3` ``````<esc>hhi" })
api.nvim_create_autocmd(
	"FileType",
	{ pattern = "markdown", command = "nnoremap <F12> :CocCommand markdown-preview-enhanced.openPreview<cr>" }
)
