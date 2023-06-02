function Test-ValidateMapping {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$strValue
        ,
        [Parameter(Mandatory = $false)]
        [hashtable]$mapping
    )

    $allValidValues = $mapping.Keys + $mapping.Values

    if ($strValue -notin $allValidValues) {
        throw ((Get-ResStr 'VALIDATE_FROM_SET_ERROR') -f $strValue, $($allValidValues -join ', '), $myInvocation.Mycommand)
    }

    if ($mapping.ContainsKey($strValue)) {
        $result = $mapping[$strValue]
    } else {
        $result = $strValue
    }

    Return $result
}
