Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Protect-String' {

    BeforeAll {
        $plainText = 'Hello, I am John, John Doe!'
        $key = 'MySpecialKey'
    }

    It 'Protect-String encrypts text' {
        $encryptedText = Protect-String -plainText $plainText -key $key
        $encryptedText | Should -Not -BeNullOrEmpty
    }

    It 'Protect-String gives different encrypted values for different texts' {
        $otherPlainText = 'Another text'
        $otherEncryptedText = Protect-String -plainText $otherPlainText -key $key
        $encryptedText = Protect-String -plainText $plainText -key $key
        $encryptedText | Should -Not -Be $otherEncryptedText
    }
}
