return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            file_types = { 'markdown', 'vimwiki' },
            completions = { blink = { enabled = true } },
            code = {
                language_pad = 1
            },
        },
        config = function(_, opts)
            require("render-markdown").setup(opts)
            vim.treesitter.language.register('markdown', 'vimwiki')
        end,
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    },
    {
        -- "3rd/image.nvim",

        'steven6662333/image.nvim',
        branch = "feat/toggle-download-error",

        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        ---@module 'image'
        ---@type Options
        opts = {
            backend = "kitty",
            kitty_method = 'normal',
            processor = "magick_cli",
            integrations = {
                markdown = {
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    only_render_image_at_cursor_mode = "inline",
                    -- floating_windows = false, -- if true, images will be rendered in floating markdown windows
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
            },
            -- ignore_download_error = true
        }
    }
}
