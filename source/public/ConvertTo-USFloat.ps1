function ConvertTo-USFloat {
    [CmdletBinding()]
    param (
        [string]$inputString
    )

    $commaPos = $inputString.LastIndexOf(",")
    $dotPos = $inputString.LastIndexOf(".")

    if ($dotPos -gt $commaPos) {
        $outputString = [string]$inputString.Replace(",", "")
    } else {
        $outputString = [string]$inputString.Replace(".", "")
        $outputString = [string]$outputString.Replace(",", ".")
    }

    try {
        $outputFloat = [float]$outputString
        if ($outputFloat) { $outputFloat = 0}  # Suppress vsc error markers
    } catch {
        Write-Error (Get-ResStr 'USFLOAT_ERROR') -f $inputString, $myInvocation.Mycommand
        return
    }

    return $outputString
}
