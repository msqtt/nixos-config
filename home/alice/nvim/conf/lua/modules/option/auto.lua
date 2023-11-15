local autocmd = vim.api.nvim_create_autocmd

-- for some specific language.
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal spell", })
autocmd("FileType", { pattern = "markdown", command = "inoremap 3` ``````<esc>hhi" })

-- auto toggle fcitx5
autocmd({ "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" }, {
	pattern = { "*.md", "*.tex", "*.adoc" },
	callback = function()
		local input_status = tonumber(vim.fn.system("fcitx5-remote"))
		if input_status == 2 then vim.fn.system("fcitx5-remote -t") end
	end,
})
autocmd({ "InsertEnter" }, {
	pattern = { "*.md", "*.tex", "*.adoc" },
	callback = function()
		local input_status = tonumber(vim.fn.system("fcitx5-remote"))
		if input_status == 1 then vim.fn.system("fcitx5-remote -t") end
	end,
})

-- for folder
autocmd("BufWritePre", { pattern = "*", command = "silent! mkview" })
autocmd("BufEnter", { pattern = "*", command = "silent! loadview" })
