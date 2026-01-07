param(
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$target = Join-Path $repoRoot 'wezterm\wezterm.lua'
$dest = Join-Path $env:USERPROFILE '.wezterm.lua'

if (!(Test-Path $target)) {
  throw "Missing target file: $target"
}

if (Test-Path $dest) {
  $item = Get-Item -LiteralPath $dest

  if ($item.LinkType -and $item.Target -eq $target) {
    Write-Host "OK: already linked -> $target"
    exit 0
  }

  if (-not $Force) {
    throw "Destination exists: $dest`nRe-run with -Force to replace it."
  }

  Remove-Item -LiteralPath $dest -Force
}

function Try-Link {
  param(
    [Parameter(Mandatory = $true)][string]$LinkType
  )
  try {
    if ($LinkType -eq 'SymbolicLink') {
      New-Item -ItemType SymbolicLink -Path $dest -Target $target | Out-Null
    }
    elseif ($LinkType -eq 'HardLink') {
      New-Item -ItemType HardLink -Path $dest -Target $target | Out-Null
    }
    else {
      throw "Unknown link type: $LinkType"
    }
    return $true
  } catch {
    return $false
  }
}

if (Try-Link -LinkType 'SymbolicLink') {
  Write-Host "Linked (symlink): $dest -> $target"
  Write-Host "Note: On Windows, symlinks may require Developer Mode or Admin."
  exit 0
}

if (Try-Link -LinkType 'HardLink') {
  Write-Host "Linked (hardlink): $dest -> $target"
  Write-Host "Note: Hardlink means both paths point to the same file on disk."
  exit 0
}

Copy-Item -LiteralPath $target -Destination $dest -Force
Write-Host "Copied: $dest <= $target"
Write-Host "Note: Linking failed; this is a one-time copy. Re-run this script after changes."
