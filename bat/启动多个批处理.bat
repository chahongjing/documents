F:

if exist "F:\MyWorkplace\文档\trunk\bat\设置批处理窗口名称.bat" (
  echo startup bat1 ...
  cd "F:\MyWorkplace\文档\trunk\bat"
  call "设置批处理窗口名称.bat"
  ping 127.0.0.1 -n 5 >nul
)

if exist "F:\MyWorkplace\文档\trunk\bat\设置批处理窗口名称.bat" (
  echo startup bat2 ...
  cd "F:\MyWorkplace\文档\trunk\bat"
  call "设置批处理窗口名称.bat"
  ping 127.0.0.1 -n 5 >nul
)
pause;