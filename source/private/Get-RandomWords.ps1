function Get-RandomWords {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [int]$MinWords = 5
        ,
        [Parameter(Mandatory = $false)]
        [int]$MaxWords = 20
    )

    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    $loremIpsum = "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do " +`
        "eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim " +`
        "veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea " +`
        "commodo consequat Duis aute irure dolor in reprehenderit in voluptate " +`
        "velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat " +`
        "cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est " +`
        "laborum"


    $words = $loremIpsum.Split() | Where-Object { $_.Length -gt 1 }
    $numWords = Get-Random -Minimum $MinWords -Maximum $MaxWords

    $result = ""

    for ($i = 1; $i -le $numWords; $i++) {
        $word = $words[(Get-Random -Minimum 0 -Maximum $words.Count)]

        if ($i -eq 1) {
            $word = $word.Substring(0, 1).ToUpper() + $word.Substring(1)
        }

        if ((Get-Random -Minimum 0 -Maximum 10) -eq 0) {
            $word = $word.Substring(0, 1).ToUpper() + $word.Substring(1)
        }

        $result += $word + " "
    }

    return $result.TrimEnd()
}
