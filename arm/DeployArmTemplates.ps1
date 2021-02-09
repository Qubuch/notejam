function DeployArmTemplates {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string] $tenantId,
        [Parameter(Mandatory=$true)]
        [string] $rgName,
        [Parameter(Mandatory=$true)]
        [string] $environment,
        [Parameter(Mandatory=$true)]
        [IO.FileInfo] $templateFile,
        [Parameter(Mandatory=$true)]
        [IO.FileInfo] $parameterFile
    )
    
    # Connecting to Azure Services
    Connect-AzAccount

    # Create resource group
    New-AzResourceGroup -Name $rgName -Location "West Europe"

    # Deploy ARM templates
    New-AzResourceGroupDeployment `
        -Name $environment `
        -ResourceGroupName $rgName `
        -TemplateFile $templateFile `
        -TemplateParameterFile $parameterFile
}

