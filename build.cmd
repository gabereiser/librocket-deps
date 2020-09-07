
@ECHO OFF
ECHO Dependency compilation starting...

:: Target  = CMAKE Build Dir
:: lib     = Post-combine lib dir
:: include = Headers for all included libs

RMDIR /s /q target
RMDIR /s /q lib
RMDIR /s /q include

MD target >NUL
MD lib >NUL
MD include\freetype >NUL
MD include\libzip >NUL
MD include\zlib >NUL
MD include\glm >NUL
MD include\json >NUL

CD target

ECHO Running cmake.

cmake -D CMAKE_INSTALL_PREFIX=./install .. >NUL
COPY zlib\zconf.h ..\zlib\zconf.h >NUL

ECHO Configuration complete.
ECHO Compiling...

devenv rocket-deps.sln /build Release

ECHO Compiling complete.
ECHO Gathering...

@call ..\combine_static_libraries.cmd librocket-deps

CD ..

XCOPY /S /Y /Q /H freetype2\include\* include\
XCOPY /S /Y /Q /H target\freetype2\include\* include\
XCOPY /S /Y /Q /H glm\glm\* include\glm\
XCOPY /S /Y /Q /H SDL\include\* include\
XCOPY /S /Y /Q /H target\SDL\include\* include\
XCOPY /S /Y /Q /H json\single_include\nlohmann\* include\json\
XCOPY /S /Y /Q /H libzip\lib\*.h include\libzip\
XCOPY /S /Y /Q /H zlib\*.h include\zlib\

XCOPY /S /Y /Q /H target\librocket-deps.lib lib\

ECHO Dependency compilation complete!
