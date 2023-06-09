function Get-DefaultSelectArticle {
    [CmdletBinding()]
    param()

    [string]$result = 'CHANGEDATE, ARTNUMMER, BARCODE, MWSTSATZ, MWSTGR, WAEHRUNG, GEWICHT, ' +`
        'SHOPEXPORTDATUM, SHOPFREIGABEFLG, AUSLAUFFLG, NEUFLG, SONDERFLG, LOESCHFLG, ' +`
        'VERPACKEH, PREISEH, EKNETTO, VK, BRUTTOFLG, VKNETTO, VKBRUTTO, LAGERTYP, ' +`
        'URSPRUNGSLAND, WARENNR, VOLUMEN, KURZTEXT1, KURZTEXT2, ULTRAKURZTEXT, LANGTEXT, INFO'

    Return $result

    <# Test:

        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features {  Get-DefaultSelectArticle }

    #>
}