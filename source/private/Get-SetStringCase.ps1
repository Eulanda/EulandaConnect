function Get-SetStringCase {
    [CmdletBinding()]
    param()

    return @('none', 'upper', 'lower', 'capital')

    <# Test:

        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features {
            $result = Get-SetStringCase
            Write-Host "'$result' are all valid options"
        }

    #>

}
