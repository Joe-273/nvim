require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 20
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	-- open_mapping = [[<c-\>]],
	shade_terminals = false,
	shell = function()
		if vim.fn.has("win32") == 1 then
			return "pwsh"
		else
			return "/bin/zsh"
		end
	end,
	winblend = 0,
	highlights = {
		WinSeparator = {
			link = "FloatBorder",
		},
	},
})

vim.keymap.set(
	"n",
	"|",
	'<Cmd>execute v:count . "ToggleTerm direction=vertical"<CR>',
	{ silent = true, noremap = true, desc = "ToggleTerm Vertical" }
)
vim.keymap.set(
	"n",
	"<C-\\>",
	'<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>',
	{ silent = true, noremap = true, desc = "ToggleTerm Horizontal" }
)
vim.keymap.set("t", "|", "<Esc><Cmd>ToggleTerm<CR>", { noremap = true })
vim.keymap.set("t", "<C-\\>", "<Esc><Cmd>ToggleTerm<CR>", { silent = true, noremap = true })

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
		Normal = {
			link = "Normal",
		},
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

local function _lazygit_toggle()
	lazygit:toggle()
end

vim.keymap.set("n", "<leader>gl", function()
	_lazygit_toggle()
end, { desc = "[G]it toggle [l]azygit", noremap = true, silent = true })
