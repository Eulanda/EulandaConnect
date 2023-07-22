Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-FieldTruncated' {

    It "Should truncate the field value based on maxLen" {
        # Arrange
        $rs = New-Object -ComObject ADODB.Recordset
        $rs.Fields.Append("MyStringField", $adVarChar, 255)
        $rs.Open()
        $rs.AddNew()
        $rs.Fields("MyStringField").Value = "This is a test string with more than twenty characters."
        $fieldName = "MyStringField"
        $maxLen = 20

        # Act
        $result = Get-FieldTruncated -rs $rs -fieldname $fieldName -maxLen $maxLen

        # Assert
        $result.Length | Should -BeLessOrEqual $maxLen

        # Cleanup
        $rs.Close()
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($rs) | Out-Null
    }
}
