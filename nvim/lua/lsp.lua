local lsp = require'lspconfig'
local utils = require'utils'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
-- lsp config

lsp.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
 }
--lsp.pylsp.setup{}
lsp.clangd.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}
lsp.html.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}
lsp.tsserver.setup{}
lsp.angularls.setup{}
lsp.cssls.setup { capabilities = capabilities }
lsp.arduino_language_server.setup({
  cmd = {
  "arduino-language-server", 
  "-cli-config", "~/.arduino15/arduino-cli.yaml" , 
  "-fqbn", 'arduino:avr:nano'
  },
  capabilities = capabilities
})
-- lsp.efm.setup{
--   init_options = {documentFormatting = true},
--   settings = {
--     rootMarkers = {".git/"},
--     languages = {
--       lua = {formatCommand = "lua-format -i", formatStdin = true},
--       python = {completion = true, codeAction = true}
--     }
--   },
--   filetypes = { 'python', 'lua'}
--}

--lsp.vuels.setup{}
--lsp.nlua.setup{}
-- require("nlua.lsp.nvim").setup(require("lspconfig"), {
--   on_attach = on_attach,
--   globals = {
--     "Color", "c", "Group", "g", "s",
--   }
-- })

-- omnisharp

local pid = vim.fn.getpid()
local omnisharp_bin = "/usr/bin/omnisharp"

require'lspconfig'.omnisharp.setup{
  cmd = { omnisharp_bin, "-lsp", "-hpid", tostring(pid)};
}
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
  opts = opts or {}

  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
  if vim.tbl_isempty(line_diagnostics) then return end

  local diagnostic_message = ""
  for i, diagnostic in ipairs(line_diagnostics) do
    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    print(diagnostic_message)
    if i ~= #line_diagnostics then
      diagnostic_message = diagnostic_message .. "\n"
    end
  end
  vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end

vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

-- compe comfig

vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = true;
    luasnip = false;
  };
}

-- autopairs
require('nvim-autopairs').setup()
require('nvim-autopairs.completion.compe').setup({
  map_cr = true,
  map_complete = true
})

-- functions
-- Utility functions for compe and luasnip
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menu
--- jump to prev/next snippet's placeholder
--local luasnip = require 'luasnip'

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  --elseif luasnip.expand_or_jumpable() then
  --  return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else 
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  --elseif luasnip.jumpable(-1) then
  --  return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

-- Map tab to the above tab complete functions
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })

