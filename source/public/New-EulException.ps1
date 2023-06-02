class EulException : Exception {
    [string] $additionalData
    EulException($message, $additionalData) : base($message) {
        $this.additionalData = $additionalData
    }
}

function New-EulException {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$message
        ,
        [Parameter(Mandatory = $false)]
        $additionalData
    )

    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    return [EulException]::New($message,$additionalData)
}
