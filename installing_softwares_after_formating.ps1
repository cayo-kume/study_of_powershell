# 1. Define o local de salvamento
$url = "https://go.microsoft.com/fwlink/?linkid=2196106&clcid=0x4009&culture=en-in&country=in"
$outputFile = "C:\Temp\MSTeams-x64.msix"

# 2. Cria a pasta Temporária se não existir
if (!(Test-Path "C:\Temp")) { New-Item -ItemType Directory -Path "C:\Temp" }

# 3. Baixa o instalador
Invoke-WebRequest -Uri $url -OutFile $outputFile

# 4. Instala o pacote MSIX
Add-AppProvisionedPackage -Online -PackagePath $outputFile -SkipLicense

####################################################################################################################################

# 1. Definir o local de download e o nome do arquivo
$url = "https://teamviewer.com"
$output = "C:\Temp\TeamViewer_Setup.exe"

# 2. Criar a pasta temporária se não existir
New-Item -ItemType Directory -Path "C:\Temp" -Force

# 3. Baixar o instalador
Invoke-WebRequest -Uri $url -OutFile $output

# 4. Instalar o TeamViewer de forma silenciosa
Start-Process -FilePath $output -ArgumentList "/S", "/norestart" -Wait

# 5. Remover o instalador após a instalação
Remove-Item -Path $output

####################################################################################################################################

Invoke-WebRequest -Uri "https://anydesk.com" -OutFile "C:\Windows\Temp\AnyDesk.exe"

Start-Process -FilePath "C:\Windows\Temp\AnyDesk.exe" -ArgumentList "--install", "C:\Program Files (x86)\AnyDesk", "--start-with-win", "--silent" -Wait

####################################################################################################################################

# Define o local de download e destino
$url = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.7/npp.8.7.Installer.x64.exe"
$output = "$env:TEMP\npp_installer.exe"

# Baixa o instalador
Invoke-WebRequest -Uri $url -OutFile $output

# Executa o instalador silenciosamente
Start-Process -FilePath $output -ArgumentList "/S" -Wait

# Remove o instalador temporário
Remove-Item $output

winget install googlechrome

.\vs_community.exe --installPath C:\VS2026 --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NetWeb --includeRecommended --quiet --norestart

[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://dl-cli.pstmn.io/install/win64.ps1'))



winget install -e --id Microsoft.VisualStudioCode

winget install "Microsoft.AzureCLI"