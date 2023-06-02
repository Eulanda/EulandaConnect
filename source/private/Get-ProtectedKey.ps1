function Get-ProtectedKey {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$key = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'key', $myInvocation.Mycommand))
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    if ($key.length -lt 16) {
        $key = $key.PadRight(16,' ')
    } elseif ($key.length -lt 32) {
        $key = $key.PadRight(32,' ')
    } else {
        Throw ((Get-ResStr 'KEY_LENGTH32_ERROR') -f $myInvocation.Mycommand)
    }

    $length = $key.length
    $pad = 32-$length
    $encoding = New-Object System.Text.ASCIIEncoding
    $bytes = $encoding.GetBytes($key + "0" * $pad)

    return $bytes
}
