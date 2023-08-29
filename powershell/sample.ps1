[CmdletBinding()]
[OutputType([string])]
param (
  # [Parameter()]
  [string] $Text = 'Def'
)
Write-Host 'Hello from powershell with your text: ' $Text
# save current nodejs version in a variable
$nodeVersion = $(node -v)
Write-Host "Current node version: $nodeVersion"

return $nodeVersion
