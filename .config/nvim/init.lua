vim.cmd.so '~/.vimrc'

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
end)

require('lspconfig/configs')['my_mono_omni_sharp'] = {
    default_config = {
        cmd = { '/home/sel/Public/OmniSharp/omnisharp-mono/OmniSharp.exe', '--languageserver' },
        filetypes = 'csharp',
        root_dir = require('lspconfig/util').path.dirname,
    },
    docs = {
        description = 'please work, thanks',
        default_config = { root_dir = 'root_pattern(".git")' },
    },
}

for _, it in pairs {
    'clangd',
    'my_mono_omni_sharp',
    'elmls',
    'erlangls',
    'jdtls',
    'tsserver',
    'lua_ls',
    'nim_langserver',
    'pylsp',
    'rust_analyzer',
    'zls',
} do require('lspconfig')[it].setup {} end
