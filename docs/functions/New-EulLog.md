---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-EulLog.md
schema: 2.0.0
---

# New-EulLog

## SYNOPSIS
Writes messages to a text file to log events

## SYNTAX

```
New-EulLog [[-name] <String>] [[-path] <String>] [<CommonParameters>]
```

## DESCRIPTION
After creating this class, the first thing that is written away is a message 'Initialization'. Messages can be saved during runtime using the Put method. The output file is written to the subfolder 'event' with as tab-delimited text file and eacht entriy is saved with the local time. 

To distinguish that the Pu methods belong to the object just created, a ProcessId is stored. 

In the simplest case the method Put is used with the message as parameter. Alternatively, a level, i.e. the importance, can be specified. If level is not specified, '0' is used as default. If an event group is to be stored, then the parameter Group is to be used. If this is not specified, the default value '(default)' is used.

The class EulLog should be created in the main script. This way Dispose can be used in the Finlally block. This will write away a message with the text 'Finalization' when the class exits.

## EXAMPLES

### Example 1:Creates EulLog and stores some messages
```powershell
$evt= New-EulLog 'MySection' 'C:\temp'
try {
	$evt.put("before calculation")
	$i = 5+6
	$evt.put("after calculation")
} finally {
	$evt.dispose()
}
```

```
2023-02-25 17:37:20  MySection  28668e21-82c6-4906-8ba8-edff3e45647c  0  (default)  Initialization
2023-02-25 17:37:20  MySection  28668e21-82c6-4906-8ba8-edff3e45647c  0  (default)  before calculation
2023-02-25 17:37:20  MySection  28668e21-82c6-4906-8ba8-edff3e45647c  0  (default)  after calculation 
2023-02-25 17:37:20  MySection  28668e21-82c6-4906-8ba8-edff3e45647c  0  (default)  Finalization
```

The class EulLog is created. This already creates an entry in the output file. Various messages can now be output via the Put method. When the script is terminated, the Finally block ensures that the Dispose method writes away a Closing message. In the output, the time is stored in local notation and also the ProcessId. This makes it easy to filter the messages that originated with a process.

## PARAMETERS

### -name
A short message that is automatically written to all put messages.

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

### -path
Root path for the output file. All files are stored in the subfolder `event` .

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
