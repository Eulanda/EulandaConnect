function ConvertTo-WrappedLinesEdi {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$text
        ,
        [Parameter(Mandatory = $false)]
        [int]$Width = 80
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'a1' -Scope 'Private' -Value ('')
        New-Variable -Name 'al' -Scope 'Private' -Value ('')
        New-Variable -Name 'i' -Scope 'Private' -Value (0)
        New-Variable -Name 'maxPunctuation' -Scope 'Private' -Value (0)
        New-Variable -Name 'paragraph' -Scope 'Private' -Value ('')
        New-Variable -Name 'paragraphs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'punctuation' -Scope 'Private' -Value (0)
        New-Variable -Name 'test' -Scope 'Private' -Value (0)
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Standard arrays dont allow 'add' command
        $result = [System.Collections.ArrayList]@()

        # Normalize string delimiter to unix style
        $text = $text.replace("`r`n", "`n")

        # Delete all unnecessary empty lines and characters at the end of the last paragraph
        $text = $text.TrimEnd()

        # Each line break is a hard return, i.e. a paragraph
        [string[]]$paragraphs = $text -split "\n+"

        # Clear unnessecary spaces in each paragraph
        for ($i=0; $i -le $paragraphs.Count-1; $i++) {
            $paragraphs[$i] = $paragraphs[$i].Trim()
        }

        # Check if nativ lines match 2 lines and each line is less $width
         if (($paragraphs.count -eq 2) -and ($paragraphs[0].length -le $width) -and ($paragraphs[1].length -le $width)) {
            $al = $paragraphs[0]
            $a1 = $paragraphs[1]
            Write-Verbose (Get-ResStr 'VERBOSE_WRAPPED_TWO_LINES')
        } elseif (($paragraphs.count -eq 1) -and ($paragraphs[0].length -le $width) ) {
            Write-Verbose (Get-ResStr 'VERBOSE_WRAPPED_FIRST_LINE')
            $al = $paragraphs[0]
            $a1 = ""
        } else {
            # AT LEAST ONE LINE IS TOO LONG

            # Make one big line
            [string]$paragraph = $paragraphs -join (' ')

            # Clear double spaces
            $paragraph = $paragraph.Replace('  ', ' ')

            [string]$al = $paragraph.Substring(0,[System.Math]::Min($width, $paragraph.Length))
            [string]$a1 = $paragraph.Substring([System.Math]::Min($width, $paragraph.Length))

            # Only if there is text in A1, it could be better to make a new line wrapping
            if ($a1) {
                $punctuation = Get-PunctuationIdx $al

                [int]$maxPunctuation = $al.Length / 3 * 2
                if (($punctuation -ne -1) -and ($punctuation -lt $maxPunctuation)) {
                    # if we are loosing to much chars we are dividung after the last word
                    [Int]$test = $al.lastIndexOf(' ')
                    if ($test -gt $punctuation) { $punctuation = $test -1 }
                }

                if ($punctuation -ge 0) {
                    $a1 = "$($al.Substring($punctuation+1))$a1"
                    $a1 = $a1.Trim()
                    if ($a1.Length -gt $width) {
                        $a1 = "$($a1.Substring(0,$width-3))..."
                    }
                    $al = $al.Substring(0, $punctuation+1)
                }
            }

        }

        [string[]]$result = @()

        $result += $al.trim()
        $result += $a1.trim()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  ConvertTo-WrappedLinesEdi -text 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor lacus sed augue commodo dapibus. Suspendisse potenti.' -width 40
}
