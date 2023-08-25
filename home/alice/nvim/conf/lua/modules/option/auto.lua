local autocmd = vim.api.nvim_create_autocmd
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal spell", })
