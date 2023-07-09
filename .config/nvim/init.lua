vim.cmd.so '~/.vimrc'

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
end)

for _, it in pairs {
    'clangd',
    --'mono-omni-sharp',
    'elmls',
    'erlangls',
    'jdtls',
    'tsserver',
    --'lua_ls',
    --'nim_langserver',
    'pylsp',
    'rust_analyzer',
    'zls',
} do require('lspconfig')[it].setup {} end
