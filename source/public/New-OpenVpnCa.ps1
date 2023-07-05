function New-OpenVpnCa {
    param(
        [string]$openVpnPath = "$($env:ProgramFiles)\OpenVPN"
        ,
        [string]$destination = "$($home)\.eulandaconnect\OpenVPN"
        ,
        [string]$hostname = [System.Net.Dns]::GetHostname()
        ,
        [string]$country = "DE"
        ,
        [string]$province = "HE"
        ,
        [string]$city = "Huenstetten"
        ,
        [string]$organisation = "EULANDA"
        ,
        [string]$unit = "eCommerce"
        ,
        [string]$passphrase = "eulen"

    )

    begin {
        # Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        # $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {

        Push-Location
        try {
            Set-Location -Path (Join-Path -path $openVpnPath 'bin')

            [string]$keyDir = Join-Path -path $destination "server"

            if (-not (Test-Path $keyDir -PathType Container)) {
                New-Item -ItemType Directory -Path $keyDir | Out-Null
            }

            # for OpenVPN 2.5 and up
            $argumentString = "genrsa -aes256 -out ""$keyDir\ca.key"" -passout pass:$passphrase"
            Start-Process `
                        -NoNewWindow `
                        -LoadUserProfile `
                        -Wait `
                        -FilePath "openssl" `
                        -ArgumentList $argumentString

            Set-Location -Path (Join-Path -path $openVpnPath 'bin')
            $argumentString = "req -x509 -new -nodes -key ""$keyDir\ca.key"" -passin pass:$passphrase -sha256 -days 3650 -out ""$keyDir\ca.crt"" -subj ""/C=$country/ST=$province/L=$city/O=$organisation/CN=$organisatiom-ca/OU=$unit"""
            Start-Process `
                        -NoNewWindow `
                        -LoadUserProfile `
                        -Wait `
                        -FilePath "openssl" `
                        -ArgumentList $argumentString

        }
        finally {
            Pop-Location
        }
    }

    end {
        # Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }

}

