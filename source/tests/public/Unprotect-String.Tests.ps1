Import-Module -Name .\EulandaConnect.psd1

Describe 'Unprotect-String' {

    BeforeAll {
        $plainText = 'Hello, I am John, John Doe!'
        $key = 'MySpecialKey'
        $encryptedText = Protect-String -plainText $plainText -key $key
    }

    It 'Unprotect-String decrypts text' {
        $decryptedText = Unprotect-String -protectedText $encryptedText -key $key
        $decryptedText | Should -Be $plainText
    }

    It 'Unprotect-String  gives different decrypted values for different texts' {
        $otherEncryptedText = Protect-String -plainText 'Another text' -key $key
        $decryptedText = Unprotect-String -protectedText $otherEncryptedText -key $key
        $decryptedText | Should -Not -Be $plainText
    }
}