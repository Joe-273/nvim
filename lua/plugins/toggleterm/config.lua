require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 20
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
	shade_terminals = false,
	shell = "nu",
	winblend = 0,
})

-- Setting lazygit
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "rounded",
	},
	highlights = {
		NormalFloat = {
			link = "NormalFloat",
		},
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	-- function to run on closing the terminal
	on_close = function()
		vim.cmd("startinsert!")
	end,
})

function _lazygit_toggle()
	lazygit:toggle()
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>gl",
	"<cmd>lua _lazygit_toggle()<CR>",
	{ desc = "[G]it toggle [l]azygit", noremap = true, silent = true }
)
