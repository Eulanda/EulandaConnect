Import-Module -Name .\EulandaConnect.psd1

Describe 'Send-TelegramMessage' {

    It 'should send message without throwing exceptions' {
        if (-not $noTelegram) {
            { Send-TelegramMessage -path "$home\.eulandaconnect\secureTelegramToken.xml" -ChatId "-713022389" -Message 'PESTER first test message in <b>bold</b> as html!' } | Should -Not -Throw
        }
    }

    It 'should return true when message is sent' {
        if (-not $noTelegram) {
            $result = Send-TelegramMessage -path "$home\.eulandaconnect\secureTelegramToken.xml" -ChatId "-713022389" -Message 'PESTER second test message in <b>bold</b> as html!'
        } else {
            $result = $true
        }
        $result | Should -Be $true
    }
}
