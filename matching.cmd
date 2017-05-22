@ECHO OFF
SET startfolder=experiments\images
for /D %%f IN (%startfolder%\output\*) do (
    start matlab -nosplash -nodisplay -nodesktop -r "automateMatcher('%startfolder%\original','%%f','Settings\settingsMaxCurvature.ini');exit;"
    ping -n 500 127.0.0.1 > NUL
 )