#Set Variables
$v10sitename = "Convert10Site"
$v13sitename = "Convert13Site"
$v10migrationfolder = "F:\temp\ConvertV10\"
$v13migrationfolder = "F:\temp\ConvertV13\"

#Folder locations
$currentFolder = (get-location).path
$v10Folder = $(($v10migrationfolder)+($v10sitename))
$v13Folder = $(($v13migrationfolder)+($v13sitename))

Set-Location $v10Folder 

#Copy mod files to thge V10 convert site
Copy-Item -Path $(($currentFolder)+'\V10\Mods') -Destination ($v10Folder) -Recurse

Set-Location $v13Folder 

#Copy mod files to thge V13 convert site
Copy-Item -Path $(($currentFolder)+'\V13\Mods') -Destination ($v13Folder) -Recurse

Set-Location $currentFolder
Write-Host "Migration sites are updated, update connectionstring to the V8 database and run both sites in visual studio (v10) first"

