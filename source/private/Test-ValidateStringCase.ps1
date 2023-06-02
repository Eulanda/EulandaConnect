function Test-ValidateStringCase {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$value
    )

    if ($value -in (Get-SetStringCase)) {
        return $true
    } else {
        throw ((Get-ResStr 'PARAMS_INVALID_VALUE') -f ((Get-SetStringCase) -join ', ') )
    }
}
