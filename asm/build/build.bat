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

path ..\..\tools\SBCTools\BinToMif\bin\Release
BinToMif.exe min.bin monmin.mif
IF %ERRORLEVEL% NEQ 0 (
  ECHO Failed to convert binary
  EXIT ERROR
)

%systemroot%\System32\xcopy /y monmin.mif ..\..\hdl\rtl\monmin.mif
ECHO Copied memory init file to project

ECHO Built successfully
