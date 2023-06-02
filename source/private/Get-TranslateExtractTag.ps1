function Get-TranslateExtractTag {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$value
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    [string]$iso = ""
    [string]$SubVar = ""
    [string[]]$result = @("", "")

    $value = $value.Substring(0, $value.Length-1) # delete last
    $value = $value.Substring(1, $value.Length-1) # delete first
    $value = $value.ToUpper()

    # check for an optional part
    $p = $value.IndexOf(":")
    if ($p -eq -1) {
        $iso = $value.ToUpper()
    } else {
        if ($p -eq 0 ) {
            $subVar = $value.Substring(1, $value.Length-1).ToUpper()
            $iso = "00" # Default
        } else {
            $iso = $value.Substring(0, 2).ToUpper()
            $subVar = $value.SubString(3, $value.Length-3).ToUpper()
        }

    }
    $result[0] = $iso
    $result[1] = $subVar
    Return $result
}
