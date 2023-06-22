---
bookCollapseSection: true
---

![](/functions.png) 

# These functions 

> **Local links in this readme document do not work, they are rendered for online documentation in HUGO CMS.**

are provided by EulandaConnect. They can be executed directly in a command prompt. Simply call a PowerShell console and copy the text from the function example. Change paths passwords etc. if necessary and run the command in the console.

To test that the extension is installed correctly, type the following:

```powershell
PS C:\> Out-Welcome	
```

A logo with different version information should be displayed here. If this is not the case, EulandaConnect must first be installed. Enter the following commands in the PowerShell console:

```powershell
PS C:\> Set-PSRepository PSGallery -InstallationPolicy Trusted
PS C:\> Install-Module -Name EulandaConnect -Repository PsGallery -scope CurrentUser
```

Congratulations, now it should have worked!

Now look for the appropriate function in the left navigation and get started.
