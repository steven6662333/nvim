local function lsp_check()
    if vim.b.lsp_running == nil then
        vim.b.lsp_running = vim.fn.empty(vim.lsp.get_clients({
            bufnr = vim.api.nvim_get_current_buf(),
            ft = vim.bo.filetype
        })) ~= 1 -- True when not empty
    end
    if vim.b.lsp_running then
        vim.lsp.buf.format { async = true }
    else
        vim.api.nvim_feedkeys("gg=G''", "n", false)
    end
end
return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        }
    },

    {
        "smjonas/inc-rename.nvim",
        keys = {
            { '<F2>', function()
                local cur = vim.fn.expand("<cword>")
                vim.fn.feedkeys(":IncRename " .. cur)
            end
            }
        },
        opts = {
            save_in_cmdline_history = false
        }
    },

    {
        'nvimdev/lspsaga.nvim',
        event = 'LspAttach',
        keys = {
            { 'gd',        "<cmd>Lspsaga goto_definition<cr>" },
            { 'gD',        "<cmd>Lspsaga peek_definition<cr>" },
            { 'gt',        "<cmd>Lspsaga goto_type_definition<cr>" },
            { 'gT',        "<cmd>Lspsaga peek_type_definition<cr>" },
            { '<leader>]', "<cmd>Lspsaga diagnostic_jump_next<cr>" },
            { '<leader>[', "<cmd>Lspsaga diagnostic_jump_prev<cr>" },
            { '<A-Enter>', "<cmd>Lspsaga code_action<cr>" },
            { 'gh',        "<cmd>Lspsaga hover_doc<cr>" },
            { 'gH',        "<cmd>Lspsaga hover_doc ++keep<cr>" },
            { '<leader>=', function()
                vim.lsp.buf.format { async = true }
            end
            },
        },
        opts = {
            ui = { code_action = "" },
            scroll_preview = {
                scroll_down = '<A-j>',
                scroll_up = '<A-k>',
            },
            lightbulb = {
                enable_in_insert = false,
                virtual_text = false
            },
            code_action = {
                keys = { quit = '<ESC>' }
            }
        },
        config = function(_, opts)
            require('lspsaga').setup(opts)
            -- rewrite lightbulb highlight group
            vim.api.nvim_set_hl(0, "SagaLightBulb", { fg = "#FDC30A" })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        }
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000,    -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup {
                preset = "classic",
                transparent_bg = true,
                transparent_cursorline = true,
                options = {
                    break_line = {
                        enabled = true,
                        after = 40,
                    },
                }
            }
            vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
        end
    }
}
