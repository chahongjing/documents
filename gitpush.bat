@echo off
title documents push
echo.
set /p comment=ÇëÊäÈë±¸×¢:
git commit -m %comment%
git push documents master
pause;