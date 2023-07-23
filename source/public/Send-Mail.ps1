function Send-Mail {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$from = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'from', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$to = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'to', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$cc
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$bcc
        ,
        [Parameter(Mandatory = $false)]
        [string]$replyTo = $from
        ,
        [Parameter(Mandatory = $false)]
        [Alias('server')]
        [string]$smtpServer = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'smtpServer', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('Normal', 'High', 'Low', IgnoreCase = $true)]
        [string]$priority= 'Normal'
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('utf8NoBOM', 'ascii','bigendianunicode','bigendianutf32', 'oem', 'unicode', 'utf7', 'utf8', 'utf8BOM', 'utf8NoBOM', 'utf32', IgnoreCase = $true)]
        [string]$encoding= 'utf8'
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [string]$password
        ,
        [Parameter(Mandatory = $false)]
        [secureString]$secPassword
        ,
        [Parameter(Mandatory = $false)]
        [psCredential]$credential
        ,
        [Parameter(Mandatory = $false)]
        [switch]$useSsl
        ,
        [Parameter(Mandatory = $false)]
        [Alias('useHtml')]
        [switch]$bodyAsHtml
        ,
        [Parameter(Mandatory = $false)]
        [int]$port= 25
        ,
        [Parameter(Mandatory = $false)]
        [Alias('DNO')]
        [ValidateSet('None', 'OnSuccess', 'OnFailure', 'Delay', 'Never')]
        [string[]]$deliveryNotificationOption = 'None'
        ,
        [Parameter(Mandatory = $false)]
        [string]$subject = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'subject', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$body
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$attachment
    )

    begin {

        function Get-Encoding ([string]$encodingName) {
            switch ($encodingName.ToLower()) {
                'utf8nobom' { return New-Object System.Text.UTF8Encoding $false }
                'ascii' { return [System.Text.Encoding]::ASCII }
                'bigendianunicode' { return [System.Text.Encoding]::BigEndianUnicode }
                'bigendianutf32' { return [System.Text.Encoding]::GetEncoding("utf-32BE") }
                'oem' { return [System.Text.Encoding]::GetEncoding(850) } # OEM-Multilingual Latin 1; Western European (DOS)
                'unicode' { return [System.Text.Encoding]::Unicode }
                'utf7' { return [System.Text.Encoding]::UTF7 }
                'utf8' { return [System.Text.Encoding]::UTF8 }
                'utf8bom' { return New-Object System.Text.UTF8Encoding $true }
                'utf32' { return [System.Text.Encoding]::UTF32 }
                default { throw "Invalid encoding name: $encodingName" }
            }
        }

        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'mailParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'message' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPref' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        Set-Tls
        # Get Credential by Dialog  : $Credential = Get-Credential
        # Retruning user is like    : $User = $credential.Username
        # Returning plain pPassword : $Password = $credential.GetNetworkCredential().Password

        [System.Object]$credential = $null
        if ( ($user) -and ($password ) ) {
            $secPassword = ConvertTo-SecureString $password -AsPlainText -Force
            $credential = New-Object System.Management.Automation.PSCredential ($user, $secPassword)
        }

        $enc = Get-Encoding $encoding
        $mailParams = @{
            From = $from
            To = $to.Split(',')
            Subject = $subject
            Port = $port
            Priority = $priority
            Encoding = $enc
            SmtpServer = $smtpServer
            DeliveryNotificationOption = $deliveryNotificationOption
        }

        if ($cc) {$mailParams.Add('CC', $cc.split(',')) }
        if ($bcc) {$mailParams.Add('BCC', $bcc.split(',')) }
        if ($useSsl) {$mailParams.Add('useSSL', $true) }
        if ($credential) { $mailParams.Add('Credential', $credential ) }
        if ($bodyAsHtml) {$mailParams.Add('bodyAsHtml', $true) }
        if ($body) {$mailParams.Add('Body', $body) }
        if ($attachment) { $mailParams.Add('Attachments', $attachment) }
        if (( $PSVersionTable.PsVersion.Major -gt 6 ) -or `
            (($PSVersionTable.PsVersion.Major -eq 6) -and `
            ($PSVersionTable.PsVersion.Minor -ge 2))) {
            if ($replyTo) {
                $mailParams.Add('ReplyTo', $replyTo )
            }
        }

        try {
            $oldPref = $WarningPreference
            $WarningPreference = 'SilentlyContinue'
            Send-MailMessage @mailParams
            $WarningPreference = $oldPref
            if ($attachment) {
                [string]$message = ((Get-ResStr 'EMAIL_SENT_WITH_ATTACHMENT') -f $subject, $attachment)
            } else {
                [string]$message = ((Get-ResStr 'EMAIL_SENT') -f $subject)
            }
            write-verbose $message
        }

        catch {
            write-host ((Get-ResStr 'EMAIL_SENT_ERROR') -f [string]($to -join(',')), $subject, $_) -foregroundcolor Red
        }

        Start-Sleep -Seconds 1
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Send-Mail -from 'johne@doe.eu' -to 'info@doe.eu' -server '192.168.88.1' -user 'noreply@doe.eu' -password 'JohnDoe' -subject 'One Testmail' -body 'Is better then nothing' -usessl
}
