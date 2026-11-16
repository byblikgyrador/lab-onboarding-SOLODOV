@echo off
chcp 65001 > nul

:weights
echo === Модуль сравнительного анализа CI/CD систем ===
echo.
echo Назначьте веса критериям (сумма должна быть равна 100):
set /p w1="Вес критерия 1 (Скорость настройки и деплоя): "
set /p w2="Вес критерия 2 (Простота поддержки для команды из 5 чел.): "
set /p w3="Вес критерия 3 (Стоимость владения / бесплатные лимиты): "

set /a total_weight=w1+w2+w3
if %total_weight% neq 100 (
    echo Ошибка: сумма весов равна %total_weight%, а должна быть 100! Попробуйте снова.
    echo.
    goto weights
)

echo.
echo Оцените альтернативы по шкале от 1 до 5:
echo --- GitLab CI ---
set /p gl_1="GitLab CI по критерию 1 (Скорость настройки): "
set /p gl_2="GitLab CI по критерию 2 (Простота поддержки): "
set /p gl_3="GitLab CI по критерию 3 (Стоимость владения): "

echo --- Jenkins ---
set /p jk_1="Jenkins по критерию 1 (Скорость настройки): "
set /p jk_2="Jenkins по критерию 2 (Простота поддержки): "
set /p jk_3="Jenkins по критерию 3 (Стоимость владения): "

echo --- CircleCI ---
set /p cc_1="CircleCI по критерию 1 (Скорость настройки): "
set /p cc_2="CircleCI по критерию 2 (Простота поддержки): "
set /p cc_3="CircleCI по критерию 3 (Стоимость владения): "

set /a score_gl=gl_1*w1+gl_2*w2+gl_3*w3
set /a score_jk=jk_1*w1+jk_2*w2+jk_3*w3
set /a score_cc=cc_1*w1+cc_2*w2+cc_3*w3

echo.
echo === Матрица решений ===
echo Критерий              ^| Вес ^| GitLab CI ^| Jenkins ^| CircleCI
echo --------------------------------------------------------------
echo Скорость деплоя       ^| %w1%  ^| %gl_1%         ^| %jk_1%       ^| %cc_1%
echo Простота поддержки    ^| %w2%  ^| %gl_2%         ^| %jk_2%       ^| %cc_2%
echo Стоимость владения    ^| %w3%  ^| %gl_3%         ^| %jk_3%       ^| %cc_3%
echo --------------------------------------------------------------
echo ИТОГО                 ^| 100 ^| %score_gl%       ^| %score_jk%     ^| %score_cc%
echo.

set wsm_winner=GitLab CI
if %score_jk% gtr %score_gl% if %score_jk% geq %score_cc% set wsm_winner=Jenkins
if %score_cc% gtr %score_gl% if %score_cc% gtr %score_jk% set wsm_winner=CircleCI

echo Победитель сравнительного анализа: %wsm_winner%
echo.
pause
