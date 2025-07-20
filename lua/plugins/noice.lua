local high = {
    relative = "editor",
    position = {
        col = "50%",
        row = "30%"
    }
}
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        cmdline = {
            format = {
                cmdline = { opts = high },
                lua = { opts = high },
                help = { opts = high },
                filter = { opts = high },
                input = { opts = high }
            }
        },
        routers = {
            {
                view = "cmdline",
                filter = { event = "msg_show", find = "Hop" },
            }
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            -- command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = true,            -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        {
            "rcarriga/nvim-notify",
            opts = {
                background_colour = "#000000",
            }
        },
    }
}
