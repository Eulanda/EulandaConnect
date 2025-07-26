---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-Table.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-Table

## SYNOPSIS
Creates a data table in memory

## SYNTAX

```
New-Table [[-tableName] <String>] [[-columnNames] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Uses the **System.Data.DataTable** object to create a table with column names. The column names can be passed either as an array of strings or as a comma-separated string. There is an option to append a data type to each column name by extending the name with `/?` For example `MyDate/?DateTime`. The name of the table is created as a **global** variable.

## EXAMPLES

### Example 1:Creates a table and adds rows
```powershell
PS C:\> New-Table -TableName 'TestTable' -columnNames 'Field1,Field2,Field3/?DateTime'
PS C:\> [void]$TestTable.Rows.Add('John','Doe',$(Get-Date))
PS C:\> [void]$TestTable.Rows.Add('Max','Mustermann','2020-05-20')
PS C:\> $TestTable.Rows[0].Field1
```

```ini
# Output

John
```

Once created, the added rows can be accessed directly. Here the first added row is used and there the field `Field1` is retrieved.

### Example 2:Datatype in PowerShell
```ini
┌─────────────────┬───────────────────────────────────────────────────────────────────┐
│ Type            │ Description                                                       │
├─────────────────┼───────────────────────────────────────────────────────────────────┤
│ bool            │ Boolean with value true or false                                  │
│ switch          │ PowerShell switch is like Boolean, but it could be present or not │
│ datetime        │ Combination of date and time                                      │
│ timespan        │ A time interval                                                   │
│ byte            │ An 8-bit unsigned integer                                         │
│ sbyte           │ An 8-bit signed integer                                           │
│ int32 or int    │ 32 bit Integer                                                    │
│ uint            │ A 32-bit unsigned integer                                         │
│ long            │ 64 bit Integer                                                    │
│ ulong           │ A 64-bit unsigned integer                                         │
│ single or float │ Floating point numbers                                            │
│ double          │ Floating point more precise                                       │
│ decimal         │ A decimal number with 28-29 significant digits                    │
│ char            │ Single character                                                  │
│ string          │ Continuous text                                                   │
│ null            │ Represents a null or undefined value                              │
│ void            │ Represents no value                                               │
│ array           │ Array                                                             │
│ hashtable       │ Is a collection of key and value pairs                            │
│ xml             │ Xml document                                                      │
│ guid            │ 32 bit GUID like d7872426-c7b8-4161-a132-b5643023e593             │
│ scriptblock     │ A block of script code that can be invoked                        │
│ psobject        │ PowerShell object                                                 │
│ object          │ A generic object                                                  │
│ regex           │ A regular expression object                                       │
└─────────────────┴───────────────────────────────────────────────────────────────────┘
```

This is an example of data types in PowerShell. Not all of them can be used, but the first part of common data types should work.

## PARAMETERS

### -columnNames
List of column names passed either as a comma separated list or as an array of strings. Each field name can be given a special data type by appending `/?`.

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

### -tableName
Name of the table. This name is used as a global variable.

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


