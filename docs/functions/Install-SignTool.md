---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Install-SignTool.md
schema: 2.0.0
---

# Install-SignTool

## SYNOPSIS
Download the Windows SDK, unzip the SignTool and install the SignTool.

## SYNTAX

```
Install-SignTool [[-signToolBasePath] <String>] [[-isoBasePath] <String>] [[-url] <String>] [-leaveIso]
 [-noBuild] [-noInstall] [<CommonParameters>]
```

## DESCRIPTION
This function has no other dependences to **EulandaConnect** module. The download of the Windows SDK and the unpacking of the **SignTool** as well as the subsequent installation are performed without specifying any parameters. 

The current version of the Windows 11 SDK is always loaded, which can currently (2023/02) also be taken for Windows 10. The download of the SDK also takes a little longer, because it is about 1.5 GB.

At the end of the installation, the ISO file is deleted unless the `leaveIso` switch has been specified. If the installation is performed, the installer files of the **SignTool** will be deleted also after installation. 

If no installation is to be performed, this can be specified with the `noInstall` switch, in which case the **SignTool** installation files will not be deleted. 

The folder name of the **SignTools** gets the current build number of the SDK. If you don't want a build number in the folder name, this can be specified by the switch `noBuild`. By default the base path for the **ISO** as well as the folder **SignTool** is the temp folder. With `isoBasePath` and `signToolBasePath` you can specify your own base path.

> **ATTENTION**:
> The installation of SignTool, which is executed at the end of the process, **requires elevated rights** (= administrator rights) to install. If you are unsure you can look at the section in the source code of the module. It does not use any external dependencies. EulandaConnect is also signed with EV, currently the **highest level** of application signing.

## EXAMPLES

### Example 1:Install actual version of signtool
```powershell
PS C:\> Install-SignTool
```

This installs the current version of signtool. It is loaded from https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/.

## PARAMETERS

### -isoBasePath
The default base path is the **temp folder**.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: "$([Environment]::GetFolderPath("Desktop"))"
Accept pipeline input: False
Accept wildcard characters: False
```

### -leaveIso
After installation process, the iso image is not deleted.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -noBuild
The SignTool path is used without build number, so it is always downloaded in the same folder.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -noInstall
No installation of SignTool will be performed, so SignTool with all installation files will remain in its folder.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -signToolBasePath
The default base path is the desktop. The folder for the files is **SignTool(BuildNo)** or just **SignTool**, if the switch `noBuild` is specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: "$([Environment]::GetFolderPath("Desktop"))"
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
Specifies the URL where the Windows SDK can be found. The default URL is  `https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/`

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

## OUTPUTS

## NOTES

## RELATED LINKS

[Approve-Signature](../functions/Approve-Signature.md)

[Get-SignToolPath](../functions/Get-SignToolPath.md)
