local themes_config = require("plugins.colorscheme.themes-config")

--- @param palette table|nil
local register_theme = function(palette)
	local configs = {}

	if palette ~= nil then
		if themes_config[palette.theme_name] then
			themes_config[palette.theme_name].event = nil
		end
	end

	for _, config in pairs(themes_config) do
		table.insert(configs, config)
	end

	-- Set theme
	local hl = require("config.highlight")
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = function()
			if palette ~= nil then
				vim.cmd.colorscheme(palette.value)
			end

			-- And need to reset highlight
			hl.set_highlight()
		end,
	})

	return configs
end

return register_theme
