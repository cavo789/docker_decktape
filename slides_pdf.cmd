@echo off

::-------------------------------------------------------------
:: Convert an online RevealJs presentation to PDF; extracting each
:: slide as a JPG image.
:: Rely on Decktape (https://hub.docker.com/r/astefanutti/decktape)
::-------------------------------------------------------------

cls 

set argcount=0
for %%i in (%*) do set /a argcount+=1

IF "%argcount%" NEQ "0" (
    call :fnConvert %1
) ELSE (
    call :fnShowHelp
)

GOTO end

:fnShowHelp

    echo [36mHow to use?[0m
    echo.
    echo Please run %~n0%~x0 with the URL to your reveal presentation.
    echo.
    echo For instance: %~n0%~x0 https://slides.mysite.be/slides
    echo.
    echo The slideshow will then be converted to a PDF file.
    echo Each slide will be saved as a JPG in the %cd%\.slides_output folder.
    echo.

    GOTO:EOF

:fnConvert

    IF NOT EXIST %cd%\.slides_output MKDIR %cd%\.slides_output

    echo [36mRun decktape...[0m
    echo.
    echo Convert %1 to %cd%\slides.pdf
    echo.

    docker run --rm -t -v %cd%:/slides astefanutti/decktape --size 1280x720 --screenshots --screenshots-directory .slides_output --screenshots-format jpg reveal %1 slides.pdf

    echo.

    GOTO:EOF

::-------------------------------------------------------------
:: Job done
::-------------------------------------------------------------
:end

    echo [33mEnjoy your day![0m
    echo.
