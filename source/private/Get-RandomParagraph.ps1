function Get-RandomParagraph {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [int]$minSentences = 2
        ,
        [Parameter(Mandatory = $false)]
        [int]$maxSentences = 4
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    $sentences = @()
    $numSentences = Get-Random -Minimum $minSentences -Maximum $maxSentences
    for ($i = 1; $i -le $numSentences; $i++) {
        $sentence = "$(Get-RandomWords)$(Get-RandomPunctuation)"
        if (! $sentences) {
            $sentences = $sentence
        } else { $sentences += " $sentence" }
    }

    return $sentences.TrimEnd()
}
