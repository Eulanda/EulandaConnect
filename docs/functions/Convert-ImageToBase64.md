---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-ImageToBase64.md
schema: 2.0.0
---

# Convert-ImageToBase64

## SYNOPSIS
This PowerShell function converts an image file into a mime text Base64 encoded. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-ImageToBase64.ps1).

## SYNTAX

```
Convert-ImageToBase64 [[-path] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Convert-ImageToBase64 function loads an image file from the specified path and converts it to a Base64-encoded **MIME** string, using the file extension to determine the MIME type (jpeg, bmp, or png). The resulting string can be used to embed the image in HTML or other documents.

## EXAMPLES

### Example 1:Converts an image file into a mime text
```powershell
PS C:\> Convert-ImageToBase64 -path "C:\Temp\MyImage.jpg"
```

```ini
# Output

data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAwADAAAD/4cNoRXhpZgAATU0AKgAAAAgACwEPAAIAAAAKAAAAkgEQAAIAAAAWAAAAnAESAAMAAAABAAEAAAEaAAUAAAABAAAAsgEbAAUAAAABAAAAugEoAAMAAAABAAIAAAExAAIAAAAmAAAAwgEyAAIAAAAUAAAA6AITAAMAAAABAAEAAIdpAAQAAAABAAAA/IglAAQAAAABAADCyAAAAABNaWNyb3NvZnQATHVta...
```

This will convert the image file "MyImage.jpg" located in the "C:\Temp" directory to a Base64-encoded MIME string.

## PARAMETERS

### -path
This parameter is mandatory and specifies the path of the image file that needs to be converted. The path can be a local file path or a remote file path (UNC path), and it must include the name and extension of the file. If the file is located in a directory with a space in its name, the path must be enclosed in quotation marks. The parameter accepts string values.

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
