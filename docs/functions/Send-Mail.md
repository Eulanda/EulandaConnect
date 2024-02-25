---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Send-Mail.md
schema: 2.0.0
---

# Send-Mail

## SYNOPSIS
Sends an email via Send-MailMessage, but with some additions

## SYNTAX

```
Send-Mail [[-from] <String>] [[-to] <String[]>] [[-cc] <String[]>] [[-bcc] <String[]>] [[-replyTo] <String>]
 [[-smtpServer] <String>] [[-priority] <String>] [[-encoding] <String>] [[-user] <String>]
 [[-password] <String>] [[-secPassword] <SecureString>] [[-credential] <PSCredential>] [-useSsl] [-bodyAsHtml]
 [[-port] <Int32>] [[-deliveryNotificationOption] <String[]>] [[-subject] <String>] [[-body] <String>]
 [[-attachment] <String[]>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Today's mail servers work with encryption and also with encrypted user password. This wrapper uses different TLS versions and converts the user with password to creditals.

## EXAMPLES

### EXAMPLE 1:Sends an email with two attachments

```powershell
$global:mailParams = @{
    From =  'john@doe.com'
    Port = 587
    Server = '192.168.178.100'
    User = doe
    Password = "pwd"
    Priority = "high"
    Encoding = "utf8"
    DNO = 'none'
    useSsl = $false
    BodyAsHtml = $true
}

Send-Email @global:mailParams
    -priority 'Normal'
    -to "cn@eulanda.de"
    -Subject 'This is a test from jonny'
    -Body "\<h1\>My Headline\</h1\>\<p\>Today i am fine!\</p\>"
    -Attachment ("C:\temp\foo.ini,C:\temp\readme.txt").Split(',')
```

This is an example for the use of a hashlist for the standard configuration in order to set only the remaining information as individual parameters when sending e-mails.

## PARAMETERS

### -attachment
Files incl. path. If several files are specified, they must be separated by commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -bcc
Recipients in blind copy, here these recipients are not visibly displayed to the normal recipients. The string supports multiple recipients, which can be specified separated by commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -body
The e-mail text can be specified either ASCII or in HTML. This is controlled by the switch BodyAsHtml.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -bodyAsHtml
The main e-mail text can be interpreted as standard ASCII or as HTML. Here, an HTML e-mail does not necessarily have to contain all the elements of an HTML web page, but can for example start directly with a paragraph '\<p\>Text\</p\>'.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: useHtml

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -cc
Recipient in copy (= carbon copy). The string supports multiple copy recipients, which can be specified separated by commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -credential
Creditals is a combination of username and password, both securely encoded. This is the new method preferred by Microsoft. For example, if the data are specified via username and password, they are automatically converted to creditals.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deliveryNotificationOption
Indicates that an acknowledgement of receipt is desired from the recipient, but this is usually not done.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: DNO
Accepted values: None, OnSuccess, OnFailure, Delay, Never

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -encoding
The encoding of the special characters in the e-mail. Nowadays, most emails are sent with utf8 encoding. This encoding allows the representation of most special characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: utf8NoBOM, ascii, bigendianunicode, bigendianutf32, oem, unicode, utf7, utf8, utf8BOM, utf8NoBOM, utf32

Required: False
Position: 7
Default value: Utf8
Accept pipeline input: False
Accept wildcard characters: False
```

### -from
The e-mail address of the sender e.g. 'john doe\<jd@outlook.com\>'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -password
The password is used in combination with the user name to authorize the SMTP server when sending the e-mail. It is specified unencrypted.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -port
The default port on the SMTP server was 25, but with SSL and TSL there are other common ports. These are for example 587 for TLS and 465 for SSL. Many SMTP servers today even use port 25 again and expect a TSL connection there.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 25
Accept pipeline input: False
Accept wildcard characters: False
```

### -priority
The possible values are `normal`, `high` and `low`. If the priority is set to `high`, for example, a red exclamation mark is displayed in the overview list in `Outlook` for these e-mails.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Normal, High, Low

Required: False
Position: 6
Default value: Normal
Accept pipeline input: False
Accept wildcard characters: False
```

### -replyTo
Reply address if different from the sender.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: $from
Accept pipeline input: False
Accept wildcard characters: False
```

### -secPassword
The SecPassword is an encrypted password, it is used in combination with the user name to authorize the SMTP server when sending the e-mail.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -smtpServer
Mail receiving server, this must be an SMTP server. The server can be specified using a DNS resolvable name such as `mail.doe.com` or its IP number. For IP numbers, only IP is currently accepted.

```yaml
Type: String
Parameter Sets: (All)
Aliases: server

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subject
The email subject

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -to
Recipient of the e-mail. The string supports multiple recipients, they can be specified separated by comma.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -useSsl
SSL encryption is no longer state of the art and is generally only used for in-house solutions. The switch is therefore usually not set. Instead, encryption with one of the TLS standards is automatically negotiated.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -user
The user is the name with which you authorize yourself at the SMTP server when sending the e-mail.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://adamtheautomator.com/send-mailmessage](https://adamtheautomator.com/send-mailmessage)
[https://adamtheautomator.com/powershell-get-credential](https://adamtheautomator.com/powershell-get-credential)
[https://stackoverflow.com/questions/53785662/why-does-send-mailmessage-fail-to-send-using-starttls-over-port-587](https://stackoverflow.com/questions/53785662/why-does-send-mailmessage-fail-to-send-using-starttls-over-port-587)
[https://www.codyhosterman.com/2016/06/force-the-invoke-restmethod-powershell-cmdlet-to-use-tls-1-2](https://www.codyhosterman.com/2016/06/force-the-invoke-restmethod-powershell-cmdlet-to-use-tls-1-2)

