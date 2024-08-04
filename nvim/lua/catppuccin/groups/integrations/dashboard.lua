local M = {}

function M.get()
	return {
		DashboardShortCut = { fg = C.pink },
		DashboardHeader = { fg = C.teal },
		DashboardCenter = { fg = C.green },
		DashboardFooter = { fg = C.yellow, style = { "italic" } },
		DashboardMruTitle = { fg = C.sky },
		DashboardProjectTitle = { fg = C.sky },
		DashboardFiles = { fg = C.lavender },
		DashboardKey = { fg = C.peach },
		DashboardDesc = { fg = C.sapphire },
		DashboardIcon = { fg = C.green, bold = true },
	}
end

return M
