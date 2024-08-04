return {
    -- Create annotations with one keybind, and jump your cursor in the inserted annotation
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>cc",
                function() require("neogen").generate({}) end,
                desc = "Neogen Comment"
            }
        },
        opts = {snippet_engine = "luasnip"}
    }, -- Incremental rename
    {"smjonas/inc-rename.nvim", cmd = "IncRename", config = true}, {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            --[[ things you want to change go here]]
            open_mapping = [[<c-\>]],
            autochdir = false,
            shade_terminals = true,
            -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',2
            close_on_exit = true, -- close the terminal window when the process exits
            auto_scroll = true
        }
    }, -- Refactoring tool
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>r",
                function()
                    require("refactoring").select_refactor()
                end,
                mode = "v",
                noremap = true,
                silent = true,
                expr = false
            }
        },
        opts = {}
    }, -- Go forward/backward with square brackets
    {
        "echasnovski/mini.bracketed",
        event = "BufReadPost",
        config = function()
            local bracketed = require("mini.bracketed")
            bracketed.setup({
                file = {suffix = ""},
                window = {suffix = ""},
                quickfix = {suffix = ""},
                yank = {suffix = ""},
                treesitter = {suffix = "n"}
            })
        end
    }, -- Better increase/descrease
    {
        "monaqa/dial.nvim",
        -- stylua: ignore
        keys = {
            {
                "<C-a>",
                function()
                    return require("dial.map").inc_normal()
                end,
                expr = true,
                desc = "Increment"
            }, {
                "<C-x>",
                function()
                    return require("dial.map").dec_normal()
                end,
                expr = true,
                desc = "Decrement"
            }
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal, augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"], augend.constant.alias.bool,
                    augend.semver.alias.semver,
                    augend.constant.new({elements = {"let", "const"}})
                }
            })
        end
    }, {
        "simrat39/symbols-outline.nvim",
        keys = {
            {"<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline"}
        },
        cmd = "SymbolsOutline",
        opts = {position = "right"}
    }, {
        "nvim-cmp",
        dependencies = {"hrsh7th/cmp-emoji"},
        opts = function(_, opts)
            table.insert(opts.sources, {name = "emoji"})
        end
    }, {
        "linux-cultist/venv-selector.nvim",
        cmd = "VenvSelect",
        opts = function(_, opts)
            if require("lazyvim.util").has("nvim-dap-python") then
                opts.dap_enabled = true
            end
            return vim.tbl_deep_extend("force", opts, {
                name = {"venv", ".venv", "env", ".env"}
            })
        end,
        keys = {
            {"<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv"}
        }
    }, {
        "nvim-lualine/lualine.nvim",
        optional = true,
        event = "VeryLazy",
        opts = function(_, opts)
            local icon = require("lazyvim.config").icons.kinds.TabNine
            table.insert(opts.sections.lualine_x, 2,
                         require("lazyvim.util").lualine
                             .cmp_source("cmp_tabnine", icon))
        end
    }, 
    {
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"
        },
        ft = {"markdown"},
        build = function() vim.fn["mkdp#util#install"]() end
    }, {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim", -- optional
            "nvim-treesitter/nvim-treesitter", "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            ---@type string
            arg = "leetcode.nvim",

            ---@type lc.lang
            lang = "cpp",

            cn = { -- leetcode.cn
                enabled = false, ---@type boolean
                translator = true, ---@type boolean
                translate_problems = true ---@type boolean
            },

            ---@type string
            directory = vim.fn.stdpath("data") .. "/leetcode/",

            ---@type boolean
            logging = true,

            cache = {
                update_interval = 60 * 60 * 24 * 7 ---@type integer 7 days
            },

            console = {
                open_on_runcode = true, ---@type boolean

                dir = "row", ---@type lc.direction

                size = { ---@type lc.size
                    width = "90%",
                    height = "75%"
                },

                result = {
                    size = "60%" ---@type lc.size
                },

                testcase = {
                    virt_text = true, ---@type boolean

                    size = "40%" ---@type lc.size
                }
            },

            description = {
                position = "left", ---@type lc.position

                width = "40%", ---@type lc.size

                show_stats = true ---@type boolean
            },

            hooks = {
                ---@type fun()[]
                LeetEnter = {},

                ---@type fun(question: { lang: string })[]
                LeetQuestionNew = {}
            },

            ---@type boolean
            image_support = false -- setting this to `true` will disable question description wrap

        }

    }

}
