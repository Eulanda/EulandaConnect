function Test-ValidateNo {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)]
        [Alias('no')]
        [ValidateRange(-2147483648,2147483647)]
        [int]$transactionNo
        ,
        [parameter(Mandatory = $false)]
        [string]$name = 'Transaction Number'
    )

    if ($transactionNo -lt 1) {
        if ($name) {
            throw ((Get-ResStr 'VALIDATE_NAMED_INT_ERROR') -f $name, $transactionNo, $myInvocation.Mycommand)
        } else {
            throw ((Get-ResStr 'VALIDATE_INT_ERROR') -f $transactionNo, $myInvocation.Mycommand)
        }
    }

    return $transactionNo
}
