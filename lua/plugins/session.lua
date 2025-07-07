return {
    "Shatur/neovim-session-manager",
    lazy = false,
    keys = {
        { '<leader>s', "<cmd>SessionManager load_session<cr>" }
    },
    config = function()
        local config = require("session_manager.config")
        require("session_manager").setup {
            autoload_mode = { config.AutoloadMode.GitSession, config.AutoloadMode.LastSession, config.AutoloadMode.CurrentDir, config.AutoloadMode.Disabled }
        }
    end
}
