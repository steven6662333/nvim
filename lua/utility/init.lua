local M = {}

M.require_all = function(dir)
    local path = vim.fn.stdpath("config") .. "/lua/" .. dir
    if vim.fn.isdirectory(path) == 1 then
        for _, file in ipairs(vim.fn.readdir(path)) do
            -- Only require lua files
            if file:match("%.lua$") then
                -- Remove the .lua extension
                local module = file:gsub("%.lua$", "")
                require(dir .. "." .. module)
            end
        end
    end
end

return M
