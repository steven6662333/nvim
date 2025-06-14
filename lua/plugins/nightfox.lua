return {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
        options = {
            transparent = true,
        },
        palettes = {
            carbonfox = {
                bg0 = "#222222", -- Black background
            },
        },
    },
    config = function(_, opts)
        require("nightfox").setup(opts)
        vim.cmd("colorscheme carbonfox")
    end
}
