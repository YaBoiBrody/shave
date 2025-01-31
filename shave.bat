@echo off
title shave installer
cls

echo =====================================
echo            shave installer            
echo =====================================
echo shave is not responsible for any damages or misuse of this service.
echo do you accept? (y/n)
set /p choice="> "

if /i "%choice%" neq "y" (
    exit
)

cls
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
echo.
echo do you want to install shave? (y/n)
set /p install="> "

if /i "%install%" neq "y" (
    exit
)

set "install_dir=C:\Windows\Temp\shave"
set "desktop_dir=C:\Users\%USERNAME%\OneDrive - Volusia County Schools\Desktop"
set "batch_file=%USERPROFILE%\Downloads\shave.bat"

echo installing shave...
echo creating installation directory
mkdir "%install_dir%" 2>nul

echo creating readme.txt...
(
    echo Welcome to your computer, enhanced by shave.
    echo Any file/folder placed in here will be completely unblocked meaning you can run games and more.
    echo To open the shave panel to get games and manage downloads, open up "Run Shave".
    echo If you lose the location of this folder, on your desktop (computer home screen) click on the folder shortcut that says shave.
) > "%install_dir%\readme.txt"

echo downloading shave panel...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/yaboibrody/shave/releases/latest/download/ShaveInstaller.exe', '%install_dir%\ShaveInstaller.exe')" 2>nul
if %errorlevel% neq 0 (
    echo.
    echo [91merror: cannot access download server. either your internet is off or shave server has been blocked.[0m
    echo [91mtry turning your internet on or wait until the website is unblocked.[0m
    pause
    exit
)

echo creating shortcut on desktop...
powershell -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%desktop_dir%\shave.lnk'); $s.TargetPath='%install_dir%\Shave.exe'; $s.Save()"

echo opening installation folder...
start "" "%install_dir%"

echo running shaveinstaller.exe...
start /wait "" "%install_dir%\ShaveInstaller.exe"

echo cleaning up...
del "%install_dir%\ShaveInstaller.exe" /f /q
del "%batch_file%" /f /q

echo installation complete! 
pause
exit

:::            /$$                                    
:::           | $$                                    
:::   /$$$$$$$| $$$$$$$   /$$$$$$  /$$    /$$ /$$$$$$ 
:::  /$$_____/| $$__  $$ |____  $$|  $$  /$$//$$__  $$
::: |  $$$$$$ | $$  \ $$  /$$$$$$$ \  $$/$$/| $$$$$$$$
:::  \____  $$| $$  | $$ /$$__  $$  \  $$$/ | $$_____/
:::  /$$$$$$$/| $$  | $$|  $$$$$$$   \  $/  |  $$$$$$$
::: |_______/ |__/  |__/ \_______/    \_/    \_______/
