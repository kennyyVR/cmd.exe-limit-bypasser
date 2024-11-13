@echo off
:loop
set /p cmd_input=Enter a command to run (or type 'exit' to quit): 
if "%cmd_input%"=="exit" exit

:: Handle 'clr' or 'Clear' commands to clear the screen
if /i "%cmd_input%"=="clr" (
    cls
    goto loop
)
if /i "%cmd_input%"=="Clear" (
    cls
    goto loop
)

:: Check if the command is "Send Pings"
if /i "%cmd_input%"=="Send Pings" (
    :: Prompt for IP address
    set /p ip_address=Enter IP address to ping (or type 'stop' to cancel): 
    
    :: Check if the user typed 'stop'
    if /i "%ip_address%"=="stop" (
        echo Ping operation canceled.
        goto loop
    )

    :: Check if the user typed '0' to stop pinging
    if "%ip_address%"=="0" (
        echo Stopping pinging.
        goto loop
    )

    echo Pinging %ip_address% as fast as possible. Type '0' to stop. Type 'exit' to quit.

    :pingloop
    :: Ping the IP address with no delay
    ping -n 1 %ip_address% > nul
    if errorlevel 1 (
        echo Ping failed. Try again or check the IP address.
    ) else (
        echo Ping to %ip_address% successful.
    )

    :: Minimize delay as much as possible
    timeout /nobreak /t 0 > nul
    goto pingloop
)

:: If the input isn't "Send Pings", try executing it as a command
%cmd_input%
goto loop
