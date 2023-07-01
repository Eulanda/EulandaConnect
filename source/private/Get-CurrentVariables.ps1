function Get-CurrentVariables {
<#
.SYNOPSIS
    A helper function to identify new local variables in the current scope
    when debugging PowerShell scripts.

.DESCRIPTION
    The Get-CurrentVariables function is a debugging tool designed to help
    identify new local variables created in the current scope of a script.
    The function works by comparing the current set of variables to an
    initial set and outputting the difference.
    This allows the user to easily identify new variables and their types.
    When the Debug switch is set, the function generates the code necessary
    to initialize these new variables with their appropriate default values.

.PARAMETER InitialVariables
    An array of variable names representing the initial set of variables
    before executing the main code. If this parameter is not provided,
    the function returns the current set of variables in the scope.

.EXAMPLE
    function ExampleFunction {
        [CmdletBinding()]
        param ()

        begin {
            $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
        }

        process {
            # Your main code here and now some new variables...
            $localVar1 = "Example 1"
            $localVar2 = "Example 2"
            $localVar3 = [version]"0.0"
        }

        end {
            Get-CurrentVariables -initialVariables $initialVariables -Debug:$DebugPreference
        }
    }
    ExampleFunction -Debug

    The above example demonstrates how to use Get-CurrentVariables in a script to
    identify new local variables when debugging is enabled.
    The function is called in the begin and end blocks of the script,
    and the new variables are output with their initialization code when the
    Debug switch is set.

    Screenoutput is:
    Neue lokale Variablen:
    New-Variable -Name 'localVar1' -Scope 'Private' -Value ('')
    New-Variable -Name 'localVar2' -Scope 'Private' -Value ('')
    New-Variable -Name 'localVar3' -Scope 'Private' -Value ([System.Version]::new())
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string[]]$initialVariables
    )

    function Test-IsComObject {
        param ( $inputObject )
        return ($inputObject -is [System.__ComObject])
    }

    if ($PSBoundParameters['Debug']) {
        New-Variable -Name 'currentVariables' -Scope 'Private' -Value @()
        New-Variable -Name 'newVariables' -Scope 'Private' -Value @()
        New-Variable -Name 'firstTime' -Scope 'Private' -Value ([bool]$false)
        New-Variable -Name 'variableName' -Scope 'Private' -Value ''
        New-Variable -Name 'variable' -Scope 'Private' -Value ([PsVariable]$null)
        New-Variable -Name 'type' -Scope 'Private' -Value ''
        New-Variable -Name 'initValue' -Scope 'Private' -Value ''
        New-Variable -Name 'privateVariableCode' -Scope 'Private' -Value ''

        $currentVariables = (Get-Variable).Name

        if ($initialVariables) {
            $newVariables = $currentVariables | Where-Object { $_ -notin $initialVariables } | Sort-Object -Property @{Expression = { $_ -eq 'result' }; Ascending = $true }

            # $newVariables = $currentVariables | Where-Object { $_ -notin $initialVariables }
            $firstTime = $true
            foreach ($variableName in $newVariables) {
                $variable = Get-Variable $variableName

                if (($null -ne $variable.Value) -and ($variable.name -notlike '_*')) {
                    # $type = $variable.Value.GetType().ToString()  # $type = $variable.Value.GetType().FullName
                    if (Test-IsComObject $variable.Value) {
                        $type = "COM-Object"
                    } elseif ($null -ne $variable.Value) {
                        $type = $variable.Value.GetType().ToString()
                    } else {
                        $type = "null"
                    }

                    if ($type.StartsWith("System.Text.UTF8Encoding")) {
                        $type = 'System.Text.Encoding'
                        $initValue = '[System.Text.Encoding]::UTF8'
                    } else {
                        # Set initialization values by type
                        # Write-Host "$($variable.Name) : $type"
                        switch ($type) {
                            'System.Boolean' { $initValue = '[boolean]$false' }
                            'System.Byte' { $initValue = '[byte]0' }
                            'System.Int16' { $initValue = '[int16]0' }
                            'System.Int32' { $initValue = '[int32]0' }
                            'System.Int64' { $initValue = '[int64]0' }
                            'System.UInt16' { $initValue = '[uint16]0' }
                            'System.UInt32' { $initValue = '[uint32]0' }
                            'System.UInt64' { $initValue = '[uint64]0' }
                            'System.Single' { $initValue = '[single]0.0' }
                            'System.Double' { $initValue = '[double]0.0' }
                            'System.Decimal' { $initValue = '[decimal]0.0' }
                            'System.String' { $initValue = "[string]''" }
                            'System.String[]' { $initValue = '[string[]]@()' }
                            'System.Array' { $initValue = '[array]@()' }
                            'System.Hashtable' { $initValue = '[hashtable]@{}' }
                            'System.Collections.ArrayList' { $initValue = '[System.Collections.ArrayList]@()' }
                            'System.Collections.Hashtable' { $initValue = '[System.Collections.Hashtable]@{}' }
                            'System.Object' { $initValue = '[System.Object]::New()' }
                            'System.Object[]' { $initValue = '[System.Object[]]@()' }
                            'System.IO.StringWriter' { $initValue = '[System.IO.StringWriter]::new()' }
                            default { $initValue = '$null' } # Set to null for all other types
                        }
                    }
                    $privateVariableCode = "New-Variable -Name '$($variable.Name)' -Scope 'Private' -Value ($initValue)"

                    if ($firstTime) {
                        # Write-Host (Get-ResStr 'NEW_VARIABLES') -ForegroundColor Yellow
                        Write-Output 'New variables:' # english and with write-output, because it is paresed by pester test
                    }
                    # Write-Host $privateVariableCode -ForegroundColor Yellow
                    Write-Output "$privateVariableCode"
                    $firstTime = $false
                }
            }
        } else {
            return $currentVariables
        }
    } else {
        Return @()
    }

    <# Test:
        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features { $initialVariables = Get-CurrentVariables -Debug:$true; $result = (Get-CurrentVariables -InitialVariables $initialVariables -Debug:$true); ($null -eq $result ) }
        & $Features { $initialVariables = Get-CurrentVariables -Debug:$true; $dummy = 'Dummy'; $result = (Get-CurrentVariables -InitialVariables $initialVariables -Debug:$true); ($null -eq $result ) }
    #>
}
