Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Send-TelegramPhoto' -Tag 'integration', 'telegram' {
    BeforeAll {
        # Create a new image
        $image = New-Object System.Drawing.Bitmap(500, 500)
        $graphics = [System.Drawing.Graphics]::FromImage($image)
        $redBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Red)
        $graphics.FillRectangle($redBrush, 50, 50, 400, 400)
        $global:originalImagePath = Join-Path ([System.IO.Path]::GetTempPath()) 'OriginalImage.jpg'
        $image.Save($global:originalImagePath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        $redBrush.Dispose()
        $graphics.Dispose()
        $image.Dispose()
    }

    It 'should send photo without throwing exceptions' {
        if (-not $noTelegram) {
            { Send-TelegramPhoto -pathToToken "$home\.eulandaconnect\secureTelegramToken.xml" -ChatId "-713022389" -Caption "PESTER first test photo" -Uri $global:originalImagePath} | Should -Not -Throw
        } else {
            Set-ItResult -Skipped -Because 'Test skipped because -noTelegram is set'
            return
        }
    }

    It 'should return true when photo is sent' {
        if (-not $noTelegram) {
            $result = Send-TelegramPhoto -pathToToken "$home\.eulandaconnect\secureTelegramToken.xml" -ChatId "-713022389" -Caption "PESTER second test photo" -Uri $global:originalImagePath
        } else {
            Set-ItResult -Skipped -Because 'Test skipped because -noTelegram is set'
            return
        }
        $result | Should -Be $true
    }

    AfterAll {
        # Remove the temporary image and clean up the global variable
        Remove-Item -Path $global:originalImagePath -ErrorAction SilentlyContinue
        Remove-Variable -Name 'global:originalImagePath' -ErrorAction SilentlyContinue
    }
}
