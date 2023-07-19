Import-Module -Name .\EulandaConnect.psd1

Describe "Get-ConnItems" {

    It "returns a Hashtable with connection items" {
        # Arrange
        $udlPath = Resolve-Path '.\source\tests\Eulanda_1 Pester.udl'

        # Act
        $connItems = Get-ConnItems -udl $udlPath

        # Assert
        $connItems | Should -Not -BeNullOrEmpty
        $connItems | Should -BeOfType [System.Collections.Hashtable]
    }
}
