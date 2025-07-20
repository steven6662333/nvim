local function shorter_name(filename)
    return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
end

return {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- This is the regexp branch, use this for the new version
    ft = { "python" },
    cmd = { "VenvSelect" },
    ---@type venv-selector.Config
    opts = {
        options = {
            -- If you put the callback here as a global option, its used for all searches (including the default ones by the plugin)
            on_telescope_result_callback = shorter_name,
            notify_user_on_venv_activation = true
        },
    },
    dependencies = {
        "neovim/nvim-lspconfig",
        -- "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
        { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    }
}
