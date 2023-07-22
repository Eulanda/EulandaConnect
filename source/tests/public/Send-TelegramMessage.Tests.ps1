Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Send-TelegramMessage' -Tag 'integration', 'telegram' {

    It 'should send message without throwing exceptions' {
        if (-not $noTelegram) {
            { Send-TelegramMessage -path "$home\.eulandaconnect\secureTelegramToken.xml" -ChatId "-713022389" -Message 'PESTER first test message in <b>bold</b> as html!' } | Should -Not -Throw
        } else {
            Set-ItResult -Skipped -Because 'Test skipped because -noTelegram is set'
            return
        }
    }

    It 'should return true when message is sent' {
        if (-not $noTelegram) {
            $result = Send-TelegramMessage -path "$home\.eulandaconnect\secureTelegramToken.xml" -ChatId "-713022389" -Message 'PESTER second test message in <b>bold</b> as html!'
        } else {
            Set-ItResult -Skipped -Because 'Test skipped because -noTelegram is set'
            return
        }
        $result | Should -Be $true
    }
}
