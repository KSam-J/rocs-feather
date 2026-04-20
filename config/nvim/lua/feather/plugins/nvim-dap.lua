return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- auto-install cppdbg (MS C++ debug adapter with GDB support)
        require("mason-nvim-dap").setup({
            ensure_installed = { "cppdbg" },
            handlers = {},
        })

        require("nvim-dap-virtual-text").setup()

        dapui.setup()

        -- auto open/close the UI with debug sessions
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- cppdbg adapter (installed by mason into its bin/ dir)
        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
        }

        -- Read optional per-project debug config from .dap.json in the cwd.
        -- Example .dap.json for an STM32 project:
        --   {
        --     "program": "build/Debug/myproject.elf",
        --     "miDebuggerPath": "/usr/bin/arm-none-eabi-gdb",
        --     "miDebuggerServerAddress": "localhost:3333"
        --   }
        local function load_dap_json()
            local path = vim.fn.getcwd() .. "/.dap.json"
            local lines = vim.fn.readfile(path)
            if #lines == 0 then return {} end
            return vim.fn.json_decode(table.concat(lines, "\n")) or {}
        end

        -- C launch config using GDB as the MI backend
        dap.configurations.c = {
            {
                name = "Launch (GDB)",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtEntry = true,
                MIMode = "gdb",
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "Enable GDB pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
            {
                -- Connects to an already-running OpenOCD GDB server.
                -- Project-specific values are loaded from .dap.json in the cwd.
                name = "Embedded: OpenOCD (remote)",
                type = "cppdbg",
                request = "launch",
                cwd = "${workspaceFolder}",
                MIMode = "gdb",
                stopAtEntry = true,
                program = function()
                    local proj = load_dap_json()
                    local default = vim.fn.getcwd() .. "/" .. (proj.program or "")
                    return vim.fn.input("ELF: ", default, "file")
                end,
                miDebuggerPath = function()
                    local proj = load_dap_json()
                    return proj.miDebuggerPath or "arm-none-eabi-gdb"
                end,
                miDebuggerServerAddress = function()
                    local proj = load_dap_json()
                    return proj.miDebuggerServerAddress or "localhost:3333"
                end,
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "Enable GDB pretty printing",
                        ignoreFailures = false,
                    },
                },
                postRemoteConnectCommands = {
                    {
                        text = "monitor reset halt",
                        description = "Reset and halt the target via OpenOCD",
                        ignoreFailures = false,
                    },
                },
            },
        }

        -- C++ shares C configs
        dap.configurations.cpp = dap.configurations.c

        -- Keymaps (all under <leader>d)
        local keymap = vim.keymap
        keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
        keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "DAP conditional breakpoint" })
        keymap.set("n", "<leader>dc", function()
            -- If a session is already running, just continue it.
            if dap.session() then
                dap.continue()
                return
            end
            -- Otherwise collect all configs across all filetypes and let the
            -- user pick one — avoids "no config for filetype X" errors when
            -- launching from oil, telescope, etc.
            local configs = {}
            for ft, ft_configs in pairs(dap.configurations) do
                for _, config in ipairs(ft_configs) do
                    table.insert(configs, { ft = ft, config = config })
                end
            end
            if #configs == 0 then
                vim.notify("No DAP configurations registered", vim.log.levels.WARN)
                return
            end
            vim.ui.select(configs, {
                prompt = "Select debug configuration:",
                format_item = function(item)
                    return string.format("[%s] %s", item.ft, item.config.name)
                end,
            }, function(choice)
                if choice then
                    dap.run(choice.config)
                end
            end)
        end, { desc = "DAP continue / start" })
        keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP step into" })
        keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP step over" })
        keymap.set("n", "<leader>dO", dap.step_out, { desc = "DAP step out" })
        keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP open REPL" })
        keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP run last" })
        keymap.set("n", "<leader>dt", dapui.toggle, { desc = "DAP toggle UI" })
        keymap.set("n", "<leader>dx", dap.terminate, { desc = "DAP terminate" })
    end,
}
