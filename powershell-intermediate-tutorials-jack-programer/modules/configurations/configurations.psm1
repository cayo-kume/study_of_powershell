function Get-Configuration {
    <#
        .DESCRIPTION
        This is the description for the get-configuration cmdlets written by cayo.kume

        .EXAMPLE
        Get-Configuration
        This will return all configurations

        .EXAMPLE
        Get-Configurations -Name "teste"
        This will return configuration with the name of teste

        .LINK
        This is the linf to my github and my websit with more informations about this module
    #>
    [CmdletBinding()]
    Param()

    Write-Output "Get-Configuration function"
}

function Set-Configuration {
    [CmdletBinding()]
    Param()

    Write-Output "Set-Configuration function"
}

function New-Configuration {
    [CmdletBinding()]
    Param()

    Write-Output "New-Configuration function"
}

#Você pode ter quantas funções desejar nesse arquivo