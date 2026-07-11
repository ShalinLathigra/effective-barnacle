return {
	'andyg/leap.nvim',
	url = 'https://codeberg.org/andyg/leap.nvim',
	config = function ()
		vim.keymap.set({'n', 'x', 'o'}, 's',  '<plug>(leap-forward)')
		vim.keymap.set({'n', 'x', 'o'}, 's',  '<plug>(leap-backward)')
		vim.keymap.set('n',             'gs', '<plug>(leap-from-window)')
	end
}
