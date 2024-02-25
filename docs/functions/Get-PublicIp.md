---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-PublicIp.md
schema: 2.0.0
---

# Get-PublicIp

## SYNOPSIS
Get the public ip from a outbound website

## SYNTAX

```
Get-PublicIp [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function uses an external server's WEB API to determine the public IP address of the upstream router.

> ATTENTION! Multiple API calls on the same day may result in blockings.

## EXAMPLES

### Example 1:Get the public ip number also behind a router
```powershell
PS C:\> Get-PublicIp
```

```ini
# Output

95.238.49.168
```

This function provides the public IP of the own connection.

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

