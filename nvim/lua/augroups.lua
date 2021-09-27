vim.api.nvim_exec([[
	augroup VCenterCursor
	au!
	au BufEnter,WinEnter,WinNew,VimResized *,*.* let &scrolloff=winheight(win_getid())
	augroup END
]], false)

