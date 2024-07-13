local status_ok, whichkey = pcall(require, "which-key")

if not status_ok then
    return
end

whichkey.setup({})

whichkey.add({ '<leader>g', group = 'Git' })
whichkey.add({ '<leader>f', group = 'Telescope' })
whichkey.add({ '<leader>c', group = 'Quickfix' })
whichkey.add({ '<leader>d', group = 'Debug' })
whichkey.add({ '<leader>l', group = 'LSP', icon = '🧠' })
whichkey.add({ '<leader>o', group = 'Options', icon = '⚙️' })

