F:

if exist "F:\MyWorkplace\�ĵ�\trunk\bat\����������������.bat" (
  echo startup bat1 ...
  cd "F:\MyWorkplace\�ĵ�\trunk\bat"
  call "����������������.bat"
  ping 127.0.0.1 -n 5 >nul
)

if exist "F:\MyWorkplace\�ĵ�\trunk\bat\����������������.bat" (
  echo startup bat2 ...
  cd "F:\MyWorkplace\�ĵ�\trunk\bat"
  call "����������������.bat"
  ping 127.0.0.1 -n 5 >nul
)
pause;