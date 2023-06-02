function Convert-ToMultipart() {
    Param(
        [Parameter(Mandatory = $false)]
        [hashtable]$params = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'params', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$boundary = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'boundary', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = ""
        $crlf = "`r`n"

        foreach ($entry in $params.GetEnumerator()) {
            switch ($entry.value.GetType().Name) {
                "FileInfo" {
                    $fileBinary = [IO.File]::ReadAllBytes($entry.value.FullName)
                    $encoding = [System.Text.Encoding]::GetEncoding("iso-8859-1")
                    $encodedContent = $encoding.GetString($fileBinary)
                    $FileName = Split-Path $entry.value.FullName -leaf

                    $result = "$result--$boundary$crlf" +
                        "Content-Disposition: form-data; name=`"$($entry.Name)`"; filename=`"$fileName`"$crlf" +
                        "Content-Type: application/octet-stream$crlf" +
                        "$crlf" +
                        "$encodedContent$crlf"
                }
                Default {
                    $result = "$result--$boundary$crlf" +
                        "Content-Type: text/plain; charset=utf-8$crlf" +
                        "Content-Disposition: form-data; name=`"$($entry.Name)`"$crlf" +
                        "$crLf" +
                        "$(Convert-ToUTF7 $entry.Value)$crLf"

                }
            }
            Write-Verbose "$myInvocation.Mycommand | Name: $($entry.Name) | Type: $($entry.Value.GetType().Name) | Value: $($entry.Value)"
        }
        $result = "$result--$boundary--$crLf"
    }

    end {
        Get-CurrentVariables -initialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test
}
