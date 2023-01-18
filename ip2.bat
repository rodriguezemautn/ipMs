@echo off

REM External IP
for /f "tokens=2 delims=:" %%a in ('ping -n 1 -4 icanhazip.com ^| findstr Pinging') do set externalip=%%a
echo External IP: %externalip%

REM Interfaces
setlocal enabledelayedexpansion
for /f "tokens=*" %%a in ('ipconfig ^| findstr Ethernet') do (
    set interface=%%a
    set interface=!interface:Ethernet adapter =!
    set interface=!interface:*:=!
    echo Interface: !interface!
)

REM MAC address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr Physical') do set mac=%%a
echo MAC address: %mac%

REM Netmask
for /f "tokens=3 delims=:" %%a in ('ipconfig ^| findstr Mask') do set netmask=%%a
echo Netmask: %netmask%

REM Gateway
for /f "tokens=3 delims=:" %%a in ('route print ^| findstr "0.0.0.0 "') do set gateway=%%a
echo Gateway: %gateway%

REM DNS servers
for /f "tokens=3 delims=:" %%a in ('ipconfig ^| findstr "DNS Servers"') do set dns=%%a
echo DNS servers: %dns%

REM Proxy server
for /f "tokens=2 delims=:" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer ^| findstr ProxyServer') do set proxy=%%a
echo Proxy server: %proxy%
