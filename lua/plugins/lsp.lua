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
            { ']',         "<cmd>Lspsaga diagnostic_jump_next<cr>" },
            { '[',         "<cmd>Lspsaga diagnostic_jump_prev<cr>" },
            { '<A-Enter>', "<cmd>Lspsaga code_action<cr>" },
            { 'gh',        "<cmd>Lspsaga hover_doc<cr>" },
            { 'gH',        "<cmd>Lspsaga hover_doc ++keep<cr>" },
            { '<leader>=', function() vim.lsp.buf.format { async = true } end },
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
        },
        config = function(_, opts)
            require('lspsaga').setup(opts)
            -- fix conflex between keymap '[' and '[['
            vim.keymap.del('n', '[')
            vim.keymap.del('n', ']')
            -- rewrite lightbulb highlight group
            vim.api.nvim_set_hl(0, "SagaLightBulb", { fg = "#FDC30A" })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        }
    }
}
