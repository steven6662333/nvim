return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query",
            "markdown", "markdown_inline", "rust", "python", "javascript", "html", "css" },
    },
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)
        require("nvim-treesitter.configs").setup {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<CR>',
                    node_decremental = '<BS>',
                    -- scope_incremental = '<TAB>',
                }
            },
        }
    end
}
