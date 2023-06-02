Function Install-SignTool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$signToolBasePath= "$env:TEMP"
        ,
        [Parameter(Mandatory = $false)]
        [string]$isoBasePath= "$env:TEMP"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateUrl -Url $_ })]
        [string]$url = "https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/"
        ,
        [Parameter(Mandatory = $false)]
        [switch]$leaveIso
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noBuild
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noInstall
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'build' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'cookieContainer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'downloadLink' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'filename' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'headers' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'installer' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'isoDrive' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'isoPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'link' -Scope 'Private' -Value ($null)
        New-Variable -Name 'response' -Scope 'Private' -Value ($null)
        New-Variable -Name 'signToolPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sourcePath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'StorageHistoryCharts' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [hashtable]$headers = @{"User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36 Edge/16.16299"}

        # ------------------------
        # Download Link
        # ------------------------
        $response = Invoke-WebRequest -uri $url -Headers $headers -UseDefaultCredentials -UseBasicParsing -SessionVariable cookieContainer
        [string]$downloadLink= $null
        foreach ($link in $response.Links) {if ($link.outerHTML -match "Download the \.iso") {$downloadLink = $link.href; break } }

        # ------------------------
        # Download Iso
        # ------------------------
        if ($downloadLink) {
            $response = Invoke-WebRequest -uri $downloadLink -Headers $headers -Method Head -UseBasicParsing -SessionVariable cookieContainer
            [string]$filename = $response.Headers['Content-Disposition'].Split('; ')[1].Split('=')[1]
            [string]$build= $filename.Split('.')[0]
            [string]$isoPath= "$isoBasePath\$filename"
            # Invoke-WebRequest -uri $downloadLink -Headers $headers -UseBasicParsing -SessionVariable cookieContainer -OutFile "$isoPath"
            Write-Host -NoNewline ((Get-ResStr 'DOWNLOADING_WINSDK')) -ForegroundColor Blue
            (New-Object System.Net.WebClient).DownloadFile($downloadLink, $isoPath)
            Write-Host " $(Get-ResStr 'READY')"
        } else {
            throw ((Get-ResStr 'DOWNLOADLINK_MISSING'))
        }

        # ------------------------
        # Extract ISO
        # ------------------------
        Mount-DiskImage -ImagePath $isoPath -StorageType ISO | Out-Null
        [string]$isoDrive = (Get-Volume -FriendlyName "KSDK*" | Select-Object -ExpandProperty DriveLetter) + ":\"
        [string]$sourcePath = "$isoDrive\Installers"
        if ($noBuild) {
            [string]$signToolPath = "$signToolBasePath\Signtool"
        } else {
            [string]$signToolPath = "$signToolBasePath\Signtool($build)"
        }
        if (! (Test-Path $signToolPath )) {
            New-Item -ItemType Directory -Path $signToolPath -force | Out-Null
        }
        [string]$installer= "Windows SDK Signing Tools-x86_en-us.msi"
        if (! (Test-path "$sourcePath\$installer")) {
            [string]$installer= "Windows SDK Signing Tools-x86_en-us.exe"
        }

        # Extracting Items
        Copy-Item "$sourcePath\$installer" $signToolPath -force
        Copy-Item "$sourcePath\4c3ef4b2b1dc72149f979f4243d2accf.cab" $signToolPath -force
        Copy-Item "$sourcePath\685f3d4691f444bc382762d603a99afc.cab" $signToolPath -force
        Copy-Item "$sourcePath\e5c4b31ff9997ac5603f4f28cd7df602.cab" $signToolPath -force
        Copy-Item "$sourcePath\e98fa5eb5fee6ce17a7a69d585870b7c.cab" $signToolPath -force

        Dismount-DiskImage -ImagePath $isoPath | Out-Null
        if (! $leaveIso) {
            Remove-Item $isoPath -Force
        }

        # ------------------------
        # Install SignTool
        # ------------------------
        if (! $noInstall) {
            $msiPath = "$signToolPath\$installer"
            $arguments = "/i `"$msiPath`" /qn"
            Start-Process msiexec.exe -ArgumentList $arguments -Wait -Verb RunAs

            Remove-Item -Path "$signToolPath\*.cab" -Force
            Remove-Item -Path "$signToolPath\$installer" -Force
            Remove-Item -Path "$signToolPath" -Force
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Install-SignTool -leaveIso -noInstall
}
