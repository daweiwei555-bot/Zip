@echo off
chcp 65001 >nul
setlocal
set "FOLDER=%USERPROFILE%\Zip"

echo Creating folder "%FOLDER%"...
if not exist "%FOLDER%" mkdir "%FOLDER%"

echo Downloading required files to "%FOLDER%"...
powershell -NoProfile -Command ^
  "Try { $wc = New-Object System.Net.WebClient; $wc.DownloadFile('https://raw.githubusercontent.com/daweiwei555-bot/Zip/main/Sherlock.bat', '%FOLDER%\\Sherlock.bat'); $wc.DownloadFile('https://raw.githubusercontent.com/daweiwei555-bot/Zip/main/run_local.sh', '%FOLDER%\\run_local.sh'); $wc.DownloadFile('https://raw.githubusercontent.com/daweiwei555-bot/Zip/main/create_desktop_shortcut.bat', '%FOLDER%\\create_desktop_shortcut.bat'); $wc.DownloadFile('https://raw.githubusercontent.com/daweiwei555-bot/Zip/main/create_desktop_shortcut.ps1', '%FOLDER%\\create_desktop_shortcut.ps1'); $wc.DownloadFile('https://raw.githubusercontent.com/daweiwei555-bot/Zip/main/installer_run_once.bat', '%FOLDER%\\installer_run_once.bat'); Write-Output 'Downloads completed.' } Catch { Write-Error 'Download failed: ' + $_.Exception.Message; Exit 1 }"

if not exist "%FOLDER%\Sherlock.bat" (
  echo Error: Sherlock.bat not found after download.
  pause
  exit /b 1
)

echo Creating desktop shortcut "ZIP.lnk"...
powershell -NoProfile -Command ^
  "$desktop = [Environment]::GetFolderPath('Desktop'); $shortcutPath = Join-Path $desktop 'ZIP.lnk'; $wsh = New-Object -ComObject WScript.Shell; $sc = $wsh.CreateShortcut($shortcutPath); $sc.TargetPath = '%FOLDER%\\Sherlock.bat'; $sc.Arguments = 'ZIP'; $sc.WorkingDirectory = '%FOLDER%'; $sc.IconLocation = '%FOLDER%\\Sherlock.bat,0'; $sc.Save(); Write-Output 'Shortcut created at ' + $shortcutPath"

echo Launching Sherlock...
start "" "%FOLDER%\Sherlock.bat"

echo Done. If a window opened, Sherlock has been started. The desktop shortcut named "ZIP" should now exist.
pause
