local r = require('util.registers')
local b = require('util.buffers')
local map = vim.keymap.set

map("n", "<leader>ft", b.list_terminals_in_quickfix, { desc = "List terminals" })
map("n", "<leader>rs", r.promptAndSwap, { desc = "Swap registers" })

map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })

-- LSP
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })

local startMark = 'S'
map("n", "<C-]>", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "gr", function() r.markAndDo(startMark, function() vim.lsp.buf.references({ includeDeclaration = false }) end) end, { desc = "References" })
map("n", "gi", function() r.markAndDo(startMark, vim.lsp.buf.implementation) end, { desc = "Implementations" })
map("n", "gT", function() r.markAndDo(startMark, vim.lsp.buf.type_definition) end, { desc = "Type definitions" })
map("n", "gh", function() r.markAndDo(startMark, vim.lsp.buf.typehierarchy) end, { desc = "Type hierarchy" })

map("n", "<leader>le", function() r.markAndDo(startMark, vim.diagnostic.open_float) end, { desc = "Inline diagnostics" })
map("n", "<leader>lE", function() r.markAndDo(startMark, vim.diagnostic.setqflist) end, { desc = "Workspace diagnostics" })

