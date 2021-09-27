local utils = require('utils')

-- normal mode mappings
utils.map('n', ',Y', '"*y')
utils.map('n', ',P', '"*p')
utils.map('n', ',y', '"+y')
utils.map('n', ',p', '"+p')
utils.map('n', ',bn', ':bNext<cr>')
utils.map('n', ',bp', ':bPrevious<cr>')
utils.map('n', ',tt', ':term<cr>')
utils.map('n', ',eq', ':lua require("nabla").action()<cr>')

utils.map('n', ',cm', ':Com ')
utils.map('n', 'cu', ':Unc ')
--utils.map('n', 'gt', ':tabn<CR>')
--utils.map('n', 'gT', ':tabp<CR>')
--utils.map('n', 'gN', 'tabnew<CR>')

-- visual mode mappings
utils.map('v', ',Y', '"*y')
utils.map('v', ',P', '"*p')
utils.map('v', ',y', '"+y')
utils.map('v', ',p', '"+p')

-- insert mode mappings
--utils.map('i', '"', '""<left>')
--utils.map('i', '\'', '\'\'<left>')
--utils.map('i', '(', '()<left>')
--utils.map('i', '[', '[]<left>')
--utils.map('i', '{', '{}<left>')
utils.map('i', 'jj', '<Esc>')

-- terminal mode mappings
--utils.map('t', '<Esc>', '<C-\><C-n>')


