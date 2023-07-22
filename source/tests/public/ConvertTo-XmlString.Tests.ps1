Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'ConvertTo-XmlString' {

    It "Should convert a string field to an XML compatible string" {
        # Arrange
        $rs = New-Object -ComObject ADODB.Recordset
        $rs.Fields.Append("MyStringField", $adVarChar, 255) # Size of 255 added for a VarChar field
        $rs.Open()
        $rs.AddNew()
        $rs.Fields("MyStringField").Value = "Test String"
        $adoField = $rs.Fields("MyStringField")

        # Act
        $result = ConvertTo-XmlString -adoField $adoField

        # Assert
        $result | Should -Be "Test String"

        # Cleanup
        $rs.Close()
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($rs) | Out-Null
    }
}

