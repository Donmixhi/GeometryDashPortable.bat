@echo off
TITLE Geometry Dash...
COLOR A
cls 

set "DIRECTORIO=INICIALIZADOR.BAT"
for %%u in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%u:\%DIRECTORIO%" (
        set "UNIDAD=%%u"
        goto :FIN
    )
)
:FIN
REM MENU DE OPCIONES
:GEOMETRYDASH
cls
color a 
ECHO ====================================================
ECHO I 1.CREAR BACKUP       I 2-CARGAR BACKUP           I
ECHO I----------------------I---------------------------I
ECHO I 3.BORRAR APPDATA I 4.BORRAR BACKUPS I 5.EJECUTAR I          
ECHO ====================================================
SET ELECCION=0
set /p ELECCION=">_"
REM SEGUN CADA OPCION SE EJECUTAN LOS COMANDO SEGUN LA ETIQUETA
IF /i "%ELECCION%"=="1" (
    GOTO CREARBACKUP
) ELSE IF /i "%ELECCION%"=="2" (
    GOTO CARGARBACKUP
) ELSE IF /i "%ELECCION%"=="3" (
    GOTO BORRARAPPDATA
) ELSE IF /i "%ELECCION%"=="4" (
    GOTO BORRARBACKUPS
) ELSE IF "%ELECCION%"=="5" (
    REM REEMPLAZAR RUTA_DE_GD.EXE
    REM POR LA RUTA DE TU GD
    REM EJEMPLO 
    REM F:\APPS\GEOMETRYDASH.EXE
    REM LO PONDRAS ASI 
    REM %UNIDAD%:\APPS\GEOMETRYDASH.EXE
    REM START "" "%UNIDAD%:\APPS\GEOMETRYDASH.EXE"
    REM SIEMPRE REEMPLAZAR LA PRIMERA LETRA DE SU UBICACIÓN POR %UNIDAD%
    rem en caso de que tu gd este dentro de la carpeta de este archivo tendras que hacerlo asi
    rem F:\GDP\apps\geometrydash.exe
    REM START "" "%UNIDAD%apps\geometrydash.exe
    rem por que %unidad% valdra "F:\GDP\" 
    echo ejecutando
    START "" "%UNIDAD%:\APPS\GEOMETRYDASH.EXE" 
    echo listo 
    pause 
    GOTO GEOMETRYDASH
) ELSE (
    ECHO OPCIÓN NO VÁLIDA
    GOTO GEOMETRYDASH
)

:CREARBACKUP
CLS
COLOR A
rem Obtener la fecha actual en formato D-M-A
for /f "tokens=1-3 delims=/- " %%a in ('date /t') do (
    set dia=%%a
    set mes=%%b
    set YEAR=%%c
)

set fecha=%dia%-%mes%-%YEAR%

rem Especificar las rutas de los directorios
set "directorio_destino=%UNIDAD%BACKUPS\%fecha%"
set "directorio_mp3=%UNIDAD%BACKUPS\SONGS"
set "directorio_origen=C:\Users\user\AppData\Local\GeometryDash"
set "directorio_de_directorios=%UNIDAD%BACKUPS\LOGS"

rem Crear los directorios si no existen
if not exist "%directorio_destino%" mkdir "%directorio_destino%"
if not exist "%directorio_mp3%" mkdir "%directorio_mp3%"

rem Mover los archivos .mp3 y .ogg al directorio de archivos mp3
move "%directorio_origen%\*.mp3" "%directorio_mp3%"
move "%directorio_origen%\*.ogg" "%directorio_mp3%"
move "%directorio_origen%\*.dat" "%directorio_destino%"
move "%directorio_origen%\*.bak" "%directorio_destino%"
move "%directorio_origen%\*.json" "%directorio_destino%"
rem Mover el resto de los archivos al directorio con la fecha actual
robocopy "%directorio_origen%" "%directorio_de_directorios%" /E /V /MOV /XF *.dat *.bak *.json *.mp3 *.ogg
echo Todo el contenido ha sido movido exitosamente.
pause
GOTO GEOMETRYDASH

:CARGARBACKUP
CLS 
COLOR A
setlocal enabledelayedexpansion
ATTRIB "%UNIDAD%BACKUPS\GeometryDash" +H
ATTRIB "%UNIDAD%BACKUPS\LOGS" +H
ATTRIB "%UNIDAD%BACKUPS\SONGS" +H
rem Especificar el directorio de origen y destino
set "directorio_origen=%UNIDAD%BACKUPS"
if exist "C:\Users\user\AppData\Local\GeometryDash" (
goto continuar     
) else (
    mkdir "C:\Users\user\AppData\Local\GeometryDash"
    goto continuar
)

:continuar
set "directorio_destino=C:\Users\user\AppData\Local\GeometryDash\"

rem Inicializar contador de carpetas
set contador=0

rem Listar carpetas en el directorio de origen
echo Carpetas en %directorio_origen%:
for /d %%i in ("%directorio_origen%\*") do (
    set /a contador+=1
    set "carpeta_!contador!=%%i"
    echo !contador!. %%~nxi
)
SET seleccion=0
rem Solicitar número al usuario
set /p seleccion=Introduce el numero de la carpeta que deseas copiar:
rem Verificar si la selección es válida
if defined carpeta_%seleccion% (
    rem Obtener la ruta completa de la carpeta seleccionada
    set "carpeta_seleccionada=!carpeta_%seleccion%!"
    CLS
    ATTRIB "%UNIDAD%BACKUPS\GeometryDash" -H
    ATTRIB "%UNIDAD%BACKUPS\LOGS" -H
    ATTRIB "%UNIDAD%BACKUPS\SONGS" -H
    rem Copiar el contenido de la carpeta seleccionada al directorio de destino
    echo EXTRAYENDO contenido de !carpeta_seleccionada! a %directorio_destino%...
    robocopy "!carpeta_seleccionada!" "%directorio_destino%" /E /PURGE
    COPY "%UNIDAD%BACKUPS\SONGS\*.*" "%directorio_destino%"
    XCOPY "%UNIDAD%BACKUPS\LOGS\" "%directorio_destino%" /S /E 
    echo Copia completada exitosamente.
    pause
    goto GEOMETRYDASH
) else (
    echo Selección inválida. Por favor, ejecuta el archivo de nuevo y selecciona un número válido.
    GOTO CARGARBACKUP
)

pause
GOTO GEOMETRYDASH

:BORRARAPPDATA
CLS
COLOR A
setlocal

rem Especificar el directorio donde se encuentran las carpetas a borrar
set "directorioABORRAR=C:\Users\user\AppData\Local\GeometryDash"

rem Iterar sobre cada carpeta dentro del directorio y eliminarla
for /d %%i in ("%directorioABORRAR%\*") do (
    rd /S /Q "%%i"
)

RMDIR /S /Q %directorioABORRAR%

echo Todas las carpetas dentro de %directorioABORRAR% han sido eliminadas.
pause
GOTO GEOMETRYDASH


:BORRARBACKUPS
ATTRIB "%UNIDAD%BACKUPS\GeometryDash" +H
ATTRIB "%UNIDAD%BACKUPS\LOGS" +H
ATTRIB "%UNIDAD%BACKUPS\SONGS" +H
CLS 
COLOR A
setlocal enabledelayedexpansion

rem Especificar el directorio de origen y destino
set "directorio_origen=%UNIDAD%BACKUPS"
if exist "C:\Users\user\AppData\Local\GeometryDash" (
goto continuarA     
) else (
    mkdir "C:\Users\user\AppData\Local\GeometryDash"
    goto continuarA
)

:continuarA

rem Inicializar contador de carpetas
set contador=0

rem Listar carpetas en el directorio de origen
echo Carpetas en %directorio_origen%:
for /d %%i in ("%directorio_origen%\*") do (
    set /a contador+=1
    set "carpeta_!contador!=%%i"
    echo !contador!. %%~nxi
)
SET seleccion=0
rem Solicitar número al usuario
set /p seleccion=Introduce el numero de la carpeta que deseas BORRAR:
rem Verificar si la selección es válida
if defined carpeta_%seleccion% (
    rem Obtener la ruta completa de la carpeta seleccionada
    set "carpeta_seleccionada=!carpeta_%seleccion%!"
    CLS
    ATTRIB "%UNIDAD%BACKUPS\GeometryDash" -H
    ATTRIB "%UNIDAD%BACKUPS\LOGS" -H
    ATTRIB "%UNIDAD%BACKUPS\SONGS" -H
    rem Copiar el contenido de la carpeta seleccionada al directorio de destino
    echo BORRANDO contenido de !carpeta_seleccionada!...
    RMDIR /S "!carpeta_seleccionada!" 
    echo LISTO.
    pause
    goto GEOMETRYDASH
) else (
    echo Selección inválida. Por favor, ejecuta el archivo de nuevo y selecciona un número válido.
    GOTO CARGARBACKUP
)

pause
GOTO GEOMETRYDASH
