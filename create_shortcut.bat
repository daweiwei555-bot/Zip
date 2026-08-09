@echo off
REM Windows 桌面快捷方式创建脚本
REM 此脚本会在桌面创建一个指向 Sherlock.bat 的快捷方式

setlocal enabledelayedexpansion

REM 获取当前脚本的目录（假设在项目根目录运行）
set "SCRIPT_DIR=%~dp0"
set "TARGET_BAT=%SCRIPT_DIR%Sherlock.bat"
set "DESKTOP=%USERPROFILE%\Desktop"
set "SHORTCUT=%DESKTOP%\zip.lnk"

REM 检查 Sherlock.bat 是否存在
if not exist "%TARGET_BAT%" (
    echo.
    echo 错误：找不到 Sherlock.bat
    echo 请在项目根目录运行此脚本
    echo.
    pause
    exit /b 1
)

REM 创建快捷方式（使用 PowerShell）
powershell -Command ^
    "$WshShell = New-Object -ComObject WScript.Shell;" ^
    "$Shortcut = $WshShell.CreateShortcut('%SHORTCUT%');" ^
    "$Shortcut.TargetPath = '%TARGET_BAT%';" ^
    "$Shortcut.WorkingDirectory = '%SCRIPT_DIR%';" ^
    "$Shortcut.Description = 'Sherlock 用户名搜索工具';" ^
    "$Shortcut.Save();"

if errorlevel 1 (
    echo.
    echo 创建失败，请尝试手动方式
    echo.
) else (
    echo.
    echo ✓ 成功！已在桌面创建快捷方式：zip
    echo.
    echo 位置：%SHORTCUT%
    echo.
)

pause
