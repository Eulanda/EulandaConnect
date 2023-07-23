Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest


Describe 'Send-Mail' -Tag 'mock' {
    InModuleScope EulandaConnect {

        BeforeAll {
            Mock Send-MailMessage { }
            Mock Start-Sleep { }
        }

        It "Sends an email with the correct parameters" {
            $mailParams = @{
                From = "test@test.com"
                To = "test2@test.com","test3@test.com"
                SmtpServer = "smtp.test.com"
                Subject = "Test Email"
                Body = "Test Body"
                User = "user"
                Password = "password"
                UseSSL = $true
            }

            Send-Mail @mailParams

            Assert-MockCalled Send-MailMessage -Exactly -Times 1 -Scope It
        }

        It "Throws an error when no From parameter is provided" {
            { Send-Mail -to $to -smtpServer $smtpServer -subject $subject -body $body -user $user -password $password } | Should -Throw
        }

        It "Throws an error when no To parameter is provided" {
            { Send-Mail -from $from -smtpServer $smtpServer -subject $subject -body $body -user $user -password $password } | Should -Throw
        }

        It "Throws an error when no SmtpServer parameter is provided" {
            { Send-Mail -from $from -to $to -subject $subject -body $body -user $user -password $password } | Should -Throw
        }

        It "Throws an error when no Subject parameter is provided" {
            { Send-Mail -from $from -to $to -smtpServer $smtpServer -body $body -user $user -password $password } | Should -Throw
        }
    }
}
