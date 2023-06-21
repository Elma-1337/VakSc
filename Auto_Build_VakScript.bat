@echo off

REM Get the version from data.py
for /f "tokens=2 delims=''" %%G in ('findstr "script_version" data.py') do (
    set "version=%%G"
)

REM Set the target folder name using the extracted version
set "target_folder=VakScript v%version%"

REM Build the Python code using PyInstaller and specify the output folder
pyinstaller --onefile --noconsole --distpath "%target_folder%" main.py

REM Copy required files to the target folder
copy drawings_font.ttf "%target_folder%"
copy settings.json "%target_folder%"

REM Rename the main.exe file to match the target folder name
ren "%target_folder%\main.exe" "%target_folder%.exe"

REM Remove the build folder if it exists
if exist "%cd%\build" (
    rmdir /s /q "%cd%\build"
)

REM Remove all .spec files
for %%i in (*.spec) do (
    del "%%i"
)

echo Build completed successfully!
echo.
echo Press any key to exit...
pause >nul