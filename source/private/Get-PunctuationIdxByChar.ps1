function Get-PunctuationIdxByChar {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$text
        ,
        [Parameter(Mandatory = $false)]
        [string]$match
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    [int]$idx = -1
    while (1 -eq 1 ) {
        [Int]$Idx = $text.lastIndexOf($match)
        if ($match -ne ' ') {
            if (($idx -ne -1) -and ($idx -lt $text.length-1)) {
                if ($text.Substring($idx+1, 1) -eq ' ') {
                    break
                } else {
                    if ($text.length -gt 1) {
                        $text = $Text.SubString(0, $idx)
                    } else { break }
                }
            } else { break }
        } else { break }
    }

    if ($idx -le 0) {
        return -1
    } else {
        if ($match -eq ' ') {
            return $idx
        } else { return $idx+1 }
    }
}
