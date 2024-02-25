---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Show-MsgBoxYes.md
schema: 2.0.0
---

# Show-MsgBoxYes

## SYNOPSIS
Displays the Windows message box with `yes` and `no` buttons

## SYNTAX

```
Show-MsgBoxYes [[-prompt] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
A dialog box is displayed that shows a Yes / No question. If the `Yes` button is pressed, `true` is returned, otherwise `false`.

## EXAMPLES

### Example 1:Displays a Yes No box and asks for the button
```powershell
PS C:\> If (Show-MsgBoxYes -prompt 'Is your name John?') { Write-Host "Hello John"}
```

In this example the Windows dialog box is displayed and you are asked if your name is 'John'. If you answer with the button 'Yes' you will be greeted with your name and 'Hello John' will be displayed on the monitor.

## PARAMETERS

### -prompt
The `prompt` parameter can be used to pass the displayed text.

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

**ATTENTION!**
The display of the `Show-MsgBox` dialog is not suitable for unattended use, because the box expects user input and the script stops until a button is pressed.

## RELATED LINKS

[Show-MsgBox](./functions/Show-MsgBox.md)

