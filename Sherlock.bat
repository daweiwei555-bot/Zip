@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
set "PROJECT_DIR=%SCRIPT_DIR%"

REM 检查 run_local.sh 是否存在
if not exist "%PROJECT_DIR%run_local.sh" (
    echo.
    echo ❌ 错误：找不到 run_local.sh
    echo 请确保这个脚本和 run_local.sh 在同一目录
    echo.
    pause
    exit /b 1
)

REM 检查 Git Bash 是否安装
for /f "delims=" %%i in ('where bash 2^>nul') do set "BASH_PATH=%%i"
if "!BASH_PATH!"=="" (
    echo.
    echo ❌ 错误：找不到 bash
    echo.
    echo 请安装 Git Bash: https://gitforwindows.org/
    echo.
    pause
    exit /b 1
)

REM 检查 Python 是否安装
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ 错误：找不到 Python
    echo.
    echo 请安装 Python 3.8+: https://www.python.org/
    echo.
    pause
    exit /b 1
)

REM 清屏并显示标题
cls
echo.
echo ╔═══════════════════════════════════════════════════════════╗
echo ║           Sherlock 用户名搜索工具 - Windows 版            ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

REM 获取用户输入的用户名（如果有参数则使用参数）
if "%~1"=="" (
    set "USERNAME=daweiwei"
    echo 📝 使用默认用户名: daweiwei
    echo 提示：可以在命令行添加参数指定用户名，例如：
    echo        Sherlock.bat alice
) else (
    set "USERNAME=%~1"
    echo 📝 搜索用户名: %USERNAME%
)
echo.

REM 进入项目目录
cd /d "%PROJECT_DIR%"

REM 运行脚本
echo 🚀 正在启动 Sherlock...
echo.
bash run_local.sh "%USERNAME%"

echo.
echo ╔═══════════════════════════════════════════════════════════╗
echo ║                      运行完成！                            ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.
echo 📂 结果保存在: %PROJECT_DIR%output\
echo.
pause
