[CmdletBinding()]
param (
  [string]
  $Url,

  [int]
  $MaxRetries = 5
)

Write-Host "Checking health of $Url" -ForegroundColor Yellow

$retries = 0

while ($retries -lt $MaxRetries) {
  try {
    $retries++
    Write-Host "Health check attempt $retries"
    $response = Invoke-WebRequest -Uri $Url -DisableKeepAlive -Method Get
    if ($response.StatusCode -eq 200) {
      Write-Host "Health check succeeded" -ForegroundColor Green
      break
    }
  }
  catch {
    Write-Host "Health check failed with error $_" -ForegroundColor Red
    Start-Sleep -Seconds 5
  }
}

if ($retries -eq $MaxRetries) {
  # exit 1
  throw "Health check failed after $MaxRetries retries"
}



