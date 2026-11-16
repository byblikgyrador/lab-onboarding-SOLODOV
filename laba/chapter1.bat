@echo off
chcp 65001 > nul
set score_gitlab=0
set score_jenkins=0
set score_circleci=0

echo === Модуль выбора CI/CD системы (Вариант 7) ===
echo.

echo 1. Облачный сервис без необходимости администрировать свои серверы
echo 2. В связке с репозиторием GitLab (облако или свой сервер с авто-раннерами)
echo 3. Полностью на собственных серверах (On-Premise) с тонкой настройкой
choice /c 123 /n
if errorlevel 3 set /a score_jenkins+=20
if errorlevel 2 set /a score_gitlab+=20
if errorlevel 1 set /a score_circleci+=20
echo.

echo 1. Максимально быстро: нужны готовые шаблоны (Orbs) для Python и Docker
echo 2. Быстро: декларативный YAML-файл прямо в корне репозитория
echo 3. Сроки позволяют потратить время на установку плагинов и написание Groovy-скриптов
choice /c 123 /n
if errorlevel 3 set /a score_jenkins+=15
if errorlevel 2 set /a score_gitlab+=15
if errorlevel 1 set /a score_circleci+=15
echo.

echo 1. Бюджет минимальный, нет выделенного DevOps-инженера, код уже в GitLab
echo 2. Бюджет нулевой на лицензии, но в команде есть специалист для поддержки сервера
echo 3. Есть бюджет на облачные минуты ради максимальной скорости сборки
choice /c 123 /n
if errorlevel 3 set /a score_circleci+=15
if errorlevel 2 set /a score_jenkins+=15
if errorlevel 1 set /a score_gitlab+=15
echo.

echo Итоговые баллы: GitLab CI = %score_gitlab%, Jenkins = %score_jenkins%, CircleCI = %score_circleci%

set rec_tech=GitLab CI
if %score_jenkins% gtr %score_gitlab% if %score_jenkins% geq %score_circleci% set rec_tech=Jenkins
if %score_circleci% gtr %score_gitlab% if %score_circleci% gtr %score_jenkins% set rec_tech=CircleCI

echo Рекомендация: %rec_tech%
echo.
pause
