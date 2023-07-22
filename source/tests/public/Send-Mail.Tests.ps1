Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

InModuleScope 'EulandaConnect' {
    Describe 'Send-Mail' -Tag 'mock' {

        BeforeEach {
            Mock Send-MailMessage { }
            Mock Get-ResStr { return "Mocked Resource String" }
            Mock Start-Sleep { }
        }

        It "Sends an email with the correct parameters" {

            # Arrange
            $from = "test@test.com"
            $to = "test2@test.com"
            $smtpServer = "smtp.test.com"
            $subject = "Test Email"
            $body = "Test Body"
            $user = "user"
            $password = "password"

            # Act
            Send-Mail -from $from -to $to -smtpServer $smtpServer -subject $subject -body $body -user $user -password $password

            # Assert
            Assert-MockCalled Send-MailMessage -Exactly -Times 1 -Scope It
        }

        It "Throws an error when no From parameter is provided" {
            # Act
            { Send-Mail -to $to -smtpServer $smtpServer -subject $subject -body $body -user $user -password $password } | Should -Throw
        }

        It "Throws an error when no To parameter is provided" {
            # Act
            { Send-Mail -from $from -smtpServer $smtpServer -subject $subject -body $body -user $user -password $password } | Should -Throw
        }

        It "Throws an error when no SmtpServer parameter is provided" {
            # Act
            { Send-Mail -from $from -to $to -subject $subject -body $body -user $user -password $password } | Should -Throw
        }

        It "Throws an error when no Subject parameter is provided" {
            # Act
            { Send-Mail -from $from -to $to -smtpServer $smtpServer -body $body -user $user -password $password } | Should -Throw
        }
    }
}
