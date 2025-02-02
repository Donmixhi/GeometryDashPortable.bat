    TITLE CMDPRO: Geometry Dash...
COLOR A
cls 
ECHO ==============================================
ECHO I 1.CREAR BACKUP       I 2-CARGAR BACKUP     I
ECHO I----------------------I---------------------I
ECHO I 3.BORRAR APPDATA     I 4.ABRIR FAKE PLAYER I
ECHO I----------------------I---------------------I
ECHO I 5.FAKE PLAYER.TXT    I 6.EJECUTAR          I 
ECHO I----------------------I---------------------I
ECHO I 7.GD 10 ANIVERSARIO  I 8.RETURN            I 
ECHO ==============================================
ECHO ...
SET respuestasdf=0
set /p respuestasdf=">_ "

if /i "%respuestasdf%"=="1" (
    echo MOVIENDO DATOS A BACKUP
    GOTO FMOVERBACKUP
) else if /i "%respuestasdf%"=="2" (
    echo INICIANDO SESION
    GOTO FCARGARBACKUP
) else if /i "%respuestasdf%"=="3" (
    echo Borrando appdata
    GOTO FBORRARAPPDATA
) else if /i "%respuestasdf%"=="4" (
    echo ABRIENDO
    start "" "%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\FAKE PLAYER PROGRES"
PAUSE
goto GeometryDash
) else if /i "%respuestasdf%"=="5" (
    start "" "%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\FAKE PLAYER PROGRES\PROGRESO.txt"
PAUSE
goto GeometryDash
) else if /i "%respuestasdf%"=="6" (
START "CMDPRO: DATA Geometry Dash" "%UNIDAD%:\LOSCOMANDOS\EXECUTE.BAT"
goto GeometryDash
) else if /i "%respuestasdf%"=="7" (
    goto FD10
) else if "%respuestasdf%"=="8" (
    GOTO RETURN
) else (
    echo OPCION NO VALIDA
    GOTO GeometryDash
)

goto GeometryDash

:FMOVERBACKUP
CLS
START "" "%UNIDAD%:\LOSCOMANDOS\CMDPRO.lnk"
COLOR A
rem Obtener la fecha actual en formato D-M-A
for /f "tokens=1-3 delims=/- " %%a in ('date /t') do (
    set dia=%%a
    set mes=%%b
    set YEAR=%%c
)

set fecha= %dia%-%mes%-%YEAR%

rem Especificar las rutas de los directorios
set "directorio_destino=%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\%fecha%"
set "directorio_mp3=%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\SONGS"
set "directorio_origen=C:\Users\user\AppData\Local\GeometryDash"
set "directorio_de_directorios=%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\LOGS"

rem Crear los directorios si no existen
if not exist "%directorio_destino%" mkdir "%directorio_destino%"
if not exist "%directorio_mp3%" mkdir "%directorio_mp3%"

rem Mover los archivos .mp3 y ogg al directorio de archivos mp3
move "%directorio_origen%\*.mp3" "%directorio_mp3%"
move "%directorio_origen%\*.ogg" "%directorio_mp3%"
move "%directorio_origen%\*.dat" "%directorio_destino%"
move "%directorio_origen%\*.bak" "%directorio_destino%"
move "%directorio_origen%\*.json" "%directorio_destino%"
rem Mover el resto de los archivos al directorio con la fecha actual
robocopy "%directorio_origen%" "%directorio_de_directorios%" /E /V /MOV /XF *.dat *.bak *.json *.mp3 *.ogg
echo Todo el contenido ha sido movido exitosamente.
pause
::GOTO GeometryDash
EXIT

:FCARGARBACKUP
CLS
:FCARGARBACKUPS
CLS 
COLOR A
setlocal enabledelayedexpansion

rem Especificar el directorio de origen y destino
set "directorio_origen=%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups"
set "directorio_destino=C:\Users\user\AppData\Local\GeometryDash"

rem Inicializar contador de carpetas
set contador=0

rem Listar carpetas en el directorio de origen
echo Carpetas en %directorio_origen%:
for /d %%i in ("%directorio_origen%\*") do (
    set /a contador+=1
    set "carpeta_!contador!=%%i"
    echo !contador!. %%~nxi
)

rem Solicitar número al usuario
set /p seleccion=Introduce el número de la carpeta que deseas copiar:
rem Verificar si la selección es válida
if defined carpeta_%seleccion% (
    START "" "%UNIDAD%:\LOSCOMANDOS\CMDPRO.lnk"
    rem Obtener la ruta completa de la carpeta seleccionada
    set "carpeta_seleccionada=!carpeta_%seleccion%!"

    rem Copiar el contenido de la carpeta seleccionada al directorio de destino
    echo EXTRAYENDO contenido de !carpeta_seleccionada! a %directorio_destino%...
    robocopy "!carpeta_seleccionada!" "%directorio_destino%" /E /PURGE
    COPY "%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\SONGS" "%directorio_destino%"
    COPY "%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\LOGS" "%directorio_destino%" /S /E 
    echo Copia completada exitosamente.
    EXIT
) else (
    echo Selección inválida. Por favor, ejecuta el archivo de nuevo y selecciona un número válido.
    GOTO FCARGARBACKUPS
)

pause
EXIT
::goto GeometryDash

:FBORRARAPPDATA
CLS
START "" "%UNIDAD%:\LOSCOMANDOS\CMDPRO.lnk"
COLOR A
setlocal

rem Especificar el directorio donde se encuentran las carpetas a borrar
set "directorioABORRRAR=C:\Users\user\AppData\Local\GeometryDash"

rem Iterar sobre cada carpeta dentro del directorio y eliminarla
for /d %%i in ("%directorioABORRAR%\*") do (
    rd /S /Q "%%i"
)

RMDIR /S /Q  %directorioABORRRAR%

echo Todas las carpetas dentro de %directorioABORRAR% han sido eliminadas.
pause
EXIT 
:FD10
TITLE CMDPRO: GD DECIMO ANIVERSARIO...
COLOR A
IF EXIST "%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\drive\DRIVE\Nueva carpeta\TEMP\GD 10 ANIVERSARIO\Geometry Dash 10-Year Anniversary.mp4" (
START "" "%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\drive\DRIVE\Nueva carpeta\TEMP\GD 10 ANIVERSARIO\Geometry Dash 10-Year Anniversary.mp4"
) ELSE (
%WINRAR% X "%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\Geometry Dash 10-Year Anniversary.rar" "%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\drive\DRIVE\Nueva carpeta\TEMP\GD 10 ANIVERSARIO\"
START "" "%UNIDAD%:\cancer\Nueva carpeta\GEMOETRY DASH.HTML\backups\drive\DRIVE\Nueva carpeta\TEMP\GD 10 ANIVERSARIO\Geometry Dash 10-Year Anniversary.mp4"
goto GeometryDash
)
