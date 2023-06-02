Function Use-Culture {
    [CmdletBinding()]
    param(
        [System.Globalization.CultureInfo]
        $culture = $(throw (Get-ResStr 'HELP_USE_CULTURE'))
        ,
        [ScriptBlock]
        $script = $(throw (Get-ResStr 'HELP_USE_CULTURE'))
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    $oldCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
    trap
    {
        [System.Threading.Thread]::CurrentThread.CurrentCulture = $oldCulture
    }
    [System.Threading.Thread]::CurrentThread.CurrentCulture = $culture
    Invoke-Command $script
    [System.Threading.Thread]::CurrentThread.CurrentCulture = $oldCulture
}
