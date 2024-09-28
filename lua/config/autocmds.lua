local wr_group = vim.api.nvim_create_augroup('WinResize', { clear = true })
vim.api.nvim_create_autocmd(
	'VimResized',
	{
		group = wr_group,
		pattern = '*',
		command = 'wincmd =',
		desc = 'Automatically resize windows when the host window size changes.'
	}
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
  end,
})
