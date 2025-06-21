local function get_task(id)
    local tasks = require("overseer").list_tasks()
    for _, t in ipairs(tasks) do
        if t.id == id then
            return t
        end
    end
    return nil
end
local function try_run()
    local bufnr = vim.api.nvim_get_current_buf()
    local task_id = vim.b.last_task_id
    if task_id ~= nil then
        require("overseer").run_template(get_task(task_id))
    else
        require("overseer").run_template("", function(task)
            vim.b[bufnr].last_task_id = task.id
        end)
    end
end
return {
    'stevearc/overseer.nvim',
    keys = {
        { "<F5>", try_run },
        { "<F6>", "<cmd>OverseerRun<cr>" }
    },
    opts = {
    },
    config = function(_, _opts)
        local overseer = require("overseer")
        overseer.setup(_opts)
        overseer.register_template({
            generator = function(opts, cb)
                local files = require("overseer.files")
                local scripts = vim.tbl_filter(function(filename)
                    return filename:match("%.sh$") or filename:match("%.fish$")
                end, files.list_files(opts.dir))
                local ret = {}
                for _, filename in ipairs(scripts) do
                    table.insert(ret, {
                        name = filename,
                        params = {
                            args = { optional = true, type = "list", delimiter = " " },
                        },
                        builder = function(params)
                            return {
                                cmd = { files.join(opts.dir, filename) },
                                args = params.args,
                            }
                        end,
                    })
                end

                cb(ret)
            end,
        })
    end,
}
