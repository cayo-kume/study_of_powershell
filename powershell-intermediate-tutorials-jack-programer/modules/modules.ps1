#Um modulo no powersehll é um arquivo com um agrupamento de métodos

#Criar manifesto do módulo
New-ModuleManifest `
-Path ".\configurations\configurations.psd1" `
-Author "CayoKume" `
-Description "This is the configuration module" `
-ModuleVersion "1.0.0" `
-RootModule "configurations.psm1"

#Listar modulos do C:
#$($env:PSModulePath).split(';')

Import-Module .\configurations

Get-Module configurations

Remove-Module configurations

#Se você não quiser usar Import-Module para importar o módulo para dentro do powershell, copie a pasta do módulo (no exemplo .\configurations) 
#E cole em C:\Program Files (x86)\WindowsPowerShell\Modules, apos isso execute o comando a baixo
#O powershell sempre olha para os módulos presentes nessa pasta.

Import-Module configurations

#Listar commandos e funções presentes no módulo
Get-Command -Module configurations

#Sempre que você adicionar uma nova função ao arquivo de módulo .psm1 e não fechar e recarregar o arquivo o powershell não vai encontrar o novo método
#Para isso, fecehe e abra o arquivo ou force a importação com o comando
Import-Module .\configurations -Force

Get-Command -Module configurations

#Lista o summary da função
Get-Help Get-Configuration -Full