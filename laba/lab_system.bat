@echo off
chcp 65001 > nul

:menu
cls
echo   СИСТЕМА МОДЕЛИРОВАНИЯ ПРОЦЕССОВ РАЗРАБОТКИ ПО
echo.
echo 1. Модуль выбора технологий (chapter1.bat)
echo 2. Модуль инспекции кода (chapter2.bat)
echo 3. Модуль сравнительного анализа (chapter3.bat)
echo 4. Запустить все модули последовательно
echo 5. Выход
echo.
set /p choice="Ваш выбор (1-5): "

if "%choice%"=="1" (
    cls
    call chapter1.bat
)
if "%choice%"=="2" (
    cls
    call chapter2.bat
)
if "%choice%"=="3" (
    cls
    call chapter3.bat
)
if "%choice%"=="4" (
    cls
    call chapter1.bat
    cls
    call chapter2.bat
    cls
    call chapter3.bat
    cls
    echo
    echo   ИТОГОВЫЙ ОТЧЁT
    echo.
    echo Модуль 1 (Выбор технологии): Рекомендован %rec_tech%
    echo Модуль 2 (Инспекция кода):   Уровень - %reviewer_level% (Точность: %percentage%%%)
    echo Модуль 3 (Анализ WSM):       Победитель - %wsm_winner%
    echo.
    (
        echo 
        echo   ИТОГОВЫЙ ОТЧЁТ СИСТЕМЫ
        echo 
        echo Дата и время формирования: %DATE% %TIME%
        echo.
        echo 1. Рекомендация по выбору CI/CD системы: %rec_tech%
        echo 2. Результат код-ревью: %reviewer_level% (Точность: %percentage%%%, Очки: %points%)
        echo 3. Победитель сравнительного анализа (WSM): %wsm_winner%
    ) > report.txt
    echo Отчёт успешно сохранён(report.txt)
    echo.
    pause
)
if "%choice%"=="5" exit
goto menu
