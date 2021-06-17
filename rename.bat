::重命名文件夹
set a=00

setlocal EnableDelayedExpansion

FOR /f "tokens=*" %%i IN ('dir /a:d /b') DO (

set /A a+=1

ren "%%i" "java-!a!"

)


