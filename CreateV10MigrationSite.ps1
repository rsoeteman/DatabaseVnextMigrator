#Set Variables
$v10sitename = "Convert10Site"
$migrationfolder = "F:\temp\ConvertV10\"

#Folder locations
$v10Folder = $(($migrationfolder)+($v10sitename))

#go to the location where we want to install the sites
#ensure the folder exists
New-Item -ItemType Directory -Force -Path $migrationfolder
Set-Location $migrationfolder 

#Create new Umbraco Site
dotnet new install Umbraco.Templates::v10.8.7
dotnet new umbraco -n $v10sitename  --connection-string "Server=(localdb)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Umbraco.mdf;Integrated Security=true"

Set-Location $v10Folder 
#Set info for installer
Set-Item Env:\UMBRACO__CMS__GLOBAL__INSTALLMISSINGDATABASE true
Set-Item Env:\UMBRACO__CMS__UNATTENDED__INSTALLUNATTENDED true
Set-Item Env:\UMBRACO__CMS__UNATTENDED__UNATTENDEDUSERNAME "Soeteman Software Test User"
Set-Item Env:\UMBRACO__CMS__UNATTENDED__UNATTENDEDUSEREMAIL "richard@soetemansoftware.nl"
Set-Item Env:\UMBRACO__CMS__UNATTENDED__UNATTENDEDUSERPASSWORD "test123456"

#Create solution and add project and Starterkit
dotnet new sln
dotnet sln add $($v10sitename+".csproj")

Set-Location $v10Folder

#build site including dependencies
dotnet build

#start site
dotnet run


