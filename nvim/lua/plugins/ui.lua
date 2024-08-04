return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 3000,
		},
	},

	-- animations
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		
		opts = {
			options = {
				-- globalstatus = false,
				-- theme = "tokyonight",
				theme="ayu_dark"
				-- theme = "catppuccin-mocha",
				-- theme="solarized_dark"
			},
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
		  "SmiteshP/nvim-navic",
		  "nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
		  -- configurations go here
		  theme = 'tokyonight-night'
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		event = "VeryLazy",
		config = function()
		  require('incline').setup({
			---@class InclineRenderProps
			---@field buf number
			---@field win number
			---@field focused boolean
	
			---@param props InclineRenderProps
			render = function(props)
			  if not props.focused then return "" end
	
			  local count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
			  local contents = vim.fn.getreg("/")
			  if string.len(contents) == 0 then return "" end
	
			  return {
				{
				  " ? ",
				  group = "dkoStatusKey",
				},
				{
				  (" %s "):format(contents),
				  group = "IncSearch",
				},
				{
				  (" %d/%d "):format(count.current, count.total),
				  group = "dkoStatusValue",
				}
			  }
			end,
	
			window = {
			  margin = { horizontal = 0 },
			  padding = 0,
			},
		  })
		end,
	  },

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
		  local logo = [[
█████████╗ ██████╗ ██████╗ ██╗  ██╗██╗   ██╗ █████╗ ███████╗
 ╚══██╔══╝██╔═══██╗██╔══██╗██║ ██╔╝██║   ██║██╔══██╗██╔════╝
    ██║   ██║   ██║██████╔╝█████╔╝ ██║   ██║███████║███████╗
    ██║   ██║   ██║██╔══██╗██╔═██╗ ╚██╗ ██╔╝██╔══██║╚════██║
    ██║   ╚██████╔╝██║  ██║██║  ██╗ ╚████╔╝ ██║  ██║███████║
    ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝
		  ]]
	  
		  logo = string.rep("\n", 4) .. logo .. "\n\n"
		  opts.config.header = vim.split(logo, "\n")
	  
		end,
	  },
}
