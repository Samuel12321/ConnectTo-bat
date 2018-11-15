@echo off
@REM to comment out commands or text put "@REM" before them or :: (comment)

cmdkey /list 
IF EXIST "ConnectTo" (
goto CONNECT
) 
else( 
:: Check OS is compattable 
setlocal
for /f "tokens=2 delims=[]" %%i in ('ver') do set VERSION=%%i
for /f "tokens=2-3 delims=. " %%i in ("%VERSION%") do set VERSION=%%i.%%j
if "%VERSION%"=="5.00" set OperatingSys="Windows 2000"  
if "%VERSION%"=="5.0"  set OperatingSys="Windows ME"
if "%VERSION%"=="5.1" set OperatingSys="Windows XP"
if "%VERSION%"=="6.0" set OperatingSys="Windows Vista"
if "%VERSION%"=="6.1" set OperatingSys="Windows 7"
if "%VERSION%"=="6.2" set OperatingSys="Windows 8"
if "%VERSION%"=="6.3" set OperatingSys="Windows 8.1"
if "%VERSION%"=="6.4" set OperatingSys="Windows 10"
if "%VERSION%"=="10.0" set OperatingSys="Windows 10"

If "%VERSION%"=! "6.1", "6.3", "6.4", "10.0"
(
echo Unsupported OS
if "%OperatingSys%"=="Windows 2000", "Windows ME","Windows XP","Windows Vista","Windows 8"
(
echo You are an irresponsible security hazard, this application will not run on your OS, Upgrade Your OS immediately
)
exit
)
echo your Operating System (%OperatingSys%) is supported 
endlocal
:: End OS compatible Check
echo Use VPN y/n? "echo"
set UseVPN=""
if UseVPN==y
(
echo Please ensure your VPN rasphone.exe file is labled 'INSERTvpnNAMEhere'
)
echo Use WakeOnLan Y/N? "echo"
set UseWOL=""
if UseWOL==y
(
echo Please enter Remote Desktop Mac Address "echo"
set MacAddress=""
echo Please enter Remote Desktop IP Address "echo"
set IpAddress=""
echo Please enter Remote Desktop Subnet Mask "echo"
set SubnetMask=""
echo Please enter Remote Desktop Port Number "echo"
set PortNumber=""
)
echo Please enter your Remote Desktop username "echo"
set Usrname="" 
echo Please enter your Remote Desktop password "echo"
set Password=""
start cmdkey /add:ConnectTo /user:%Usrname% /pass:%Password%
echo specify loction of.rdp file "echo "
set Locationrdp=""

goto CONNECT
)

:CONNECT

:: Connecting to VPN...
if UseVPN==y
( 
rasphone.exe -d "INSERTvpnNAMEhere"
)

if UseWOL==y
(
 wolcmd %MacAddress% %IpAddress% %SubnetMask% %PortNumber%  :: Wake on Lan Command Line 
)


:: runs remote desktop connection and waits for remote desktop to close
START /W mstsc.exe "%locationrdp%" 


if UseVPN==y
( 
rasphone.exe -h "INSERTvpnNAMEhere"
)


exit
