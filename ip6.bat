@echo off

rem External IP
for /f "tokens=2 delims=:" %%a in ('nslookup myip.opendns.com. resolver1.opendns.com^|find "Address:"') do set "externalip=%%a"
echo External IP: %externalip%

rem Interfaces
for /f "tokens=1,*" %%a in ('ipconfig ^| findstr "Ethernet adapter"') do echo Interface: %%b

rem MAC address, netmask, and gateway
for /f "tokens=1,*" %%a in ('ipconfig ^| findstr "Ethernet adapter"') do (
    echo MAC address: 
    for /f "tokens=1,*" %%i in ('ipconfig ^| findstr /i "Physical Address"') do echo %%j
    echo Netmask: 
    for /f "tokens=1,*" %%i in ('ipconfig ^| findstr /i "Subnet Mask"') do echo %%j
    echo Gateway: 
    for /f "tokens=1,*" %%i in ('ipconfig ^| findstr /i "Default Gateway"') do echo %%j
)

rem DNS servers
for /f "tokens=1,*" %%a in ('ipconfig ^| findstr "DNS Servers"') do echo DNS Server: %%b

rem Proxy server
for /f "tokens=1,*" %%a in ('netsh winhttp show proxy') do (
    if "%%a"=="Proxy Server(s)" (
        set "proxy=%%b"
        echo Proxy Server: %proxy%
    )
)