local map = vim.keymap.set

return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        ft = { 'java', 'python', 'go', },
        config = function()
            local dap = require('dap')
            local widgets = require('dap.ui.widgets')
            local dbg = require('util.debug')

            require("nvim-dap-virtual-text").setup()

            dap.adapters.coreclr = {
                type = 'executable',
                command = '/usr/lib/netcoredbg/netcoredbg',
                args = { '--interpreter=vscode' }
            }
            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                },
            }
            dap.adapters.python = {
                type = 'executable',
                command = 'python3',
                args = {'-m', 'debugpy.adapter'}
            }
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function() return '/usr/bin/python3' end,
                },
            }

            -- https://microsoft.github.io/debug-adapter-protocol/specification#Events
            local sidebar = nil
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dbg.openRepl()
                sidebar = widgets.sidebar(widgets.scopes)
                sidebar.open()
            end
            dap.listeners.before.event_stopped['dapui_config'] = function()
                print('Debug session stopped')
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                print('Debug session terminated')
                if sidebar then
                    sidebar.close()
                end
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                print('Debug session exited')
                if sidebar then
                    sidebar.close()
                end
            end

            -- breakpoints
            vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = 'DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '🔵', texthl = '', linehl = '', numhl = 'DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointRejected', { text = '◯', texthl = '', linehl = '', numhl = 'DapBreakpoint' })
            vim.fn.sign_define('DapLogPoint', { text = '⚪️', texthl = '', linehl = '', numhl = 'DapLogPoint' })
            vim.fn.sign_define('DapStopped', { text = '🟡', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

            -- persist breakpoints
            dbg.loadBreakpoints() -- load on startup
            vim.api.nvim_create_autocmd('VimLeavePre', { -- save on leave
                desc = 'Save breakpoints',
                callback = dbg.saveBreakpoints,
            })
            map("n", "<leader>dP", dbg.saveBreakpoints, { desc = "Save breakpoints to file" })

            -- breakpoints
            map("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
            map("n", "<leader>dc", dbg.setConditionalBreakpoint, { desc = "Set conditional breakpoint" })
            map("n", "<leader>dl", dbg.setLoggingBreakpoint, { desc = "Set logging breakpoint" })
            map("n", "<leader>dh", dbg.setHitCountBreakpoint, { desc = "Set hit count breakpoint" })
            map("n", "<leader>dp", dbg.listBreakpoints, { desc = "List breakpoints" })
            map("n", "<leader>dC", dap.clear_breakpoints, { desc = "Clear all breakpoints" })

            -- view
            map({"n", "v"}, "<M-p>", dbg.floatExpr, { desc = "Evaluate expression" })
            map("n", "<leader>dv", function() widgets.centered_float(widgets.scopes) end, { desc = "Scope variables" })
            map("n", "<leader>df", function() widgets.centered_float(widgets.frames) end, { desc = "Frames" })
            map("n", "<leader>dR", dbg.openRepl, { desc = "Open repl" })
            map("n", "<leader>dq", dbg.closeView, { desc = "Close opened view" })

            -- debugging controls
            map("n", "<M-d>", dbg.readConfigAndDebug, { desc = "Load launch.json and debug" })
            map("n", "<M-r>", dap.continue, { desc = "Debug continue" })
            map("n", "<M-a>", dap.run_last, { desc = "Rerun last debug" })
            map("n", "<M-n>", dap.step_over, { desc = "Debug step over" })
            map("n", "<M-i>", dap.step_into, { desc = "Debug step into" })
            map("n", "<M-o>", dap.step_out, { desc = "Debug step out" })
            map("n", "<leader>ds", dap.terminate, { desc = "Terminate" })
            map("n", "<leader>dr", dap.restart_frame, { desc = "Restart frame" })
        end
    },
    { 'theHamsta/nvim-dap-virtual-text', lazy = true },
    {
        'mfussenegger/nvim-dap-python',
        lazy = true,
        ft = { 'py' },
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
        end
    },
    {
        'leoluz/nvim-dap-go',
        lazy = true,
        ft = { 'go' },
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            -- go
            require('dap-go').setup {
                dap_configurations = {
                    {
                        -- Must be "go" or it will be ignored by the plugin
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                -- delve configurations
                delve = {
                    args = {},
                    -- the build flags that are passed to delve.
                    -- defaults to empty string, but can be used to provide flags
                    -- such as "-tags=unit" to make sure the test suite is
                    -- compiled during debugging, for example.
                    -- passing build flags using args is ineffective, as those are
                    -- ignored by delve in dap mode.
                    build_flags = "",
                },
            }
        end
    },
}

