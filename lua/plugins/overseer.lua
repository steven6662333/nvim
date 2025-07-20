local function get_task_by_id(id)
    local tasks = require("overseer").list_tasks()
    if vim.tbl_isempty(tasks) then
        return nil
    end
    for _, t in ipairs(tasks) do
        if t.id == id then
            return t
        end
    end
    return nil
end
local function select_and_save(bufnr)
    -- print("Last task not found. Select and run one.")
    if bufnr == nil then
        bufnr = vim.api.nvim_get_current_buf()
    end
    require("overseer").run_template(nil, function(task)
        if task == nil then
            return
        end
        vim.b[bufnr].last_task_id = task.id
    end)
end
local function try_run()
    local bufnr = vim.api.nvim_get_current_buf()
    local task_id = vim.b.last_task_id
    if task_id ~= nil then
        local task = get_task_by_id(task_id)
        if task == nil or vim.tbl_isempty(task) then
            select_and_save(bufnr)
            return
        end
        task.autostart = true
        require("overseer").run_action(task, "restart")
    else
        select_and_save(bufnr)
    end
end

return {
    'stevearc/overseer.nvim',
    lazy = false,
    keys = {
        { "<F5>", try_run },
        { "<F6>", select_and_save }
    },
    opts = {
        strategy = {
            "toggleterm",
            hidden = false,
            auto_scroll = true,
        },
    },
    config = function(_, _opts)
        local overseer = require("overseer")
        overseer.setup(_opts)
        overseer.register_template {
            name = "shell",
            generator = function(opts, cb)
                local files = require("overseer.files")
                local scripts = vim.tbl_filter(function(filename)
                    return filename:match("%.sh$") or filename:match("%.fish$")
                end, files.list_files(opts.dir))
                local ret = {}
                for _, filename in ipairs(scripts) do
                    table.insert(ret, {
                        name = filename, -- string.format("Run \"%s\"", filename),
                        params = {
                            args = { optional = true, type = "list", delimiter = " " },
                        },
                        builder = function(params)
                            return {
                                cmd = { files.join(opts.dir, filename) },
                                args = params.args,
                                cwd = opts.dir
                            }
                        end,
                    })
                end

                cb(ret)
            end,
        }
    end,
}
