local autocmd = vim.api.nvim_create_autocmd
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal spell", })

-- auto toggle fcitx5
autocmd({ "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" }, {
	pattern = { "*" },
	callback = function()
		local input_status = tonumber(vim.fn.system("fcitx5-remote"))
		if input_status == 2 then vim.fn.system("fcitx5-remote -t") end
	end,
})
autocmd({"InsertEnter"}, {
	pattern = { "*.md", "*.tex" },
	callback = function()
		local input_status = tonumber(vim.fn.system("fcitx5-remote"))
		if input_status == 1 then vim.fn.system("fcitx5-remote -t") end
	end,
})
