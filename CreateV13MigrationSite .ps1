#Set Variables
$v13sitename = "Convert13Site"
$migrationfolder = "F:\temp\ConvertV13\"

#Folder locations
$v13Folder = $(($migrationfolder)+($v13sitename))

#go to the location where we want to install the sites
#ensure the folder exists
New-Item -ItemType Directory -Force -Path $migrationfolder
Set-Location $migrationfolder

#Create new Umbraco Site
dotnet new install Umbraco.Templates::13.5.2
dotnet new umbraco -n $v13sitename  --connection-string "Server=(localdb)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Umbraco.mdf;Integrated Security=true"

Set-Location $v13Folder 
#Set info for installer
Set-Item Env:\UMBRACO__CMS__GLOBAL__INSTALLMISSINGDATABASE true
Set-Item Env:\UMBRACO__CMS__UNATTENDED__INSTALLUNATTENDED true
Set-Item Env:\UMBRACO__CMS__UNATTENDED__UNATTENDEDUSERNAME "Soeteman Software Test User"
Set-Item Env:\UMBRACO__CMS__UNATTENDED__UNATTENDEDUSEREMAIL "richard@soetemansoftware.nl"
Set-Item Env:\UMBRACO__CMS__UNATTENDED__UNATTENDEDUSERPASSWORD "test123456"

#Create solution and add project and Starterkit
dotnet new sln
dotnet sln add $($v13sitename+".csproj")

Set-Location $v13Folder
#build site including dependencies
dotnet build

#start site
dotnet run

