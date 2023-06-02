---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Remove-ItemWithRetry.md
schema: 2.0.0
---

# Remove-ItemWithRetry

## SYNOPSIS
Delete a file with wait until it is no longer locked

## SYNTAX

```
Remove-ItemWithRetry [[-path] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function deletes the file specified with the -Path parameter. If the file is locked, the function waits until the lock is removed. The maximum waiting time is 50 seconds.

## EXAMPLES

### Example 1:Deletes a file with retry
```powershell
PS C:\> Remove-ItemWithRetry -Path C:\temp\test.txt
```

Deletes the text file `test.txt` in the folder **c:\temp**, If this is currently in use, the function waits up to 50 seconds and repeats the deletion request during this time.

## PARAMETERS

### -path
Path incl. filename.

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
