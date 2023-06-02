function Test-ValidateFileExists {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    process {
        if (-not (Test-Path $path)) {
            throw ((Get-ResStr 'FILE_DOES_NOT_EXIST') -f $path, $myInvocation.Mycommand)
        }
        return $true
    }
}
