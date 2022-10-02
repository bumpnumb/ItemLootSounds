echo on 

:loop
git pull
timeout /t 10 /nobreak
goto loop


