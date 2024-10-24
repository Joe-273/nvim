return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	opts = {
		extra_groups = { -- table/string: additional groups that should be cleared
			-- In particular, when you set it to 'all', that means all available groups
			"BqfPreviewFloat",
			"NormalFloat",
			"NormalNC",
			"NvimTreeNormal",
			"NeoTreeNormal",
			"NeoTreeNormalNC",
			"NeoTreePreview",
			"NeoTreeTabInactive",
			"LineNr",
			"CursorColumn",
			"CursorLine",
			"CursorLineNr",
			"FloatBorder",
			"WinBar",
			"WinBarNC",
			"TreesitterContext",
			"DapUIPlayPause",
			"DapUIRestart",
			"DapUIStop",
			"DapUIStepOut",
			"DapUIStepBack",
			"DapUIStepInto",
			"DapUIStepOver",
			"DapUIPlayPauseNC",
			"DapUIRestartNC",
			"DapUIStopNC",
			"DapUIStepOutNC",
			"DapUIStepBackNC",
			"DapUIStepIntoNC",
			"DapUIStepOverNC",
			"SignColumn",
			"StatusLine",
			"TelescopeBorder",
			"TelescopeNormal",
			"TelescopePreviewNormal",
			"TelescopeResultsNormal",
			"TelescopePromptNormal",
			"TabLineFill",
			"TreesitterContextLineNumber",
			"QuickFixLine",
			-- "Pmenu",
			-- "PmenuSel",
			-- "PmenuSbar",
			-- "PmenuThumb",
			"NotifyINFOBody",
			"NotifyWARNBody",
			"NotifyERRORBody",
			"NotifyDEBUGBody",
			"NotifyTRACEBody",
			"NotifyINFOBorder",
			"NotifyWARNBorder",
			"NotifyERRORBorder",
			"NotifyDEBUGBorder",
			"NotifyTRACEBorder",
			"WhichKeyFloat",
		},
	},
	keys = {
		{ "<leader>t" .. "T", "<cmd>TransparentToggle<CR>", desc = "[T]oggle [T]ransparency" },
	},
}
