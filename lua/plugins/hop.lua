return {
    'smoka7/hop.nvim',
    version = "*",
    keys = {
        { '<leader>w',         "<cmd>HopWordCurrentLine<cr>", mode = { 'n', 'v' } },
        { '<leader>v',         "v<cmd>HopChar2AC<cr>" },
        { 's', "<cmd>HopChar2<cr>", mode = { 'n', 'v' } },
        { ',',         "<cmd>HopVertical<cr>",        mode = { 'n', 'v' } },
        { '<leader>/',         "<cmd>HopPattern<cr>" }
    },
    opts = {
        keys = 'etovxpdygfblzhckisuran',
        exit_key = { 'q', '<esc>' },
        jump_on_sole_occurrence = true,
        uppercase_labels = true,
        virtual_cursor = true
    }
}
