---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Show-MsxBox.md
schema: 2.0.0
---

# Show-MsgBox

## SYNOPSIS
Displays the Windows message box, for example the Yes/No box

## SYNTAX

```
Show-MsgBox [[-prompt] <String>] [[-btn] <Int32>] [[-title] <String>] [[-icon] <Int32>] [[-btnDef] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Windows dialog box allows to display a text with heading and to perform simple queries like Yes/No, Ok/Cancel etc.. Additionally, one of the predefined icons can be used or it can be determined which button is the default button, i.e. returned on Enter. 

Which buttons are displayed is specified by the parameter `btn`. The possible values are: `mbOk`, `mbOkCancel`, `mbAbortRetryIgnore`, `mbYesNoCancel`, `mbYesNo` and `mbRetryCancel`.

The function returns an integer value as **result**, where the possible return values are predefined as global variables. These are: `mbrOk`, `mbrCancel`, `mbrYes`, `mbrNo`, `mbrAbort`, `mbrRetry`, `mbrIgnore`, `mbrTryAgain` and `mbrContinue`.

If nothing is specified for the `icon` parameter, no special icon is displayed. Otherwise the following icon values are predefined: `mbStop`, `mbQuestion`, `mbWarning` and `mbInfo`.

If you want to specify the default button, this can be done with the parameter `btnDef`. The following values are predefined: `mbButton1`, `mbButton2`, `mbButton3` and `mbButton4`.

## EXAMPLES

### Example 1:Displays a Yes No box and asks for the button
```powershell
PS C:\> If ((Show-MsgBox -prompt 'Is your name John?' -btn $mbYesNo) -eq $mbrYes) { Write-Host "Hello John"}
```

In this example the Windows dialog box is displayed and you are asked if your name is 'John'. If you answer with the button 'Yes' you will be greeted with your name and 'Hello John' will be displayed on the monitor.

## PARAMETERS

### -btn
The parameter can be used to determine which button combination is to be displayed. The possible values are: `mbOk`, `mbOkCancel`, `mbAbortRetryIgnore`, `mbYesNoCancel`, `mbYesNo` and `mbRetryCancel`.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Accepted values: 0, 1, 2, 3, 4, 5

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -btnDef
If several default buttons are displayed, it is possible to specify which one is the default button. This is the button that should be triggered when Enter is pressed. The following values are predefined: `mbButton1`, `mbButton2`, `mbButton3` and `mbButton4`.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Accepted values: 0, 256, 512, 768

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -icon
This parameter can be used to specify whether an icon is to be displayed in the dialog box and also which one. The following icons are available for selection: `mbStop`, `mbQuestion`, `mbWarning` and `mbInfo`.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Accepted values: 0, 16, 32, 48, 64

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -title
The `title` parameter can be used to specify the title of the dialog box.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

> **ATTENTION!**
> The display of the `Show-MsgBox` dialog is not suitable for unattended use, because the box expects user input and the script stops until a button is pressed.

## RELATED LINKS

[Show-MsgBoxYes](./functions/Show-MsgBoxYes.md)



