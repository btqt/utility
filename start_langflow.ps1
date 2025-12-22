# Langflow start script (Windows PowerShell)
# Run:
#   PowerShell:   .\langflow_start.ps1
# If blocked by execution policy (one-time for this session):
#   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Host.UI.RawUI.WindowTitle = 'Langflow Local Server'
Clear-Host

# ==============================================================
# 1) Cấu hình (đổi theo nhu cầu)
# ==============================================================

# LANGFLOW_CONFIG_DIR: Thư mục lưu cấu hình/dữ liệu của Langflow (profiles, cache, state...)
$env:LANGFLOW_CONFIG_DIR = 'D:\00_wip\99_learning\03_AI\data_langflow'

# LANGFLOW_HOST: Địa chỉ bind của server Langflow.
# - 127.0.0.1: chỉ truy cập trên máy này (an toàn hơn khi dùng local).
# - 0.0.0.0: cho phép máy khác trong mạng truy cập (cần mở firewall/router nếu cần).
$env:LANGFLOW_HOST = '127.0.0.1'

# LANGFLOW_PORT: Cổng server Langflow sẽ lắng nghe.
$env:LANGFLOW_PORT = '7860'

# (TUỲ CHỌN) Đường dẫn tới activate của Python venv.
# - Để trống nếu bạn cài Langflow global hoặc tự activate venv trước.
$VenvActivate = ''
# $VenvActivate = 'C:\path\to\venv\Scripts\Activate.ps1'

# ==============================================================
# 2) Biến môi trường best-practice (phiên hiện tại)
# ==============================================================

# Tắt telemetry/analytics (nếu Langflow hoặc dependencies có dùng cơ chế này)
$env:DO_NOT_TRACK = 'true'
Write-Host "[INFO] DO_NOT_TRACK=$env:DO_NOT_TRACK (chỉ áp dụng cho phiên hiện tại)"

# ==============================================================
# 3) Khuyến nghị: KHÔNG hard-code API keys trong file .ps1
# ==============================================================
# Nên cấu hình trong Windows Environment Variables hoặc set trong session trước khi chạy.
# Ví dụ:
#   $env:OPENAI_API_KEY = '...'
#   $env:GOOGLE_API_KEY = '...'

# ==============================================================
# 4) Kích hoạt venv (nếu có)
# ==============================================================
if ($VenvActivate -and (Test-Path -LiteralPath $VenvActivate)) {
    try {
        . $VenvActivate
        Write-Host "[INFO] Đã kích hoạt venv: $VenvActivate"
    }
    catch {
        Write-Host "[WARN] Không thể kích hoạt venv: $VenvActivate"
        Write-Host "[WARN] $($_.Exception.Message)"
    }
}
elseif ($VenvActivate) {
    Write-Host "[WARN] Không tìm thấy venv activate: $VenvActivate"
}

# ==============================================================
# 5) Đảm bảo thư mục config tồn tại
# ==============================================================
New-Item -ItemType Directory -Force -Path $env:LANGFLOW_CONFIG_DIR | Out-Null

# ==============================================================
# 6) Kiểm tra langflow có sẵn
# ==============================================================
# $langflowCmd = Get-Command langflow -ErrorAction SilentlyContinue
# if (-not $langflowCmd) {
#     Write-Host '[ERROR] Không tìm thấy lệnh "langflow" trong PATH.'
#     Write-Host '[HINT] Hãy cài đặt: pip install langflow  (trong đúng python/venv)'
#     Write-Host '[HINT] Nếu đã cài, hãy mở PowerShell mới hoặc activate venv trước.'
#     Read-Host 'Nhấn Enter để thoát'
#     exit 1
# }

Write-Host '[INFO] Langflow đang khởi động...'
Write-Host "[INFO] Dữ liệu lưu tại: $env:LANGFLOW_CONFIG_DIR"
Write-Host "[INFO] URL: http://$env:LANGFLOW_HOST`:$env:LANGFLOW_PORT/"

# ==============================================================
# 7) Chạy Langflow
# ==============================================================
langflow run --host $env:LANGFLOW_HOST --port $env:LANGFLOW_PORT

Read-Host 'Nhấn Enter để đóng'
