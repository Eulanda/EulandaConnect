function Convert-OemToUtf8 {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$inputString
    )

    $convertedString = [System.Text.StringBuilder]::new()

    foreach ($char in $inputString.ToCharArray()) {
        switch ([int][char]$char) {
            129 {
                $convertedString = $convertedString.Append('ü')
            }
            132 { $convertedString = $convertedString.Append('ä') }
            142 { $convertedString = $convertedString.Append('Ä') }
            148 { $convertedString = $convertedString.Append('ö') }
            153 { $convertedString = $convertedString.Append('Ö') }
            154 { $convertedString = $convertedString.Append('Ü') }
            225 { $convertedString = $convertedString.Append('ß') }
            default { $convertedString = $convertedString.Append($char) }
        }
    }

    return $convertedString.ToString()

    # Test: $a = Convert-OemToUtf8 'Rckfahrt'
}
