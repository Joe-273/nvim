local components = require("plugins.heirline.components")

return {
	components.ViMode,
	components.Spacer,
	components.Git,
	components.Spacer,
	components.Diagnostics,
	components.Fill,
	components.FileNameBlock,
	components.Fill,
	components.LSPActive,
	components.Spacer,
	components.Ruler,
}
