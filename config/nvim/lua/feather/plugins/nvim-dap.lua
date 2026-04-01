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
        }

        -- C++ shares C configs
        dap.configurations.cpp = dap.configurations.c

        -- Keymaps (all under <leader>d)
        local keymap = vim.keymap
        keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
        keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "DAP conditional breakpoint" })
        keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP continue / start" })
        keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP step into" })
        keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP step over" })
        keymap.set("n", "<leader>dO", dap.step_out, { desc = "DAP step out" })
        keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP open REPL" })
        keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP run last" })
        keymap.set("n", "<leader>dt", dapui.toggle, { desc = "DAP toggle UI" })
        keymap.set("n", "<leader>dx", dap.terminate, { desc = "DAP terminate" })
    end,
}
