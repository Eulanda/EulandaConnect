Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Resize-Image' {

    BeforeAll {
        # Create a new image with a width and height of 500 pixels.
        $image = New-Object System.Drawing.Bitmap(500, 500)

        # Create a Graphics object from the image.
        $graphics = [System.Drawing.Graphics]::FromImage($image)

        # Create a red square.
        $redBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Red)
        $graphics.FillRectangle($redBrush, 50, 50, 400, 400)

        # Get the path to the temp directory
        $tempDir = Get-TempDir

        # Save the image in JPEG format.
        $global:originalImagePath = Join-Path $tempDir 'OriginalImage.jpg'
        $image.Save($global:originalImagePath, [System.Drawing.Imaging.ImageFormat]::Jpeg)

        # Clean up resources.
        $redBrush.Dispose()
        $graphics.Dispose()
        $image.Dispose()

        # Determine size of the original image file
        $global:originalFileSize = (Get-Item $global:originalImagePath).Length
    }

    It 'Resize-Image correctly resizes the image' {
        $resizedImagePath = Join-Path (Get-TempDir) 'ResizedImage.jpg'
        Resize-Image -pathIn $global:originalImagePath -pathOut $resizedImagePath -maxWidth 50 -maxHeight 50
        $resizedImage = [System.Drawing.Image]::FromFile($resizedImagePath)
        $resizedImage.Width | Should -BeLessThan 500
        $resizedImage.Height | Should -BeLessThan 500

        # Clean up resources.
        $resizedImage.Dispose()
    }

    It 'Image file size is smaller after resizing' {
        $resizedImagePath = Join-Path (Get-TempDir) 'ResizedImage.jpg'
        Resize-Image -pathIn $global:originalImagePath -pathOut $resizedImagePath -maxWidth 50 -maxHeight 50

        # Check the size of the resulting image file
        $resizedFileSize = (Get-Item $resizedImagePath).Length
        $resizedFileSize | Should -BeLessThan $global:originalFileSize
    }

    It 'Throws an error when invalid path is provided' {
        { Resize-Image -pathIn 'C:\non\existing\path.jpg' -pathOut (Join-Path (Get-TempDir) 'ResizedImage.jpg') -maxWidth 50 -maxHeight 50 } | Should -Throw
    }

    It 'Throws an error when maxWidth is out of range' {
        { Resize-Image -pathIn $global:originalImagePath -pathOut (Join-Path (Get-TempDir) 'ResizedImage.jpg') -maxWidth 5001 -maxHeight 50 } | Should -Throw
    }

    It 'Throws an error when maxHeight is out of range' {
        { Resize-Image -pathIn $global:originalImagePath -pathOut (Join-Path (Get-TempDir) 'ResizedImage.jpg') -maxWidth 50 -maxHeight 5001 } | Should -Throw
    }

    It 'Throws an error when quality is out of range' {
        { Resize-Image -pathIn $global:originalImagePath -pathOut (Join-Path (Get-TempDir) 'ResizedImage.jpg') -maxWidth 50 -maxHeight 50 -quality 101 } | Should -Throw
    }
}
