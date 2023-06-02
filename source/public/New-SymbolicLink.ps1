function New-SymbolicLink {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$symbolicLink = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'symbolicLink', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$target = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'target', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$flag = 1 # 1 is directory, change to 0 for a file
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (Test-Administrator) {
            # Attempt to create the symbolic link
            $result = [SymbolicLink]::CreateSymbolicLink($symbolicLink, $target, $flag)

            # Verify that the symbolic link was created successfully
            if($result -eq $false) {
                throw New-Object System.ComponentModel.Win32Exception -ArgumentList @([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())
            }
        } else {
            throw (Get-ResStr('ADMIN_RIGHTS_NEEDED') -f $myInvocation.MyCommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  New-SymbolicLink -symbolicLink 'C:\MySymbolicLink' -target 'C:\temp'
}
