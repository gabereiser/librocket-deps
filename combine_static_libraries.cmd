SETLOCAL EnableDelayedExpansion
:: %1 will be the name of the output lib
@ECHO off
ECHO Combining Libraries...
SET _libs=glfw/src/Release/glfw3.lib zlib/Release/zlibstatic.lib freetype2/Release/freetype.lib libzip/lib/Release/zip.lib

SET libs=

@FOR /F "tokens=*" %%G IN ('DIR /S /B *.lib') DO (
	SET libs=!libs!%%G 
)

ECHO Combination complete.
lib /out:%1.lib %_libs%

