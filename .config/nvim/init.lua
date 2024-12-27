vim.cmd.so '~/.vimrc'

-- TODO: (#1229) swich over to lazy, or other, or plain (most likely)
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    --use 'nvim-treesitter/nvim-treesitter'
end)

--[[require('nvim-treesitter.configs').setup {
    ensure_installed= 'all',
    sync_install= false,
    auto_install= true,
    highlight= {
        enable= true,
        additional_vim_regex_highlighting= false,
    },
}
vim.cmd.hi 'link @punctuation NormalNC']]

--do return end

--vim.lsp.set_log_level("trace")

for it, conf in pairs {
    clangd= {},
    elmls= {},
    erlangls= {},
    jdtls= {},
    ts_ls= {},
    lua_ls= {},
    nim_langserver= {},
    basedpyright= { settings= { basedpyright= { analysis= { diagnosticSeverityOverrides= {
        reportAny= 'none',
        reportDeprecated= 'information',
        reportExplicitAny= 'none',
        reportImplicitOverride= 'information',
        reportImplicitRelativeImport= 'warning',
        reportImplicitStringConcatenation= 'warning',
        reportIncompatibleVariableOverride= 'warning',
        reportMissingModuleSource= 'warning',
        reportMissingTypeStubs= 'warning',
        reportOptionalCall= 'warning',
        reportOptionalMemberAccess= 'warning',
        reportOptionalSubscript= 'warning',
        reportPrivateUsage= 'warning',
        reportTypeCommentUsage= 'information',
        reportUnannotatedClassAttribute= 'none',
        reportUninitializedInstanceVariable= 'none',
        reportUnreachable= 'unreachable',
        reportUnusedCallResult= 'none',
        reportUnusedExpression= 'none',
        reportWildcardImportFromLibrary= 'information',
    } } } } },
    rust_analyzer= { settings= { ['rust-analyzer']= { procMacro= { enable= false } } } },
    ruby_lsp= {},
    zls= {},
} do require('lspconfig')[it].setup(conf) end

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
    group= vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback= function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- whever, I hate nvim anyways
        if 'rust' == vim.bo[ev.buf].ft
          then vim.keymap.set('n', 'gq', vim.lsp.buf.format, opts)
        end

        vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<space>a', vim.lsp.buf.code_action, opts)

        vim.keymap.set('n', '<space>=', vim.lsp.buf.format, opts)
    end,
})

vim.g.zig_fmt_autosave = 0
