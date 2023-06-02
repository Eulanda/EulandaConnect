function Remove-SymbolicLink {
    param(
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$symbolicLink = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'symbolicLink', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (Test-Administrator) {
            if (Test-Path $symbolicLink) {
                # Check if it is a symbolic link
                $attributes = (Get-Item -Path $symbolicLink).Attributes
                if (($attributes -band [System.IO.FileAttributes]::ReparsePoint) -eq [System.IO.FileAttributes]::ReparsePoint) {
                    try {
                        Remove-Item $symbolicLink -Force
                        Write-Verbose ((Get-ResStr 'VERBOSE_SYMBOLIC_LINK_REMOVED') -f $symbolicLink)
                    } catch {
                        throw ((Get-ResStr 'SYMBOLIC_LINK_REMOVE_ERROR') -f  $symbolicLink, $_)
                    }
                } else {
                    throw ((Get-ResStr 'SYMBOLIC_LINK_ISNOT_SYMBOLIC') -f $symbolicLink)
                }
            } else {
                Write-Verbose ((Get-ResStr 'PATH_NOT_EXISTS') -f $symbolicLink)
            }
        } else {
            throw ((Get-ResStr 'ADMIN_RIGHTS_NEEDED') -f $myInvocation.MyCommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Remove-SymbolicLink -symbolicLink 'C:\MySymbolicLink'
}
