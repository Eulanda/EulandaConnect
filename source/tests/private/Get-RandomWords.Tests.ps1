# Import the module
Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-RandomWords' {
    # Put all your tests inside the InModuleScope block
    InModuleScope 'EulandaConnect' {

        # Test if the function is working
        It 'should return string of words' {
            $result = Get-RandomWords

            $result | Should -BeOfType [String]
            $result.Split(' ').Count | Should -BeGreaterOrEqual 5
            $result.Split(' ').Count | Should -BeLessOrEqual 20
        }

        # Test if the function respects the MinWords parameter
        It 'should respect the MinWords parameter' {
            $result = Get-RandomWords -MinWords 10

            $result.Split(' ').Count | Should -BeGreaterOrEqual 10
        }

        # Test if the function respects the MaxWords parameter
        It 'should respect the MaxWords parameter' {
            $result = Get-RandomWords -MaxWords 10

            $result.Split(' ').Count | Should -BeLessOrEqual 10
        }
    }
}
