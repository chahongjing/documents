@echo off

set remotename=documents

:head
echo.
set /p type=git type: pull(1), add(2), commit(3), push(4), status(5):
if "%type%"=="1" (
  goto gitpull
)
if "%type%"=="2" (
  goto gitadd
)
if "%type%"=="3" (
  goto xgitcommit
)
if "%type%"=="4" (
  goto gitpush
)
if "%type%"=="5" (
  goto gitstatus
)
echo quit
goto end

:gitpull
echo.
echo git pull
git pull %remotename% master
set type=
goto head

:gitadd
echo.
echo git add
git add .
set type=
goto head

:gitcommit
echo.
echo git commit
set /p commsg=commit: 
git commit -m %commsg%
set type=
goto head

:gitpush
echo.
echo git push
git push %remotename% master
set type=
goto head

:gitstatus
echo.
echo git status
git status
set type=
goto head

:end