ECHO OFF
ECHO Beginning build

ca65 -D EHBASIC ..\src\min.asm -o min.o
IF %ERRORLEVEL% NEQ 0 (
  ECHO Failed to compile
  EXIT ERROR
)

ld65 -C ..\src\monmin.cfg min.o -o min.bin
IF %ERRORLEVEL% NEQ 0 (
  ECHO Failed to link
  EXIT ERROR
)

ECHO Compile and linking OK



ECHO Built successfully
