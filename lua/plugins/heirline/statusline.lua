local status_comp = require("plugins.heirline.statusline-comp")
local public_copm = require("plugins.heirline.public-comp")

return {
	status_comp.ViMode,
	public_copm.Spacer,
	status_comp.Git,
	public_copm.Spacer,
	status_comp.Diagnostics,
	public_copm.Fill,
	public_copm.StatuslineFileNameBlock,
	public_copm.Fill,
	status_comp.LSPActive,
	public_copm.Spacer,
	status_comp.Ruler,
}
