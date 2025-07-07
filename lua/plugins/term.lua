return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        size = 15,
        open_mapping = [[<A-`>]],
        shell = vim.g.shell
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)
        vim.api.nvim_create_autocmd({ "TermEnter" }, {
            callback = function()
                for _, buffers in ipairs(vim.fn.getbufinfo()) do
                    local filetype = vim.api.nvim_buf_get_option(buffers.bufnr, "filetype")
                    if filetype == "toggleterm" then
                        vim.api.nvim_create_autocmd({ "BufWriteCmd", "FileWriteCmd", "FileAppendCmd" }, {
                            buffer = buffers.bufnr,
                            command = "q!",
                        })
                    end
                end
            end,
        })
    end
}
