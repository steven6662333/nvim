return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    keys = {
        { '<leader>h', "<cmd>Telescope oldfiles<cr>", { desc = "Telescope old files" } }
    },
    config = function()
        local t = require("telescope")
        t.setup {
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                mappings = {
                    i = {
                        ["<A-j>"] = "move_selection_next",
                        ["<A-k>"] = "move_selection_previous",
                    }
                }
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                },
                fzf = {
                    fuzzy = true,     -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        }
        t.load_extension("ui-select")
        t.load_extension("fzf")
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    }
}
