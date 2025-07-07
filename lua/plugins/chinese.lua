return {
    {
        'noearc/jieba.nvim',
        opts = {},
        config = function(_, opts)
            require("jieba_nvim").setup(opts)
            vim.keymap.set({ 'x', 'n' }, 'B', function() require("jieba_nvim").wordmotion_B() end,
                { noremap = false, silent = true })
            vim.keymap.set({ 'x', 'n' }, 'b', function() require("jieba_nvim").wordmotion_b() end,
                { noremap = false, silent = true })
            vim.keymap.set({ 'x', 'n' }, 'w', function() require("jieba_nvim").wordmotion_w() end,
                { noremap = false, silent = true })
            vim.keymap.set({ 'x', 'n' }, 'W', function() require("jieba_nvim").wordmotion_W() end,
                { noremap = false, silent = true })
            vim.keymap.set({ 'x', 'n' }, 'E', function() require("jieba_nvim").wordmotion_E() end,
                { noremap = false, silent = true })
            vim.keymap.set({ 'x', 'n' }, 'e', function() require("jieba_nvim").wordmotion_e() end,
                { noremap = false, silent = true })
            vim.keymap.set({ 'x', 'n' }, 'ge', function() require("jieba_nvim").wordmotion_ge() end,
                { noremap = false, silent = true })
            vim.keymap.set({ 'x', 'n' }, 'gE', function() require("jieba_nvim").wordmotion_gE() end,
                { noremap = false, silent = true })
        end,
        dependencies = { 'noearc/jieba-lua' }
    },
}
