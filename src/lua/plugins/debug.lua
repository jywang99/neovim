local map = vim.keymap.set
local debugees =  { 'java', 'python', 'go', }

return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        ft = debugees,
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

            local function float_scopes()
                widgets.cursor_float(widgets.scopes) -- TODO preferably preview
            end

            -- https://microsoft.github.io/debug-adapter-protocol/specification#Events
            dap.listeners.after.event_initialized['dapui_config'] = function()
                print('Debug session started')
            end
            dap.listeners.before.event_stopped['dapui_config'] = function()
                print('Debug session stopped')
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                print('Debug session terminated')
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                print('Debug session exited')
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
            map({"n", "v"}, "<M-p>", widgets.hover, { desc = "Evaluate expression" })
            map("n", "<M-s>", float_scopes, { desc = "Scope variables" })
            map("n", "<leader>df", function() widgets.cursor_float(widgets.frames) end, { desc = "Frames" })
            map("n", "<leader>dR", dap.repl.open, { desc = "Open repl" })

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
    {
        'jay-babu/mason-nvim-dap.nvim',
        lazy = true,
        ft = debugees,
        dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
        config = function()
            require('mason-nvim-dap').setup({
                ensure_installed = { 'python', 'javadbg', 'javatest', 'delve' },
            })
        end
    },
    { 'theHamsta/nvim-dap-virtual-text', lazy = true },

    -- languages
    {
        'mfussenegger/nvim-dap-python',
        lazy = true,
        ft = { 'python' },
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require('dap-python').setup('python')
        end
    },
    {
        'leoluz/nvim-dap-go',
        lazy = true,
        ft = { 'go' },
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require('dap-go').setup()
        end
    },
}

