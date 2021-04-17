ECHO OFF

iverilog -v -o sbc_system.vvp -I ..\rtl -DFAKE_BRAM ..\rtl\sbc_system.v
IF %ERRORLEVEL% NEQ 0 (
  ECHO Failed to build
  EXIT ERROR
)

vvp sbc_system.vvp

ECHO iverilog build success
