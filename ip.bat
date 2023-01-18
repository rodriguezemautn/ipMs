@echo off
echo ========================================================================================================================
rem IP Publica
echo ip Publica:
for /f "tokens=2 delims=:" %%a in ('nslookup myip.opendns.com. resolver1.opendns.com^|find "Address:"') do set "externalip=%%a"
echo External IP: %externalip%
echo.
rem Servidor Proxy
echo Servidor Proxy:
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer
echo ========================================================================================================================
echo.
rem Obtener información de interfaces de red y hostname
ipconfig /all | findstr /i "Adaptador Dirección IPv4 Dirección física Máscara subred Puerta Servidor"
echo.
)