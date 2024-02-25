---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Send-TelegramMap.md
schema: 2.0.0
---

# Send-TelegramMap

## SYNOPSIS
Sends a location via a Telegram message, visualized on a map based on given latitude and longitude or IP address.

## SYNTAX

```
Send-TelegramMap [[-token] <String>] [[-encryptedToken] <String>] [[-secureToken] <SecureString>]
 [[-pathToToken] <String>] [[-chatId] <String>] [[-latitude] <Single>] [[-longitude] <Single>]
 [[-ip] <IPAddress>] [-disableNotification] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Send-TelegramMap` function sends a Telegram message presenting a location on a map. The location is specified by a pair of latitude and longitude coordinates or an IP address. When the IP address is used, the function `Get-IpGeoInfo` determines the location data via a REST API.

A valid Telegram API token and a chat ID are required to send the map. The token authenticates the sender as a valid Telegram bot, and the chat ID specifies the recipient, which can be a private chat, a group, or a channel.

For more secure transmission, there are options to send the token as an encrypted string or a secure string. There is also an option to refer to a file path containing the secure string version of the token. To disable automatic content type detection, use the `-disableNotification` switch.

If neither latitude and longitude nor IP address are provided, the function attempts to retrieve the current public IP address using the `Get-PublicIp` function.

Upon successful execution, the function outputs an object that includes the sent message's details.

## EXAMPLES

### Example 1: Send the location of the ip address via SendLocation
```powershell
PS C:\> Send-TelegramMap --token 'your_token' -chatId 'your_chatId' -ip '5.1.80.40'
```

The function sends a Telegram message in the form of a map. The longitude and latitude of the flag that marks the location in the map is determined from the IP number in this case. Via the function Get-IpGeoInfo, this data is determined via a REST api. A valid Telegram Api token is required, as well as a chat ID to which the map should be sent. At the end of the document there is a simple instruction how to get such a personal token from Telegram.

## PARAMETERS

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

### -disableNotification
An optional switch to disable the automatic content type detection.

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

### -ip
Specifies the IP address for which is necessary to retrieve the longitudes and latitudes from a GEO database. If no longitude and latitude and also no IP address are specified, `Get-PublicIp` tries to get the current public IP address.

```yaml
Type: IPAddress
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -latitude
Latitude of the first point in DD format. Should be a decimal number between -90 and 90.

```yaml
Type: Single
Parameter Sets: (All)
Aliases: lat

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -longitude
Longitude of the first point in DD format. Should be a decimal number between -180 and 180.

```yaml
Type: Single
Parameter Sets: (All)
Aliases: lon

Required: False
Position: 6
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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
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

[Send-TelegramMessage](./functions/Send-TelegramMessage.md)

[Send-TelegramPhoto](./functions/Send-TelegramPhoto.md)


