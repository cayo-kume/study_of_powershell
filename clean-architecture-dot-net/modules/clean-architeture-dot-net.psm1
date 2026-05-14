function Create-Dotnet-Clean-Architecture {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$path_project,

        [Parameter(Mandatory)]
        [string]$project_name
    )

    begin {
        [string]$base_path = "$path_project\$project_name"
        [string]$path_domain = "..\Domain.$project_name\Domain.$project_name.csproj"
        [string]$path_application = "..\Application.$project_name\Application.$project_name.csproj"
    }

    process {
        # Write-Output "Workdir para o path do projeto"
        # Set-Location $path_project

        Create-Dotnet-Clean-Architecture-Folders -path_project $base_path -project_name $project_name

        Write-Output "Workdir para a pasta src"
        Set-Location "$base_path\src"

        Create-Dotnet-Clean-Architecture-Projects -project_name $project_name

        Write-Host "Workdir para a pasta domain"
        Set-Location ".\Domain.$project_name"

        Create-Dotnet-Clean-Architecture-Domain-Template -project_name $project_name

        Write-Host "Workdir para a pasta application"
        Set-Location ".."
        Set-Location ".\Application.$project_name"

        Create-Dotnet-Clean-Architecture-Application-Template -project_name $project_name -path_domain $path_domain

        Write-Host "Workdir para a pasta infrastructure"
        Set-Location ".."
        Set-Location ".\Infrastructure.$project_name"

        Create-Dotnet-Clean-Architecture-Infrastructure-Template -project_name $project_name -path_application $path_application -path_domain $path_domain
    }
}

function Create-Dotnet-Clean-Architecture-Folders {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$path_project,

        [Parameter(Mandatory)]
        [string]$project_name
    )

    process {
        Write-Output "Criando pasta $project_name"
        New-Item -Path "$path_project" -ItemType Directory

        Write-Output "Criando pasta src"
        New-Item -Path "$path_project\src" -ItemType Directory

        Write-Output "Criando pasta tests"
        New-Item -Path "$path_project\tests" -ItemType Directory

        Write-Output "Copiando gitignore"
        Copy-Item -Path ".gitignore" -Destination "$path_project"

        Write-Output "Copiando dockerfile"
        Copy-Item -Path "Dockerfile" -Destination "$path_project"

        Write-Output "Copiando dockerignore"
        Copy-Item -Path ".dockerignore" -Destination "$path_project"
    }
}

function Create-Dotnet-Clean-Architecture-Projects {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$project_name
    )

    process {
        Write-Output "Criando projeto Domain"
        dotnet new classlib --name "Domain.$project_name" --output "Domain.$project_name"

        Write-Output "Criando projeto Application"
        dotnet new classlib --name "Application.$project_name" --output "Application.$project_name"

        Write-Output "Criando projeto Infrastructure"
        dotnet new classlib --name "Infrastructure.$project_name" --output "Infrastructure.$project_name"
    }
}

function Create-Dotnet-Clean-Architecture-Domain-Template {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$project_name
    )

    process {
        Remove-Item -Path ".\Class1.cs"

        New-Item -Path ".\Dtos" -ItemType Directory
        New-Item -Path ".\Entities" -ItemType Directory
        New-Item -Path ".\Abstractions" -ItemType Directory
        New-Item -Path ".\Abstractions\Apis" -ItemType Directory
        New-Item -Path ".\Abstractions\Repositorys" -ItemType Directory
        New-Item -Path ".\Abstractions\Handlers" -ItemType Directory
        New-Item -Path ".\Abstractions\Handlers\Commands" -ItemType Directory
        New-Item -Path ".\Abstractions\Handlers\Querys" -ItemType Directory
        New-Item -Path ".\Abstractions\Services" -ItemType Directory

        Set-Content `
        -Path ".\Abstractions\Apis\IAPICall.cs" `
        -Value @"
        using System;
        namespace Domain.$project_name.Abstractions.Apis
        {
            public interface IAPICall
            {
            }
        }
"@

        Set-Content `
        -Path ".\Abstractions\Repositorys\I${project_name}Repository.cs" `
        -Value @"
        using System;
        namespace Domain.$project_name.Abstractions.Repositorys
        {
            public interface I${project_name}Repository
            {
            }
        }
"@

        Set-Content `
        -Path ".\Abstractions\Handlers\Commands\I${project_name}CommandsHandler.cs" `
        -Value @"
        using System;
        namespace Domain.$project_name.Abstractions.Handlers.Commands
        {
            public interface I${project_name}CommandsHandler
            {
            }
        }
"@

        Set-Content `
        -Path ".\Abstractions\Handlers\Querys\I${project_name}QuerysHandler.cs" `
        -Value @"
        using System;
        namespace Domain.$project_name.Abstractions.Handlers.Querys
        {
            public interface I${project_name}QuerysHandler
            {
            }
        }
"@

        Set-Content `
        -Path ".\Abstractions\Services\I${project_name}Service.cs" `
        -Value @"
        using System;
        namespace Domain.$project_name.Abstractions.Services
        {
            public interface I${project_name}Service
            {
            }
        }
"@
    }
}

function Create-Dotnet-Clean-Architecture-Application-Template {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$project_name,

        [Parameter(Mandatory)]
        [string]$path_domain
    )

    process {
        Remove-Item -Path ".\Class1.cs"

        New-Item -Path ".\Services" -ItemType Directory
        New-Item -Path ".\Validations" -ItemType Directory
        New-Item -Path ".\Handlers" -ItemType Directory
        New-Item -Path ".\Handlers\Commands" -ItemType Directory
        New-Item -Path ".\Handlers\Querys" -ItemType Directory

        Set-Content `
        -Path ".\Handlers\Commands\${project_name}CommandsHandler.cs" `
        -Value @"
        using System;
        namespace Application.$project_name.Handlers.Commands
        {
            public class ${project_name}CommandsHandler
            {
            }
        }
"@
        Set-Content `
        -Path ".\Handlers\Querys\${project_name}QuerysHandler.cs" `
        -Value @"
        using System;
        namespace Application.$project_name.Handlers.Querys
        {
            public class ${project_name}QuerysHandler
            {
            }
        }
"@

        Set-Content `
        -Path ".\Services\${project_name}Service.cs" `
        -Value @"
        using System;
        namespace Application.$project_name.Services
        {
            public class I${project_name}Service
            {
            }
        }
"@
        dotnet add reference "$path_domain"
    }
}

function Create-Dotnet-Clean-Architecture-Infrastructure-Template {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$project_name,

        [Parameter(Mandatory)]
        [string]$path_domain,

        [Parameter(Mandatory)]
        [string]$path_application
    )

    process {
        Remove-Item -Path ".\Class1.cs"

        New-Item -Path ".\Apis" -ItemType Directory
        New-Item -Path ".\Repositorys" -ItemType Directory
        New-Item -Path ".\Scripts" -ItemType Directory

        Set-Content `
        -Path ".\Apis\APICall.cs" `
        -Value @"
        using System;
        namespace Infrastructure.$project_name.Apis
        {
            public class APICall
            {
            }
        }
"@
        Set-Content `
        -Path ".\Repositorys\${project_name}Repository.cs" `
        -Value @"
        using System;
        namespace Infrastructure.$project_name.Repositorys
        {
            public class ${project_name}Repository
            {
            }
        }
"@
        Set-Content `
        -Path ".\DependencyInjection.cs" `
        -Value @"
        using System;
        namespace Infrastructure.$project_name.DependencyInjection
        {
            public static class DependencyInjection
            {
                public static IServiceCollection AddScopedMovideskServices(this IServiceCollection services, IConfiguration configuration)
                {
                    return services;
                }
            }
        }
"@
        dotnet add reference $path_domain
        dotnet add reference $path_application
    }
}