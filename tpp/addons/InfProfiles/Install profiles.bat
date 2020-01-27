@echo OFF
set INSTALLFILE=InfProfiles
setlocal ENABLEEXTENSIONS
set CURRENTPATH=%~dp0

REM Get install path
set KEY_NAME=HKCU\Software\SnakeBite
for /F "usebackq tokens=3*" %%A IN (`reg query %KEY_NAME% /ve`) do (
    set appdir=%%A %%B
)

if defined appdir (
   if not exist "%appdir%" (
        @echo "%appdir%" not found.
        pause
        exit
    )

    REM tex snakebite not happy if working directory is different from where it's installed?
	cd /d "%appdir%"

	echo Uninstalling any existing %INSTALLFILE%
	snakebite.exe -u -x %INSTALLFILE%

	echo Building .mgsv
	copy /y "%CURRENTPATH%\%INSTALLFILE%.lua" "%CURRENTPATH%%INSTALLFILE%\Assets\tpp\script\lib\%INSTALLFILE%.lua"
    makebite.exe "%CURRENTPATH%%INSTALLFILE%"
    del "%CURRENTPATH%%INSTALLFILE%\%INSTALLFILE%.mgsv"
    ren "%CURRENTPATH%%INSTALLFILE%\mod.mgsv" %INSTALLFILE%.mgsv

    echo Installing .mgsv
    REM tex TODO skiping conflict check till I can get makebite to accept msgv version on command line 
    snakebite.exe -i -c -x "%CURRENTPATH%%INSTALLFILE%\%INSTALLFILE%.mgsv"
    echo Done.
) else (
    @echo Snakebite install path not found.
    pause
    exit
) 



