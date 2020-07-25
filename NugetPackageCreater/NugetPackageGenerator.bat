ECHO OFF

SETLOCAL=ENABLEDELAYEDEXPANSION

    REN NugetVersionNumber.txt text.tmp
    FOR /f %%a in (text.tmp) do (
        SET ver=%%a 			
        ) 
SET /A VersionNumber=!ver!+1
ECHO %VersionNumber% >> NugetVersionNumber.txt
DEL text.tmp


SET output_dir="local-nuget-repo"


SET version_suffix=alpha

SET version_prefix=1.0.%VersionNumber%

SET project_dir="..\..\Core"

SET curr_dir=%cd%"

SET version="%version_prefix%-%version_suffix%"

::Delete output_dir if already exists

RMDIR /S /Q  %output_dir%


FOR /R %project_dir% %%G IN (*.csproj) DO (

dotnet pack %%G -p:PackageVersion=%version% --no-build --output %output_dir% --configuration Debug

)

ECHO %errorlevel%
IF %errorlevel% NEQ 0 GOTO ERROR

FOR %%G in ("%output_dir%\*.nupkg") DO (
nuget add %%G -source %output_dir%
)

SET /P upload_required=Do you want to upload packages to nuget server? Y/N:

IF "%upload_required%" NEQ "y" GOTO OK

FOR %%G in ("%output_dir%\*.nupkg") DO (
dotnet nuget push %%G -k oy2ne2ogvuug4i6emziqw2jgcuwn3ivurcto4srthcs7ky -s https://api.nuget.org/v3/index.json
)

SET /P delete_required=Do you want to delete local nuget temp folder? Y/N:
IF "%delete_required%" NEQ "y" GOTO OK
RMDIR /S /Q  %output_dir%


ECHO %errorlevel%
IF %errorlevel% NEQ 0 ( GOTO ERROR )
GOTO OK




:ERROR
ECHO ON
ECHO "Program failed, please check this log file for errors ..."
ECHO OFF
GOTO END

:OK
ECHO ON
ECHO "Program successful"
ECHO OFF
GOTO END

:END
CD %curr_dir%





