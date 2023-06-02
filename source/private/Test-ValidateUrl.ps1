function Test-ValidateUrl {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$url = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'url', $myInvocation.Mycommand))
    )

    if ($url -match "^(http|https)://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$") {
        return $true
    } else {
        throw ((Get-ResStr 'PARAMS_INVALID_URL') -f $url)
    }
}
