function Update-Desktop {
    [CmdletBinding()]
    param()
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
    New-Variable -Name 'accel_F5' -Scope 'Private' -Value ($null)
    New-Variable -Name 'c' -Scope 'Private' -Value ($null)
    New-Variable -Name 'dsktp' -Scope 'Private' -Value ($null)
    New-Variable -Name 'nullptr' -Scope 'Private' -Value ($null)
    New-Variable -Name 'WM_COMMAND' -Scope 'Private' -Value ([int32]0)
    $initialVariables = Get-CurrentVariables -Debug:$DebugPreference

    try {
        $c= Add-Type -Name WinAPI -PassThru -MemberDefinition @'
        [DllImport("user32.dll")] public static extern IntPtr GetShellWindow();
        [DllImport("user32.dll")] public static extern int SendMessageW(IntPtr hWnd, uint Msg, UIntPtr wParam, IntPtr lParam);
'@
        $dsktp=$c::GetShellWindow();
        $WM_COMMAND=273;
        $accel_F5=New-Object UIntPtr(41504);
        $nullptr=[IntPtr]::Zero;
        [int](($dsktp -eq $nullptr) -or ($c::SendMessageW($dsktp, $WM_COMMAND, $accel_F5, $nullptr) -ne 0)) | Out-Null
    } catch { }
    Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
}
