@echo off
:: This batch script will zip up the contents of the folder its in and drop it in the pack folder
:: Handy for doing releases
setlocal enabledelayedexpansion
cd %~dp0
set currentDir=%~dp0

set packname=dual_mp3cr.zip
set udo=%OneDrive%\Documents\EmoTracker\packs\%packname%
set udd=%USERPROFILE%\Documents\EmoTracker\packs\%packname%
set udl=%udd% %udo%
set runfail=0
set itemlist=0
echo .


::Calls all locations and sees if a file exists

(for %%a in (%udl%) do (
  (set /a itemlist=itemlist+1)
  (if exist %%a (
    (echo %%a located.)
    (del %%a 2>NUL)
    ("C:\Program Files\7-Zip\7z.exe" a %%a %currentDir%/ xr!*.git xr!*.bat xr!*.pdn xr!*_uncompressed* xr!.git*)
    (echo %%a replaced.)
  ) else (
    (set /a runfail=runfail+1)
    (echo %runfail%)
  ))
))


::If there is such a case where the tracker does not exist

echo .
if %runfail% GEQ %itemlist% (
  (del %udo% 2>NUL)
  ("C:\Program Files\7-Zip\7z.exe" a %udo% %currentDir%/ xr!*.git xr!*.bat xr!*.pdn xr!*_uncompressed* xr!.git*)
) else (
  echo .
)

::Test

"C:/ProgramData/Microsoft/Windows/Start Menu/Programs/EmoTracker/EmoTracker.lnk"
