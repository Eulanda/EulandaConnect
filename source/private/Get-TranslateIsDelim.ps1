function Get-TranslateIsDelim {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$value
    )

    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    [bool]$result = $false
    # test if the first character is an open bracket
    if ($value) {
        if ($value.SubString(0,1) -eq "[") {
            $value = $value.TrimEnd()
            # test if the last character is a closed bracket
            if ($value.Substring($value.Length-1) -eq "]") {
                $value = $value.Substring(0, $value.Length-1)  # delete last
                $value = $value.Substring(1, $value.Length-1)  # delete first

                # check if there is an optional part
                $p = $value.IndexOf(":")
                if ($p -eq -1) {
                    # without optional part the iso tag must be 2 characters long
                    if ($value.Length -eq 2) {$result = $True } else { $result = $False }
                } else {
                    # valid positions for the colon are the first or the third (after the iso-tag)
                    if (($p -eq 0) -or ($p -eq 2)) { $result = $True } else { $result = $False }
                }
            }
        }
    }
    Return $result
}
