local v = vim

local r = require('util.registers')
local b = require('util.buffers')
local map = v.keymap.set

map("n", "<leader>ft", b.list_terminals_in_quickfix, { desc = "List terminals" })
map("n", "<leader>rs", r.promptAndSwap, { desc = "Swap registers" })

map("n", "[d", function() v.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
map("n", "]d", function() v.diagnostic.goto_next() end, { desc = "Next diagnostic" })

-- LSP
map("n", "<leader>lr", v.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>la", v.lsp.buf.code_action, { desc = "Code actions" })

-- disable default LSP mappings
v.keymap.del("n", "gra")
v.keymap.del("n", "grn")
v.keymap.del("n", "grt")
v.keymap.del("n", "gri")
v.keymap.del("n", "grr")

local startMark = 'S'
map("n", "<C-]>", v.lsp.buf.definition, { desc = "Definition" })
map("n", "gu", function() r.markAndDo(startMark, function() v.lsp.buf.references({ includeDeclaration = false }) end) end, { desc = "References" })
map("n", "gI", function() r.markAndDo(startMark, v.lsp.buf.implementation) end, { desc = "Implementations" })
map("n", "gT", function() r.markAndDo(startMark, v.lsp.buf.type_definition) end, { desc = "Type definitions" })
map("n", "gh", function() r.markAndDo(startMark, v.lsp.buf.typehierarchy) end, { desc = "Type hierarchy" })

map("n", "<leader>le", function() r.markAndDo(startMark, v.diagnostic.open_float) end, { desc = "Inline diagnostics" })
map("n", "<leader>lE", function() r.markAndDo(startMark, v.diagnostic.setqflist) end, { desc = "Workspace diagnostics" })

