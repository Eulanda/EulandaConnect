function Read-IniFile {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if (-Not ($_ | Test-Path) ){
                throw ((Get-ResStr 'PATHIN_DOES_NOT_EXIST') -f $_)
            }
            if (-Not ($_ | Test-Path -PathType Leaf) ){
                throw ((Get-ResStr 'ARGUMENT_MUST_BE_A_FILE') -f $_)
            }
            if ($_ -notmatch "(\.ini)"){
                throw ((Get-ResStr 'MUST_BE_INIFILE') -f $_)
            }
            return $true
        })]
        [System.IO.FileInfo]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'commentCount' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'data' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'name' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'section' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (!(test-path variable:section)) {[string]$section = $null}
        [int]$commentCount = 0

        if (test-path $path) {
            $result = @{}
            $data = get-content $path -Encoding Default
            switch -regex($data)
            {
                "^\[(.+)\]" # Section
                {
                    $section = $matches[1]
                    if (!$result[$section]) { $result[$section] = [ordered]@{} }
                    $commentCount = 0
                }
                "^(;.*)$" # Comment
                {
                    if (!($section))
                    {
                        $section = "No-Section"
                        if (! $result[$section]) { $result[$section] = @{} }
                    }
                    [string]$value = $matches[1]
                    $commentCount = $commentCount + 1
                    $name = "Comment" + $commentCount
                }
                "(.+?)\s*=(.*)" # Key
                {
                    if (!($section))
                    {
                        $section = "No-Section"
                        if (!$result[$section]) { $result[$section] = [ordered]@{} }
                    }
                    $name,$value = $matches[1..2]
                    if ($result[$section].Contains($name))
                        { $result[$section][$name] = $value.Trim() }
                    else
                        { $result[$section].Add($name, $value.Trim()) }
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Read-IniFile -path 'C:\windows\win.ini'
}
