Import-Module -Name .\EulandaConnect.psd1


Describe 'New-EulException' {

    It 'New-EulException creates EulException' {
        $message = 'Test message'
        $additionalData = 'Test additional data'

        $eulException = New-EulException -message $message -additionalData $additionalData

        $eulException | Should -Not -BeNullOrEmpty
        $eulException.Message | Should -Be $message
        $eulException.additionalData | Should -Be $additionalData
    }
}
