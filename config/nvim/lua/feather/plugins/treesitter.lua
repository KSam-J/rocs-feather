return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        -- nvim-treesitter main branch uses a new API (no more nvim-treesitter.configs)
        -- Highlighting is now handled natively by Neovim via FileType autocommands
        require("nvim-treesitter").setup()

        -- Install required parsers
        require("nvim-treesitter").install({
            "json",
            "javascript",
            "yaml",
            "html",
            "css",
            "markdown",
            "markdown_inline",
            "bash",
            "lua",
            "vim",
            "dockerfile",
            "gitignore",
            "query",
            "vimdoc",
            "c",
            "cpp",
            "python",
        })

        -- Enable treesitter highlighting and indentation per filetype
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "json", "javascript", "yaml", "html", "css",
                "markdown", "bash", "lua", "vim", "dockerfile",
                "gitignore", "query", "vimdoc", "c", "cpp", "python",
            },
            callback = function()
                vim.treesitter.start()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        -- Incremental selection keymaps
        vim.keymap.set("n", "<C-space>", function()
            require("nvim-treesitter.incremental_selection").init_selection()
        end, { desc = "TS init selection" })

        -- autotag setup (nvim-ts-autotag handles its own integration)
        require("nvim-ts-autotag").setup()
    end,
}
