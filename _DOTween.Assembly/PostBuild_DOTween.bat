:: %1 = $(SolutionDir) ► Solution dir path - with final slash
:: %2 = $(TargetDir) ► Bin folder dir path - with final slash
:: %3 = $(TargetFileName) ► DLL filename with extension
:: %4 = $(TargetName) ► DLL filename without extension
:: %5 = Main export dir ► Main folder inside bin.Global/etc where to copy the files (ex: "DOTween", "DOTweenPro")
:: %6 = Bin dir name ► (ex: "bin", "bin_pro")
:: %7 = Eventual export subdir (can be NULL) ► Eventual subdirectory inside the main export dir (ex: "Editor")

echo :
echo :
echo :
echo :
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :::::::::::::::::: EXECUTING BATCH FILE :::::::::::::::::::::::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :
echo :
echo :
echo :
echo :::::: TARGET: %5 %7

echo :::::: Deleting TMPs...
DEL %2*.tmp

echo :::::: Converting PDB to MDB and deleting PDB...
CD %2
"c:\Program Files\pdb2mdb\pdb2mdb.exe" %3
echo ::: Deleting PDB files: %4.pdb
DEL %4.pdb
echo ::: PDB files deleted, PAUSE for 0.5 second
waitfor pdbsToBeDeletedHopefully /t 0.5 2>NUL || type nul>nul

echo :::::: Starting export...

set SubDir=%7
if not "%SubDir%"=="" ( set SubDir=\%7 )
set CopyFromDir=%1%6%SubDir%

set CopyToDir=%1..\..\bin.Global\%5%SubDir%
set CopyToDirNoMeta=%1..\..\bin.Global_no_meta\%5%SubDir%
set CopyToDirUnityTests=%1..\UnityTests.Unity4\Assets\Demigiant\%5%SubDir%
set CopyToDirUnity5Tests=%1..\UnityTests.Unity5\Assets\Demigiant\%5%SubDir%
set CopyToDirCompatibilityTests=%1..\UnityCompatibilityTests.Unity35\Assets\Demigiant\%5%SubDir%
set CopyToDirExtPluginsTests=%1..\ExternalPluginsTestsAndExamples.Unity5\Assets\Demigiant\%5%SubDir%
set CopyToDirModulesTest=%1..\ModulesTest.Unity2018\Assets\Demigiant\%5%SubDir%

:: For now build only to Modules test project
echo ::: Exporting from %CopyFromDir% to %CopyToDirModulesTest%
echo ::: f | xcopy %CopyFromDir% %CopyToDirModulesTest% /Y /I /E

exit /B

echo ::: Exporting from %CopyFromDir% to %CopyToDir%
echo ::: f | xcopy %CopyFromDir% %CopyToDir% /Y /I /E

echo ::: Exporting from %CopyFromDir% to %CopyToDirNoMeta%
echo ::: f | xcopy %CopyFromDir% %CopyToDirNoMeta% /Y /I /E

echo ::: Exporting from %CopyFromDir% to %CopyToDirUnityTests%
echo ::: f | xcopy %CopyFromDir% %CopyToDirUnityTests% /Y /I /E

echo ::: Exporting from %CopyFromDir% to %CopyToDirUnity5Tests%
echo ::: f | xcopy %CopyFromDir% %CopyToDirUnity5Tests% /Y /I /E

echo ::: Exporting from %CopyFromDir% to %CopyToDirCompatibilityTests%
echo ::: f | xcopy %CopyFromDir% %CopyToDirCompatibilityTests% /Y /I /E

echo ::: Exporting from %CopyFromDir% to %CopyToDirExtPluginsTests%
echo ::: f | xcopy %CopyFromDir% %CopyToDirExtPluginsTests% /Y /I /E

echo :
echo :
echo :
echo :
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::::::::::::::::::: BATCH FILE END ::::::::::::::::::::::::::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :
echo :
echo :
echo :