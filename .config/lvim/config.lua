local function nop(_) return _ end
local function have(a) return a or setmetatable({}, {__index=nop, __call=nop}) end
local vim, lvim = have(vim), have(lvim)
vim.keymap.set("n", "<C-c>", ":q<cr>")
vim.keymap.set("n", "<C-s>", ":w<cr>")
vim.g.do_filetype_lua = 1
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.builtin.autopairs.active = false
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.cmp.completion.keyword_length = 4
lvim.plugins = {
  "tpope/vim-surround",
  keys={"c", "d", "y"},
}
-- added language support (REM/TODO: .config/lvim/queries)
local parser_config = have(nil and require "nvim-treesitter.parsers").get_parser_configs()
local function ts_grammar(repo, name, branch)
  name = name or ({string.find(repo, "(.-.)tree[-]sitter[-](%a+)[.]git")})[4]
  parser_config[""..name] = { install_info = { url=repo, branch=branch or "main", files={"src/parser.c"}, requires_generate_from_grammar=false } }
  vim.filetype.add { extension = {[name]=name} }
end
ts_grammar "https://github.com/PictElm/tree-sitter-nmp.git"
ts_grammar "https://github.com/PictElm/tree-sitter-nasm.git"
