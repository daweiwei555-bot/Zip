@echo off
REM 一键生成桌面快捷方式
REM 适用于搜索用户名: daweiwei5211@outlook.com

chcp 65001 >nul
setlocal enabledelayedexpansion

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
set "TARGET_BAT=%SCRIPT_DIR%Sherlock.bat"
set "DESKTOP=%USERPROFILE%\Desktop"
set "SHORTCUT=%DESKTOP%\ZIP.lnk"

echo.
echo ���═══════════════════════════════════════════════════════════╗
echo ║        正在生成桌面快捷方式 - ZIP (一键启动)              ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

REM 检查 Sherlock.bat 是否存在
if not exist "%TARGET_BAT%" (
    echo ❌ 错误：找不到 Sherlock.bat
    echo 请确保此脚本在项目根目录
    echo.
    pause
    exit /b 1
)

echo 📍 检查依赖...

REM 检查 Git Bash
bash --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ 错误：找不到 Git Bash
    echo 请先安装: https://gitforwindows.org/
    echo.
    pause
    exit /b 1
)
echo ✓ Git Bash 已安装

REM 检查 Python
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ 错误：找不到 Python
    echo 请先安装: https://www.python.org/
    echo 重要：勾选 "Add Python to PATH"
    echo.
    pause
    exit /b 1
)
echo ✓ Python 已安装

echo.
echo 🔧 正在创建快捷方式...
echo 位置: %SHORTCUT%
echo.

REM 使用 PowerShell 创建快捷方式（调用仓库中的 PowerShell 脚本以提高兼容性）
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0create_desktop_shortcut.ps1" || (
    REM 如果调用脚本失败，回退到内联 PowerShell 命令
    powershell -NoProfile -Command ^
        "$WshShell = New-Object -ComObject WScript.Shell; " ^
        "$Shortcut = $WshShell.CreateShortcut('%SHORTCUT%'); " ^
        "$Shortcut.TargetPath = '%TARGET_BAT%'; " ^
        "$Shortcut.Arguments = 'daweiwei5211@outlook.com'; " ^
        "$Shortcut.WorkingDirectory = '%SCRIPT_DIR%'; " ^
        "$Shortcut.Description = 'Sherlock 用户搜索 - ZIP 快捷启动'; " ^
        "$Shortcut.IconLocation = '%SCRIPT_DIR%Sherlock.bat,0'; " ^
        "$Shortcut.Save(); " ^
        "Write-Host '✓ 快捷方式已创建'"
)

if errorlevel 1 (
    echo.
    echo ⚠️  PowerShell 创建失败，尝试备选方案...
    echo.
    
    REM 备选方案：使用 VBScript
    set "VBS_FILE=%TEMP%\create_shortcut.vbs"
    (
        echo Set oWS = WScript.CreateObject("WScript.Shell"^)
        echo sLinkFile = "%SHORTCUT%"
        echo Set oLink = oWS.CreateShortCut(sLinkFile^)
        echo oLink.TargetPath = "%TARGET_BAT%"
        echo oLink.Arguments = "daweiwei5211@outlook.com"
        echo oLink.WorkingDirectory = "%SCRIPT_DIR%"
        echo oLink.Description = "Sherlock 用户搜索 - ZIP 快捷启动"
        echo oLink.Save
    ) > "!VBS_FILE!"
    
    cscript.exe "!VBS_FILE!" //nologo
    del "!VBS_FILE!"
)

echo.
echo ╔═══════════════════════════════════════════════════════════╗
echo ║                    ✓ 完成！                               ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.
echo 📌 桌面快捷方式信息：
echo    名称: ZIP
echo    位置: %DESKTOP%
echo    功能: 搜索用户 daweiwei5211@outlook.com
echo.
echo 💡 用法：
echo    1. 双击桌面的 ZIP 快捷方式
echo    2. 等待搜索完成（首次较慢）
echo    3. 结果保存在项目的 output\ 文件夹
echo.
echo 📂 项目路径: %SCRIPT_DIR%
echo.

pause
