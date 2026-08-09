@echo off
chcp 65001 >nul
setlocal

echo =============================================
echo  ZIP — 一键安装并运行（创建桌面快捷方式并启动 Sherlock）
echo =============================================

REM 首先，尝试创建桌面快捷方式
call "%~dp0create_desktop_shortcut.bat"

REM 无论快捷方式是否创建成功，尝试启动 Sherlock
if exist "%~dp0Sherlock.bat" (
    echo 启动 Sherlock...
    start "ZIP - Sherlock" "%~dp0Sherlock.bat"
) else (
    echo 错误：找不到 Sherlock.bat，无法启动。
    pause
    exit /b 1
)

echo 完成。桌面上应已出现 ZIP 快捷方式，并已启动 Sherlock。
echo 默认传入参数：ZIP
echo 如需更改默认搜索用户名，请修改 create_desktop_shortcut.ps1 的 -Argument 值或编辑已创建的快捷方式属性。

pause
