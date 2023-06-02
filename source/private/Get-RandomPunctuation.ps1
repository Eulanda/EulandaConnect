function Get-RandomPunctuation {
    [CmdletBinding()]
    param()

    $punctuations = @(".", ".", ".", ".", ".", "!", "!", "!", "?", "?")
    $index = Get-Random -Minimum 0 -Maximum $punctuations.Count

    return $punctuations[$index]
}
