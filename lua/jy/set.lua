vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*" },
    command = "setlocal ts=4 sts=4 sw=4 expandtab",
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.html", "*.svelte", "*.yml", "*.yaml" },
    command = "setlocal ts=2 sts=2 sw=2",
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.man" },
    command = "setlocal ft=man relativenumber number",
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "Makefile" },
    command = "setlocal noexpandtab",
})

vim.filetype.add({
    pattern = {
        [".*/hypr/.*%.conf"] = "hyprlang",
        [".*.rasi"] = "rasi",
    },
})

-- appearance
vim.opt.laststatus = 3

-- backups
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"

