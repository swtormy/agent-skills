param(
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [Parameter(Mandatory = $true)]
    [string]$Caption
)

$ErrorActionPreference = 'Stop'

function Read-EnvFile {
    param([string]$File)
    $map = @{}
    Get-Content -LiteralPath $File -Encoding UTF8 | ForEach-Object {
        $line = $_.Trim()
        if (-not $line -or $line.StartsWith('#') -or -not $line.Contains('=')) { return }
        $parts = $line.Split('=', 2)
        $map[$parts[0].Trim()] = $parts[1].Trim().Trim('"').Trim("'")
    }
    return $map
}

$png = Get-Item -LiteralPath $Path

$token = $env:TELEGRAM_BOT_TOKEN
if (-not $token) { $token = $env:BOT_TOKEN }
$chatId = $env:TELEGRAM_CHAT_ID
if (-not $chatId) { $chatId = $env:CHAT_ID }

if ((-not $token -or -not $chatId) -and $env:TELEGRAM_ENV -and (Test-Path -LiteralPath $env:TELEGRAM_ENV)) {
    $fromFile = Read-EnvFile -File $env:TELEGRAM_ENV
    if (-not $token) { $token = $fromFile['TELEGRAM_BOT_TOKEN']; if (-not $token) { $token = $fromFile['BOT_TOKEN'] } }
    if (-not $chatId) { $chatId = $fromFile['TELEGRAM_CHAT_ID']; if (-not $chatId) { $chatId = $fromFile['CHAT_ID'] } }
}

if (-not $token -or -not $chatId) {
    throw "Set TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID, or TELEGRAM_ENV to a KEY=value file"
}

$api = "https://api.telegram.org/bot$token/sendPhoto"
$form = @{
    chat_id = $chatId
    caption = $Caption
    photo   = $png
}
$resp = Invoke-RestMethod -Uri $api -Method Post -Form $form
if (-not $resp.ok) {
    throw "sendPhoto failed"
}
Write-Output 'sent'
