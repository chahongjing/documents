@echo off
title documents push
echo.
set /p comment=�����뱸ע:
git commit -m %comment%
git push documents master
pause;