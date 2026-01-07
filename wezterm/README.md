# WezTerm config (tracked)

This repo keeps the WezTerm config at `wezterm/wezterm.lua`.

## Link it (Windows)

PowerShell:

```powershell
# from repo root
.\scripts\link-wezterm.ps1

# replace existing %USERPROFILE%\.wezterm.lua
.\scripts\link-wezterm.ps1 -Force
```

If symlink creation fails, enable **Developer Mode** in Windows Settings or run PowerShell as Admin.
