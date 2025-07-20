local M = {}
local rime_ls_filetypes = { 'markdown' }

function M.setup_rime()
    -- global status
    vim.g.rime_enabled = false

    -- update lualine
    local function rime_status()
        if vim.g.rime_enabled then
            return 'ㄓ'
        else
            return ''
        end
    end

    require('lualine').setup({
        sections = {
            lualine_x = { rime_status, 'copilot', 'encoding', 'fileformat', 'filetype' },
        }
    })

    -- add rime-ls to lspconfig as a custom server
    -- see `:h lspconfig-new`
    local lspconfig = require('lspconfig')
    local configs = require('lspconfig.configs')
    if not configs.rime_ls then
        configs.rime_ls = {
            default_config = {
                name = "rime_ls",
                cmd = { 'rime_ls' },
                filetypes = rime_ls_filetypes,
                single_file_support = true,
            },
            settings = {},
            docs = {
                description = [[
https://www.github.com/wlh320/rime-ls

A language server for librime
]],
            }
        }
    end

    local rime_on_attach = function(client, _)
        vim.api.nvim_create_user_command('RimeToggle', function()
            client.request('workspace/executeCommand',
                { command = "rime-ls.toggle-rime" },
                function(_, result, ctx, _)
                    if ctx.client_id == client.id then
                        vim.g.rime_enabled = result
                    end
                end
            )
        end, { nargs = 0 })
        -- keymaps for executing command
        -- vim.keymap.set('n', '<leader>rs', function() vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" }) end)
    end

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    lspconfig.rime_ls.setup {
        init_options = {
            enabled = vim.g.rime_enabled,
            shared_data_dir = "/usr/share/rime-data",
            user_data_dir = vim.fn.expand "~/.local/share/rime-ls",
            log_dir = vim.fn.expand "~/.local/share/rime-ls",
            paging_characters = {},
            trigger_characters = {},
            schema_trigger_character = "&",
            -- TODO: check this configuration
            -- this seems no need for blink
            -- max_token = 4,
            always_incomplete = true,
            long_filter_text = true
        },
        on_attach = rime_on_attach,
        capabilities = capabilities,
    }

    vim.api.nvim_create_autocmd('FileType', {
        pattern = rime_ls_filetypes,
        callback = function(env)
            -- copilot cannot attach client automatically, we must attach manually.
            local rime_ls_client = vim.lsp.get_clients({ name = 'rime_ls' })
            if #rime_ls_client == 0 then
                vim.cmd('LspStart rime_ls')
                rime_ls_client = vim.lsp.get_clients({ name = 'rime_ls' })
            end
            if #rime_ls_client > 0 then
                vim.lsp.buf_attach_client(env.buf, rime_ls_client[1].id)
            end
        end
    })
end

local function contains_unacceptable_character(content)
    if content == nil then return true end
    local ignored_head_number = false
    for i = 1, #content do
        local b = string.byte(content, i)
        if b >= 48 and b <= 57 or b == 32 or b == 46 then
            -- number dot and space
            if ignored_head_number then
                return true
            end
        elseif b <= 127 then
            return true
        else
            ignored_head_number = true
        end
    end
    return false
end

local function is_rime_item(item)
    if item == nil or item.source_name ~= 'LSP' then return false end
    local client = vim.lsp.get_client_by_id(item.client_id)
    return client ~= nil and client.name == 'rime_ls'
end

--- @param item blink.cmp.CompletionItem
local function rime_item_acceptable(item)
    -- return true
    return
        not contains_unacceptable_character(item.label)
        or
        item.label:match("%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d%")
end

local function get_n_rime_item_index(n, items)
    if items == nil then
        items = require('blink.cmp.completion.list').items
    end
    local result = {}
    if items == nil or #items == 0 then
        return result
    end
    for i, item in ipairs(items) do
        if is_rime_item(item) and rime_item_acceptable(item) then
            result[#result + 1] = i
            if #result == n then
                break;
            end
        end
    end
    return result
end

-- auto upload when there is only one rime item after inputting a number
require('blink.cmp.completion.list').show_emitter:on(function(event)
    if not vim.g.rime_enabled then return end
    local col = vim.fn.col('.') - 1
    if event.context.line:sub(col, col):match("%d") == nil then return end
    local rime_item_index = get_n_rime_item_index(2, event.items)
    if #rime_item_index ~= 1 then return end
    require('blink.cmp').accept({ index = rime_item_index[1] })
end)

return M
