function Test-ValidateNotEmpty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$strParam
    )

    if ($strParam -eq "") {
        throw ((Get-ResStr 'PARAMETER_IS_EMPTY') -f 'strParam', $myInvocation.Mycommand)
    }

    return $true
}
