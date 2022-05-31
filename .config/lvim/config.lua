vim.keymap.set("n", "<C-c>", ":q<cr>")
vim.keymap.set("n", "<C-s>", ":w<cr>")
vim.g['do_filetype_lua'] = 1
local function with(may, try, nop) return may and try(may) or nop end -- YYY: maybe better off with a proxy approach
with(lvim, function(lvim)
  lvim.log.level = "warn"
  lvim.format_on_save = false
  lvim.builtin.autopairs.active = false
  lvim.builtin.nvimtree.show_icons.git = 0
  lvim.builtin.cmp.completion.keyword_length = 4
  -- TODO: comment ./.local/share/lunarvim/lvim/lua/lvim/core/nvimtree.lua:163
end)
-- added language support (REM/TODO: .config/lvim/queries)
with(require "nvim-treesitter.parsers", function(parsers)
  local parser_config = parsers.get_parser_configs()
  local function setup(name, repo)
    parser_config[name] = { install_info = { url=repo, branch="main", files={"src/parser.c"}, requires_generate_from_grammar=false } }
    vim.filetype.add { extension = { [name]=name } }
  end
  setup("nmp", "https://github.com/PictElm/tree-sitter-nmp.git")
  setup("nasm", "https://github.com/PictElm/tree-sitter-nasm.git")
end)
