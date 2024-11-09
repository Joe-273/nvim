local themes_config = require("plugins.colorscheme.themes-config")

local register_theme = function(palette)
	local theme_palette = palette or nil
	local configs = {}

	if theme_palette ~= nil then
		if themes_config[theme_palette.theme_name] then
			themes_config[theme_palette.theme_name].event = nil
		end
	end

	for _, config in pairs(themes_config) do
		table.insert(configs, config)
	end

	-- Set theme
	local hl = require("config.highlight")
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = function()
			if theme_palette ~= nil then
				vim.cmd.colorscheme(theme_palette.value)
			end

			-- After loading the theme, it is necessary to reconfigure hlchunk plugin
			require("lazy").reload({ plugins = { "hlchunk.nvim" } })
			-- And need to reset highlight
			hl.set_highlight()
		end,
	})

	return configs
end

return register_theme
