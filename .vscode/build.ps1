$ErrorActionPreference = 'Stop'

$Configuration = 'Debug'

$VersionTargetPrefix = "D:\RimWorld"
$VersionTargetSuffix = "Mods\TacticsModeRedux"
$Target = "$VersionTargetPrefix\1.5\$VersionTargetSuffix"

# build dlls
dotnet build --configuration $Configuration Source/TacticsModeRedux/TacticsModeRedux.csproj
if ($LASTEXITCODE -gt 0) {
    throw "Build failed"
}
dotnet build --configuration $Configuration Source/TacticsModeRedux.Achtung/TacticsModeRedux.Achtung.csproj
if ($LASTEXITCODE -gt 0) {
    throw "Build failed"
}

# remove mod folder
Remove-Item -Path $Target -Recurse -ErrorAction SilentlyContinue

# copy mod files
Copy-Item -Path Assemblies $Target\Assemblies -Recurse

# copy interop mod files
Copy-Item -Path Achtung $Target\Achtung -Recurse

Copy-Item -Path Defs $Target\Defs -Recurse
Copy-Item -Path Textures $Target\Textures -Recurse
Copy-Item -Path Languages $Target\Languages -Recurse
Copy-Item -Path LoadFolders.xml $Target\LoadFolders.xml -Recurse

New-Item -Path $Target -ItemType Directory -Name About
Copy-Item -Path About\About.xml $Target\About
Copy-Item -Path About\Preview.png $Target\About
Copy-Item -Path About\ModIcon.png $Target\About
Copy-Item -Path About\PublishedFileId.txt $Target\About
