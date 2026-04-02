-- nvim-treesitter manages parser installation.
-- Highlighting, folding, indent are built into Neovim.

-- Install parsers on first run
local parsers = {
  "bash", "c", "css", "diff", "go", "gomod", "gosum", "gowork",
  "html", "javascript", "jsdoc", "json", "lua", "luadoc",
  "luap", "markdown", "markdown_inline", "python", "query", "regex",
  "toml", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml",
}

local installed = require("nvim-treesitter").get_installed()
local installed_set = {}
for _, p in ipairs(installed) do
  installed_set[p] = true
end

local to_install = {}
for _, p in ipairs(parsers) do
  if not installed_set[p] then
    table.insert(to_install, p)
  end
end

if #to_install > 0 then
  require("nvim-treesitter").install(to_install)
end
