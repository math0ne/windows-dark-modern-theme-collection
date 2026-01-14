# PowerShell System Fetch Script

# Set console encoding to UTF-8 to properly display Unicode characters
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Get system information
$Hostname = $env:COMPUTERNAME
$Username = $env:USERNAME
$OS = (Get-CimInstance Win32_OperatingSystem).Caption
$Kernel = (Get-CimInstance Win32_OperatingSystem).Version
$Shell = "PowerShell $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"

# Get IP Address (first non-loopback IPv4)
$IPAddress = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.*" } | Select-Object -First 1).IPAddress

# Get uptime
$BootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$Uptime = (Get-Date) - $BootTime
$UptimeString = "{0} days, {1} hours, {2} minutes" -f $Uptime.Days, $Uptime.Hours, $Uptime.Minutes

# Get memory info
$OS_Info = Get-CimInstance Win32_OperatingSystem
$TotalMemory = [math]::Round($OS_Info.TotalVisibleMemorySize / 1MB, 2)
$FreeMemory = [math]::Round($OS_Info.FreePhysicalMemory / 1MB, 2)
$UsedMemory = [math]::Round($TotalMemory - $FreeMemory, 2)
$MemoryString = "$UsedMemory GB / $TotalMemory GB"

# Get CPU info
$CPU = (Get-CimInstance Win32_Processor).Name

# Display the ASCII art
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$artFile = Join-Path $scriptPath "dotfiles-plain.txt"

# Read and display the art with cyan color (using UTF-8 encoding)
Get-Content $artFile -Encoding UTF8 | ForEach-Object {
    if ($_ -match '(.*)(math0ne\.2017)(.*)') {
        # Colorize the math0ne.2017 line with yellow for the signature
        Write-Host -NoNewline $Matches[1] -ForegroundColor Cyan
        Write-Host -NoNewline $Matches[2] -ForegroundColor Yellow
        Write-Host $Matches[3] -ForegroundColor Cyan
    } else {
        Write-Host $_ -ForegroundColor Cyan
    }
}

# Display system information inline with colors
Write-Host ""
Write-Host -NoNewline "   "
Write-Host -NoNewline -ForegroundColor Green $Username
Write-Host -NoNewline "."
Write-Host -NoNewline -ForegroundColor Cyan $Hostname
Write-Host -NoNewline "."
Write-Host -NoNewline -ForegroundColor Cyan $IPAddress
Write-Host -NoNewline "."
Write-Host -NoNewline -ForegroundColor Magenta $OS
Write-Host -NoNewline "."
Write-Host -NoNewline -ForegroundColor Blue $Kernel
Write-Host -NoNewline "."
Write-Host -ForegroundColor Yellow $Shell
