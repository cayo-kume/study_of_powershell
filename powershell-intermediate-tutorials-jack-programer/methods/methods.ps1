function Create-Configuration-Files {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Path = ".\configs",

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Version = "1.0.0",

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateSet("Linux","Windows")]
        [string]$OperatingSystem = "Windows"
    )

    begin {
        #A fun��o passa aqui somente uma vez � tipo o construtor do c-sharp
        #Exemplos de uso: iniciar conex�o com o banco de dados, iniciar contadores ++
        Write-Output "Begin Block"
        $SucessfulFilesCreated = 0
        $FailedFilesCreated = 0
    }

    process {
        try {
            Write-Verbose "Creating configuration for $Name with version $Version"
            New-Item -Path $Path -Name "$($Name).cfg" -ItemType File -ErrorAction Stop
            $Version | Out-File -FilePath "$Path\$($Name).cfg" -Force
            $OperatingSystem | Out-File -FilePath "$Path\$($Name).cfg" -Append -Force
            Write-Verbose "Created configuration file for $Name with version $Version"
            $SucessfulFilesCreated++
        }
        catch {
            Write-Verbose "Falied on creating configuration file for $Name with version $Version"
            Write-Verbose $_.Exception.Message
            $FailedFilesCreated++
        }
        Write-Debug "Configurations files created: $SucessfulFilesCreated"
        Write-Debug "Configurations files falied: $FailedFilesCreated"
    }

    end {
        #A fun��o passa aqui somente uma vez
        #Exemplos de uso: fechar conex�o com o banco de dados, resetar contadores ++
        Write-Output "End Block"
        Write-Verbose "Configurations files created: $SucessfulFilesCreated"
        Write-Verbose "Configurations files falied: $FailedFilesCreated"
    }
}

$Names = @('teste1', 'teste2', 'teste3')

$Names | Create-Configuration-Files -Verbose -Debug

#Passar um objeto como parametro para a fun��o

$IISServer = New-Object -TypeName PSCustomObject
Add-Member -InputObject $IISServer -MemberType NoteProperty -Name "Name" -Value "IISServer2022"
Add-Member -InputObject $IISServer -MemberType NoteProperty -Name "Version" -Value "1.0.3"
Add-Member -InputObject $IISServer -MemberType NoteProperty -Name "OperatingSystem" -Value "Linux"

$IISServer | Create-Configuration-Files

#Para um unico objeto o Add-Member � uma boa forma de adicionar as propriedades, porem come�a a ficar um c�digo poluido quando possuimos muitos objetos
#Podemos ent�o usar um arquivo csv para popular uma lista de objetos

$Servers = Import-Csv -Path ".\severs.csv" -Delimiter ','

$Servers | Create-Configuration-Files -Verbose