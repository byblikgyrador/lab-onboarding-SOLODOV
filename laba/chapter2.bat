@echo off
chcp 65001 > nul
set correct=0
set points=0
set total=3
echo.

echo Фрагмент 1
echo 10: def deploy_service(env):
echo 11:     status = run_ansible_playbook(env)
echo 12:     return status
echo 13:     notify_slack("Deploy finished!")
echo.
echo Какой дефект здесь скрыт?
echo 1. Мёртвое присваивание
echo 2. Недостижимый код после return (уведомление в Slack не отправится)
echo 3. Неинициализированная переменная
choice /c 123 /n
if errorlevel 3 goto wrong1
if errorlevel 2 goto right1
if errorlevel 1 goto wrong1

:right1
echo Верно! Строка 13 после return никогда не выполнится. (+10 очков)
set /a correct+=1
set /a points+=10
goto frag2

:wrong1
echo Неверно. Правильный ответ: 2. (-5 очков)
set /a points-=5

:frag2
echo.
echo Фрагмент 2
echo 20: def check_build_timeout(duration_sec):
echo 21:     if duration_sec ^> 1800:
echo 22:         abort_pipeline()
echo 23:     return True
echo.
echo Какой дефект здесь скрыт?
echo 1. Магическое число (1800 секунд нужно вынести в константу MAX_BUILD_TIME)
echo 2. Утечка ресурса
echo 3. Неинициализированная переменная
choice /c 123 /n
if errorlevel 3 goto wrong2
if errorlevel 2 goto wrong2
if errorlevel 1 goto right2

:right2
echo Верно! Число 1800 вшито в код без пояснения, его нужно вынести в константу. (+10 очков)
set /a correct+=1
set /a points+=10
goto frag3

:wrong2
echo Неверно. Правильный ответ: 1. (-5 очков)
set /a points-=5

:frag3
echo.
echo Фрагмент 3
echo 30: def run_migrations(db_url):
echo 31:     conn = connect_db(db_url)
echo 32:     conn.execute("ALTER TABLE users ADD COLUMN role TEXT;")
echo 33:     return "OK"
echo.
echo Какой дефект здесь скрыт?
echo 1. Мёртвое присваивание
echo 2. Неинициализированная переменная
echo 3. Отсутствие обработки ошибок и закрытия соединения (утечка ресурса)
choice /c 123 /n
if errorlevel 3 goto right3
if errorlevel 2 goto wrong3
if errorlevel 1 goto wrong3

:right3
echo Верно! Нет блока try/except/finally для перехвата ошибок миграции и закрытия conn. (+10 очков)
set /a correct+=1
set /a points+=10
goto report2

:wrong3
echo Неверно. Правильный ответ: 3. (-5 очков)
set /a points-=5

:report2
echo.
echo === Итоговый отчёт ===
echo Просмотрено фрагментов: %total%
echo Правильных ответов: %correct% из %total%
echo Набрано очков: %points%
set /a percentage=correct*100/total
echo Точность: %percentage%%%

set reviewer_level=Junior Reviewer
if %percentage% geq 80 set reviewer_level=Senior Reviewer
if %percentage% geq 50 if %percentage% lss 80 set reviewer_level=Middle Reviewer

echo Уровень ревьюера: %reviewer_level%
echo.
pause
