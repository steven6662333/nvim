local colors = {
    dark_gray = "#171A1E",
}
return {
    'akinsho/bufferline.nvim',
    version = "*",
    lazy = false,
    keys = {
        { 'J', "<cmd>BufferLineCyclePrev<cr>" },
        { 'K', "<cmd>BufferLineCycleNext<cr>" },
        { 'td', "<cmd>bdelete<cr>" },
        { 'tD', "<cmd>BufferLineCloseOthers<cr>" },
    },
    opts = {
        options = {
            middle_mouse_command = "bdelete! %d",
            diagnostics = "nvim_lsp",
            -- offsets = {
                --     {
                    --         filetype = "codecompanion",
                    --         text = "File Explorer" | function ,
                    --         text_align = "left" | "center" | "right"
                    --         separator = true
                    --     }
                    -- },
                    separator_style = "slant", -- "slope"
                    -- indicator = { style = 'underline' }
                },
                highlights = {
                    fill = {
                        fg = colors.dark_gray,
                        bg = colors.dark_gray,
                    },
                    separator_selected = {
                        fg = colors.dark_gray,
                    },
                    separator_visible = {
                        fg = colors.dark_gray,
                    },
                    separator = {
                        fg = colors.dark_gray,
                    },
                },
            },
            dependencies = { 'nvim-tree/nvim-web-devicons' }
        }
