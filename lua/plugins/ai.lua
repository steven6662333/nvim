
return {
    {
        "olimorris/codecompanion.nvim",
        lazy = false,
        keys = {
            { "<leader>cc", "<cmd>CodeCompanion<cr>" },
            {
                "<C-l>",
                "<cmd>CodeCompanionChat Toggle<cr>",
                mode = { "n", "v" }
            },
            {
                "<leader>cc",
                "<cmd>CodeCompanionChat<cr>"
            },
            {
                "<leader>ca",
                "<cmd>CodeCompanionActions<cr>"
            },
            {
                "<leader>ca",
                "<cmd>CodeCompanionChat Add<cr>",
                mode = "v"
            },
            {
                "<leader>ch",
                "<cmd>CodeCompanionHistory<cr>"
            },
        },
        config = function()
            local default_model = "google/gemini-2.5-pro"
            local available_models = {
                "google/gemini-2.5-flash-preview-05-20",
                "google/gemini-2.5-pro",
                "anthropic/claude-3.7-sonnet",
                "deepseek/deepseek-chat-v3-0324",
                "openai/gpt-4o-mini",
            }
            local current_model = default_model

            local function select_model()
                vim.ui.select(available_models, {
                    prompt = "Select  Model:",
                }, function(choice)
                    if choice then
                        current_model = choice
                        vim.notify("Selected model: " .. current_model)
                    end
                end)
            end

            require("codecompanion").setup {
                strategies = {
                    chat = {
                        adapter = "openrouter",
                    },
                    inline = {
                        adapter = "openrouter",
                    },
                },
                adapters = {
                    openrouter = function()
                        return require("codecompanion.adapters").extend("openai_compatible", {
                            env = {
                                url = "https://openrouter.ai/api",
                                api_key = "cmd:rbw get openrouter",
                                chat_url = "/v1/chat/completions",
                            },
                            schema = {
                                model = {
                                    default = current_model,
                                },
                            },
                        })
                    end,
                },
                opts = { language = "Chinese" },
                display = {
                    chat = {
                        window = {
                            position = "right",
                            width = 0.3,
                        }
                    },
                    diff = {
                        enabled = true,
                        close_chat_at = 240,    -- Close an open chat buffer if the total columns of your display are less than...
                        layout = "vertical",    -- vertical|horizontal split for default provider
                        opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
                        provider = "mini_diff", -- default|mini_diff
                    },
                },
                extensions = {
                    history = {
                        enabled = true,
                        opts = {
                            -- Keymap to open history from chat buffer (default: gh)
                            keymap = "gh",
                            -- Keymap to save the current chat manually (when auto_save is disabled)
                            save_chat_keymap = "sc",
                            -- Save all chats by default (disable to save only manually using 'sc')
                            auto_save = true,
                            -- Number of days after which chats are automatically deleted (0 to disable)
                            expiration_days = 0,
                            -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
                            picker = "telescope",
                            -- Customize picker keymaps (optional)
                            picker_keymaps = {
                                rename = { n = "r", i = "<M-r>" },
                                delete = { n = "d", i = "<M-d>" },
                                duplicate = { n = "<C-y>", i = "<C-y>" },
                            },
                            ---Automatically generate titles for new chats
                            auto_generate_title = true,
                            title_generation_opts = {
                                ---Adapter for generating titles (defaults to active chat's adapter)
                                adapter = "openrouter",                               -- e.g "copilot"
                                ---Model for generating titles (defaults to active chat's model)
                                model = "google/gemini-2.5-flash-lite-preview-06-17", -- e.g "gpt-4o"
                                ---Number of user prompts after which to refresh the title (0 to disable)
                                refresh_every_n_prompts = 0,                          -- e.g., 3 to refresh after every 3rd user prompt
                                ---Maximum number of times to refresh the title (default: 3)
                                max_refreshes = 3,
                            },
                            ---On exiting and entering neovim, loads the last chat on opening chat
                            continue_last_chat = false,
                            ---When chat is cleared with `gx` delete the chat from history
                            delete_on_clearing_chat = false,
                            ---Directory path to save the chats
                            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                            ---Enable detailed logging for history extension
                            enable_logging = false,
                            ---Optional filter function to control which chats are shown when browsing
                            chat_filter = nil, -- function(chat_data) return boolean end
                        }
                    }
                }
            }
            vim.keymap.set("n", "<leader>cm", select_model, { desc = "Select Gemini Model" })
            -- Expand 'cc' into 'CodeCompanion' in the command line
            vim.api.nvim_command([[cnoreabbrev <expr> CC 'CodeCompanion ""<Left>']])
        end,

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/codecompanion-history.nvim",
            {
                'echasnovski/mini.diff',
                version = '*',
                opts = {
                    mappings = {
                        -- Apply hunks inside a visual/operator region
                        apply = '<A-a>',

                        -- Reset hunks inside a visual/operator region
                        -- reset = 'gH',

                        -- Hunk range textobject to be used inside operator
                        -- Works also in Visual mode if mapping differs from apply and reset
                        -- textobject = 'gh',

                        -- Go to hunk range in corresponding direction
                        -- goto_first = '[H',
                        goto_prev = '{',
                        goto_next = '}',
                        -- goto_last = ']H',
                    },
                }

            }
        },
    },
    {
        'milanglacier/minuet-ai.nvim',
        opts = {
            virtualtext = {
                auto_trigger_ft = { "*" },
                auto_trigger_ignore_ft = { 'codecompanion', 'TelescopePrompt', 'overseer', 'lazy', 'toggleterm', 'yazi' },
                keymap = {
                    -- accept whole completion
                    accept = '<A-w>',
                    -- accept one line
                    accept_line = '<A-W>',
                    -- accept n lines (prompts for number)
                    -- e.g. "A-z 2 CR" will accept 2 lines
                    -- accept_n_lines = '<A-z>',
                    -- Cycle to prev completion item, or manually invoke completion
                    prev = '<A-[>',
                    -- Cycle to next completion item, or manually invoke completion
                    next = '<A-]>',
                    dismiss = '<A-e>',
                },
            },
            provider = 'openai_compatible',
            request_timeout = 2.5,
            throttle = 1000, -- Increase to reduce costs and avoid rate limits
            debounce = 600,  -- Increase to reduce costs and avoid rate limits
            provider_options = {
                openai_compatible = {
                    api_key = function()
                        local raw = vim.system({ "rbw", "get", "openrouter" }, { text = true }):wait().stdout
                        if raw == nil then
                            return ""
                        end
                        return string.sub(raw, 1, string.len(raw) - 1)
                    end,
                    end_point = 'https://openrouter.ai/api/v1/chat/completions',
                    model = 'qwen/qwen-2.5-coder-32b-instruct',
                    name = 'Openrouter',
                    optional = {
                        max_tokens = 56,
                        top_p = 0.9,
                        provider = {
                            -- Prioritize throughput for faster completion
                            sort = 'throughput',
                        },
                    },
                },
            },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-lualine/lualine.nvim',
        }
    },
}
