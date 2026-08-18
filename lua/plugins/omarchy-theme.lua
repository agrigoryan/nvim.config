-- Keep Neovim in sync with Omarchy's current desktop theme.
local theme_dir = vim.fn.expand("~/.local/state/omarchy/current/theme")
local theme_file = theme_dir .. "/neovim.lua"
local state_dir = vim.fn.expand("~/.local/state/omarchy/current")
local last_theme

local function plugin_module(spec)
  local repo = spec[1] or ""
  local tail = repo:match("/([^/]+)$") or repo
  local candidates = {
    spec.name,
    tail:gsub("%.nvim$", ""),
    tail:gsub("%-nvim$", ""),
    tail:gsub("^nvim%-", ""),
  }

  for _, name in ipairs(candidates) do
    if name and name ~= "" then
      local ok, mod = pcall(require, name)
      if ok and type(mod.setup) == "function" then
        return mod
      end
    end
  end
end

local function collect_plugin(spec, result)
  for _, dependency in ipairs(spec.dependencies or {}) do
    if type(dependency) == "string" then
      dependency = { dependency }
    end
    collect_plugin(dependency, result)
  end

  if spec[1] and spec[1] ~= "LazyVim/LazyVim" then
    table.insert(result, {
      src = "https://github.com/" .. spec[1],
      name = spec.name,
      version = spec.branch or spec.version,
    })
  end
end

local function apply_theme()
  local ok, specs = pcall(dofile, theme_file)
  if not ok or type(specs) ~= "table" then
    vim.notify("Could not load Omarchy's Neovim theme: " .. tostring(specs), vim.log.levels.WARN)
    return
  end

  local plugins = {}
  local colorscheme
  for _, spec in ipairs(specs) do
    if spec[1] == "LazyVim/LazyVim" then
      colorscheme = spec.opts and spec.opts.colorscheme
    else
      collect_plugin(spec, plugins)
    end
  end

  if #plugins > 0 then
    vim.pack.add(plugins, { confirm = false })
  end

  for _, spec in ipairs(specs) do
    if spec[1] ~= "LazyVim/LazyVim" and spec.opts then
      local mod = plugin_module(spec)
      if mod then
        mod.setup(spec.opts)
      end
    end
  end

  if colorscheme then
    local applied, err = pcall(vim.cmd.colorscheme, colorscheme)
    if not applied then
      vim.notify("Could not apply Omarchy colorscheme " .. colorscheme .. ": " .. err, vim.log.levels.WARN)
    end
  end
end

local function current_theme()
  local name_file = state_dir .. "/theme.name"
  local lines = vim.fn.readfile(name_file, "", 1)
  return lines[1]
end

local function refresh_if_changed()
  local theme = current_theme()
  if theme and theme ~= last_theme then
    last_theme = theme
    apply_theme()
  end
end

refresh_if_changed()

-- Omarchy atomically replaces the theme directory, then updates theme.name.
-- Watch its parent so already-running Neovim instances update too.
local watcher = vim.uv.new_fs_event()
if watcher then
  watcher:start(state_dir, {}, vim.schedule_wrap(function(err, filename)
    if not err and (not filename or filename == "theme.name") then
      vim.defer_fn(refresh_if_changed, 100)
    end
  end))
  _G.omarchy_theme_watcher = watcher
end

return {}
