function ConvertTo-WrappedLines {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$text
        ,
        [Parameter(Mandatory = $false)]
        [int]$width= 80
        ,
        [Parameter(Mandatory = $false)]
        [switch]$asString
        ,
        [Parameter(Mandatory = $false)]
        [switch]$useCrLf
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'column' -Scope 'Private' -Value (0)
        New-Variable -Name 'line' -Scope 'Private' -Value ('')
        New-Variable -Name 'paragraph' -Scope 'Private' -Value ('')
        New-Variable -Name 'paragraphs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rawWords' -Scope 'Private' -Value ($null)
        New-Variable -Name 'word' -Scope 'Private' -Value ('')
        New-Variable -Name 'words' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # standard arrays dont allow 'add' command
        $result = [System.Collections.ArrayList]@()

        # Normalize string delimiter to unix style
        $text = $text.replace("`r`n", "`n")

        # Delete all unnecessary empty lines and characters at the end of the last paragraph
        $text = $text.TrimEnd()

        # Each line break is a hard return, i.e. a paragraph
        [string[]]$paragraphs = $text -split "\n+"

        foreach ($paragraph in $paragraphs ) {

            [string[]]$rawWords = $paragraph -split "\s+"

            # Create a word list with words and make sure that no word is longer than 'width'
            $words = [System.Collections.ArrayList]@()
            foreach ($word in $rawWords ) {
                if ($word.Length -le $width) {
                    $words.Add($word) | Out-Null
                } else {
                    # if one word is longer then the width, split it
                    [string[]]$wordparts = $word -split "(.{$width})" -ne ''
                    foreach ($word in $wordparts) {
                        $words.Add($word) | Out-Null
                    }
                }
            }

            # Put as many words as possible in one line, but never longer than 'width'
            [int]$column = 0
            [string]$line = ""
            foreach ($word in $words ) {
                $column += $word.Length + 1
                if ($column -gt $width ) {
                    $result.add($line.trim()) | Out-Null
                    $column = $word.Length + 1
                    $line = ""
                }
                $line = "$line$($word) "
            }
            $result.add($line.trim()) | Out-Null
        }

        if ($asString) {
            if ($useCrLf) {
                [string]$result = $result -join "`r`n"
            } else {
                [string]$result = $result -join "`n"
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  ConvertTo-WrappedLines -text 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor lacus sed augue commodo dapibus. Suspendisse potenti.' -width 40
}
