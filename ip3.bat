@echo off

rem External IP
for /f "tokens=2 delims=:" %%a in ('nslookup myip.opendns.com. resolver1.opendns.com^|find "Address:"') do set "externalip=%%a"
echo External IP: %externalip%

rem Obtener información de interfaces de red
echo.
for /f "tokens=*" %%a in ('ipconfig /all   ^| findstr /i "Adaptador de Ethernet"') do echo %%a
echo.
for /f "tokens=2 delims=:" %%a in ('ipconfig /all  ^| findstr /i "Dirección IPv4"') do echo Direccion IP: %%a
for /f "tokens=2 delims=:" %%a in ('ipconfig /all  ^| findstr /i "Dirección física"') do echo MAC: %%a
for /f "tokens=2 delims=:" %%a in ('ipconfig /all  ^| findstr /i "Máscara de subred"') do echo Mascara de subred: %%a
for /f "tokens=2 delims=:" %%a in ('ipconfig /all  ^| findstr /i "Puerta de enlace predeterminada"') do echo Puerta de enlace predeterminada: %%a
for /f "tokens=2 delims=:" %%a in ('ipconfig /all  ^| findstr /i "Servidores DNS"') do echo Servidores DNS: %%a


REM Proxy server
for /f "tokens=2 delims=:" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer ^| findstr ProxyServer') do set proxy=%%a
echo Proxy server: %proxy%

