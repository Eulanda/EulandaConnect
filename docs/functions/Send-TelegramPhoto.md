---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Send-TelegramPhoto.md
schema: 2.0.0
---

# Send-TelegramPhoto

## SYNOPSIS
Sends a photo with a caption via Telegram API, without requiring a locally installed Telegram app. The function is compatible with PowerShell 5.1 and PowerShell Core versions 7.x and above.

## SYNTAX

```
Send-TelegramPhoto [[-token] <String>] [[-encryptedToken] <String>] [[-secureToken] <SecureString>]
 [[-pathToToken] <String>] [[-chatId] <String>] [[-caption] <String>] [[-uri] <String>] [[-parseMode] <String>]
 [-disableContentTypeDetection] [-disableNotification] [<CommonParameters>]
```

## DESCRIPTION
This function allows the user to send a photo using the Telegram API, a cloud-based instant messaging service. It is particularly useful for sending server status updates or notifications as instant messages to a designated group, eliminating the need for a locally installed Telegram app.

This function is designed to work with the Telegram Bot API to send messages from a PowerShell script. It supports both **PowerShell 5.1** and higher versions, including **PowerShell 7**. The function takes various parameters to configure the message, such as the chat ID, the message text, the parse mode, and whether to disable notifications.

It accepts the bot token in several ways, including as a **plaintext** string, an **encrypted** string, a **secure** string, or a **path** to a file containing the token. For security reasons, the function purges the token from memory after it is used.

The `parseMode` parameter can be set to either `html` or `markdown`, allowing you to format the message text accordingly.

The function returns a boolean value, `true` if the message was sent successfully, and `false` if there was an error.

> How to generate a **secureToken**, an **encryptedToken**, or an XML file with a secureToken is described in another document. Once it becomes available, it will be linked under **related links**.

## EXAMPLES

### Example 1: Sends a photo via Telegram API
```powershell
PS C:\> Send-TelegramPhoto -token "123456789:ABCdefGhIjKlmnoPQRstUvWXyz" -chatId "-713022389" -caption "My simple caption..." -uri 'c:\temp\logo.png'
```

In this example, the function `Send-TelegramPhoto` is called with a token, a chatId, a caption, and a URI to the photo that you want to send. The URI in this case is a local file, 'c:\temp\logo.png'.

## PARAMETERS

### -caption
An string that represents the caption to be displayed with the photo.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -chatId
Specifies the chat ID to which the message will be sent. The chat ID can be either the unique identifier for a private chat or the identifier for a group or channel. Create a Telegram group and add the bot to the group to send messages to the group members.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableContentTypeDetection
An optional switch to disable the automatic content type detection.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: noDetection

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableNotification
(Optional) Disables notification for the message. By default, notifications are enabled, and the recipient will receive a notification for the sent message.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: noNotify

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -encryptedToken
This is an encrypted string created from your Telegram bot token. To create an encrypted token from your plaintext token, you can use the `ConvertTo-SecureString` and `ConvertFrom-SecureString` cmdlets in PowerShell 7.

Creating an encrypted string in PowerShell 5 is considerably more complicated. A separate document will be provided with detailed information on this process, which will be available under the **related links** when it becomes available.

```yaml
Type: String
Parameter Sets: (All)
Aliases: eToken

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parseMode
(Optional) Specifies the parsing mode for the message. Valid values are 'HTML' and 'Markdown'. By default, the parse mode is set to 'HTML'. When using HTML parse mode, you can use a subset of HTML tags to format the message. When using Markdown parse mode, you can use Markdown syntax to format the message.

```yaml
Type: String
Parameter Sets: (All)
Aliases: mode
Accepted values: html, markdown

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pathToToken
This is the path to an XML file holding a secure string version of your Telegram bot token. You can create such a file by exporting a secure token to an XML file using the `Export-Clixml` cmdlet.

A separate document will be provided with detailed information on this process, which will be available under the **related links** when it becomes available.

```yaml
Type: String
Parameter Sets: (All)
Aliases: path

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -secureToken
This is a secure string version of your Telegram bot token. The secure string is a string type that provides a measure of security by preventing the value from being displayed or converted to an unencrypted string. To create a secure token from your plaintext token, you can use the `ConvertTo-SecureString` cmdlet. 

Creating an encrypted string in PowerShell 5 is considerably more complicated. A separate document will be provided with detailed information on this process, which will be available under the **related links** when it becomes available.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases: sToken

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -token
Specifies the Telegram bot token required for authentication. To obtain a token, you need to create a bot on Telegram by following the instructions provided in the Telegram Bot API documentation.

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

### -uri
The URI of the photo to be sent. This could be either a local file or an internet resource URL.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Boolean

Returns $true if the message was sent successfully, otherwise $false.

## NOTES

Steps to create a Telegram bot and obtain the token:

1. Open the Telegram app on your device or visit the Telegram website: https://telegram.org/.
2. Search for the bot named "BotFather" in the Telegram search and start a conversation with it.
3. Follow the instructions provided by BotFather to create a new bot. You will be asked to provide a name for the bot, such as "MyAwesomeBot," and a username that must end with "Bot," for example, "AwesomeBot" (the complete username will be "@MyAwesomeBot").
4. Once you have successfully created the bot, BotFather will provide you with a token. The token will be a combination of numbers and letters and will look something like this: "123456789:ABCdefGhIjKlmnoPQRstUvWXyz".
5. Make sure to take note of the token you receive as you will need it to authenticate with the Telegram API and send messages using your bot.

This is a basic guide to obtaining a Telegram bot token using BotFather. Please note that Telegram may have made changes to the user interface or the process, so it's advisable to consult the official Telegram documentation or online resources for updated information and guides if any changes have been made.

Important: Treat your bot token as a password and do not share it with others. The token grants access to your bot and should be kept secure.

## RELATED LINKS

[Send-TelegramMessage](./Send-TelegramMessage.md)
