return {
    {
        "folke/flash.nvim",
        -- event = "VeryLazy",
        ---@type Flash.Config
        -- stylua: ignore
        opts = {
            label = {
                after = false,
                before = true
            },
            modes = {
                char = { enabled = false },
                search = { enabled = true }
            }
        },
    },
    {
        "roobert/search-replace.nvim",
        keys = {
            { '<leader>r', '<cmd>SearchReplaceSingleBufferCWord<cr>' }
        },
        opts = {}
    }
}
