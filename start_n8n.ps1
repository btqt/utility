# n8n start script (Windows PowerShell)
# Run:
#   PowerShell:   .\n8n_start.ps1
# If blocked by execution policy (one-time for this session):
#   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Host.UI.RawUI.WindowTitle = 'n8n Local Server'
Clear-Host

# ==============================================================
# 1) CONFIG (đổi theo nhu cầu)
# ==============================================================

# Where to store n8n "project" data (workflows, credentials, DB, logs)
$env:N8N_USER_FOLDER = 'D:\00_wip\99_learning\03_AI\data_n8n'

# Optional: set a fixed encryption key so credentials remain readable across moves.
# Nếu để trống, n8n sẽ tự tạo key trong N8N_USER_FOLDER.
# $env:N8N_ENCRYPTION_KEY = 'paste-your-long-random-string-here'

# Listen port
$env:N8N_PORT = '5678'

# Bind host
$env:N8N_HOST = '127.0.0.1'
# $env:N8N_HOST = '0.0.0.0'

# Optional: if you access n8n via reverse proxy / public URL
# $env:N8N_PROTOCOL = 'https'
# $env:WEBHOOK_URL = 'https://your-domain.com/'

# (Optional) Disable telemetry for this session (if applicable)
$env:DO_NOT_TRACK = 'true'

# ==============================================================
# 2) Ensure folder exists
# ==============================================================
New-Item -ItemType Directory -Force -Path $env:N8N_USER_FOLDER | Out-Null

Write-Host "[INFO] Starting n8n..."
Write-Host "[INFO] N8N_USER_FOLDER = $env:N8N_USER_FOLDER"
Write-Host "[INFO] N8N_HOST        = $env:N8N_HOST"
Write-Host "[INFO] N8N_PORT        = $env:N8N_PORT"
Write-Host "[INFO] URL             = http://$env:N8N_HOST`:$env:N8N_PORT/"
Write-Host ''

# ==============================================================
# 3) Start n8n (prefer global n8n; fallback to npx)
# ==============================================================

$n8nCmd = Get-Command n8n -ErrorAction SilentlyContinue
if ($n8nCmd) {
    & $n8nCmd.Source
    Read-Host 'Nhấn Enter để đóng'
    exit 0
}

Write-Host '[WARN] Không tìm thấy lệnh "n8n" trong PATH. Dùng npx để chạy n8n...'
Write-Host '[HINT] Muốn start nhanh hơn: npm i -g n8n'

$npxCmd = Get-Command npx -ErrorAction SilentlyContinue
if (-not $npxCmd) {
    Write-Host '[ERROR] Không tìm thấy "npx". Bạn cần cài Node.js (npm/npx) trước.'
    Read-Host 'Nhấn Enter để thoát'
    exit 1
}

& $npxCmd.Source -y n8n

Read-Host 'Nhấn Enter để đóng'
