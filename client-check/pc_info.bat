@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul
set "REPORT_FILE=%~dp0pc_report.txt"
set "TEMP_APPS=%TEMP%\apps_list.txt"
set "SORTED_APPS=%TEMP%\apps_list_sorted.txt"
:: Очищаем старые файлы перед началом работы
if exist "%REPORT_FILE%" del /q "%REPORT_FILE%"
if exist "%TEMP_APPS%" del /q "%TEMP_APPS%"
if exist "%SORTED_APPS%" del /q "%SORTED_APPS%"
call :log "ДИАГНОСТИКА И АУДИТ КОМПЬЮТЕРА"
call :log ""
call :log "Дата и время проверки: %DATE% %TIME%"
call :log "Имя компьютера: %COMPUTERNAME%"
call :log "Имя пользователя: %USERNAME%"
call :log ""
call :log "[Операционная система]"
set "os_name="
set "os_version="
for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value 2^>nul') do if not "%%i"==" " set "os_name=%%i"
for /f "tokens=2 delims==" %%i in ('wmic os get Version /value 2^>nul') do if not "%%i"==" " set "os_version=%%i"
if not defined os_name (
    for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).Caption" 2^>nul`) do set "os_name=%%A"
)
if not defined os_version (
    for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).Version" 2^>nul`) do set "os_version=%%A"
)
if defined os_name ( call :log "Название: %os_name%" ) else ( call :log "Название: [ОШИБКА] Не удалось получить данные" )
if defined os_version ( call :log "Версия:   %os_version%" ) else ( call :log "Версия:   [ОШИБКА] Не удалось получить данные" )
call :log ""
call :log "[Процессор]"
set "cpu_name="
for /f "tokens=2 delims==" %%i in ('wmic cpu get Name /value 2^>nul') do if not "%%i"==" " set "cpu_name=%%i"
if not defined cpu_name (
    for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "(Get-CimInstance Win32_Processor).Name" 2^>nul`) do set "cpu_name=%%A"
)
if defined cpu_name ( call :log "Модель:   %cpu_name%" ) else ( call :log "Модель:   [ОШИБКА] Не удалось получить данные" )
call :log ""
call :log "[Оперативная память]"
set "total_mem="
set "free_mem="
for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /value 2^>nul') do set "total_mem=%%i"
for /f "tokens=2 delims==" %%i in ('wmic os get FreePhysicalMemory /value 2^>nul') do set "free_mem=%%i"
if defined total_mem (
    set /a total_gb=%total_mem% / 1048576
    call :log "Всего памяти:     !total_gb! ГБ"
) else (
    for /f "usebackq" %%A in (`powershell -NoProfile -Command "[math]::round((Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize / 1MB)" 2^>nul`) do set "total_gb=%%A"
    if defined total_gb ( call :log "Всего памяти:     !total_gb! ГБ" ) else ( call :log "Всего памяти: [ОШИБКА] Ошибка расчета" )
)
if defined free_mem (
    set /a free_gb=%free_mem% / 1048576
    call :log "Свободно памяти:  !free_gb! ГБ"
) else (
    for /f "usebackq" %%A in (`powershell -NoProfile -Command "[math]::round((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB)" 2^>nul`) do set "free_gb=%%A"
    if defined free_gb ( call :log "Свободно памяти:  !free_gb! ГБ" ) else ( call :log "Свободно памяти:  [ОШИБКА] Ошибка расчета" )
)
call :log ""
call :log "[Диск C]"
set "disk_size="
set "disk_free="
for /f "tokens=2 delims==" %%i in ('wmic logicaldisk where DeviceID^="C:" get Size /value 2^>nul') do set "disk_size=%%i"
for /f "tokens=2 delims==" %%i in ('wmic logicaldisk where DeviceID^="C:" get FreeSpace /value 2^>nul') do set "disk_free=%%i"
if not defined disk_size (
    for /f "usebackq" %%A in (`powershell -NoProfile -Command "[math]::round((Get-CimInstance Win32_LogicalDisk -Filter ""DeviceID='C:'"").Size / 1GB)" 2^>nul`) do set "disk_size_gb=%%A"
) else (
    for /f "usebackq" %%A in (`powershell -NoProfile -Command "[math]::round(%disk_size% / 1GB)" 2^>nul`) do set "disk_size_gb=%%A"
)
if not defined disk_free (
    for /f "usebackq" %%A in (`powershell -NoProfile -Command "[math]::round((Get-CimInstance Win32_LogicalDisk -Filter ""DeviceID='C:'"").FreeSpace / 1GB)" 2^>nul`) do set "disk_free_gb=%%A"
) else (
    for /f "usebackq" %%A in (`powershell -NoProfile -Command "[math]::round(%disk_free% / 1GB)" 2^>nul`) do set "disk_free_gb=%%A"
)
if defined disk_size_gb ( call :log "Общий размер:     %disk_size_gb% ГБ" ) else ( call :log "Общий размер:     [ОШИБКА] Не удалось рассчитать" )
if defined disk_free_gb ( call :log "Свободно места:   %disk_free_gb% ГБ" ) else ( call :log "Свободно места:   [ОШИБКА] Не удалось рассчитать" )
call :log ""
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s /f DisplayName 2^>nul ^| findstr "DisplayName"') do echo %%b >> "%TEMP_APPS%"
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s /f DisplayName 2^>nul ^| findstr "DisplayName"') do echo %%b >> "%TEMP_APPS%"
if exist "%TEMP_APPS%" (
    powershell -NoProfile -Command "Get-Content '%TEMP_APPS%' | Select-Object -Unique | Sort-Object | Out-File -FilePath '%SORTED_APPS%' -Encoding utf8"
)
call :log "[Рекомендации по недостающему ПО]"
if not exist "%SORTED_APPS%" (
    call :log "  [КРИТИЧЕСКИЙ СБОЙ] Не удалось проанализировать реестр программ."
) else (
    set "found_app="
    for /f "usebackq delims=" %%A in (`findstr /I /C:"Office" /C:"LibreOffice" /C:"OpenOffice" /C:"МойОфис" "%SORTED_APPS%" 2^>nul`) do set "found_app=%%A"
    if defined found_app (
        call :log "  [ОК] Офисный пакет: Обнаружен (!found_app!)"
    ) else (
        call :log "  [ВНИМАНИЕ] Не обнаружен офисный пакет. Для базовой работы с документами рекомендуется установить LibreOffice или МойОфис."
    )
    set "found_app="
    for /f "usebackq delims=" %%A in (`findstr /I /C:"7-Zip" /C:"WinRAR" /C:"WinZip" "%SORTED_APPS%" 2^>nul`) do set "found_app=%%A"
    if defined found_app (
        call :log "  [ОК] Архиватор: Обнаружен (!found_app!)"
    ) else (
        call :log "  [ВНИМАНИЕ] Не обнаружен архиватор. Для работы с вложениями в почте рекомендуется установить 7-Zip или WinRAR."
    )
    set "found_app="
    for /f "usebackq delims=" %%A in (`findstr /I /C:"Acrobat" /C:"Foxit" /C:"SumatraPDF" "%SORTED_APPS%" 2^>nul`) do set "found_app=%%A"
    if defined found_app (
        call :log "  [ОК] Просмотр PDF: Обнаружен (!found_app!)"
    ) else (
        call :log "  [ВНИМАНИЕ] Не обнаружен PDF-ридер. Для работы со счетами и инструкциями рекомендуется установить Foxit или SumatraPDF."
    )
    set "found_app="
    for /f "usebackq delims=" %%A in (`findstr /I /C:"Chrome" /C:"Firefox" /C:"Yandex" "%SORTED_APPS%" 2^>nul`) do set "found_app=%%A"
    if defined found_app (
        call :log "  [ОК] Дополнительный браузер: Обнаружен (!found_app!)"
    ) else (
        call :log "  [ИНФО] Сторонние браузеры не найдены. Компонент системы Microsoft Edge используется по умолчанию."
    )
    set "found_app="
    for /f "usebackq delims=" %%A in (`findstr /I /C:"Kaspersky" /C:"ESET" /C:"Dr.Web" /C:"Defender" "%SORTED_APPS%" 2^>nul`) do set "found_app=%%A"
    if defined found_app (
        call :log "  [ОК] Антивирус: Обнаружен или контролируется системой (!found_app!)"
    ) else (
        call :log "  [ВНИМАНИЕ] Сторонний антивирус не зарегистрирован. Убедитесь, что встроенная защита Windows активна."
    )
)
call :log ""
call :log "[Рекомендации по излишнему ПО]"
if exist "%SORTED_APPS%" (
    set "has_excess=0"
    set "group_found=0"
    for /f "usebackq delims=" %%A in (`findstr /I /C:"Steam" /C:"Epic Games" /C:"GOG" /C:"Origin" /C:"Ubisoft" /C:"Battle.net" /C:"Riot" /C:"game" /C:"gaming" "%SORTED_APPS%" 2^>nul`) do (
        if !group_found!==0 (
            call :log "  -> Обнаружено игровое ПО (не относится к базовым офисным задачам и подлежит проверке):"
            set "group_found=1"
            set "has_excess=1"
        )
        call :log "     - %%A"
    )
    set "group_found=0"
    for /f "usebackq delims=" %%A in (`findstr /I /C:"torrent" /C:"uTorrent" /C:"BitTorrent" /C:"qBittorrent" /C:"Vuze" "%SORTED_APPS%" 2^>nul`) do (
        if !group_found!==0 (
            call :log "  -> Обнаружены файлообменные программы (Создают угрозу безопасности и трафика, рекомендуются к проверке):"
            set "group_found=1"
            set "has_excess=1"
        )
        call :log "     - %%A"
    )
    set "group_found=0"
    for /f "usebackq delims=" %%A in (`findstr /I /C:"Discord" /C:"Telegram" /C:"WhatsApp" /C:"Viber" /C:"Skype" "%SORTED_APPS%" 2^>nul`) do (
        if !group_found!==0 (
Используйте код с осторожностью.
call :log "  -> Обнаружены мессенджеры (Требуется верификация ИТ-отдела на соответствие регламентам связи):"
set "group_found=1"
set "has_excess=1"
)
call :log "     - %%A"
)
if !has_excess!==0 (
call :log "  [ОК] Явных признаков нецелевого или излишнего ПО не обнаружено."
)
)
call :log ""
call :log "Конец отчета. Все данные успешно зафиксированы."
if exist "%TEMP_APPS%" del /q "%TEMP_APPS%"
if exist "%SORTED_APPS%" del /q "%SORTED_APPS%"
echo.
echo Отчет сохранен в файл: pc_report.txt
echo.
pause
exit /b 0
:log
if "%~1" == "" (
echo(
echo(>> "%REPORT_FILE%"
exit /b
)
echo %~1
echo %~1>> "%REPORT_FILE%"
exit /b
