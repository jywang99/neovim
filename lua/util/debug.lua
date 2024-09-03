local persist = require('util.persist')

local M = {}

local BP_FILE = persist.getPersistPath() .. '/breakpoints.json'

function M.saveBreakpoints()
    vim.notify('Saving breakpoints', 'info', { title = 'DAP' })
    if not persist.persistPathExists() then
        return
    end

    -- get breakpoints table
    local breakpoints_by_buf = require("dap.breakpoints").get()
    local breakpoints_by_file = {}
    local any = false
    for buf, buf_bps in pairs(breakpoints_by_buf) do
        if #buf_bps > 0 then
            any = true
        end
        breakpoints_by_file[vim.api.nvim_buf_get_name(buf)] = buf_bps
    end

    -- if no breakpoints
    if not any then
        -- if file exists delete it
        if vim.fn.filereadable(BP_FILE) == 1 then
            os.remove(BP_FILE)
        end
        return
    end

    -- if doesn't exist create json file
    if vim.fn.filereadable(BP_FILE) == 0 then
        os.execute("touch " .. BP_FILE)
    end

    -- write breakpoints as json
    local fp = io.open(BP_FILE, "w")
    if fp == nil then
        print "Error opening file"
        return
    end
    local final = vim.fn.json_encode(breakpoints_by_file)
    fp:write(final)

    vim.notify('Breakpoints saved', 'info', { title = 'DAP' })
end

function M.loadBreakpoints()
    local fp = io.open(BP_FILE, "r")
    if fp == nil then
        return
    end

    local content = fp:read "*a"
    if content == "" then
        return
    end

    local bps = vim.fn.json_decode(content)
    local loaded_buffers = {}
    local found = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local file_name = vim.api.nvim_buf_get_name(buf)
        if bps[file_name] ~= nil and bps[file_name] ~= {} then
            found = true
        end
        loaded_buffers[file_name] = buf
    end
    if found == false then
        return
    end
    for path, buf_bps in pairs(bps) do
        for _, bp in pairs(buf_bps) do
            local line = bp.line
            local opts = {
                condition = bp.condition,
                log_message = bp.logMessage,
                hit_condition = bp.hitCondition,
            }
            require("dap.breakpoints").set(opts, tonumber(loaded_buffers[path]), line)
        end
    end
end

-- launch.json
local LAUNCH_JSON = persist.getPersistPath() .. '/launch.json'
function M.readConfigAndDebug()
    local vscode = require('dap.ext.vscode')
    local dap = require('dap')

    if vim.fn.filereadable(LAUNCH_JSON) == 0 then
        print('No launch.json found')
        return
    end
    vscode.load_launchjs(LAUNCH_JSON, {})
    dap.continue()
end

-- breakpoint actions
function M.setConditionalBreakpoint()
    local deleted_line = vim.fn.getline(vim.fn.line('.'))
    vim.cmd('normal! dd')
    require('dap').set_breakpoint(deleted_line)
end

function M.setLoggingBreakpoint()
    local exp = vim.fn.input("Log message (interpolation with {foo}): ")
    require('dap').set_breakpoint(nil, nil, exp)
end

function M.setHitCountBreakpoint()
    local times = vim.fn.input("Times: ")
    local numTimes = tonumber(times)
    if not numTimes then
        print('Invalid argument, number expected!')
        return
    end
    require('dap').set_breakpoint(nil, nil, times)
end

function M.listBreakpoints()
    require('dap').list_breakpoints()
    vim.cmd('copen')
end

return M
