local wezterm = require("wezterm")
local mux = wezterm.mux

local config = wezterm.config_builder()

local function which(exe)
  if type(exe) ~= "string" or exe == "" then
    return nil
  end

  -- WezTerm doesn't expose `wezterm.which()` in some versions.
  -- Use a tiny shim that asks the OS to resolve PATH.
  if wezterm.target_triple and wezterm.target_triple:find("windows") then
    local ok, stdout, _ = wezterm.run_child_process({ "where", exe })
    if ok and stdout and stdout ~= "" then
      return stdout:match("([^\r\n]+)")
    end
    return nil
  end

  do
    local ok, stdout, _ = wezterm.run_child_process({ "which", exe })
    if ok and stdout and stdout ~= "" then
      return stdout:match("([^\r\n]+)")
    end
  end

  return nil
end

-- Default shell on Windows: prefer PowerShell 7 (pwsh) if installed.
if wezterm.target_triple and wezterm.target_triple:find("windows") then
  local pwsh = which("pwsh.exe") or which("pwsh")
  local powershell = which("powershell.exe") or which("powershell")
  local shell = pwsh or powershell
  if shell then
    config.default_prog = { shell, "-NoLogo" }

    local menu = {}
    if pwsh then
      table.insert(menu, { label = "PowerShell (pwsh)", args = { pwsh, "-NoLogo" } })
    end
    if powershell then
      table.insert(menu, { label = "Windows PowerShell", args = { powershell, "-NoLogo" } })
    end
    if #menu > 0 then
      config.launch_menu = menu
    end
  end
end

local function env_truthy(name, default)
  local v = os.getenv(name)
  if v == nil or v == "" then
    return default
  end
  v = tostring(v):lower()
  return (v == "1" or v == "true" or v == "yes" or v == "on")
end

-- Forward-declare so we can apply persisted bg on startup.
local apply_bg_overrides

-- Startup behavior: fullscreen/maximize
-- NOTE: On Windows 11, Acrylic/Mica can be disabled by the OS in true fullscreen.
-- For a "fullscreen-like" experience while keeping Acrylic, prefer maximize + ZEN.
-- Defaults: maximize ON, fullscreen OFF
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui = window:gui_window()

  if env_truthy("WEZTERM_START_MAXIMIZED", true) then
    gui:maximize()
  end
  -- On Windows, Acrylic/Mica + transparency can appear disabled in fullscreen
  -- depending on composition mode; maximize keeps the effect reliably.
  if env_truthy("WEZTERM_START_FULLSCREEN", false) then
    gui:toggle_fullscreen()
  end

  -- Apply persisted background selection/state (if any)
  if apply_bg_overrides then
    apply_bg_overrides(window)
  end
end)

-- =====================
-- "Neovide-like" feel
-- =====================
-- Neovide is using: Monofoki Nerd Font:h10.5
config.font = wezterm.font_with_fallback({
  "Monofoki Nerd Font",
  "Symbols Nerd Font Mono",
})
config.font_size = 10.5

-- High refresh like Neovide (120Hz)
config.max_fps = 120
config.animation_fps = 120

-- =====================
-- Windows 11 visuals
-- =====================
config.front_end = "WebGpu"

-- Pick one: "Mica" (subtle) or "Acrylic" (stronger)
-- config.win32_system_backdrop = os.getenv("WEZTERM_BACKDROP") or "Mica"
config.win32_system_backdrop = "Acrylic"

-- Transparency (tweak to taste)
-- Lower = more transparent
-- Windows Terminal-like: set overall opacity to 0.70
config.window_background_opacity = 0.30
config.text_background_opacity = 0.85
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
-- Clean window chrome
-- Zen mode: hide title bar buttons (minimize/max/close)
-- On Windows, fully borderless (NONE) can sometimes change how composition/backdrop behaves.
-- So Zen defaults to RESIZE to keep Acrylic more reliable.
-- If you truly want borderless, set WEZTERM_BORDERLESS=1.
local zen = env_truthy("WEZTERM_ZEN", false)
local borderless = env_truthy("WEZTERM_BORDERLESS", false)
config.window_decorations = (zen and borderless) and "NONE" or "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.show_new_tab_button_in_tab_bar = false

config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 8,
}

-- =====================
-- Cursor + scrolling
-- =====================
-- WezTerm doesn't have Neovide-style cursor trails/vfx, but we can make the
-- blink feel smoother.
config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "EaseInOut"
config.cursor_blink_ease_out = "EaseInOut"

-- No true scroll animation like Neovide; this is as close as WezTerm gets.
config.scrollback_lines = 20000
config.enable_scroll_bar = true

-- =====================
-- Color scheme (built-in style, but defined locally for consistency)
-- =====================
config.color_schemes = {
  ["NVIM-Mocha"] = {
    foreground = "#cdd6f4",
    background = "#11111b",
    cursor_bg = "#f5e0dc",
    cursor_fg = "#11111b",
    cursor_border = "#f5e0dc",
    selection_fg = "#cdd6f4",
    selection_bg = "#313244",

    scrollbar_thumb = "#45475a",
    split = "#45475a",

    ansi = {
      "#45475a",
      "#f38ba8",
      "#a6e3a1",
      "#f9e2af",
      "#89b4fa",
      "#f5c2e7",
      "#94e2d5",
      "#bac2de",
    },
    brights = {
      "#585b70",
      "#f38ba8",
      "#a6e3a1",
      "#f9e2af",
      "#89b4fa",
      "#f5c2e7",
      "#94e2d5",
      "#a6adc8",
    },
  },
}
config.color_scheme = "NVIM-Mocha"

config.inactive_pane_hsb = {
  saturation = 0.60,
  brightness = 0.60,
}

config.audible_bell = "Disabled"

-- NOTE: Relative paths in WezTerm can resolve unexpectedly on Windows.
-- Use LOCALAPPDATA so this always points to your tracked bg folder.
local BG_DIR = (os.getenv("LOCALAPPDATA") or "") .. "\\nvim\\wezterm\\bg"
local BG_STATE_FILE = (os.getenv("LOCALAPPDATA") or "") .. "\\nvim\\wezterm\\bg_state.txt"
local BG_OPACITY = 0.8

local function pick_background_from_dir(dir)
  local ok, entries = pcall(wezterm.read_dir, dir)
  if not ok or type(entries) ~= "table" then
    return nil
  end

  local images = {}
  for _, p in ipairs(entries) do
    local lower = string.lower(p)
    if lower:match("%.png$") or lower:match("%.jpg$") or lower:match("%.jpeg$") or lower:match("%.webp$") then
      table.insert(images, p)
    end
  end

  table.sort(images)
  if #images == 0 then
    return nil
  end

  -- Deterministic pick (changes daily): avoids needing randomness.
  local day = tonumber(os.date("%j")) or 1
  local idx = (day % #images) + 1
  return images[idx]
end

-- Background image is applied dynamically via keybinds (see below).
local bg_state = {
  enabled = false,
  idx = 1,
  selected = nil,
  images = nil,
}

local function load_bg_state()
  local f = io.open(BG_STATE_FILE, "r")
  if not f then
    return
  end
  local enabled = f:read("*l")
  local selected = f:read("*l")
  f:close()

  bg_state.enabled = (enabled == "1")
  if selected and selected ~= "" then
    bg_state.selected = selected
  end
end

local function save_bg_state()
  local f = io.open(BG_STATE_FILE, "w")
  if not f then
    return
  end
  f:write(bg_state.enabled and "1\n" or "0\n")
  f:write((bg_state.selected or "") .. "\n")
  f:close()
end

local function ensure_bg_images_loaded()
  if bg_state.images ~= nil then
    return
  end
  local ok, entries = pcall(wezterm.read_dir, BG_DIR)
  if not ok or type(entries) ~= "table" then
    bg_state.images = {}
    return
  end
  local images = {}
  for _, p in ipairs(entries) do
    local lower = string.lower(p)
    if lower:match("%.png$") or lower:match("%.jpg$") or lower:match("%.jpeg$") or lower:match("%.webp$") then
      table.insert(images, p)
    end
  end
  table.sort(images)
  bg_state.images = images

  -- If we have a persisted selection, try to align idx to it.
  if bg_state.selected and bg_state.selected ~= "" then
    for i, p in ipairs(images) do
      if p == bg_state.selected then
        bg_state.idx = i
        break
      end
    end
  end
end

apply_bg_overrides = function(window)
  local overrides = window:get_config_overrides() or {}

  if not bg_state.enabled then
    overrides.background = nil
    window:set_config_overrides(overrides)
    return
  end

  ensure_bg_images_loaded()
  local images = bg_state.images or {}
  if #images == 0 then
    overrides.background = nil
    window:set_config_overrides(overrides)
    return
  end

  if bg_state.idx < 1 then
    bg_state.idx = #images
  elseif bg_state.idx > #images then
    bg_state.idx = 1
  end

  -- Keep selection stable across toggles/restarts.
  if not bg_state.selected or bg_state.selected == "" then
    bg_state.selected = images[bg_state.idx]
  end

  -- If the selected image disappeared, fall back to current idx.
  local bg_image = bg_state.selected
  local selected_exists = false
  for i, p in ipairs(images) do
    if p == bg_image then
      selected_exists = true
      bg_state.idx = i
      break
    end
  end
  if not selected_exists then
    bg_image = images[bg_state.idx]
    bg_state.selected = bg_image
  end

  save_bg_state()
  overrides.background = {
    {
      source = { File = bg_image },
      opacity = BG_OPACITY,
      hsb = { brightness = 0.1, hue = 1.0, saturation = 1.0 },
    },
  }
  window:set_config_overrides(overrides)
end

-- When reloading config, re-apply overrides so bg state remains consistent.
wezterm.on("window-config-reloaded", function(window, _pane)
  if apply_bg_overrides then
    apply_bg_overrides(window)
  end
end)

wezterm.on("toggle-bg", function(window, _pane)
  bg_state.enabled = not bg_state.enabled
  save_bg_state()
  apply_bg_overrides(window)
end)

wezterm.on("bg-next", function(window, _pane)
  bg_state.enabled = true
  ensure_bg_images_loaded()
  bg_state.idx = bg_state.idx + 1
  local images = bg_state.images or {}
  if #images > 0 then
    if bg_state.idx > #images then
      bg_state.idx = 1
    end
    bg_state.selected = images[bg_state.idx]
  end
  save_bg_state()
  apply_bg_overrides(window)
end)

wezterm.on("bg-prev", function(window, _pane)
  bg_state.enabled = true
  ensure_bg_images_loaded()
  bg_state.idx = bg_state.idx - 1
  local images = bg_state.images or {}
  if #images > 0 then
    if bg_state.idx < 1 then
      bg_state.idx = #images
    end
    bg_state.selected = images[bg_state.idx]
  end
  save_bg_state()
  apply_bg_overrides(window)
end)

-- Load persisted background selection at startup.
load_bg_state()

-- =====================
-- Keybindings (quality-of-life)
-- =====================
config.keys = {

  -- Make Ctrl+Tab usable inside Neovim (terminal TUIs often can't see <C-Tab> directly)
  { key = "Tab", mods = "CTRL", action = wezterm.action.SendKey({ key = "F12" }) },
  { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.SendKey({ key = "F10" }) },

  -- Fullscreen toggle (like a window manager)
  { key = "z", mods = "CTRL", action = wezterm.action.ToggleFullScreen },
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

  -- Background image controls (optional)
  -- Toggle background image on/off
  { key = "b", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("toggle-bg") },
  -- Cycle images (requires BG_DIR to contain images)
  -- Note: with SHIFT held, many layouts report these as '{' and '}' instead of '[' and ']'.
  { key = "{", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("bg-prev") },
  { key = "}", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("bg-next") },
  -- Fallbacks that work on basically any layout
  { key = "F7", mods = "NONE", action = wezterm.action.EmitEvent("bg-prev") },
  { key = "F8", mods = "NONE", action = wezterm.action.EmitEvent("bg-next") },
}

return config
