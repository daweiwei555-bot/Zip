@echo off
REM ╔═══════════════════════════════════════════════════════════════╗
REM ║  Sherlock 一键安装脚本 - Windows                              ║
REM ║  自动克隆仓库 + 创建桌面快捷方式                              ║
REM ╚═══════════════════════════════════════════════════════════════╝

chcp 65001 >nul
setlocal enabledelayedexpansion

set "REPO_URL=https://github.com/daweiwei555-bot/Zip.git"
set "INSTALL_PATH=D:\Zip"
set "DESKTOP=%USERPROFILE%\Desktop"
set "SHORTCUT=%DESKTOP%\ZIP.lnk"
set "TARGET_BAT=%INSTALL_PATH%\Sherlock.bat"

cls
echo.
echo ╔═══════════════════════════════════════════════════════════════╗
echo ║     Sherlock 一键安装 - ZIP 快捷方式生成器                   ║
echo ╚═══════════════════════════════════════════════════════════════╝
echo.
echo 账户: daweiwei555@gmail.com
echo 安装路径: %INSTALL_PATH%
echo 快捷方式: %SHORTCUT%
echo.

REM 第一步：检查依赖
echo [1/4] 🔍 检查依赖...
echo.

git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误：找不到 Git
    echo 请先安装 Git: https://gitforwindows.org/
    echo.
    pause
    exit /b 1
)
echo ✓ Git 已安装

python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误：找不到 Python
    echo 请先安装 Python: https://www.python.org/
    echo 重要：安装时勾选 "Add Python to PATH"
    echo.
    pause
    exit /b 1
)
echo ✓ Python 已安装

bash --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误：找不到 Git Bash
    echo 请先安装 Git Bash: https://gitforwindows.org/
    echo.
    pause
    exit /b 1
)
echo ✓ Git Bash 已安装

echo.

REM 第二步：克隆仓库
echo [2/4] ⬇️  克隆仓库到 %INSTALL_PATH%...
echo.

if exist "%INSTALL_PATH%" (
    echo ⚠️  %INSTALL_PATH% 已存在，跳过克隆
) else (
    git clone %REPO_URL% %INSTALL_PATH%
    if errorlevel 1 (
        echo ❌ 克隆失败
        echo 请检查网络连接
        echo.
        pause
        exit /b 1
    )
    echo ✓ 仓库克隆完成
)

echo.

REM 第三步：检查必要文件
echo [3/4] 📋 检查文件...
echo.

if not exist "%TARGET_BAT%" (
    echo ❌ 错误：找不到 Sherlock.bat
    echo 仓库可能不完整，请重新克隆
    echo.
    pause
    exit /b 1
)
echo ✓ Sherlock.bat 已验证

echo.

REM 第四步：创建桌面快捷方式
echo [4/4] 🔗 创建桌面快捷方式...
echo.

REM 使用 PowerShell 创建快捷方式
powershell -NoProfile -Command ^
    "$WshShell = New-Object -ComObject WScript.Shell; " ^
    "$Shortcut = $WshShell.CreateShortcut('%SHORTCUT%'); " ^
    "$Shortcut.TargetPath = '%TARGET_BAT%'; " ^
    "$Shortcut.Arguments = 'daweiwei5211@outlook.com'; " ^
    "$Shortcut.WorkingDirectory = '%INSTALL_PATH%'; " ^
    "$Shortcut.Description = 'Sherlock 用户搜索 - 一键启动'; " ^
    "$Shortcut.Save(); " ^
    "Write-Host '✓ 快捷方式已创建'"

if errorlevel 1 (
    echo.
    echo ⚠️  PowerShell 方式失败，尝试 VBScript...
    echo.
    
    set "VBS_FILE=%TEMP%\create_zip_shortcut.vbs"
    (
        echo Set oWS = WScript.CreateObject("WScript.Shell"^)
        echo sLinkFile = "%SHORTCUT%"
        echo Set oLink = oWS.CreateShortCut(sLinkFile^)
        echo oLink.TargetPath = "%TARGET_BAT%"
        echo oLink.Arguments = "daweiwei5211@outlook.com"
        echo oLink.WorkingDirectory = "%INSTALL_PATH%"
        echo oLink.Description = "Sherlock 用户搜索 - 一键启动"
        echo oLink.Save
    ) > "!VBS_FILE!"
    
    cscript.exe "!VBS_FILE!" //nologo
    del "!VBS_FILE!"
)

echo.
echo ╔═══════════════════════════════════════════════════════════════╗
echo ║                   ✓ 安装完成！                                ║
echo ╚═══════════════════════════════════════════════════════════════╝
echo.
echo 📍 安装信息：
echo    系统账户: daweiwei555@gmail.com
echo    搜索用户: daweiwei5211@outlook.com
echo    仓库位置: %INSTALL_PATH%
echo    快捷方式: ZIP（在你的桌面上）
echo.
echo 🚀 使用方法：
echo    1. 查看你的桌面
echo    2. 找到 "ZIP" 快捷方式
echo    3. 双击运行即可！
echo.
echo 📝 注意：
echo    • 第一次运行会下载依赖（5-10分钟，请耐心等待）
echo    • 搜索结果保存在 %INSTALL_PATH%\output\ 文件夹
echo    • 之后每次运行都会更快
echo.
echo 🎉 完成！按 Enter 关闭此窗口
echo.

pause
