Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Send-TelegramMap' -Tag 'integration', 'telegram' {

    It 'should send map location without throwing exceptions' {
        if (-not $noTelegram) {
            { Send-TelegramMap -pathToToken "$home\.eulandaconnect\secureTelegramToken.xml" -ChatId "-713022389" -latitude 48.8566 -longitude 2.3522 } | Should -Not -Throw
        } else {
            Set-ItResult -Skipped -Because 'Test skipped because -noTelegram is set'
            return
        }
    }

    It 'should return true when location is sent' {
        if (-not $noTelegram) {
            $result = Send-TelegramMap -pathToToken "$home\.eulandaconnect\secureTelegramToken.xml" -ChatId "-713022389" -latitude 48.8566 -longitude 2.3522
        } else {
            Set-ItResult -Skipped -Because 'Test skipped because -noTelegram is set'
            return
        }
        $result | Should -Be $true
    }
}
