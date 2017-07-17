@echo PASSWORDS WILL BE SAVED IN FoundPasswords.txt

rem delete FoundPasswords.txt if there is one
IF EXIST "FoundPasswords.txt" del FoundPasswords.txt

rem find all wifi names used on the local machine
netsh wlan show profile | findstr All>>FoundPasswords.txt

rem show the user how many were found
setlocal EnableDelayedExpansion
set "cmd=findstr "^^" FoundPasswords.txt | find /C ":""
for /f %%a in ('!cmd!') do set number=%%a
@echo FOUND: %number% WIFI NETWORKS

rem Put each Wifi network name into array
@echo off &setlocal enabledelayedexpansion
for /F "tokens=2 delims=:" %%a in (FoundPasswords.txt) do (
    set /A count+=1
    set "array[!count!]=%%a"
)

rem get rid of space in wifi name string array 
@echo off
setlocal enabledelayedexpansion

for /l %%j in (1,1,!count!) do (
	set array[%%j]=!array[%%j]:~1!
)
  
del FoundPasswords.txt
  
rem Show results to user 
@echo _____________________________________________________
@echo.
@echo 		   RESULTS

for /l %%k in (1,1,!count!) do (
	@echo _____________________________________________________
	@echo.
	@echo       Wifi Name            : !array[%%k]!
	@echo       Wifi Name            : !array[%%k]!>>FoundPasswords.txt
	netsh wlan show profile name="!array[%%k]!" key=clear | findstr Content 
	netsh wlan show profile name="!array[%%k]!" key=clear | findstr Content>>FoundPasswords.txt
	@echo. >>FoundPasswords.txt
	
	)
@echo.
@echo PASSWORDS WILL BE SAVED IN FoundPasswords.txt in this directory
@echo.
	
timeout 10
