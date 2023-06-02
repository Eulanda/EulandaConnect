function Get-PunctuationIdx {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$text
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    [int]$idx = -1

    [int]$i = Get-PunctuationIdxByChar -text $text -Match '.'
    if ($i -gt $idx) { $idx = $i }

    [int]$i = Get-PunctuationIdxByChar -text $text -Match '!'
    if ($i -gt $idx) { $idx = $i }

    [int]$i = Get-PunctuationIdxByChar -text $text -Match '?'
    if ($i -gt $idx) { $idx = $i }

    if ($idx -eq -1) {
        # if no punctuation is found, then take space char
        [int]$i = Get-PunctuationIdxByChar -text  $text -Match  ' '
        if ($i -gt $idx) { $idx = $i }
    }

    if ($idx -eq -1 ) { $idx = $text.Length-1 }
    return $idx
}
