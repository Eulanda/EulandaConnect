function Convert-ImageToBase64 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateFileExists -Path $_ })]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'base64' -Scope 'Private' -Value ('')
        New-Variable -Name 'content' -Scope 'Private' -Value ($null)
        New-Variable -Name 'extension' -Scope 'Private' -Value ('')
        New-Variable -Name 'mimeType' -Scope 'Private' -Value ('')
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $content = [System.IO.File]::ReadAllBytes($path)
        $base64 = [System.Convert]::ToBase64String($content)
        $extension = [System.IO.Path]::GetExtension($path).ToLower()
        switch ($extension) {
            ".jpg"  { $mimeType = "image/jpeg" }
            ".jpeg" { $mimeType = "image/jpeg" }
            ".gif"  { $mimeType = "image/gif" }
            ".png"  { $mimeType = "image/png" }
            ".bmp"  { $mimeType = "image/bmp" }
            ".ico"  { $mimeType = "image/x-icon" }
            ".pdf"  { $mimeType = "application/pdf" }
            default { throw "Unknown image file type: $extension" }
        }
        $result = "data:$mimeType;base64,$base64"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $result
    }
    # Test:  Convert-ImageToBase64 -path 'C:\temp\Eulanda.jpg'
}
