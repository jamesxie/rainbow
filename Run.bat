@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat

:menu
echo.
echo Package for target

echo  [1] 480                720 x 480               720 x 480                
echo  [2] 720                1280 x 720              1280 x 720               
echo  [3] 1080               1920 x 1080             1920 x 1080              
echo  [4] Droid              480 x 816               480 x 854                
echo  [5] FWQVGA             240 x 432               240 x 432                
echo  [6] FWVGA              480 x 854               480 x 854                
echo  [7] HVGA               320 x 480               320 x 480                
echo  [8] iPad               768 x 1004              768 x 1024               
echo  [9] iPhone             320 x 460               320 x 480                
echo  [10] iPhoneRetina       640x 920                640x 960                 
echo  [11] iPod               320 x 460               320 x 480                
echo  [12] NexusOne           480 x 762               480 x 800                
echo  [13] QVGA               240 x 320               240 x 320                
echo  [14] SamsungGalaxyS     480 x 762               480 x 800                
echo  [15] SamsungGalaxyTab   600 x 986               600 x 1024               
echo  [16] WQVGA              240 x 400               240 x 400                
echo  [17] WVGA               480 x 800               480 x 800     
echo.

:choice
set /P C=[Choice]: 
echo.
if "%c%"=="1" set SCREEN_SIZE=480
if "%c%"=="2" set SCREEN_SIZE=720
if "%c%"=="3" set SCREEN_SIZE=1080
if "%c%"=="4" set SCREEN_SIZE=Droid
if "%c%"=="5" set SCREEN_SIZE=FWQVGA
if "%c%"=="6" set SCREEN_SIZE=FWVGA
if "%c%"=="7" set SCREEN_SIZE=HVGA
if "%c%"=="8" set SCREEN_SIZE=iPad
if "%c%"=="9" set SCREEN_SIZE=iPhone
if "%c%"=="10" set SCREEN_SIZE=iPhoneRetina
if "%c%"=="11" set SCREEN_SIZE=NexusOne
if "%c%"=="12" set SCREEN_SIZE=QVGA
if "%c%"=="13" set SCREEN_SIZE=SamsungGalaxyS
if "%c%"=="14" set SCREEN_SIZE=SamsungGalaxyTab
if "%c%"=="15" set SCREEN_SIZE=WQVGA
if "%c%"=="16" set SCREEN_SIZE=WVGA

echo.
echo Starting AIR Debug Launcher with screen size '%SCREEN_SIZE%'
echo.
echo (hint: edit 'Run.bat' to test on device or change screen size)
echo.
adl -screensize %SCREEN_SIZE% "%APP_XML%" "%APP_DIR%"
if errorlevel 1 goto error
goto end


:ios-debug
echo.
echo Packaging application for debugging on iOS
echo.
set TARGET=-debug-interpreter
set OPTIONS=-connect %DEBUG_IP%
goto ios-package

:ios-test
echo.
echo Packaging application for testing on iOS
echo.
set TARGET=-test-interpreter
set OPTIONS=
goto ios-package

:ios-package
set PLATFORM=ios
call bat\Packager.bat

echo Now manually install and start application on device
echo.
goto error


:android-debug
echo.
echo Packaging and installing application for debugging on Android (%DEBUG_IP%)
echo.
set TARGET=-debug
set OPTIONS=-connect %DEBUG_IP%
goto android-package

:android-test
echo.
echo Packaging and Installing application for testing on Android (%DEBUG_IP%)
echo.
set TARGET=
set OPTIONS=
goto android-package

:android-package
set PLATFORM=android
call bat\Packager.bat

adb devices
echo.
echo Installing %OUTPUT% on the device...
echo.
adb -d install -r "%OUTPUT%"
if errorlevel 1 goto installfail

echo.
echo Starting application on the device for debugging...
echo.
adb shell am start -n air.%APP_ID%/.AppEntry
exit

:installfail
echo.
echo Installing the app on the device failed

:error
pause
