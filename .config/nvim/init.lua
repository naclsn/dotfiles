vim.cmd.so '~/.vimrc'

vim.notify(vim.fn.system({'/bin/sh'}, [[set -e
  sitepackages=~/.local/share/nvim/site/pack/ages/start
  mkdir -p $sitepackages; cd $sitepackages
  [ -d nvim-lspconfig ] || git clone --depth 1 https://github.com/neovim/nvim-lspconfig
]]))


--vim.lsp.set_log_level("trace")

for it, conf in pairs {
    ansiblels= {
        -- npm i -g @ansible/ansible-language-server
        --filetypes= { 'yaml', 'yaml.ansible' },
        settings= { ansible= { validation= { enabled= false } } },
    },
    basedpyright= { settings= { basedpyright= { analysis= { diagnosticSeverityOverrides= {
        -- pip install basedpyright
        reportAny= 'none',
        reportConstantRedefinition= 'warning',
        reportDeprecated= 'information',
        reportExplicitAny= 'none',
        reportImplicitOverride= 'information',
        reportImplicitRelativeImport= 'warning',
        reportImplicitStringConcatenation= 'warning',
        reportIncompatibleVariableOverride= 'warning',
        reportMissingModuleSource= 'warning',
        reportMissingParameterType= 'warning',
        reportMissingTypeStubs= 'warning',
        reportOptionalCall= 'warning',
        reportOptionalMemberAccess= 'warning',
        reportOptionalSubscript= 'warning',
        reportPrivateUsage= 'warning',
        reportTypeCommentUsage= 'information',
        reportUnannotatedClassAttribute= 'none',
        reportUninitializedInstanceVariable= 'none',
        reportUnknownArgumentType= 'warning',
        reportUnknownLambdaType= 'warning',
        reportUnknownParameterType= 'warning',
        reportUnreachable= 'unreachable',
        reportUnusedVariable= 'warning',
        reportUnusedCallResult= 'none',
        reportUnusedExpression= 'none',
        reportUnusedImport= 'warning',
        reportUnusedParameter= 'warning',
        reportWildcardImportFromLibrary= 'information',
    } } } } },
    clangd= {},
    jdtls= {},
    lua_ls= {}, -- https://github.com/LuaLS/lua-language-server/releases/
    rust_analyzer= { --[[settings= { ['rust-analyzer']= { procMacro= { enable= false } } }]] },
    ts_ls= {}, -- npm i -g typescript typescript-language-server
    zls= {},
} do require('lspconfig')[it].setup(conf) end

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_user_command('LspDiagnostics', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, {})

vim.api.nvim_create_autocmd('LspAttach', {
    group= vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback= function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        if '' == vim.api.nvim_eval('maparg("gqq")')
            then vim.keymap.set('n', 'gqq', vim.lsp.buf.format, opts)
        end

        vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<space>a', vim.lsp.buf.code_action, opts)

        vim.keymap.set('n', '<space>=', vim.lsp.buf.format, opts)
    end,
})




-- -

vim.g.zig_fmt_autosave = 0

-- https://github.com/neovim/neovim/issues/30985
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802
            then return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end
