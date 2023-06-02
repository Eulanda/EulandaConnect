function Test-ValidateId {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)]
        [ValidateRange(-2147483648,2147483647)]
        [int]$id = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'id', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$name = 'ID'
    )

    if ($id -lt 1) {
        if ($name) {
            throw ((Get-ResStr 'VALIDATE_NAMED_INT_ERROR') -f $name, $id, $myInvocation.Mycommand)
        } else {
            throw ((Get-ResStr 'VALIDATE_INT_ERROR') -f $id, $myInvocation.Mycommand)
        }
    }

    return $id
}
