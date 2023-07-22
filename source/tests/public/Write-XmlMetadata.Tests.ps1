Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Write-XmlMetadata tests' -Tag 'eulanda' {
    It "Returns valid XML string" {
        # Create a MemoryStream
        $stream = New-Object System.IO.MemoryStream

        # Create an XmlWriter that writes to the MemoryStream
        $settings = New-Object System.Xml.XmlWriterSettings
        $writer = [System.Xml.XmlWriter]::Create($stream, $settings)

        # Invoke test function
        Write-XmlMetadata -writer $writer

        # Close the Writer
        $writer.Flush()
        $writer.Close()

        # Reset the position of the stream
        $stream.Position = 0

        # Create a StreamReader
        $reader = New-Object System.IO.StreamReader $stream
        $xmlString = $reader.ReadToEnd()

        # Check if the output is a valid XML string
        $xml = [xml]$xmlString
        $xml.DocumentElement.Name | Should -Be 'Metadata'

        # Cleanup
        $reader.Close()
        $stream.Close()
    }
}
