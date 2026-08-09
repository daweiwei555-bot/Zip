<#
  create_desktop_shortcut.ps1
  - 在当前仓库目录下创建一个桌面快捷方式（ZIP.lnk），指向 Sherlock.bat
  - 兼容 Windows 10/11，使用 WScript.Shell COM 对象创建 .lnk 文件#>

[CmdletBinding()]
param(
    [string]$ShortcutName = 'ZIP',
    [string]$Argument = 'daweiwei5211@outlook.com'
)

try {
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
    $target = Join-Path $scriptDir 'Sherlock.bat'
    if (-not (Test-Path $target)) {
        Write-Error "目标文件未找到： $target"
        exit 1
    }

    $desktop = [Environment]::GetFolderPath('Desktop')
    $shortcutPath = Join-Path $desktop ("$ShortcutName.lnk")

    $wsh = New-Object -ComObject WScript.Shell
    $shortcut = $wsh.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $target
    $shortcut.Arguments = $Argument
    $shortcut.WorkingDirectory = $scriptDir
    $shortcut.Description = 'Sherlock 用户搜索 - ZIP 快捷启动'
    $shortcut.IconLocation = "$target,0"
    $shortcut.Save()

    Write-Output "快捷方式已创建： $shortcutPath"
    exit 0
} catch {
    Write-Error "创建快捷方式失败： $_"
    exit 2
}
