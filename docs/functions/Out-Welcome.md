---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Out-Welcome.md
schema: 2.0.0
---

# Out-Welcome

## SYNOPSIS
Displays an opening output with start time

## SYNTAX

```
Out-Welcome [[-projectScript] <String>] [-noBanner] [-noInfo] [[-culture] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates the EULANDA logo in the output incl. the start time, the scriptdir name and if available the project name. The start time is stored in the `$startTime` global variable. When leaving with `out-goodby`, the execution time of the script is then also displayed.

## EXAMPLES

### Example 1:Displays an opening output
```powershell
PS C:\> Out-Welcome
```

```ini
# Output

              ________  ____    ___    _   ______  ___
             / ____/ / / / /   /   |  / | / / __ \/   |
            / __/ / / / / /   / /| | /  |/ / / / / /| |
           / /___/ /_/ / /___/ ___ |/ /|  / /_/ / ___ |
          /_____/\____/_____/_/  |_/_/ |_/_____/_/  |_|
             _____       ______
            / ___/____  / __/ /__      ______ _________
            \__ \/ __ \/ /_/ __/ | /| / / __  / ___/ _ \
           ___/ / /_/ / __/ /_ | |/ |/ / /_/ / /  /  __/
          /____/\____/_/  \__/ |__/|__/\__,_/_/   \___/

Version:         EulandaConnect v3.2.1
Copyright:       © EULANDA Software GmbH. All rights reserved.
                 https://www.github.com/Eulanda/EulandaConnect
Module Path      C:\Git\Powershell\EulandaConnect\EulandaConnect.psm1
Execution start: 6/25/2023 12:16:19 PM
```

Displays the welcome screen and some information like the start time and the script path.

## PARAMETERS

### -culture
The culture can be changed here script-wide. This also has an immediate effect on the displayed strings if they are read from a resource file. This is for example the case with the information in Out-Welcome. Here English and German are delivered. The culture is specified with `-culture de-DE`, for example.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -noBanner
Suppresses the banner output of the EULANDA logo.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -noInfo
No additional information is displayed, only, if not suppressed the logo.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectScript
The complete script path including the name of the script can be passed here from the main script. From this the project version and the project name are formed and stored in the global variables `$global:projectName` and `$global:projectVersion`. Additionally, as soon as Out-Welcome is called, it changes to this folder. The `$PSCommandPath` automatic variable then gives the desired value in the main script.

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

## RELATED LINKS

[Out-Goodbye](./Out-Goodbye.md)
