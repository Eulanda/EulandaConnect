function Test-ValidateSelect {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$strParam
    )

    if ($strParam -eq "") {
        throw ((Get-ResStr 'PARAMETER_IS_EMPTY') -f 'select', $myInvocation.Mycommand)
    }

    return $true
}
