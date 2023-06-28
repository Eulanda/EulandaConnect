# *****************************************************************************
# EULANDA Software GmbH
# Documentation: https://github.com/Eulanda/EulandaConnect
# License: https://github.com/Eulanda/EulandaConnect/blob/master/License.md
# *****************************************************************************

# -----------------------------------------------------------------------------
# Global Settings
# -----------------------------------------------------------------------------
Set-StrictMode -version latest
Add-Type -AssemblyName System.Windows.Forms | Out-Null

# Used in New-SymbolicLink
try {
    [SymbolicLink]
} catch {
    Add-Type @"
        using System;
        using System.Runtime.InteropServices;

        public class SymbolicLink
        {
            [DllImport("kernel32.dll", SetLastError = true)]
            public static extern bool CreateSymbolicLink(string lpSymlinkFileName, string lpTargetFileName, int dwFlags);
        }
"@
}



# -----------------------------------------------------------------------------
# Global EulandaConnect Variables ReadOnly
# -----------------------------------------------------------------------------
New-Variable -Name 'ecModuleName' -Scope 'Global' -Option ReadOnly -Force -Value ([string]'EulandaConnect') -Description 'Module name for EulandaConnect'
New-Variable -Name 'ecModulePath' -Scope 'Global' -Option ReadOnly -Force -Value ([string]'') -Description 'Path including filename to the EulandaConnect module'
New-Variable -Name 'ecModuleBase' -Scope 'Global' -Option ReadOnly -Force -Value ([string]'') -Description 'Path to the EulandaConnect module'
New-Variable -Name 'ecManifestPath' -Scope 'Global' -Option ReadOnly -Force -Value ([string]'') -Description 'Path to the manifest of the EulandaConnect module'
New-Variable -Name 'ecManifest' -Scope 'Global' -Option ReadOnly -Force -Value (@{}) -Description 'Hashtable of the EulandaConnect module manifest'
New-Variable -Name 'ecModuleVersion' -Scope 'Global' -Option ReadOnly -Force -Value ([version]'0.0') -Description 'Version number for the EulandaConnect module'
New-Variable -Name 'ecModuleCopyright' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]'') -Description 'Copyright for the EulandaConnect module'
New-Variable -Name 'ecModuleLicenseUri' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]'') -Description 'License uri for the EulandaConnect module'

New-Variable -Name 'ecStartTime' -Scope 'Global'  -Option ReadOnly -Force -Value ([datetime]'1900-1-1') -Description 'Start time of EulandaConnect module'
New-Variable -Name 'ecEndTime' -Scope 'Global'  -Option ReadOnly -Force -Value ([datetime]'1900-1-1') -Description 'End time of EulandaConnect module'
New-Variable -Name 'ecCulture' -Scope 'Global'  -Option ReadOnly -Force  -Value ([string]'') -Description 'User language like en-US of EulandaConnect module'
New-Variable -Name 'ecProjectName' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]'') -Description 'Project name using EulandaConnect module'
New-Variable -Name 'ecProjectVersion' -Scope 'Global' -Option ReadOnly -Force -Value ([version]'0.0') -Description 'Project version using for the EulandaConnect module'



# -----------------------------------------------------------------------------
# Global EulandaConnect Variables
# -----------------------------------------------------------------------------
New-Variable -Name 'ecResx' -Scope 'Global' -Force -Value ([System.Collections.Hashtable]@{}) -Description  'Language resources of EulandaConnect module'
New-Variable -Name 'ecProcessId' -Scope 'Global' -Force -Value ([System.Collections.Hashtable]@{}) -Description  'Process id used in logging of EulandaConnect module'



# -----------------------------------------------------------------------------
# Global Constants: ADO Int64
# -----------------------------------------------------------------------------
New-Variable -Name 'adCmdText' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]1) -Description 'ADO constant from EulandaConnect'
New-Variable -Name 'adLockOptimistic' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]3) -Description 'ADO constant from EulandaConnect'
New-Variable -Name 'adOpenKeyset' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]1) -Description 'ADO constant from EulandaConnect'
New-Variable -Name 'adStateClosed' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]0) -Description 'ADO constant from EulandaConnect'
New-Variable -Name 'adStateConnecting' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]2) -Description 'ADO constant from EulandaConnect'
New-Variable -Name 'adStateExecuting' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]4) -Description 'ADO constant from EulandaConnect'
New-Variable -Name 'adStateFetching' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]8) -Description 'ADO constant from EulandaConnect'
New-Variable -Name 'adStateOpen' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]1) -Description 'ADO constant from EulandaConnect'
New-Variable -Name 'adTimeout' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]60*20) -Description 'ADO constant from EulandaConnect'
New-Variable -Name 'adUseClient' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]3) -Description 'ADO constant from EulandaConnect'

New-Variable -Name 'adEmpty' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]0) -Description 'ADO constant for adEmpty from EulandaConnect'
New-Variable -Name 'adTinyInt' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]16) -Description 'ADO constant for adTinyInt from EulandaConnect'
New-Variable -Name 'adSmallInt' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]2) -Description 'ADO constant for adSmallInt from EulandaConnect'
New-Variable -Name 'adInteger' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]3) -Description 'ADO constant for adInteger from EulandaConnect'
New-Variable -Name 'adBigInt' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]20) -Description 'ADO constant for adBigInt from EulandaConnect'
New-Variable -Name 'adUnsignedTinyInt' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]17) -Description 'ADO constant for adUnsignedTinyInt from EulandaConnect'
New-Variable -Name 'adUnsignedSmallInt' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]18) -Description 'ADO constant for adUnsignedSmallInt from EulandaConnect'
New-Variable -Name 'adUnsignedInt' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]19) -Description 'ADO constant for adUnsignedInt from EulandaConnect'
New-Variable -Name 'adUnsignedBigInt' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]21) -Description 'ADO constant for adUnsignedBigInt from EulandaConnect'
New-Variable -Name 'adSingle' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]4) -Description 'ADO constant for adSingle from EulandaConnect'
New-Variable -Name 'adDouble' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]5) -Description 'ADO constant for adDouble from EulandaConnect'
New-Variable -Name 'adCurrency' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]6) -Description 'ADO constant for adCurrency from EulandaConnect'
New-Variable -Name 'adDecimal' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]14) -Description 'ADO constant for adDecimal from EulandaConnect'
New-Variable -Name 'adNumeric' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]131) -Description 'ADO constant for adNumeric from EulandaConnect'
New-Variable -Name 'adBoolean' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]11) -Description 'ADO constant for adBoolean from EulandaConnect'
New-Variable -Name 'adError' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]10) -Description 'ADO constant for adError from EulandaConnect'
New-Variable -Name 'adUserDefined' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]132) -Description 'ADO constant for adUserDefined from EulandaConnect'
New-Variable -Name 'adVariant' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]12) -Description 'ADO constant for adVariant from EulandaConnect'
New-Variable -Name 'adIDispatch' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]9) -Description 'ADO constant for adIDispatch from EulandaConnect'
New-Variable -Name 'adIUnknown' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]13) -Description 'ADO constant for adIUnknown from EulandaConnect'
New-Variable -Name 'adGUID' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]72) -Description 'ADO constant for adGUID from EulandaConnect'
New-Variable -Name 'adDate' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]7) -Description 'ADO constant for adDate from EulandaConnect'
New-Variable -Name 'adDBDate' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]133) -Description 'ADO constant for adDBDate from EulandaConnect'
New-Variable -Name 'adDBTime' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]134) -Description 'ADO constant for adDBTime from EulandaConnect'
New-Variable -Name 'adDBTimeStamp' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]135) -Description 'ADO constant for adDBTimeStamp from EulandaConnect'
New-Variable -Name 'adBSTR' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]8) -Description 'ADO constant for adBSTR from EulandaConnect'
New-Variable -Name 'adChar' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]129) -Description 'ADO constant for adChar from EulandaConnect'
New-Variable -Name 'adVarChar' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]200) -Description 'ADO constant for adVarChar from EulandaConnect'
New-Variable -Name 'adLongVarChar' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]201) -Description 'ADO constant for adLongVarChar from EulandaConnect'
New-Variable -Name 'adWChar' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]130) -Description 'ADO constant for adWChar from EulandaConnect'
New-Variable -Name 'adVarWChar' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]202) -Description 'ADO constant for adVarWChar from EulandaConnect'
New-Variable -Name 'adLongVarWChar' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]203) -Description 'ADO constant for adLongVarWChar from EulandaConnect'
New-Variable -Name 'adBinary' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]128) -Description 'ADO constant for adBinary from EulandaConnect'
New-Variable -Name 'adVarBinary' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]204) -Description 'ADO constant for adVarBinary from EulandaConnect'
New-Variable -Name 'adLongVarBinary' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]205) -Description 'ADO constant for adLongVarBinary from EulandaConnect'
New-Variable -Name 'adChapter' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]136) -Description 'ADO constant for adChapter from EulandaConnect'
New-Variable -Name 'adFileTime' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]64) -Description 'ADO constant for adFileTime from EulandaConnect'
New-Variable -Name 'adPropVariant' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]138) -Description 'ADO constant for adPropVariant from EulandaConnect'
New-Variable -Name 'adVarNumeric' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]139) -Description 'ADO constant for adVarNumeric from EulandaConnect'
New-Variable -Name 'adArray' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int64]8192) -Description 'ADO constant for adArray from EulandaConnect'



# -----------------------------------------------------------------------------
# Global Constants: MsgBox
# -----------------------------------------------------------------------------
New-Variable -Name 'mbNone' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]0) -Description 'Message Box Buttons from EulandaConnect'

New-Variable -Name 'mbOk' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxButtons]::OK)) -Description 'Message Box Buttons from EulandaConnect'
New-Variable -Name 'mbOkCancel' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxButtons]::OkCancel)) -Description 'Message Box Buttons from EulandaConnect'
New-Variable -Name 'mbAbortRetryIgnore' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxButtons]::AbortRetryIgnore)) -Description 'Message Box Buttons from EulandaConnect'
New-Variable -Name 'mbYesNoCancel' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxButtons]::YesNoCancel)) -Description 'Message Box Buttons from EulandaConnect'
New-Variable -Name 'mbYesNo' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxButtons]::YesNo)) -Description 'Message Box Buttons from EulandaConnect'
New-Variable -Name 'mbRetryCancel' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxButtons]::RetryCancel)) -Description 'Message Box Buttons from EulandaConnect'

New-Variable -Name 'mbStop' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxIcon]::Stop)) -Description 'Message Box Icons from EulandaConnect'
New-Variable -Name 'mbHand' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxIcon]::Stop)) -Description 'Message Box Icons from EulandaConnect'
New-Variable -Name 'mbQuestion' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxIcon]::Question)) -Description 'Message Box Icons from EulandaConnect'
New-Variable -Name 'mbWarning' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxIcon]::Warning)) -Description 'Message Box Icons from EulandaConnect'
New-Variable -Name 'mbExclamation' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxIcon]::Warning)) -Description 'Message Box Icons from EulandaConnect'
New-Variable -Name 'mbInfo' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxIcon]::Information)) -Description 'Message Box Icons from EulandaConnect'
New-Variable -Name 'mbAsterisk' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxIcon]::Information)) -Description 'Message Box Icons from EulandaConnect'
New-Variable -Name 'mbInformation' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxIcon]::Information)) -Description 'Message Box Icons from EulandaConnect'

New-Variable -Name 'mbButton1' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxDefaultButton]::Button1)) -Description 'Message Box Default Button from EulandaConnect'
New-Variable -Name 'mbButton2' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxDefaultButton]::Button2)) -Description 'Message Box Default Button from EulandaConnect'
New-Variable -Name 'mbButton3' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxDefaultButton]::Button3)) -Description 'Message Box Default Button from EulandaConnect'

New-Variable -Name 'mbrOk' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.DialogResult]::Ok)) -Description 'Dialog Results from EulandaConnect'
New-Variable -Name 'mbrCancel' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.DialogResult]::Cancel)) -Description 'Dialog Results from EulandaConnect'
New-Variable -Name 'mbrYes' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.DialogResult]::Yes)) -Description 'Dialog Results from EulandaConnect'
New-Variable -Name 'mbrNo' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.DialogResult]::No)) -Description 'Dialog Results from EulandaConnect'
New-Variable -Name 'mbrAbort' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.DialogResult]::Abort)) -Description 'Dialog Results from EulandaConnect'
New-Variable -Name 'mbrRetry' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.DialogResult]::Retry)) -Description 'Dialog Results from EulandaConnect'
New-Variable -Name 'mbrIgnore' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.DialogResult]::Ignore)) -Description 'Dialog Results from EulandaConnect'

if ($PSVersionTable.PSEdition -eq 'Core') {
    New-Variable -Name 'mbButton4' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.MessageBoxDefaultButton]::Button4)) -Description 'Message Box Default Button from EulandaConnect'
    New-Variable -Name 'mbrTryAgain' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.DialogResult]::TryAgain)) -Description 'Dialog Results from EulandaConnect'
    New-Variable -Name 'mbrContinue' -Scope 'Global' -Option ReadOnly -Force -Value ([System.int32]([System.Windows.Forms.DialogResult]::Continue)) -Description 'Dialog Results from EulandaConnect'
} else {
    New-Variable -Name 'mbButton4' -Scope 'Global' -Option ReadOnly -Force -Value  ([System.int32]0) -Description '(needs PowerShell 7.x) Message Box Default Button from EulandaConnect'
    New-Variable -Name 'mbrTryAgain' -Scope 'Global' -Option ReadOnly -Force -Value  ([System.int32]0) -Description '(needs PowerShell 7.x) Dialog Results from EulandaConnect'
    New-Variable -Name 'mbrContinue' -Scope 'Global' -Option ReadOnly -Force -Value  ([System.int32]0) -Description '(needs PowerShell 7.x) Dialog Results from EulandaConnect'
}


# Handle PowerShell module folder, but also the project source folder for debugging
if (Test-Path "$($PSScriptRoot)\$ecModuleName.psm1")  {
    New-Variable -Name 'ecModulePath' -Scope 'Global'  -Option ReadOnly -Force -Value "$($PSScriptRoot)\$ecModuleName.psm1" -Description 'Path including filename to the EulandaConnect module'
} elseif (Test-Path "$($PSScriptRoot)\..\..\$ecModuleName.psm1") {
    New-Variable -Name 'ecModulePath' -Scope 'Global'  -Option ReadOnly -Force -Value (Resolve-Path("$($PSScriptRoot)\..\..\$ecModuleName.psm1")).Path -Description 'Path including filename to the EulandaConnect module'
} else {
    Throw "Module '$ecModuleName.psm1' not found in '$PSScriptRoot' and also not in '$PSScriptRoot\..\..\'"
}

New-Variable -Name 'ecModuleBase' -Scope 'Global'  -Option ReadOnly -Force -Value (Split-Path $ecModulePath -Parent) -Description 'Path to the EulandaConnect module'
New-Variable -Name 'ecManifestPath' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]($ecModulePath.Replace(".psm1", ".psd1"))) -Description 'Path to the manifest of the EulandaConnect module'
New-Variable -Name 'ecManifest' -Scope 'Global'  -Option ReadOnly -Force -Value ([hashtable](Import-PowerShellDataFile -path $ecManifestPath)) -Description 'Hashtable of the EulandaConnect module manifest'
New-Variable -Name 'ecModuleVersion' -Scope 'Global'  -Option ReadOnly -Force -Value ([version]($ecManifest.ModuleVersion)) -Description 'Version number for the EulandaConnect module'
New-Variable -Name 'ecModuleCopyright' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]($ecManifest.Copyright)) -Description 'Copyright for the EulandaConnect module'
New-Variable -Name 'ecModuleLicenseUri' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]'https://www.github.com/Eulanda/EulandaConnect') -Description 'License uri for the EulandaConnect module'

New-Variable -Name 'ecStartTime' -Scope 'Global'  -Option ReadOnly -Force -Value ([datetime](Get-Date)) -Description 'Start time of EulandaConnect module'

New-Variable -Name 'ecCulture' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]([System.Threading.Thread]::CurrentThread.CurrentCulture.Name)) -Description 'User language like en-US of EulandaConnect module'

# Save the original Write-Verbose function
$originalWriteVerbose = Get-Command -Name Write-Verbose
function Write-Verbose {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Message
    )

    try {
        $depth = (Get-PSCallStack).Count - 1  # -1 to not count the own write-verbose function
    }
    catch {
        $depth = 0
    }

    $indent = " " * $depth

    & $originalWriteVerbose -Message "${indent}${Message}"
}




# -----------------------------------------------------------------------------
# Public functions
# -----------------------------------------------------------------------------

function Approve-Signature {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'filename' -Scope 'Private' -Value ''
        New-Variable -Name 'extension' -Scope 'Private' -Value ''
        New-Variable -Name 'folder' -Scope 'Private' -Value ''
        New-Variable -Name 'signFile' -Scope 'Private' -Value ''
        New-Variable -Name 'arguments' -Scope 'Private' -Value ('')
        New-Variable -Name 'exitCode' -Scope 'Private' -Value (0)
        New-Variable -Name 'outputContent' -Scope 'Private' -Value ('')
        New-Variable -Name 'process' -Scope 'Private' -Value $null
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $filename = [IO.Path]::GetFileNameWithoutExtension($path)
        $extension = [IO.Path]::GetExtension($path)
        $folder = [IO.Path]::GetDirectoryName($path)


        if ((! $folder) -or ($folder -eq '.')) {
            $folder= Get-Location
        }

        # If no path take the last folder
        if (! ($filename)) {
            if (! ($folder -in '.', '.\', '')) {
                $filename = Split-Path $folder -Leaf
            }
        }

        # if no extension take ps1, then psm1 then exe
        if (! ($extension)) {
            $extension= '.ps1'
            if (-not (Test-Path "$folder\$($filename)$($extension)" )) {
                $extension= '.psm1'
                if (-not (Test-Path "$folder\$($filename)$($extension)" )) {
                    $extension= '.exe'
                    if (-not (Test-Path "$folder\$($filename)$($extension)" )) {
                        # Change back to .ps1 so that Resolve-Path can render
                        # an exeption with the default extension
                        $extension= '.ps1'
                    }
                }
            }
        }

        # Test to see if undefined vars are in the exception
        # [string]$Tester = '42'

        [string]$signFile= Resolve-Path "$folder\$($filename)$($extension)"
        [string]$arguments = "sign /tr http://timestamp.sectigo.com?td=sha256 /td sha256 /fd sha256 /a ""$signFile"""
        Write-Host ((Get-ResStr 'SIGNING_FILE') -f $signFile) -ForegroundColor Blue

        $process = New-Object System.Diagnostics.Process
        $process.StartInfo.FileName = (Get-SignToolPath)
        $process.StartInfo.Arguments = $arguments
        $process.StartInfo.RedirectStandardOutput = $true
        $process.StartInfo.RedirectStandardError = $true
        $process.StartInfo.UseShellExecute = $false
        $process.StartInfo.CreateNoWindow = $true

        $process.Start() | Out-Null
        $outputContent = $process.StandardOutput.ReadToEnd() + $process.StandardError.ReadToEnd()
        $process.WaitForExit()
        $exitCode = $process.ExitCode
        $process.Dispose()

        if ($exitCode -ne 0 -and $outputContent -notmatch 'Successfully signed') {
            Write-Host -ForegroundColor Red ((Get-ResStr 'SIGNING_FAILED') -f $exitCode)
            Write-Host -ForegroundColor Red $outputContent
            throw ((Get-ResStr 'SIGNING_EXCEPTION') -f $exitCode)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Approve-Signature .\EulandaConnect.psm1
}

function Backup-MssqlDatabase {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeAge = 60*60*3
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeRetries = 7
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$storageFolder
        ,
        [Parameter(Mandatory = $false)]
        [switch]$removeBak
        ,
        [Parameter(Mandatory = $false)]
        [int]$history = 3
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters

        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Get connection and open it
        $myConn = Get-Conn -conn $conn -ConnStr $connStr -udl $udl

        # Extract parameters from connection
        $connItems = Get-ConnItems -conn $myConn
        [string]$datasource = $connItems['Data Source']
        [string]$database = $connItems['Initial Catalog']
        [string[]]$splitDataSource = $datasource -split '\\'
        if ($splitDataSource.Count -gt 1) {
            [string]$instance = $splitDataSource[1]
        } else {
            [string]$instance = "MSSQLSERVER"
        }

        # Get standard backup path
        [hashtable]$instances = @{}
        Get-MssqlInstances | ForEach-Object { $instances[$_.Instance] = $_ }
        [string]$backupPath = $instances[$instance].BackupPath

        # Backup database from connection
        $backupFile = "$backupPath\$database.bak"
        $sql = "BACKUP DATABASE [$database] TO  DISK = N'$backupFile' WITH FORMAT, INIT,  NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, NO_COMPRESSION,  STATS = 10"
        Write-Verbose ((Get-ResStr 'VERBOSE_BACKUP_DATABASE_TO_FILE') -f $database, $backupFile)
        $myConn.Execute($sql) | Out-Null

        # Zip the database backup file
        $zipFile = "$backupPath\$database.zip"
        $result = $zipFile
        $sourcePath = $backupFile
        $sourceFiles = Get-ChildItem -Path $sourcePath -Recurse
        Write-Verbose "Zip database as '$zipFile'"
        $sourceFiles | ForEach-Object {
            $currentFile = $_
            Compress-Archive -Path $currentFile.FullName -DestinationPath $zipFile -CompressionLevel Optimal -Update
        }

        # Create time stamp to enhance the filename to be stored
        [string]$timeStamp = Get-Date -Format "yyyy-MM-dd-HH-mm-ss-ffff"


        # Filesystem is used for storeing zip file
        if ($storageFolder) {
            Write-Verbose ((Get-ResStr 'VERBOSE_COPY_ZIP_TO_FILE') -f  "$storageFolder\$database-$timeStamp.zip")
            Copy-Item -Path $zipFile -Destination "$storageFolder\$database-$timeStamp.zip" -Force

            $files = Get-ChildItem -Path $storageFolder -File | Select-Object -ExpandProperty Name
            $files = Select-OutdatedFilenames -filenames $files -basename $database -extension '.zip' -history $history
            foreach ($file in $files) {
                Remove-Item -Path "$storageFolder\$file" -Force
                Write-Verbose ((Get-ResStr 'VERBOSE_DELETED_FILE_FROM_STORAGE') -f "$storageFolder\$file")
            }
        }

        # Remote server (ftp/sftp) is used for storeing zip file
        if ($server) {
            if ($password.GetType().Name -eq 'String') {
                [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
            }

            $remoteFinalFolder = "$($remoteFolder.TrimEnd('/'))/$instance"
            $remoteFinalFolder = "$($remoteFinalFolder.TrimEnd('/'))"

            $remoteParams = @{
                server = $server
                protocol = $protocol
                port = $port
                activeMode = $activeMode
                certificate = $certificate
                user = $user
                password = $password
            }

            $folderParams = @{
                localFolder = $backupPath
                localFile = "$database.zip"
                remoteFolder = $remoteFinalFolder
                remoteFile = "$database-$timeStamp.zip"
            }

            Send-RemoteFile @remoteParams @folderParams -resumeAge $resumeAge -resumeRetries $resumeRetries
            $files = Get-RemoteDir @remoteParams -mask '*.zip' -remoteFolder $remoteFinalFolder
            $files = Select-OutdatedFilenames -filenames $files -basename $database -extension '.zip' -history $history
            foreach ($file in $files) {
                Remove-RemoteFile @remoteParams -remoteFolder $remoteFinalFolder -remoteFile $file
                Write-Verbose ((Get-ResStr 'VERBOSE_DELETED_FILE_FROM_REMOTE') -f "$remoteFinalFolder/$file")
            }
        }

        # Clean-Up mssql backup folder
        if ($removeBak) {
            Remove-Item $backupFile -force
            Write-Verbose ((Get-ResStr 'VERBOSE_DELETED_BACKUP_FROM_SQL') -f "$backupFile")
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Backup-MssqlDatabase -udl 'C:\temp\Eulanda_1 JohnDoe.udl' -storageFolder 'C:\store' -server 'mysftp.eulanda.eu' -user 'johndoe' -password 'superPass'
}

function Close-Delivery {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name "sql" -Scope "Private" -Value ""
        New-Variable -Name "myConn" -Scope "Private" -Value $null
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        if ($deliveryId)  {
            $sql = @"
            SET NOCOUNT ON;
            DECLARE @DeliveryId int
            SET @DeliveryId = $deliveryId
            EXEC dbo.cn_lfBuchen @lf_id=@DeliveryId
"@
        } else {
            $sql = @"
            SET NOCOUNT ON;
            DECLARE @DeliveryNo int
            SET @DeliveryNo = $deliveryNo
            EXEC dbo.cn_lfBuchen @lf_Nummer=@DeliveryNo
"@
        }

        $myConn.Execute($sql) | out-null

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:   Close-Delivery -deliveryNo 68 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Close-SalesOrder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$salesOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$salesOrderId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$customerOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleSalesOrderKeys) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsSalesOrder' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'relevantError' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsSalesOrder = Get-UsedParameters -validParams (Get-SingleSalesOrderKeys) -boundParams $PSBoundParameters
        $salesOrderId = Get-SalesOrderId @paramsSalesOrder -conn $myConn

        if ($salesOrderId)  {
            $sql = @"
            SET NOCOUNT ON;
            DECLARE @SalesOrderId int
            SET @SalesOrderId = $salesOrderId
            EXEC dbo.cn_afBuchen @af_id=@SalesOrderId
"@
        } else {
            $sql = @"
            SET NOCOUNT ON;
            DECLARE @SalesOrderNo int
            SET @SalesOrderId = $salesOrderNo
            EXEC dbo.cn_afBuchen @af_Nummer=@SalesOrderNo
"@
        }

        try {
            $myConn.Execute($sql) | out-null
        }

        catch {
            $relevantError = Get-ErrorFromConn -conn $myConn
            Throw  "Error: $_! $relevantError"
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:   Close-SalesOrder -salesOrderNo 131 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Confirm-System {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [switch]$all
        ,
        [Parameter(Mandatory = $false)]
        [switch]$administrator
        ,
        [Parameter(Mandatory = $false)]
        [switch]$controlledFolderAccess
        ,
        [Parameter(Mandatory = $false)]
        [switch]$memory
        ,
        [Parameter(Mandatory = $false)]
        [switch]$drives
        ,
        [Parameter(Mandatory = $false)]
        [switch]$network
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        # Test-ValidateLeastOne -validParams @('all','administrator','controlledFolderAccess','memory','drives','network') @PSBoundParameters
        Test-ValidateLeastOne -validParams @() @PSBoundParameters
        New-Variable -Name 'item' -Scope 'Private' -Value ([PSCustomObject]@{})
        New-Variable -Name 'i' -Scope 'Private' -Value ([int]0)
        New-Variable -Name 'diskModel' -Scope 'Private' -Value ''
        New-Variable -Name 'lastSpaceIndex' -Scope 'Private' -Value ([int]0)
        New-Variable -Name 'lastWord' -Scope 'Private' -Value ''
        New-Variable -Name 'status' -Scope 'Private' -Value  ([object[]]$null)
        New-Variable -Name 'broadcastIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'cidr' -Scope 'Private' -Value ([int]0)
        New-Variable -Name 'firstIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'gatewayIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'gatewayName' -Scope 'Private' -Value ''
        New-Variable -Name 'lastIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'localIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'localSubnet' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'maxHosts' -Scope 'Private' -Value ([int]0)
        New-Variable -Name 'networkId' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'publicIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'result' -Scope 'Private' -Value  ([System.Collections.ArrayList]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = New-Object System.Collections.ArrayList

        if ($all -or $administrator) {
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_ADMINISTRATIVE_RIGHTS')
                Value = [string](Test-Administrator)
            }
            $result.Add($item) | Out-Null
        }

        if ($all -or $controlledFolderAccess) {
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_RANSOMWARE')
                Value = [bool](Get-MpPreference | Select-Object EnableControlledFolderAccess).toString()
            }
            $result.Add($item) | Out-Null
        }

        if ($all -or $memory) {
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_MEMORY')
                Value = [string]((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB )
            }
            $result.Add($item) | Out-Null
        }

        if ($all -or $drives) {
            for ($i=0; $i -lt (Get-PsDrive -PsProvider FileSystem).count-1; $i++) {
                $item = [PSCustomObject]@{
                    Description = ((Get-ResStr 'CONFIRM_MEMORY') -f (Get-PsDrive -PsProvider FileSystem)[$i].Name)
                    Value = [string]([math]::Round((Get-PsDrive -PsProvider FileSystem)[$i].Free/1GB))
                }
                $result.Add($item) | Out-Null
            }

            $status = wmic diskdrive get model,status
            for ($i=1; $i -lt $Status.count-1; $i++) {
                if ($status[$i].trim()) {
                    $lastWord = ($status[$i].trim() -split " ")[-1]
                    $lastSpaceIndex = $status[$i].trim().LastIndexOf(" ")-1
                    $diskModel = $status[$i].Substring(0, $lastSpaceIndex).trim()
                    $item = [PSCustomObject]@{
                        Description = ((Get-ResStr 'CONFIRM_SMART') -f $diskModel)
                        Value = [string]$Lastword.trim()
                    }
                    $result.Add($item) | Out-Null
                }
            }
        }

        if ($all -or $network) {
            $gatewayIp = Get-GatewayIp
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_GATEWAY_IP')
                Value = [string]$gatewayIp
            }
            $result.Add($item) | Out-Null

            $gatewayName = Get-Hostname ($gatewayIp)
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_GATEWAY_NAME')
                Value = [string]$gatewayName
            }
            $result.Add($item) | Out-Null

            $localIp = Get-LocalIp
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_LOCAL_IP')
                Value = [string]$localIp
            }
            $result.Add($item) | Out-Null

            $localSubnet= Get-Subnet -localIp $localIp
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_LOCAL_SUBNET')
                Value = [string]$localSubnet
            }
            $result.Add($item) | Out-Null

            $cidr= Get-Cidr -subnet $localSubnet
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_LOCAL_CIDR')
                Value = [string]$cidr
            }
            $result.Add($item) | Out-Null

            $publicIp = Get-PublicIp
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_PUBLIC_IP')
                Value = [string]$publicIp
            }
            $result.Add($item) | Out-Null

            $maxHosts= Get-MaxHosts -cidr $cidr
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_MAX_HOSTS')
                Value = [string]$maxHosts
            }
            $result.Add($item) | Out-Null

            $networkId= Get-NetworkId -ip $localIp -cidr $cidr
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_NETWORK_ID')
                Value = [string]$networkId
            }
            $result.Add($item) | Out-Null

            $firstIp= Get-FirstIp -networkId $networkId -cidr $cidr
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_FIRST_IP')
                Value = [string]$firstIp
            }
            $result.Add($item) | Out-Null


            $lastIp= Get-LastIp -networkId $networkId -cidr $cidr
            $item = [PSCustomObject]@{
                Description =  (Get-ResStr 'CONFIRM_LAST_IP')
                Value = [string]$lastIp
            }
            $result.Add($item) | Out-Null


            $broadcastIp= Get-BroadcastIp -networkId $networkId -cidr $cidr
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_BROADCAST_IP')
                Value = [string]$broadcastIp
            }
            $result.Add($item) | Out-Null
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Confirm-System -administrator -controlledFolderAccess -memory -drives -network
}

function Convert-Accent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'hash' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'item' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = $value
        # case sensitive
        $hash = New-Object hashtable
        $hash['µ']='mikro'
        $hash['€']='eur'
        $hash['ä']='ae'
        $hash['ö']='oe'
        $hash['ü']='ue'
        $hash['Ä']='Ae'
        $hash['Ö']='Oe'
        $hash['Ü']='Ue'
        $hash['ß']='ss'
        $hash['œ']='oe'
        $hash['â']='a'
        $hash['à']='a'
        $hash['á']='a'
        $hash['ç']='c'
        $hash['ê']='e'
        $hash['è']='e'
        $hash['é']='e'
        $hash['ë']='e'
        $hash['î']='i'
        $hash['ì']='i'
        $hash['í']='i'
        $hash['ï']='i'
        $hash['ô']='o'
        $hash['ò']='o'
        $hash['ó']='o'
        $hash['û']='u'
        $hash['ù']='u'
        $hash['ú']='u'
        $hash['Â']='A'
        $hash['À']='A'
        $hash['Á']='A'
        $hash['Ê']='E'
        $hash['È']='E'
        $hash['É']='E'
        $hash['Î']='I'
        $hash['Ì']='I'
        $hash['Í']='I'
        $hash['Ô']='O'
        $hash['Ò']='O'
        $hash['Ó']='O'
        $hash['Û']='U'
        $hash['Ù']='U'
        $hash['Ú']='U'

        foreach ($item in $hash.GetEnumerator()) {
            $result = $result -creplace  "$($item.key)", "$($item.value)"
        }
        $result = Convert-StringCase -value $result -strCase $strCase
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-Accent -value 'Der Caffè ist übergut in Österreich!' -strCase 'Upper'
}

function Convert-DatanormToXml {
    [CmdletBinding()]
    param(
        $datanorm
        ,
        [switch]$show
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Create XmlWriterSettings
        $settings = New-Object System.Xml.XmlWriterSettings
        $settings.Indent = $true

        # Create a StringWriter
        $stringWriter = New-Object System.IO.StringWriter

        # Create XmlWriter that writes to the StringWriter
        $writer = [System.Xml.XmlWriter]::Create($stringWriter, $settings)

        if ($show) {
            $totalItems = $datanorm.a.values.count + $datanorm.p.values.count
            $currentItem = 0
            $item = [string]""
        }

        $writer.WriteStartDocument()

        # Start ARTIKELLISTE
        $writer.WriteStartElement('ARTIKELLISTE')

        foreach ($articleA in $datanorm.a.values) {
            if ($show) {
                $currentItem++
                $percentage = ($currentItem / $totalItems) * 100
                $item = $articleA.ArtikelNummer
                Write-Progress `
                    -Activity (Get-ResStr 'PROGBAR_DATANORM_PROMPT') `
                    -Status ((Get-ResStr 'PROGBAR_DATANORM_STATUS') -f $item, $currentItem, $totalItems) `
                    -PercentComplete $percentage
            }

            # Start ARTIKEL
            $writer.WriteStartElement('ARTIKEL')

            $articleB = $datanorm.b[$articleA.ArtikelNummer]

            $writer.WriteElementString('ARTNUMMER', $articleA.ArtikelNummer)
            $writer.WriteElementString('ARTMATCH', $articleB.Matchcode)
            $writer.WriteElementString('BARCODE', $articleB.EuroArtikelNummer)
            $writer.WriteElementString('ARTNUMMERERSATZ', $articleB.AlternativArtikelNummer)


            $price = (ConvertTo-USFloat -inputString $articleA.Preis)
            if ($articleA.PreisKennzeichen -eq '1') {
                $writer.WriteElementString('VKNETTO', $price)
            } else {
                $writer.WriteElementString('EKNETTO', $price)
            }

            $writer.WriteElementString('PREISEH', (Get-DatanormPriceUnit -priceUnitCode $articleA.PreisEinheit ))
            $writer.WriteElementString('MENGENEH', $articleA.MengenEinheit)
            if ($articleB.VerpackungsMenge) {
                $writer.WriteElementString('VERPACKEH', $articleB.VerpackungsMenge)
            } else {
                $writer.WriteElementString('VERPACKEH', 1)
            }
            $writer.WriteElementString('RABATTGR', $articleA.RabattGruppe)
            $writer.WriteElementString('WARENGR', $articleA.WarenhauptGruppe)

            $writer.WriteElementString('KURZTEXT1', $articleA.Kurztext1)
            $writer.WriteElementString('KURZTEXT2', $articleA.Kurztext2)
            $writer.WriteElementString('ULTRAKURZTEXT', $articleA.Kurztext1)
            $writer.WriteElementString('LANGTEXT', "$($articleA.Kurztext1)`r`n$($articleA.Kurztext2)"  )

            $writer.WriteElementString('USERN3',  (ConvertTo-USFloat -inputString $articleB.EUL_CuAufschlagProStueck))

            # End ARTIKEL
            $writer.WriteEndElement()
        }


        foreach ($price in $datanorm.p.values) {
            # Start ARTIKEL
            $writer.WriteStartElement('ARTIKEL')

            $artNoSet = $false
            if ($price['1']) {
                $writer.WriteElementString('ARTNUMMER', $price['1'].ArtikelNummer)
                $item = $price['1'].ArtikelNummer
                $artNoSet = $true
                $writer.WriteElementString('VKNETTO', (ConvertTo-USFloat -inputString $price['1'].Preis))
            }

            if ($price['2']) {
                if (! $artNoSet) {
                    $writer.WriteElementString('ARTNUMMER', $price['2'].ArtikelNummer)
                    $item = $price['2'].ArtikelNummer
                }
                $writer.WriteElementString('EKNETTO', (ConvertTo-USFloat -inputString $price['2'].Preis))
            }

            # End ARTIKEL
            $writer.WriteEndElement()

            if ($show) {
                $currentItem++
                $percentage = ($currentItem / $totalItems) * 100
                Write-Progress `
                    -Activity (Get-ResStr 'PROGBAR_DATANORM_PROMPT') `
                    -Status ((Get-ResStr 'PROGBAR_DATANORM_STATUS') -f $item, $currentItem, $totalItems) `
                    -PercentComplete $percentage
            }
        }

        # End ARTIKELLISTE
        $writer.WriteEndElement()
        $writer.WriteEndDocument()

        # Clean up the writer
        $writer.Flush()
        $writer.Close()

        # XML RAW for Root
        [xml]$xml = Get-XmlEulandaRoot

        # XML RAW for Metadata
        [xml]$xmlMetadata = Get-XmlEulandaMetadata

        # Now you have the XML in the StringWriter
        [xml]$xmlArticle = $stringWriter.ToString()

        $newNode = $xmlMetadata.SelectSingleNode("//METADATA")
        $node = $xml.ImportNode($newNode, $true)
        $xml.DocumentElement.AppendChild($node) | Out-Null

        if ($xmlArticle) {
            $newNode = $xmlArticle.SelectSingleNode("//ARTIKELLISTE")
            $node = $xml.ImportNode($newNode, $true)
            $xml.DocumentElement.AppendChild($node) | Out-Null
        }

        $result = [string](Format-Xml -xmlString $xml.OuterXml)

        if ($show) {
            Write-Progress -Activity (Get-ResStr 'PROGBAR_DATANORM_PROMPT') -Completed
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  $xml = Convert-DatanormToXml -datanorm $datanorm
}

function Convert-DataToXml {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        $data = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'data', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [switch]$metadata
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
        ,
        [Parameter(Mandatory = $false)]
        [string]$root = 'Root'
        ,
        [Parameter(Mandatory = $false)]
        [string]$arrRoot = 'Records'
        ,
        [Parameter(Mandatory = $false)]
        [string]$arrSubRoot = 'Record'
    )

    function Convert-DataToXmlInner {
        [CmdletBinding()]
        param(
            [Parameter(Mandatory = $false)]
            $data = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'data', $myInvocation.Mycommand))
            ,
            [Parameter(Mandatory = $false)]
            [switch]$metadata
            ,
            [Parameter(Mandatory = $false)]
            [ValidateScript({ Test-ValidateStringCase $_ })]
            [string]$strCase = 'none'
            ,
            [Parameter(Mandatory = $false)]
            [string]$root = 'Root'
            ,
            [Parameter(Mandatory = $false)]
            [string]$arrRoot = 'Records'
            ,
            [Parameter(Mandatory = $false)]
            [string]$arrSubRoot = 'Record'
            ,
            [Parameter(Mandatory = $false)]
            $writer
            ,
            [Parameter(Mandatory = $false)]
            [int]$level
        )

        begin {
            Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
            New-Variable -Name 'encoding' -Scope 'Private' -Value ([System.Text.Encoding]::UTF8)
            New-Variable -Name 'i' -Scope 'Private' -Value (0)
            New-Variable -Name 'key' -Scope 'Private' -Value ('')
            New-Variable -Name 'nodeName' -Scope 'Private' -Value ('')
            New-Variable -Name 'on' -Scope 'Private' -Value ($false)
            New-Variable -Name 'reader' -Scope 'Private' -Value ($null)
            New-Variable -Name 'settings' -Scope 'Private' -Value ($null)
            New-Variable -Name 'spaces' -Scope 'Private' -Value ('')
            New-Variable -Name 'stream' -Scope 'Private' -Value ($null)
            New-Variable -Name 'strValue' -Scope 'Private' -Value ('')
            New-Variable -Name 'value' -Scope 'Private' -Value ($null)
            New-Variable -Name 'xmlString' -Scope 'Private' -Value ('')
            New-Variable -Name 'result' -Scope 'Private' -Value ($null)
            $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
        }

        process {
            if ($DebugPreference -eq "Continue") {
                $on = $true
            } else {
                $on = $false
            }

            $root = Convert-StringCase -value $root -strCase $strCase

            if ($level -eq 0) {
                if ($on) { Write-Host "BEGIN: $root  (:$level)" -ForegroundColor Cyan }
                # On level=0 it is a good way to initialize the xmlWriter
                $encoding = [System.Text.Encoding]::UTF8
                $settings = New-Object System.Xml.XmlWriterSettings
                $settings.Indent = $true
                $settings.IndentChars = "  "
                $settings.Encoding = $encoding
                $stream = New-Object System.IO.MemoryStream
                $writer = [System.XML.XmlWriter]::Create($stream, $settings)

                # Start with the root node
                $writer.WriteStartDocument()
                $writer.WriteStartElement($root)
                if ($metadata) {
                    $writer = Write-XmlMetadata -writer $writer -strCase $strCase
                }
            }

            if  (($data -is [System.Collections.ArrayList]) -or ($data -is [System.Object[]])) {
                $nodeName = (Convert-StringCase -value ($arrRoot) -strCase $strCase)
                $writer.WriteStartElement($nodeName)
                if ($on) { Write-Host "ROOT.Array(max$($data.count)): $nodeName (:$level)" -ForegroundColor Red }
                for ($i=0; $i -lt $data.count; $i++) {
                    $nodeName = (Convert-StringCase -value $arrSubRoot -strCase $strCase)
                    $writer.WriteStartElement($nodeName)
                    if ($on) { Write-Host "ROOT.Array($i): $nodeName (:$level)" -ForegroundColor Red }
                    # $nodeName = (Convert-StringCase -value ($root+$plural) -strCase $strCase)
                    if ($data[$i] -is [System.Collections.Specialized.OrderedDictionary]) {
                        if ($on) { Write-Host "hash(max$($data[$i].count)): $nodeName (:$level+1)" -ForegroundColor blue }
                    }
                    Convert-DataToXmlInner -data $data[$i] -root $nodeName -level ($level+1) -writer $writer -strCase $strCase -arrRoot $arrRoot -arrSubRoot $arrSubRoot
                    $writer.WriteEndElement()
                }
                $writer.WriteEndElement()
            } else {
                foreach ($key in $data.Keys) {
                    $value = $data[$key]
                    if (($value -is [System.Collections.ArrayList]) -or ($value -is [System.Object[]])) {
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        $writer.WriteStartElement($nodeName)
                        if ($on) { Write-Host "array(max$($value.count)): $nodeName (:$level)" -ForegroundColor Red }
                        for ($i=0; $i -lt $value.count; $i++) {
                            $nodeName = (Convert-StringCase -value $arrSubRoot -strCase $strCase)
                            $writer.WriteStartElement($nodeName)
                            if ($on) { Write-Host "array($i): $nodeName (:$level)" -ForegroundColor Red }
                            # $nodeName = (Convert-StringCase -value ($key+$plural) -strCase $strCase)
                            if ($value[$i] -is [System.Collections.Specialized.OrderedDictionary]) {
                                if ($on) { Write-Host "hash(max$($value[$i].count)): $nodeName (:$level+1)" -ForegroundColor blue }
                            }
                            Convert-DataToXmlInner -data $value[$i] -root $nodeName -level ($level+1) -writer $writer -strCase $strCase -arrRoot $arrRoot -arrSubRoot $arrSubRoot
                            $writer.WriteEndElement()
                        }
                        $writer.WriteEndElement()
                    } elseif ($value -is [System.Collections.Hashtable]) {
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        $writer.WriteStartElement($nodeName)
                        if ($on) { Write-Host "hash(max$($value.count)): $nodeName (:$level)" -ForegroundColor blue }
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        Convert-DataToXmlInner -data $value -root $nodeName -level ($level+1) -writer $writer -strCase $strCase -arrRoot $arrRoot -arrSubRoot $arrSubRoot
                        $writer.WriteEndElement()
                    } elseif ($value -is [System.Collections.Specialized.OrderedDictionary]) {
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        $writer.WriteStartElement($nodeName)
                        Convert-DataToXmlInner -data $value -root $nodeName -level ($level+1) -writer $writer -strCase $strCase -arrRoot $arrRoot -arrSubRoot $arrSubRoot
                        $writer.WriteEndElement()
                    } else { # hash values comes here like: System.Collections.Specialized.OrderedDictionary
                        # Here we have the xml node data
                        if ($null -eq $value) {
                            $strValue= ''
                        } else {
                            if ($value.GetType().Name -eq 'DateTime') {
                                $strValue = Convert-DateToIso -value $value -noTimeZone
                            } else {
                                $strValue = [string]$value
                            }
                        }
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        $writer.WriteElementString($nodeName,$strValue)
                        $spaces = Get-Spaces -count ($level * 4)
                        if ($on) { Write-Host "$($spaces)$($nodeName) = '$strValue' (:$level)" -ForegroundColor Green }
                    }
                }
            }

            # If the level is '0' when the function results exits,
            # all recursions are done and the XmlWriter can be closed.
            if ($level -eq 0) {
                if ($on) { Write-Host "END: $root  (:$level)" -ForegroundColor Cyan }
                $writer.WriteEndElement()
                $writer.WriteEndDocument()
                $writer.Flush()
                $writer.Close()

                # Transfer the content of the memory stream to
                # a string and then to a standard XML object
                $stream.Position = 0
                $reader = New-Object System.IO.StreamReader($stream)
                $xmlString = $reader.ReadToEnd()
                [xml]$result = $xmlString
            }
        }

        end {
            Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
            if ($level -eq 0) { Return $result }
        }

    }

    $result = Convert-DataToXmlInner -data $data -metadata:$metadata -strCase $strCase -root $root  -arrRoot $arrRoot -arrSubRoot $arrSubRoot -Debug:$DebugPreference
    Return $result
    # Test:  (Convert-DataToXml -data @([ordered]@{'Field1'='Value1';'Field2'='Value2'}, [ordered]@{'Field3'='Value3';'Field4'='Value4'})).OuterXml
}


function Convert-DateToIso {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [datetime]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [switch]$asUtc
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noTime
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noDate
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noTimeZone
        ,
        [Parameter(Mandatory = $false)]
        [switch]$zeroTime
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noonTime
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'date' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($noTime) {
            [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, 12, 0, 0)

            if ($noTimeZone) {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-dd")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "yyyy-MM-dd")
                }
            } else {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-ddZ")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "yyyy-MM-dd.0zzz")
                }
            }
        } elseif ($noDate) {
            if ($noonTime) {
                [datetime]$date = [datetime]::new(1, 1, 1, 12, 0, 0)
            } elseif ($zeroTime) {
                [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, 0, 0, 0)
            } else
             {
                [datetime]$date = [datetime]::new(1, 1, 1, $value.Hour, $value.Minute, $value.Second)
            }

            if ($noTimeZone) {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "HH:mm:ss")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "HH:mm:ss")
                }
            } else {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "HH:mm:ss.0Z")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "HH:mm:ss.0zzz")
                }
            }
        } else { # time AND date
            if ($noonTime) {
                [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, 12, 0, 0)
            } elseif ($zeroTime) {
                [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, 0, 0, 0)
            } else {
                [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, $value.Hour, $value.Minute, $value.Second)
            }

            if ($noTimeZone) {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-ddTHH:mm:ss")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "yyyy-MM-ddTHH:mm:ss")
                }
            } else {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-ddTHH:mm:ssZ")
                } else {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-ddTHH:mm:ss.0zzz")
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-DateToIso -value (get-date) -noontime -debug
}

function Convert-FromDatanorm {
    [CmdletBinding()]
    param(
        [string]$path
        ,
        [double]$vat = 19.0
        ,
        [double]$cuDel = 802.0 # LAPP Copper Price (LCP) per 100 kg, because DEL has stopped his notes
        ,
        [switch]$utf8
        ,
        [switch]$show
        ,
        [Alias('decimal')]
        [string]$decimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (Test-Path $path -PathType Container) {
            $filenames = @("DATANORM.RAB", "DATANORM.WRG") + (1..999 | ForEach-Object { "DATANORM.{0:D3}" -f $_ }) + (1..999 | ForEach-Object { "DATPREIS.{0:D3}" -f $_ })
            # Convert filenames to absolute paths
            $filepaths = $filenames | ForEach-Object { Join-Path -Path $path -ChildPath $_ }
            # Keep only paths that refer to existing files
            $filepaths = $filepaths | Where-Object { Test-Path $_ -PathType Leaf }
        } else {
            # Path is only a single file
            $filepaths = @($path)
        }


        # Create empty lists for each record type
        $a = @{}
        $b = @{}
        $v = @{}
        $p = @{}

        if ($show) {
            $totalFiles = $filepaths.Count
            $currentFile = 0
        }
        foreach ($filepath in $filepaths) {

            if ($show) {
                $currentFile++
                $percentage = ($currentFile / $totalFiles) * 100
                Write-Progress `
                    -Id 1 `
                    -Activity (Get-ResStr 'PROGBAR_FILES_PROMPT') `
                    -Status ((Get-ResStr 'PROGBAR_FILES_STATUS') -f $(Split-Path $filepath -Leaf), $currentFile, $filepaths.Count) `
                    -PercentComplete $percentage
            }


            # Test if it is an empty file
            if ((Get-Item $filepath).Length -eq 0) {
                Write-Error ((Get-ResStr 'DATANORM_FILE_EMPTY') -f $filepath, $myInvocation.Mycommand) -ErrorAction Continue
                Continue
            }

            if ($utf8) {
                # First test utf-8, this is uncommon and also not according to the standard, but a good way to support both encodings
                $encoding = [System.Text.Encoding]::GetEncoding("UTF-8")
                $allLines = [System.IO.File]::ReadAllLines($filepath, $encoding)

                $hasInvalidChars = $false
                foreach($line in $allLines) {
                    if ($line -match '�') {  # illegal char '�' found
                        $hasInvalidChars = $true
                        break
                    }
                }

                if ($hasInvalidChars) {
                    # This is the allowed method for datanorm
                    $encoding = [System.Text.Encoding]::GetEncoding("IBM850")  # IBM850 corresponds to CP850
                    $allLines = [System.IO.File]::ReadAllLines($filepath, $encoding)
                }
            } else {
                $encoding = [System.Text.Encoding]::GetEncoding("IBM850")  # IBM850 corresponds to CP850
                $allLines = [System.IO.File]::ReadAllLines($filepath, $encoding)
            }

            $totalLines = $AllLines.Count
            $currentLine = 0
            foreach ($line in $allLines) {
                $currentLine++

                # Check which record type is present and process accordingly
                if (! $line) {
                    continue
                }


                # ------------------------------
                # TYPE A
                # ------------------------------
                if ($line[0] -eq "A") {
                    # Separate individual fields
                    $fields = $line.Split(";")

                    # Create new PSobject and assign fields
                    $rec = New-Object PSObject -Property ([ordered]@{
                        SatzKennzeichen       = $fields[0]
                        VerarbeitungsKennzeichen = $fields[1]
                        ArtikelNummer         = $fields[2]
                        TextKennzeichen       = $fields[3]
                        Kurztext1             = $fields[4]
                        Kurztext2             = $fields[5]
                        PreisKennzeichen      = $fields[6]
                        PreisEinheit          = $fields[7]
                        MengenEinheit         = $fields[8]
                        Preis                 = Add-DecimalPoint -number $fields[9]
                        RabattGruppe          = $fields[10]
                        WarenhauptGruppe      = $fields[11]
                        LangtextSchluessel    = $fields[12]
                        EUL_PreisProStueck    = Get-DatanormPricePerUnit `
                                                -price (ConvertTo-USFloat(Add-DecimalPoint -number $fields[9])) `
                                                -priceUnitCode $fields[7]
                    })
                    $a[$rec.ArtikelNummer] = $rec
                    if ($show) {
                        $percentage = ($currentLine / $totalLines * 100)
                        Write-Progress `
                            -Id 2 `
                            -Activity ((Get-ResStr 'PROGBAR_FILE_PROMPT') -f $(Split-Path $filepath -Leaf)) `
                            -Status ((Get-ResStr 'PROGBAR_FILE_STATUS') -f $rec.ArtikelNummer, $currentLine, $totalLines) `
                            -PercentComplete $percentage
                    }
                }

                # ------------------------------
                # TYPE B
                # ------------------------------
                elseif ($line[0] -eq "B") {
                    # Separate individual fields
                    $fields = $line.Split(";")

                    # Create new PSobject and assign fields
                    $rec = New-Object PSObject -Property ([ordered]@{
                        SatzKennzeichen          = $fields[0]
                        VerarbeitungsKennzeichen = $fields[1]
                        ArtikelNummer            = $fields[2]
                        Matchcode                = $fields[3]
                        AlternativArtikelNummer  = $fields[4]
                        KatalogSeite             = $fields[5]
                        CUGewichtsMerker         = $fields[6]
                        CUKennzahl               = $fields[7]
                        Gewicht                  = Add-DecimalPoint -number $fields[8]
                        EuroArtikelNummer        = $fields[9]
                        AnbindungsNummer         = $fields[10]
                        WarenGruppe              = $fields[11]
                        KostenArt                = $fields[12]
                        VerpackungsMenge         = $fields[13]
                        ReverenzKuerzel          = $fields[14]
                        ReverenzNummer           = $fields[15]
                        EUL_CuGewichtProStueck   = Get-DatanormCuWeight `
                                                    -cuWeight (ConvertTo-USFloat(Add-DecimalPoint -number $fields[8])) `
                                                    -divisionCode $fields[6]
                        EUL_CuAufschlagProStueck = Get-DatanormCuSurcharge `
                                                    -cuWeight (ConvertTo-USFloat(Add-DecimalPoint -number $fields[8])) `
                                                    -cuDel $cuDel `
                                                    -cuIncluded $fields[7] `
                                                    -divisionCode $fields[6]
                        EUL_CuDelPro100Kg        = $CuDel.ToString()
                    })
                    $b[$rec.ArtikelNummer] = $rec
                }


                # ------------------------------
                # TYPE V
                # ------------------------------
                elseif ($line[0] -eq "V") {
                    $rec = New-Object PSObject -Property ([ordered]@{
                        SatzKennzeichen       = $line.Substring(0,1)
                        Frei                  = $line.Substring(1,1)
                        Datum                 = Convert-DatanormDateFormat $line.Substring(2,6)
                        InfoText1             = $line.Substring(8,40).Trim()
                        InfoText2             = $line.Substring(48,40).Trim()
                        InfoText3             = $line.Substring(88,35).Trim()
                        VersionsNummer        = $line.Substring(123,2)
                        WaehrungsKennzeichen  = $line.Substring(125,3)
                    })
                    $v['V'] = $rec
                }


                # ------------------------------
                # TYPE P
                # ------------------------------
                elseif ($line[0] -eq "P") {
                    $fields = $line.Split(";")

                    $rec = New-Object PSObject -Property ([ordered]@{
                        SatzKennzeichen          = $fields[0]
                        VerarbeitungsKennzeichen = $fields[1]

                        ArtikelNummer           = $fields[2]
                        PreisKennzeichen        = $fields[3]
                        Preis                   = Add-DecimalPoint -number $fields[4]
                        KonditonKennzeichen1    = $fields[5]
                        Kondition1              = Get-DatanormConditionDecimals -condition $fields[6] -indicator ([int]$fields[5])
                        KonditonKennzeichen2    = $fields[7]
                        Kondition2              = Get-DatanormConditionDecimals -condition $fields[8] -indicator ([int]$fields[7])
                        KonditonKennzeichen3    = $fields[9]
                        Kondition3              = Get-DatanormConditionDecimals -condition $fields[10] -indicator ([int]$fields[9])
                    })
                    if ($show) {
                        $percentage = ($currentLine / $totalLines * 100)
                        Write-Progress `
                            -Id 2 `
                            -Activity ((Get-ResStr 'PROGBAR_FILE_PROMPT') -f $(Split-Path $filepath -Leaf)) `
                            -Status ((Get-ResStr 'PROGBAR_FILE_STATUS') -f $rec.ArtikelNummer, $currentLine, $totalLines) `
                            -PercentComplete $percentage
                    }


                    if ($rec.ArtikelNummer -ne '') {
                        # Check if there's already an entry for the A article number
                        if (!$p.ContainsKey($rec.ArtikelNummer)) {
                            # If not, create a new inner hash table for this article number
                            $p[$rec.ArtikelNummer] = @{}
                        }
                        # Now add the record to the inner hash table, using the PreisKennzeichen as the key
                        $p[$rec.ArtikelNummer][$rec.PreisKennzeichen] = $rec
                    }


                    $rec = New-Object PSObject -Property ([ordered]@{
                        SatzKennzeichen          = $fields[0]
                        VerarbeitungsKennzeichen = $fields[1]

                        ArtikelNummer           = $fields[11]
                        PreisKennzeichen        = $fields[12]
                        Preis                   = Add-DecimalPoint -number $fields[13]
                        KonditonKennzeichen1    = $fields[14]
                        Kondition1              = Get-DatanormConditionDecimals -condition $fields[15] -indicator ([int]$fields[14])
                        KonditonKennzeichen2    = $fields[16]
                        Kondition2              = Get-DatanormConditionDecimals -condition $fields[17] -indicator ([int]$fields[16])
                        KonditonKennzeichen3    = $fields[18]
                        Kondition3              = Get-DatanormConditionDecimals -condition $fields[19] -indicator ([int]$fields[18])
                    })

                    if ($rec.ArtikelNummer -ne '') {
                        # Check if there's already an entry for the A article number
                        if (!$p.ContainsKey($rec.ArtikelNummer)) {
                            # If not, create a new inner hash table for this article number
                            $p[$rec.ArtikelNummer] = @{}
                        }
                        # Now add the record to the inner hash table, using the PreisKennzeichen as the key
                        $p[$rec.ArtikelNummer][$rec.PreisKennzeichen] = $rec
                    }

                    $rec = New-Object PSObject -Property ([ordered]@{
                        SatzKennzeichen          = $fields[0]
                        VerarbeitungsKennzeichen = $fields[1]

                        ArtikelNummer           = $fields[20]
                        PreisKennzeichen        = $fields[21]
                        Preis                   = Add-DecimalPoint -number $fields[22]
                        KonditonKennzeichen1    = $fields[23]
                        Kondition1              = Get-DatanormConditionDecimals -condition $fields[24] -indicator ([int]$fields[23])
                        KonditonKennzeichen2    = $fields[25]
                        Kondition2              = Get-DatanormConditionDecimals -condition $fields[26] -indicator ([int]$fields[25])
                        KonditonKennzeichen3    = $fields[27]
                        Kondition3              = Get-DatanormConditionDecimals -condition $fields[28] -indicator ([int]$fields[27])
                    })

                    if ($rec.ArtikelNummer -ne '') {
                        # Check if there's already an entry for the A article number
                        if (!$p.ContainsKey($rec.ArtikelNummer)) {
                            # If not, create a new inner hash table for this article number
                            $p[$rec.ArtikelNummer] = @{}
                        }
                        # Now add the record to the inner hash table, using the PreisKennzeichen as the key
                        $p[$rec.ArtikelNummer][$rec.PreisKennzeichen] = $rec
                    }
                }
            }

        }

        if ($show) {
            Write-Progress -Id 1 -Activity (Get-ResStr 'PROGBAR_FILES_PROMPT') -Completed
            Write-Progress -Id 2 -Activity (Get-ResStr 'PROGBAR_FILE_PROMPT') -Completed
        }

        # Create a new object that contains all supported record types of ol processed files
        $datanorm = New-Object PSObject -Property @{
            a = $a
            b = $b
            v = $v
            p = $p
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $datanorm
    }
    # Test: $datanorm = Convert-FromDatanorm -path "$PSScriptRoot\.ignore\data\zander"
}

function Convert-ImageToBase64 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateFileExists -Path $_ })]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'base64' -Scope 'Private' -Value ('')
        New-Variable -Name 'content' -Scope 'Private' -Value ($null)
        New-Variable -Name 'extension' -Scope 'Private' -Value ('')
        New-Variable -Name 'mimeType' -Scope 'Private' -Value ('')
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $content = [System.IO.File]::ReadAllBytes($path)
        $base64 = [System.Convert]::ToBase64String($content)
        $extension = [System.IO.Path]::GetExtension($path).ToLower()
        switch ($extension) {
            ".jpg"  { $mimeType = "image/jpeg" }
            ".jpeg" { $mimeType = "image/jpeg" }
            ".gif"  { $mimeType = "image/gif" }
            ".png"  { $mimeType = "image/png" }
            ".bmp"  { $mimeType = "image/bmp" }
            ".ico"  { $mimeType = "image/x-icon" }
            default { throw "Unknown image file type: $extension" }
        }
        $result = "data:$mimeType;base64,$base64"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $result
    }
    # Test:  Convert-ImageToBase64 -path 'C:\temp\Eulanda.jpg'
}

function Convert-OemToUtf8 {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$inputString
    )

    $convertedString = [System.Text.StringBuilder]::new()

    foreach ($char in $inputString.ToCharArray()) {
        switch ([int][char]$char) {
            129 {
                $convertedString = $convertedString.Append('ü')
            }
            132 { $convertedString = $convertedString.Append('ä') }
            142 { $convertedString = $convertedString.Append('Ä') }
            148 { $convertedString = $convertedString.Append('ö') }
            153 { $convertedString = $convertedString.Append('Ö') }
            154 { $convertedString = $convertedString.Append('Ü') }
            225 { $convertedString = $convertedString.Append('ß') }
            default { $convertedString = $convertedString.Append($char) }
        }
    }

    return $convertedString.ToString()

    # Test: $a = Convert-OemToUtf8 'Rckfahrt'
}

function Convert-Slugify {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('-', '_')]
        [string]$delimiter = '_'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'regex' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $regex = [System.Text.RegularExpressions.Regex]
        $result = convert-accent -value $value
        $result = [Regex]::Replace($result, [char]0x20AC, ' EUR ')  # For compatibility with powerShell 5.x
        $result = $result.replace('$',' USD ')
        $result = $result.replace('£',' GBP ')
        $result = $result.replace('²','2')
        $result = $result.replace('³','3')
        $result = $result.replace('-',' ')
        $result = $result.replace('_',' ')
        $result = $regex::Replace($result, "[^a-zA-Z0-9\s-]", "")
        $result = $regex::Replace($result, "\s+", " ").Trim()
        $result = $regex::Replace($result, "\s", $delimiter)
        $result = $result = Convert-StringCase -value $result -strCase $strCase
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-Slugify -value 'This is Österreich where you pan pay in € or $ but all in m³ and never in m²'
}

Function Convert-StringCase {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'culture' -Scope 'Private' -Value ($null)
        New-Variable -Name 'words' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'wordsCapitalized' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $value
        switch ( $strCase.ToLower() ) {
            'none' { $result = $result }
            'upper' { $result = $result.ToUpper() }
            'lower' { $result = $result.ToLower() }
            'capital' {
                $culture = [System.Globalization.CultureInfo]::CurrentCulture
                $words = $result.Split(' ')
                $wordsCapitalized = $words | ForEach-Object { $culture.TextInfo.ToTitleCase($_) }
                $result = $wordsCapitalized -join ' '
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-StringCase -value 'Der Caffè ist übergut in Österreich!' -strCase capital
}

function Convert-SubnetToBitmask {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [int]$cidr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams ('subnet','cidr') @PSBoundParameters
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if ((! $subnet) -and (! $Cidr)) {
                $subnet = Get-Subnet # get it fron local ip
            }

            if (! $cidr) {
                $cidr = Get-Cidr -subnet $subnet
            }
            $result = ('1' * $cidr).PadRight(32, '0')
        }
        catch {
            $result= [string]"0".PadRight(32, '0')
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # test:  Convert-SubnetToBitmask -cidr 24
}

function Convert-ToDecimalDegrees {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateRange(0,180)]
        [int]$degrees
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(0,59)]
        [int]$minutes
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(0,59)]
        [int]$seconds
        ,
        [parameter(Mandatory = $false)]
        [ValidateSet('N', 'S', 'E', 'W')]
        [string]$direction
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $degrees + $minutes / 60 + $seconds / 3600

        # Convert direction to upper case
        $direction = $direction.ToUpper()

        # If the direction is South or West, make the result negative
        if ($direction -eq 'S' -or $direction -eq 'W') {
            $result *= -1
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-ToDecimalDegrees
}

function ConvertTo-USFloat {
    [CmdletBinding()]
    param (
        [string]$inputString
    )

    $commaPos = $inputString.LastIndexOf(",")
    $dotPos = $inputString.LastIndexOf(".")

    if ($dotPos -gt $commaPos) {
        $outputString = [string]$inputString.Replace(",", "")
    } else {
        $outputString = [string]$inputString.Replace(".", "")
        $outputString = [string]$outputString.Replace(",", ".")
    }

    try {
        $outputFloat = [float]$outputString
        if ($outputFloat) { $outputFloat = 0}  # Suppress vsc error markers
    } catch {
        Write-Error (Get-ResStr 'USFLOAT_ERROR') -f $inputString, $myInvocation.Mycommand
        return
    }

    return $outputString
}

function ConvertTo-WrappedLines {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$text
        ,
        [Parameter(Mandatory = $false)]
        [int]$width= 80
        ,
        [Parameter(Mandatory = $false)]
        [switch]$asString
        ,
        [Parameter(Mandatory = $false)]
        [switch]$useCrLf
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'column' -Scope 'Private' -Value (0)
        New-Variable -Name 'line' -Scope 'Private' -Value ('')
        New-Variable -Name 'paragraph' -Scope 'Private' -Value ('')
        New-Variable -Name 'paragraphs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rawWords' -Scope 'Private' -Value ($null)
        New-Variable -Name 'word' -Scope 'Private' -Value ('')
        New-Variable -Name 'words' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # standard arrays dont allow 'add' command
        $result = [System.Collections.ArrayList]@()

        # Normalize string delimiter to unix style
        $text = $text.replace("`r`n", "`n")

        # Delete all unnecessary empty lines and characters at the end of the last paragraph
        $text = $text.TrimEnd()

        # Each line break is a hard return, i.e. a paragraph
        [string[]]$paragraphs = $text -split "\n+"

        foreach ($paragraph in $paragraphs ) {

            [string[]]$rawWords = $paragraph -split "\s+"

            # Create a word list with words and make sure that no word is longer than 'width'
            $words = [System.Collections.ArrayList]@()
            foreach ($word in $rawWords ) {
                if ($word.Length -le $width) {
                    $words.Add($word) | Out-Null
                } else {
                    # if one word is longer then the width, split it
                    [string[]]$wordparts = $word -split "(.{$width})" -ne ''
                    foreach ($word in $wordparts) {
                        $words.Add($word) | Out-Null
                    }
                }
            }

            # Put as many words as possible in one line, but never longer than 'width'
            [int]$column = 0
            [string]$line = ""
            foreach ($word in $words ) {
                $column += $word.Length + 1
                if ($column -gt $width ) {
                    $result.add($line.trim()) | Out-Null
                    $column = $word.Length + 1
                    $line = ""
                }
                $line = "$line$($word) "
            }
            $result.add($line.trim()) | Out-Null
        }

        if ($asString) {
            if ($useCrLf) {
                [string]$result = $result -join "`r`n"
            } else {
                [string]$result = $result -join "`n"
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  ConvertTo-WrappedLines -text 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor lacus sed augue commodo dapibus. Suspendisse potenti.' -width 40
}

function ConvertTo-WrappedLinesEdi {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$text
        ,
        [Parameter(Mandatory = $false)]
        [int]$Width = 80
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'a1' -Scope 'Private' -Value ('')
        New-Variable -Name 'al' -Scope 'Private' -Value ('')
        New-Variable -Name 'i' -Scope 'Private' -Value (0)
        New-Variable -Name 'maxPunctuation' -Scope 'Private' -Value (0)
        New-Variable -Name 'paragraph' -Scope 'Private' -Value ('')
        New-Variable -Name 'paragraphs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'punctuation' -Scope 'Private' -Value (0)
        New-Variable -Name 'test' -Scope 'Private' -Value (0)
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Standard arrays dont allow 'add' command
        $result = [System.Collections.ArrayList]@()

        # Normalize string delimiter to unix style
        $text = $text.replace("`r`n", "`n")

        # Delete all unnecessary empty lines and characters at the end of the last paragraph
        $text = $text.TrimEnd()

        # Each line break is a hard return, i.e. a paragraph
        [string[]]$paragraphs = $text -split "\n+"

        # Clear unnessecary spaces in each paragraph
        for ($i=0; $i -le $paragraphs.Count-1; $i++) {
            $paragraphs[$i] = $paragraphs[$i].Trim()
        }

        # Check if nativ lines match 2 lines and each line is less $width
         if (($paragraphs.count -eq 2) -and ($paragraphs[0].length -le $width) -and ($paragraphs[1].length -le $width)) {
            $al = $paragraphs[0]
            $a1 = $paragraphs[1]
            Write-Verbose (Get-ResStr 'VERBOSE_WRAPPED_TWO_LINES')
        } elseif (($paragraphs.count -eq 1) -and ($paragraphs[0].length -le $width) ) {
            Write-Verbose (Get-ResStr 'VERBOSE_WRAPPED_FIRST_LINE')
            $al = $paragraphs[0]
            $a1 = ""
        } else {
            # AT LEAST ONE LINE IS TOO LONG

            # Make one big line
            [string]$paragraph = $paragraphs -join (' ')

            # Clear double spaces
            $paragraph = $paragraph.Replace('  ', ' ')

            [string]$al = $paragraph.Substring(0,[System.Math]::Min($width, $paragraph.Length))
            [string]$a1 = $paragraph.Substring([System.Math]::Min($width, $paragraph.Length))

            # Only if there is text in A1, it could be better to make a new line wrapping
            if ($a1) {
                $punctuation = Get-PunctuationIdx $al

                [int]$maxPunctuation = $al.Length / 3 * 2
                if (($punctuation -ne -1) -and ($punctuation -lt $maxPunctuation)) {
                    # if we are loosing to much chars we are dividung after the last word
                    [Int]$test = $al.lastIndexOf(' ')
                    if ($test -gt $punctuation) { $punctuation = $test -1 }
                }

                if ($punctuation -ge 0) {
                    $a1 = "$($al.Substring($punctuation+1))$a1"
                    $a1 = $a1.Trim()
                    if ($a1.Length -gt $width) {
                        $a1 = "$($a1.Substring(0,$width-3))..."
                    }
                    $al = $al.Substring(0, $punctuation+1)
                }
            }

        }

        [string[]]$result = @()

        $result += $al.trim()
        $result += $a1.trim()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  ConvertTo-WrappedLinesEdi -text 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor lacus sed augue commodo dapibus. Suspendisse potenti.' -width 40
}

function ConvertTo-XmlString {
    [CmdletBinding()]
    param (
        [System.__ComObject]$adoField
        ,
        [switch]$includeEmpty
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'adoType' -Scope 'Private' -Value ([int64]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [long]$adoType = $adoField.Type
        [object]$result = $adoField.Value

        switch ($adoType) {
            {$_ -in @($adChar, $adVarChar, $adLongVarChar, $adWChar, $adVarWChar, $adLongVarWChar, $adBSTR)} {

                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    [string]$result = [string]''
                } else {
                    [string]$result = [string]$result.trim()
                }
            }
            {$_ -in @($adSmallInt, $adInteger, $adTinyInt)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'0'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            {$_ -in @($adBigInt, $adUnsignedBigInt)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'0'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            {$_ -in @($adSingle, $adDouble)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'0.0'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            {$_ -in @($adCurrency, $adDecimal, $adNumeric)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'0.0'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            {$_ -in @($adDate, $adDBDate, $adDBTimeStamp)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                     } else {
                        [string]$result = [string](Convert-DateToIso -value ([datetime]::MinValue))
                     }
                } else {
                    [string]$result =  [string](Convert-DateToIso -value $result)
                }
            }
            {$_ -in @($adBoolean)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'False'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            default {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    [string]$result = [string]''
                } else {
                    [string]$result = [string]$result
                }
            }
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    <# Test:
        $rs = New-Object -ComObject ADODB.Recordset
        $rs.Fields.Append("MyDateField", $adDBTimeStamp)
        $rs.Open()
        $rs.AddNew()
        $rs.Fields("MyDateField").Value = Get-Date
        $adoField = $rs.Fields("MyDateField")

        ConvertTo-XmlString -adoField $adoField -debug

        $rs.Close()
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($rs) | Out-Null
    #>
}

function Deny-RemoteFingerprint {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'cachedFingerprint' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'remoteFingerprint' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($protocol -eq 'sftp') {
            if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
                Import-Module -Name POSH-SSH -global
                $trustedInfo = Get-SSHTrustedHost -HostName $server
                if ($trustedInfo) {
                    $cachedFingerprint = [string]($trustedInfo).Fingerprint
                }
                try {
                    $serverInfo = Get-SSHHostKey -ComputerName $server -Port $port
                    if ($serverInfo) {
                        $remoteFingerprint = [string]($serverInfo).Fingerprint
                        if (($null -ne $cachedFingerprint -and $cachedFingerprint -ne "") -and $cachedFingerprint -ne $remoteFingerprint) {
                            $result = $true
                        }
                    }
                } catch {
                }
            } else {
                Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Deny-RemoteFingerprint -server 'myftp.eulanda.eu'
}

function Export-ArticleToXml {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNotEmpty -strParam $_ })]
        [string]$select = (Get-DefaultSelectArticle)
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$alias = 'articleNo'
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$order = $alias
        ,
        [parameter(Mandatory = $false)]
        [switch]$reorder
        ,
        [parameter(Mandatory = $false)]
        [switch]$revers
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateCustomerGroups -CustomerGroups $_ })]
        [string]$customerGroups
        ,
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbPath = '\Shop'
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noEmptyPropertyTree
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathXML -path $_  })]
        [string]$path
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    # **************************************************************************
    # CREATE XML MESSAGE: ARTICLE
    # **************************************************************************

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingArticleKeys)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newNode' -Scope 'Private' -Value ($null)
        New-Variable -Name 'node' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlArticle' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlMetadata' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlPropertyTree' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value (@{})
        New-Variable -Name 'Result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SetArticleWithGroupsFilter) -boundParams $PSBoundParameters

        # **************************************************************************
        # Create a raw version for each database section
        # **************************************************************************

        # XML RAW for Root
        [xml]$xml = Get-XmlEulandaRoot

        # XML RAW for Metadata
        [xml]$xmlMetadata = Get-XmlEulandaMetadata

        # XML RAW for PropertyTree
        if ($breadcrumbPath) {
            [xml]$xmlPropertyTree = Get-XmlEulandaProperty -breadcrumbPath $breadcrumbPath -tablename 'Article' -conn $myConn
        } else {
            [xml]$xmlPropertyTree = '<MERKMALBAUM><ARTIKEL /></MERKMALBAUM>'
        }
        if ($noEmptyPropertyTree -and
            $xmlPropertyTree.Merkmalbaum.ChildNodes.Count -eq 1 -and
            $xmlPropertyTree.Merkmalbaum.ChildNodes[0].IsEmpty) {
                [xml]$xmlPropertyTree = $null
        }

        # XML RAW for all articles including nodes like SHOP, LAGER, PREISLISTE, MERKMALLISTE
        [xml]$xmlArticle = Get-XmlEulandaArticle @paramsArticle -conn $myConn


        # **************************************************************************
        # Assemble the individual XML nodes into an XML message.
        # **************************************************************************

        $newNode = $xmlMetadata.SelectSingleNode("//METADATA")
        $node = $xml.ImportNode($newNode, $true)
        $xml.DocumentElement.AppendChild($node) | Out-Null

        if ($xmlPropertyTree) {
            $newNode = $xmlPropertyTree.SelectSingleNode("//MERKMALBAUM")
            $node = $xml.ImportNode($newNode, $true)
            $xml.DocumentElement.AppendChild($node) | Out-Null
        }

        if ($xmlArticle) {
            $newNode = $xmlArticle.SelectSingleNode("//ARTIKELLISTE")
            $node = $xml.ImportNode($newNode, $true)
            $xml.DocumentElement.AppendChild($node) | Out-Null
        }

        if ($path) {
            Format-Xml -xmlString $xml.OuterXml -pathOut $path
        } else {
            [string]$result= (Format-Xml -xmlString $xml.OuterXml)
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Export-ArticleToXml -filter "ArtNummer>='1000' and ArtNummer<='1100'" -customerGroups 'HA,HB,HC' -udl 'C:\temp\Eulanda_1 Eulanda.udl' -path "$(Get-DesktopDir)\ARTICLE.xml"
    # Test:  Export-ArticleToXml -filter "ArtNummer>='1000' and ArtNummer<='1100'" -customerGroups 'HA,HB,HC' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Export-DeliveryToXml {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [switch]$includeEmpty
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$sql = $(
            if ($deliveryId) {
                Get-DeliverySql -deliveryId $deliveryId
            } else {
                Get-DeliverySql -deliveryNo $deliveryNo
            }
        )
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathXML -path $_  })]
        [string]$path
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newNode' -Scope 'Private' -Value ($null)
        New-Variable -Name 'node' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsDelivery' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'xml' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlDelivery' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlMetadata' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsDelivery = Get-UsedParameters -validParams (Get-SingleDeliveryKeys) -boundParams $PSBoundParameters

        # **************************************************************************
        # Create a raw version for each database section
        # **************************************************************************

        # XML RAW for Root
        [xml]$xml = Get-XmlEulandaRoot

        # XML RAW for Metadata
        [xml]$xmlMetadata = Get-XmlEulandaMetadata

        # XML RAW for Delivery
        [xml]$xmlDelivery = Get-XmlEulandaDelivery @paramsDelivery -sql $sql -includeEmpty:$includeEmpty -conn $myConn


        # **************************************************************************
        # Assemble the individual XML nodes into an XML message.
        # **************************************************************************

        $newNode = $xmlMetadata.SelectSingleNode("//METADATA")
        $node = $xml.ImportNode($newNode, $true)
        $xml.DocumentElement.AppendChild($node) | Out-Null

        if ($xmlDelivery) {
            $newNode = $xmlDelivery.SelectSingleNode("//LIEFERSCHEINLISTE")
            $node = $xml.ImportNode($newNode, $true)
            $xml.DocumentElement.AppendChild($node) | Out-Null
        }

        if ($path) {
            Format-Xml -xmlString $xml.OuterXml -pathOut $path
        } else {
            [string]$result= (Format-Xml -xmlString $xml.OuterXml)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Export-DeliveryToXml -deliveryNo 430952 -includeEmpty -udl 'C:\temp\Eulanda_1 JohnDoe.udl' -debug
}
function Export-PropertyToXml {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noEmptyPropertyTree
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingTablename) })]
        [string]$tablename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tablename', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathXML -path $_  })]
        [string]$path
        ,
        [Parameter(Mandatory = $false)]
        [AllowNull()]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newNode' -Scope 'Private' -Value ($null)
        New-Variable -Name 'node' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlMetadata' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlPropertyTree' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)

        # XML RAW for Root
        [xml]$xml = Get-XmlEulandaRoot

        # XML RAW for Metadata
        [xml]$xmlMetadata = Get-XmlEulandaMetadata

        # XML RAW for PropertyTree
        if ($breadcrumbPath) {
            [xml]$xmlPropertyTree = Get-XmlEulandaProperty -breadcrumbPath $breadcrumbPath -tablename $tablename -conn $myConn
        } else {
            [xml]$xmlPropertyTree = '<MERKMALBAUM><ARTIKEL /></MERKMALBAUM>'
        }

        if ($noEmptyPropertyTree -and
            $xmlPropertyTree.Merkmalbaum.ChildNodes.Count -eq 1 -and
            $xmlPropertyTree.Merkmalbaum.ChildNodes[0].IsEmpty) {
                [xml]$xmlPropertyTree = $null
        }

        $newNode = $xmlMetadata.SelectSingleNode("//METADATA")
        $node = $xml.ImportNode($newNode, $true)
        $xml.DocumentElement.AppendChild($node) | Out-Null

        if ($xmlPropertyTree) {
            $newNode = $xmlPropertyTree.SelectSingleNode("//MERKMALBAUM")
            $node = $xml.ImportNode($newNode, $true)
            $xml.DocumentElement.AppendChild($node) | Out-Null
        }

        if ($path) {
            Format-Xml -xmlString $xml.OuterXml -pathOut $path
        } else {
            [string]$result = (Format-Xml -xmlString $xml.OuterXml)
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Export-PropertyToXml -breadcrumbPath '\Shop' -tablename 'Article' -udl 'C:\temp\Eulanda_1 Eulanda.udl' -path "$(Get-DesktopDir)\PROPERTYTREE.xml"
    # Test:  Export-PropertyToXml -breadcrumbPath '\Produkte' -tablename 'Address' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

Function Export-StockToXml {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$alias = 'articleNo'
        ,
        [parameter(Mandatory = $false)]
        [int]$qtyStatic
        ,
        [parameter(Mandatory = $false)]
        [string]$warehouse
        ,
        [parameter(Mandatory = $false)]
        [switch]$legacy
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathXML -path $_  })]
        [string]$path
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ('')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)

        if ((! $warehouse) -and (! $legacy)) {
            [string]$nodeName = 'LAGERLISTE'
        } else {
            [string]$nodeName = 'LAGER'
        }

        [string[]]$sql= Get-StockSql -filter $filter -alias $alias -qtyStatic $qtyStatic -warehouse $warehouse -legacy:$legacy
        [System.Object]$data = Get-DataFromSql -sql $sql -conn $myConn -arrRoot $nodeName
        [xml]$xml = Convert-DataToXml -data $data -metadata -root 'EULANDA' -arrRoot 'ARTIKELLISTE' -arrSubRoot 'ARTIKEL'

        if ($path) {
            Format-Xml -xmlString $xml.OuterXml -pathOut $path
        } else {
            [string]$result= (Format-Xml -xmlString $xml.OuterXml)
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Export-StocktoXml -path "C:\Temp\Stock.xml" -udl "C:\Git\Powershell\ProcosSystem\EULANDA_1 ProcosUSA.udl"
 }

Function Find-MssqlServer {
    [CmdletBinding()]
     param(
        [parameter(Mandatory = $false)]
        [string]$localIp = (Get-LocalIp)
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteIp = '255.255.255.255'
        ,
        [Parameter(Mandatory = $false)]
        [int]$udpPort = 1434
        ,
        [Parameter(Mandatory = $false)]
        [int]$timeoutSeconds = 2
     )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'broadcastIP' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'udpClient' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tempObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'startTime' -Scope 'Private' -Value ($null)
        New-Variable -Name 'responseString' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'response' -Scope 'Private' -Value ($null)
        New-Variable -Name 'receivedEndpoint' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rawString' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'udpPacket' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'pairs' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'list' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'item' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'foundServers' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'endpoint' -Scope 'Private' -Value ($null)
        New-Variable -Name 'elapsedTime' -Scope 'Private' -Value ([double]0.0)
        New-Variable -Name 'localEndpoint' -Scope 'Private' -Value ($null)
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # $result = New-Object System.Collections.ArrayList

        # Create UDP client
        $udpClient = New-Object System.Net.Sockets.UdpClient
        $udpClient.Client.ReceiveTimeout = $timeoutSeconds * 1000
        $udpClient.Client.SetSocketOption([System.Net.Sockets.SocketOptionLevel]::Socket, [System.Net.Sockets.SocketOptionName]::Broadcast, 1)

        # Bind UDP client to local network interface
        $localEndpoint = New-Object System.Net.IPEndPoint ([System.Net.IPAddress]::Parse($localIp), 0)
        $udpClient.Client.Bind($localEndpoint)

        # Prepare magic message
        $udpPacket = 0x02, 0x00, 0x00

        # Broadcast or single remote ip
        $endpoint = New-Object System.Net.IPEndPoint ([System.Net.IPAddress]::Parse($remoteIp), $udpPort)

        # Send message
        $udpClient.Send($udpPacket, $udpPacket.Length, $endpoint) | Out-Null

        # Wait for response
        $startTime = Get-Date
        $elapsedTime = 0
        $foundServers = @{}

        try {
            while ($elapsedTime -lt $timeoutSeconds) {
                if ($udpClient.Available -gt 0) {
                    try {
                        $receivedEndpoint = New-Object System.Net.IPEndPoint ([System.Net.IPAddress]::Any, 0)
                        $response = $udpClient.Receive([ref]$receivedEndpoint)
                        $responseString = [System.Text.Encoding]::ASCII.GetString($response)

                        if (-not $foundServers.ContainsKey($receivedEndpoint.Address.ToString())) {
                            $foundServers.Add($receivedEndpoint.Address.ToString(), $true)

                            $rawString = $responseString.Substring(3,$responseString.Length-3)
                            $rawString = $rawString.Replace(';;',"`t")
                            $list = $rawString.Split("`t").trim()
                            $list = $list | Where-Object { $_ -ne "" }
                            foreach ($item in $list) {
                                $pairs = $item.Split(';')
                                $tempObj= [PSCustomObject]@{
                                    Ip = $($receivedEndpoint.Address)
                                }
                                for ($i = 0; $i -lt $pairs.Length; $i += 2) {
                                    $key = $pairs[$i]
                                    $value = $pairs[$i+1]
                                    Add-Member -InputObject $tempObj -MemberType NoteProperty -Name $key -Value $value
                                }
                                $result.Add($tempObj) | Out-Null
                            }
                        }
                    }
                    catch [System.Net.Sockets.SocketException] {
                        if ($_.Exception.ErrorCode -ne 10060) {
                            throw
                        }
                    }
                }
                Start-Sleep -Milliseconds 100
                $elapsedTime = (Get-Date) - $startTime
                $elapsedTime = $elapsedTime.TotalSeconds
            }
        }
        finally {
            $udpClient.Close()
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Find-MssqlServer -remoteIp '192.168.41.1'
 }

function Format-Xml {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$xmlString
        ,
        [Parameter(Mandatory = $false)]
        [string]$pathIn
        ,
        [Parameter(Mandatory = $false)]
        [string]$pathOut
        ,
        [Parameter(Mandatory = $false)]
        [switch]$removeDecoration
        ,
        [Parameter(Mandatory = $false)]
        [switch]$setDecoration
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'data' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'strWriter' -Scope 'Private' -Value ([System.IO.StringWriter]::new())
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xml' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference

        # Parameter validation in PowerShell doesn't support function-generated error messages

        # Rule 1: If XmlString is provided, PathIn cannot be provided and vice versa. But one of them must be provided
        if (![string]::IsNullOrEmpty($xmlString) -and ![string]::IsNullOrEmpty($pathIn)) {
            throw (Get-ResStr 'SPECIFY_XMLSTRING_OR_XMLFILE')
        } elseif ([string]::IsNullOrEmpty($xmlString) -and [string]::IsNullOrEmpty($pathIn)) {
            throw (Get-ResStr 'SPECIFY_XMLSTRING_OR_XMLFILE')
        }

        # Rule 2: PathIn must exist, if used
        if (![string]::IsNullOrEmpty($pathIn) -and !(Test-Path $pathIn)) {
            throw ((Get-ResStr 'PATHIN_DOES_NOT_EXIST') -f $pathIn)
        }

        # Rule 3: PathOut must exist, if used
        if (![string]::IsNullOrEmpty($pathOut) -and !(Test-Path (Split-Path $pathOut -Parent))) {
            throw ((Get-ResStr 'PATHOUT_DOES_NOT_EXIST') -f $pathOut)
        }
    }

    process {
        if ($pathIN) {
            $xmlString = Get-Content -Path $pathIn
        }

        [System.Collections.ArrayList]$data = New-Object System.Collections.ArrayList
        $data.Add($xmlString -join "`n") | Out-Null
        [System.Xml.XmlDataDocument]$xml= New-Object System.Xml.XmlDataDocument
        $xml.LoadXml($data -join "`n")

        if ($removeDecoration) {
            # Check if XML declaration is present and remove it
            if ($xml.FirstChild -is [System.Xml.XmlDeclaration]) {
                $xml.RemoveChild($xml.FirstChild) | Out-Null
            }
        }

        if ($setDecoration) {
            if (! ($xml.FirstChild -is [System.Xml.XmlDeclaration])) {
                $xmlString = $xml.OuterXml
                $i = $xmlString.IndexOf("<?")
                if ($i -lt 0) {
                    $xmlString = ('<?xml version="1.0" encoding="UTF-8"?>' + $xmlString)
                }

                [System.Collections.ArrayList]$data = New-Object System.Collections.ArrayList
                $data.Add($xmlString -join "`n") | Out-Null
                [System.Xml.XmlDataDocument]$xml= New-Object System.Xml.XmlDataDocument
                $xml.LoadXml($data -join "`n")
            }
        }

        [System.IO.StringWriter]$strWriter= New-Object System.Io.Stringwriter
        [System.Xml.XmlTextWriter]$writer= New-Object System.Xml.XmlTextWriter($strWriter)
        $writer.Formatting = [System.Xml.Formatting]::Indented
        $writer.Indentation = 4
        $writer.IndentChar = " "
        $xml.WriteContentTo($writer)
        if ($pathOut) {
            $strWriter.ToString() | Out-File -FilePath $pathOut -Encoding UTF8
        } else {
            $result = $strWriter.ToString()
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Format-Xml -xmlString '<Root><Item /></Root>'
}

function Get-AddressId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$addressMatch
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$addressId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$addressUid
        ,
        [Parameter(Mandatory = $false)]
        [switch]$like
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleAddressKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsAddress' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $paramsAddress = Get-UsedParameters -validParams (Get-SingleAddressKeys) -boundParams $PSBoundParameters
            $firstEntry = $paramsAddress.GetEnumerator() | Select-Object -First 1
            $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingAddressKeys)
            $value = $firstEntry.Value

            if ($like) {
                $sqlFrag = "$key like '$value%'"
            } else {
                $sqlFrag = "$key = '$value'"
            }

            [string]$sql = "SELECT Id FROM Adresse WHERE $sqlFrag"
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                [int]$result = $rs.fields('Id').Value
                if ($rs.RecordCount -gt 1) {
                    throw ((Get-ResStr 'MULTIPLE_RESULTS_FOUND_ERROR') -f $sqlFrag, $($myInvocation.MyCommand))
                }
            }
        }

        catch {
            Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-AddressId -addressUid '{E05050A1-501F-462B-A2E2-FD27F7F52382}' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-AddressSql {
    [CmdletBinding()]
    param(
        [parameter(Position = 0, Mandatory = $false)]
        [ValidateScript({ Test-ValidateSelect -strParam $_ })]
        [string]$select = '*'
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('none', 'upper', 'lower', 'capital', IgnoreCase = $true)]
        [string]$strCase = 'none'
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingAddressKeys) })]
        [string]$alias = 'addressMatch'
        ,
        [parameter(Mandatory = $false)]
        [string]$order = $alias
        ,
        [parameter(Mandatory = $false)]
        [switch]$noIdAlias
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(0, [int]::MaxValue)]
        [Nullable[int]]$limit
        ,
        [parameter(Mandatory = $false)]
        [switch]$reorder
        ,
        [parameter(Mandatory = $false)]
        [switch]$revers
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'arrOrder' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'arrSelect' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'fieldList' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFilter' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlLimit' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlMaster' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlOrder' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlRevers' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlSelect' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingAddressKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingAddressKeys)

        if ($filter) {
            [string]$sqlFilter= "WHERE ( RTrim(LTrim(IsNull($alias,'')))  <> '') AND $($filter -join(' AND ')) "
        } else {
            [string]$sqlFilter= "WHERE ( RTrim(LTrim(IsNull($alias,'')))  <> '')"
        }

        if ($order) {
            [string]$sqlOrder = "ORDER BY dummy.$order"
        } else {
            [string]$sqlOrder = ''
        }

        $sqlSelect = $select
        if ($sqlSelect -ne '*') {
            if (! ($SqlSelect.Contains($alias, [System.StringComparison]::InvariantCultureIgnoreCase))) {
                $sqlSelect = "$alias,$sqlSelect"
            }

            if ($order) {
                [string[]]$arrOrder = $order -split ','
                for ($i=0; $i -lt $arrOrder.count-1; $i++) {
                    # Delete ASC and DESC
                    $arrOrder[$i] = $arrOrder[$i].Split(' ')[0]
                    if ($SqlSelect.Contains($arrOrder[$i], [System.StringComparison]::InvariantCultureIgnoreCase)) {
                        $arrOrder[$i] = ''
                    }
                }
                $arrOrder = $arrOrder | Where-Object { $_ -ne "" }
                $fieldList = $arrOrder -join ','
                if ($fieldList) {
                    $sqlSelect = "$fieldlist,$SqlSelect"
                }
            }
        }

        if (! ($null -eq $limit)) {
            $sqlLimit = "TOP $limit"
        } else {
            $SqlLimit = ''
        }

        if ($revers) {
            $sqlRevers = 'DESC'
        } else {
            $sqlRevers = ''
        }

        $arrSelect = $sqlSelect -split ','
        $arrSelect = $arrSelect | ForEach-Object { $_.Trim() }
        if ($reorder) {
              $arrSelect = $arrSelect | Sort-Object
        }
        $arrSelect = $arrSelect | ForEach-Object { Convert-StringCase -value $_ -strCase $strcase }
        $arrSelect = $arrSelect | Get-Unique

        $sqlSelect = $arrSelect -join ','

        if (! ($noIdAlias)) {
            $sqlSelect = "$alias [ID.ALIAS], $sqlSelect"
        }

        [string]$sqlMaster = @"
            SELECT $sqlSelect FROM (
            SELECT
            $sqlLimit
            /* KEYS */
            Id, Match, [Uid],

            /* IDENTIFIER */
            IsNull(FremdRefNr, '') [FremdRefNr], IsNull(FremdNr, 0) [FremdNr],
            IsNull(Fibukonto,0) [Fibukonto], IsNull(ILN,0) [ILN],

            /* GROUPS */
            IsNull(AdresseGr,'') [AdresseGr],

            /* ADDRESS */
            IsNull(Name1, '') [Name1], IsNull(Name2, '') [Name2], IsNull(Name3, '') [Name3],
            IsNull(Strasse, '') [Strasse], IsNull(Plz, '') [Plz], IsNull(Ort, '') [Ort],
            RTrim(LTrim(IsNull(Land, ''))) [Land],

            /* COMMUNICATION */
            IsNull(EMail, '') [EMail], IsNull(Tel, '') [Tel], IsNull(Fax, '') [Fax], IsNull(Auto, '') [Auto],
            IsNull(Homepage, '') [Homepage],

            /* CURRENCY */
            IsNull(Rabatt, '') [Rabatt], IsNull(UstId, '') [UstId],  IsNull(SteuerNr, '') [SteuerNr],
            IsNull(BankIBAN, '') [BankIBAN],  IsNull(BankBIC, '') [BankBIC],

            /* DESCRIPTION */
            IsNull(Karteikarte,'') [Karteikarte],

            /* OTHER */
            IsNull(Warnung,'') [Warnung]

            FROM Adresse

            $sqlFilter
            ) Dummy

            $sqlOrder $sqlRevers
"@
        $result = [string[]]@($sqlMaster)

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-AddressSql
}

function Get-AdoRs {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        $recordset = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'recordset', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($recordset) {
            # Toggle all record sets until you find an open one
            Do {
                If ($recordset.State -ne $adStateOpen) {
                    $recordset = $recordset.NextRecordset()
                }
            } until ( (! $recordset) -or ($recordset.State -eq $adStateOpen) )

            if ($recordset) {
                if ($recordset.eof) {
                    $recordset= $null
                }
            }
        }

        $result = $recordset
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-AdoRs (Get-Conn -udl 'C:\temp\Eulanda_1 Eulanda.udl').Execute('SELECT COUNT(*) FROM Artikel')
}

function Get-ArticleId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        $firstEntry = $paramsArticle.GetEnumerator() | Select-Object -First 1
        $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingArticleKeys)
        $value = [string]$firstEntry.Value
        $value = $value.replace("'","''") # Escape Single Quote in Strings
        $sqlFrag = "$key = '$value'"
        [string]$sql = "SELECT Id [articleId] FROM Artikel WHERE $sqlFrag"
        $rs = $myConn.Execute($sql)
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            [int]$result = $rs.fields('articleId').Value
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ArticleId -barcode '4014751021005' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-ArticleNo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        $firstEntry = $paramsArticle.GetEnumerator() | Select-Object -First 1
        $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingArticleKeys)
        $value = $firstEntry.Value
        $value = [string]$value.replace("'","''") # Escape Single Quote in Strings
        $sqlFrag = "$key = '$value'"
        [string]$sql = "SELECT ArtNummer [articleNo] FROM Artikel WHERE $sqlFrag"
        $rs = $myConn.Execute($sql)
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            [string]$result = $rs.fields('articleNo').Value
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ArticleId -barcode '4014751021005' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-ArticlePackingUnit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        $firstEntry = $paramsArticle.GetEnumerator() | Select-Object -First 1
        $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingArticleKeys)
        $value = $firstEntry.Value
        $value = [string]$value.replace("'","''") # Escape Single Quote in Strings
        $sqlFrag = "$key = '$value'"
        [string]$sql = "SELECT VerpackEH [PackingUnit] FROM Artikel WHERE $sqlFrag"
        $rs = $myConn.Execute($sql)
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            [int]$result = $rs.fields('PackingUnit').Value
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ArticlePackingUnit -barcode '4014751021005' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-ArticleSql {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateSelect -strParam $_ })]
        [string]$select = (Get-DefaultSelectArticle)
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$alias = 'articleNo'
        ,
        [parameter(Mandatory = $false)]
        [string]$order= $alias
        ,
        [parameter(Mandatory = $false)]
        [switch]$noIdAlias
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(0, [int]::MaxValue)]
        [Nullable[int]]$limit
        ,
        [parameter(Mandatory = $false)]
        [switch]$reorder
        ,
        [parameter(Mandatory = $false)]
        [switch]$revers
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingArticleKeys)
        New-Variable -Name 'arrOrder' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'arrSelect' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'fieldList' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'sqlFilter' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlLimit' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlMaster' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlOrder' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlRevers' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlSelect' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($filter) {
            [string]$sqlFilter= "WHERE ( RTrim(LTrim(IsNull($alias,'')))  <> '') AND $($filter -join(' AND ')) "
        } else {
            [string]$sqlFilter= "WHERE ( RTrim(LTrim(IsNull($alias,'')))  <> '')"
        }

        if ($order) {
            [string]$sqlOrder = "ORDER BY dummy.$order"
        } else {
            [string]$sqlOrder = ''
        }

        $sqlSelect = $select
        if ($sqlSelect -ne '*') {
            if (! ($SqlSelect.Contains($alias, [System.StringComparison]::InvariantCultureIgnoreCase))) {
                $sqlSelect = "$alias,$sqlSelect"
            }

            if ($order) {
                [string[]]$arrOrder = $order -split ','
                for ($i=0; $i -lt $arrOrder.count-1; $i++) {
                    # Delete ASC and DESC
                    $arrOrder[$i] = $arrOrder[$i].Split(' ')[0]
                    if ($SqlSelect.Contains($arrOrder[$i], [System.StringComparison]::InvariantCultureIgnoreCase)) {
                        $arrOrder[$i] = ''
                    }
                }
                $arrOrder = $arrOrder | Where-Object { $_ -ne "" }
                $fieldList = $arrOrder -join ','
                if ($fieldList) {
                    $sqlSelect = "$fieldlist,$SqlSelect"
                }
            }
        }

        if (! ($null -eq $limit)) {
            $sqlLimit = "TOP $limit"
        } else {
            $SqlLimit = ''
        }

        if ($revers) {
            $sqlRevers = 'DESC'
        } else {
            $sqlRevers = ''
        }

        $arrSelect = $sqlSelect -split ','
        $arrSelect = $arrSelect | ForEach-Object { $_.Trim() }
        if ($reorder) {
              $arrSelect = $arrSelect | Sort-Object
        }
        $arrSelect = $arrSelect | ForEach-Object { Convert-StringCase -value $_ -strCase $strcase }
        $arrSelect = $arrSelect | Get-Unique

        $sqlSelect = $arrSelect -join ','

        if (! ($noIdAlias)) {
            $sqlSelect = "$alias [ID.ALIAS], $sqlSelect"
        }

        [string]$sqlMaster = @"
            SELECT $sqlSelect FROM (
            SELECT
            $sqlLimit
            /* KEYS */
            Id, ArtNummer, IsNull(Barcode,'') [Barcode], [Uid],

            /* IDENTIFIER */
            IsNull(ArtMatch,'') [ArtMatch], IsNull(ArtNummerErsatz,'') [ArtNummerErsatz],
            IsNull(ArtNummerHersteller,'') [ArtNummerHersteller],

            /* GROUPS */
            IsNull(RabattGr,'') [RabattGr], IsNull(WarenGr,'') [WarenGr],
            IsNull(ErloesGr,'') [ErloesGr], VerpackEh, PreisEh, MengenEh,

            /* CURRENCY */
            Waehrung, MwStGr, MwStSatz, EkNetto, IsNull(Ek2Netto,0.0)[Ek2Netto], BruttoFlg,
            Vk, VkNetto, VkBrutto,

            /* SHOP */
            IsNull(ShopExportDatum,'1900-01-01') [ShopExportDatum], ShopFreigabeFlg,

            /* FLAGS */
            AuslaufFlg, NeuFlg, SonderFlg, LoeschFlg,

            /* INTRASTAT */
            IsNull(Upper(UrsprungsLand),'')[UrsprungsLand],
            IsNull(UrsprungsRegion,'') [UrsprungsRegion], IsNull(WarenNr,'') [WarenNr],

            /* DESCRIPTION */
            IsNull(Ultrakurztext,'') [UltraKurztext], IsNull(Kurztext1,'') [Kurztext1],
            IsNull(Kurztext2,'') [Kurztext2], IsNull(Info,'') [Info], IsNull(Langtext,'') [Langtext],

            /* OTHER */
            Gewicht, Volumen, IsNull(Warnung,'') [Warnung], IsNull(Lagerplatz,'') [Lagerplatz], LagerTyp,
            ChangeDate

            FROM Artikel

            $sqlFilter
            ) Dummy

            $sqlOrder $sqlRevers
"@

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return [string[]]@($sqlMaster)
    }
    # Test:  Get-ArticleSql  -filter "ArtNummer='130100'"
}

function Get-Bool {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$boolStr = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'boolStr', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $boolStr = $boolStr.ToUpper()
        if (($boolStr -eq "1") -or ($boolStr -eq "$TRUE") -or ($boolStr -eq "TRUE")) {
            [bool]$result = $true
        } else {
            [bool]$result = $false
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Bool -boolStr 1
}

function Get-BreadcrumbId {
    param(
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingTablename) })]
        [string]$tablename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tablename', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        # DO NOT use connection validation, because params are optional
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$sql = @"
        -- Format path 'subpath1\subpath2\subpath3' without leading or trailing backslashes
        DECLARE @BreadcrumbPath VARCHAR(100) = '$breadCrumbPath';
        SET @BreadcrumbPath = REPLACE(@BreadcrumbPath, '\\', '')
        IF LEFT(@BreadcrumbPath, 1) = '\' SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, 2, LEN(@BreadcrumbPath) - 1)
        IF RIGHT(@BreadcrumbPath, 1) = '\' SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, 1, LEN(@BreadcrumbPath) - 1)
        SET @BreadcrumbPath = LTRIM(RTRIM(@BreadcrumbPath))

        DECLARE @ParentId INT = NULL;
        DECLARE @BreadcrumbId INT = NULL;
        DECLARE @Crumb VARCHAR(1024);

        SELECT @ParentId=Id From merkmal where tabelle = '$tablename' and merkmaltyp=0 and ParentId is Null
        WHILE LEN(@BreadcrumbPath) > 0
        BEGIN
          SET @Crumb = LEFT(@BreadcrumbPath, CHARINDEX('\', @BreadcrumbPath + '\') - 1);
          SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, LEN(@Crumb) + 2, 1024);
          SELECT @ParentId = Id
            FROM Merkmal
            WHERE [Name] = @Crumb AND
              IsNull(ParentId, -1) = IsNull(@ParentId, -1)  AND
              Tabelle = '$tablename';
          IF @@ROWCOUNT = 0 SET @ParentId = -1;
        END;

        SET @BreadcrumbId = @ParentId;
        -- Result is: @BreadcrumbId
"@
        if (($conn) -or ($udl) -or ($connStr)) {
            $sql = "$sql`r`n    SELECT @BreadcrumbId [BreadcrumbId];"
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                [int]$result = $rs.fields('BreadcrumbId').value
            }
        } else {
            [string]$result = [string]$sql
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-BreadcrumbId -breadcrumbPath '\Shop' -tablename 'Artikel' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-BreadcrumbPath {
    param(
        [Parameter(Mandatory = $false)]
        [int]$breadcrumbId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        # DO NOT use connection validation, because params are optional
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$sql = @"
        DECLARE @BreadcrumbPath varchar(1024);
        DECLARE @ID int = $breadcrumbId;
        WITH CTE AS (
            SELECT ID, ParentID, Name, CAST(Name AS varchar(1024)) AS Pfad
            FROM Merkmal
            WHERE ID = @ID
            UNION ALL
            SELECT M.ID, M.ParentID, M.Name, CAST(M.Name + '\' + MK.Pfad AS varchar(1024))
            FROM Merkmal AS M
            JOIN CTE AS MK ON M.ID = MK.ParentID
        )
        SELECT TOP 1 @BreadcrumbPath=Pfad
        FROM CTE
        WHERE ParentID IS NULL
        ORDER BY ID DESC;

        IF CHARINDEX('\', @BreadcrumbPath) > 0
        BEGIN
            -- Path found, cut the beginning like ':AR@1047' and start with first backslash
            SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, CHARINDEX('\', @BreadcrumbPath), LEN(@BreadcrumbPath))
        END
        ELSE
        BEGIN
            IF CHARINDEX(':', @BreadcrumbPath) > 0
            BEGIN
            -- Path is the root
            SET @BreadcrumbPath = '\'
            END
            ELSE
            BEGIN
            -- Path or Id not found
            SET @BreadcrumbPath = ''
            END;
        END;

        -- Result is: @BreadcrumbPath
"@
        if (($conn) -or ($udl) -or ($connStr)) {
            $sql = "$sql`r`n    SELECT @BreadcrumbPath [BreadcrumbPath];"
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                [string]$result = $rs.fields('BreadcrumbPath').value
            }
        } else {
            [string]$result = [string]$sql
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-BreadcrumbPath -breadcrumbId 2280 -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-BroadcastIp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$networkId
        ,
        [Parameter(Mandatory = $false)]
        [string]$ip
        ,
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [int]$cidr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'maxHosts' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if ((! $subnet) -and (! $cidr)) {
                $subnet = Get-Subnet # get it from localIp
            }

            if (! $networkId) {
                $networkId = Get-NetworkId -ip $ip -subnet $subnet -cidr $cidr
            }
            $maxHosts = Get-MaxHosts -subnet $subnet -cidr $cidr
            $result = Get-NextIp -ip $networkId -inc ($maxHosts + 1)
        }
        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-BroadcastIp -networkId 192.168.192.8 -cidr 30
}

function Get-Cidr {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [string]$ip
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ipObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'subnetBitString' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'subnetBytes' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! $subnet) {
                if (! $ip) {
                    $ip= Get-LocalIp
                }
                $ipObj= [IPAddress]::Parse($ip)
                $result =  (Get-NetIPAddress -AddressFamily IPv4 -IPAddress $ipObj -ErrorAction SilentlyContinue).PrefixLength
            } else {
                $subnetBytes = $subnet.Split('.') | ForEach-Object { [byte] $_ }
                $subnetBitString = [Convert]::ToString($subnetBytes[0], 2).PadLeft(8, '0') + `
                                      [Convert]::ToString($subnetBytes[1], 2).PadLeft(8, '0') + `
                                      [Convert]::ToString($subnetBytes[2], 2).PadLeft(8, '0') + `
                                      [Convert]::ToString($subnetBytes[3], 2).PadLeft(8, '0')
                $result = $subnetBitString.Replace('0','').Length
            }
        }
        catch {
            $result= 0
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Cidr -subnet 255.255.255.0
}

function Get-Conn {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($conn) {
            $result = $conn
            if ($result.state -eq $adStateClosed) {
                $result.open()
            }
        } elseif ($udl) {
            $result = Get-ConnFromUdl -udl $udl
        } elseif ($connStr) {
            $result = Get-ConnFromStr $connStr
        } else {
            throw ((Get-ResStr 'ADO_SET_ERROR') -f $($myInvocation.MyCommand))
        }

    } end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Conn -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-ConnItems {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'param' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $params = $myConn.ConnectionString.Split(';')
        $result = @{}
        foreach ($param in $params) {
            $key, $value = $param.Split('=')
            if (($key) -and ($value)) {
                $key = $key.trim()
                $value = $value.trim()
                $result[$key] = $value
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ConnItems -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-ConnStr {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$database = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'database', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$server
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [string]$password
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'connItems' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (! ($server)) {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $connItems = Get-ConnItems -conn $myConn
            $server= $connItems['Data Source']
            $user= $connItems['User ID']
            $password= $connItems['Password']
        }

        if (($user) -and ($password)) {
            [string]$result = `
                "Provider=SQLOLEDB.1;Data Source=$server;Initial Catalog=$database;" +`
                "Persist Security Info=True;User ID=$user;Password=$password"
        } else {
            [string]$result = "Provider=SQLOLEDB.1;Data Source=$server;Initial Catalog=$database;Integrated Security=SSPI"
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ConnStr -udl 'C:\temp\Eulanda_1 Eulanda.udl' -database MyDatabase
}

function Get-DataFromSql {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string[]]$sql = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'sql', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$arrRoot = 'Items'
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'field' -Scope 'Private' -Value ($null)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'record' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $result = New-Object System.Collections.ArrayList
        $rs = $Null
        $rs = $myConn.Execute($sql[0])
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            while (! $rs.eof) {
                $record = [ordered]@{}
                for ($i=0; $i -lt $rs.fields.count; $i++) {
                    $field = $rs.fields[$i]
                    $record.add($field.name, $field.value) | Out-Null
                }
                if ($sql.Count -gt 1) {
                    # Detail exists
                    [string]$sqlTemp= $sql[1]
                    if ($sql.Count -gt 2) {
                        # Master / Detail Link exists
                        [string]$sqlLink= $rs.fields[$sql[2]].value.replace("'","''")
                        $sqlTemp = ($sqlTemp -f $sqlLink)
                    }
                    $record.add($arrRoot, (Get-DataFromSql -sql @($sqlTemp) -conn $myConn -udl $udl -connStr $connStr )) | Out-Null
                }
                $result.Add($record) | Out-Null
                $rs.MoveNext() | Out-Null
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DataFromSql -sql @('SELECT TOP 10 ArtNummer, Vk, Kurztext1 FROM Artikel')  -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-DeliveryId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'deliveryNo', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference

    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        [string]$sql = "SELECT Id [DeliveryId] FROM Lieferschein WHERE KopfNummer = $deliveryNo"
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                [int]$result = $rs.fields('DeliveryId').value
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DeliveryId  -udl 'C:\temp\Eulanda_1 Eulanda.udl' -deliveryNo 20230342
}

function Get-DeliveryLink {
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [string]$alias = 'lf'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($alias) { $alias = "$alias." }

        if ($deliveryId) {
            [string]$result = "$($alias)Id = $deliveryId"
        } else {
            [string]$result = "$($alias)KopfNummer = $deliveryNo"
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DeliveryLink -deliveryId 28096 -alias lf
}

function Get-DeliveryNo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'deliveryId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $sql = "SELECT KopfNummer [DeliveryNo] FROM Lieferschein WHERE Id = $deliveryId"
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                [int]$result = $rs.fields('DeliveryNo').value
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DeliveryNo -deliveryId 28096 -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-DeliveryQty {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'article' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'quantity' -Scope 'Private' -Value ([single]0.0)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        [string]$article = ""
        [float]$quantity = 0.0

        if (! $deliveryNo) {
            $deliveryNo = Get-DeliveryNo -deliveryId $deliveryId -conn $myConn
        }

        # The barcode is being misused here as an article no.
        [string]$sql = @"
        SELECT Art.Barcode [Article], lfp.Menge [Quantity] FROM LieferscheinPos [lfp]
        JOIN Lieferschein [lf] ON lfp.KopfId = lf.id
        JOIN Artikel [art] ON art.Id = lfp.ArtikelId
        WHERE lf.KopfNummer = $deliveryNo ORDER BY lfp.PosNummer
"@
        $rs = new-object -comObject ADODB.Recordset
        $rs.CursorLocation = $adUseClient
        $rs.Open($sql, $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
        if ($rs.eof) {
            throw ((Get-ResStr 'DELIVERYNO_NOT_EXISTS') -f $deliveryNo, $myInvocation.Mycommand)
        }
        while (! $rs.eof) {
            [string]$article = $rs.fields('Article').value
            [float]$quantity = $rs.fields('Quantity').value

            # Under certain circumstances, the delivery note may contain the same article several times
            if (! $result.ContainsKey($article)) {
                $result.Add($article, $quantity) | Out-Null
            } else {
                $result.Item($article) += $quantity
            }
            $rs.MoveNext() | Out-Null
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DeliveryQty -deliveryId 28096 -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-DeliverySql {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        New-Variable -Name 'paramsDelivery' -Scope 'Private' -Value (@{})
        New-Variable -Name 'sqlDetail' -Scope 'Private' -Value ('')
        New-Variable -Name 'sqlMaster' -Scope 'Private' -Value ('')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $paramsDelivery = Get-UsedParameters -validParams (Get-SingleDeliveryKeys) -boundParams $PSBoundParameters

        [string]$sqlMaster = @"
        SELECT
            lf.KopfNummer [Id.Alias],

            dbo.cnf_LfDruckAnschrift(lf.Id) [Anschrift],
            lf.AdresseID,
            lf.AnzahlPakete,
            af.Datum [AuftragDatum],
            af.Id [AuftragId],
            af.KopfNummer [AuftragNummer],
            lf.BearbeitetDurch,
            af.BestellNummer,
            af.BestelltDurch,
            lf.Datum,
            lf.DruckName1,
            lf.DruckName2,
            lf.DruckName3,
            af.ShopLEMail [EMail],
            af.FibuKonto,
            lf.Gewicht,
            lf.GewichtSum,
            lf.ID,
            lf.ILN,
            lf.Info,
            dbo.cnf_LandNachISO(lf.Land) [Land],
            lf.LieferBed,
            lf.KopfNummer [LieferscheinNummer],
            lf.Name1,
            lf.Name2,
            lf.Name3,
            lf.NameLang,
            lf.Nachtext,
            lf.Objekt,
            lf.Ort,
            lf.OrtLang,
            lf.PLZ,
            lf.Provinz,
            lf.SpedAuftragNr,
            lf.Strasse,
            af.ShopLTel [Tel],
            lf.TrackingNr,
            lf.UstId,
            lf.UserD1,
            lf.UserD2,
            lf.UserI1,
            lf.UserI2,
            lf.UserI3,
            lf.UserN1,
            lf.UserN2,
            lf.UserN3,
            lf.UserVC1,
            lf.UserVC2,
            lf.UserVC3,
            lf.VersandartName,
            lf.Vortext,
            lf.Zahlungsart
        FROM PRINT_Lieferschein [lf]
        JOIN Adresse [adr] ON adr.Id = lf.AdresseId
        JOIN Auftrag [af] ON af.Id = lf.Af_Id
        WHERE $(Get-DeliveryLink @paramsDelivery)
"@

        [string]$sqlDetail =   @"
        SELECT
            lfp.PosNummer [ID.ALIAS], -- special case, because it is sorted later by index 1

            art.ArtMatch,
            art.ArtNummer,
            art.Barcode,
            lfp.ErweitertePos,
            lfp.Gewicht,
            lfp.GewichtGes,
            lfp.ID,
            lfp.Info,
            CAST(((lfp.Menge + lfp.VerpackEH -1 ) / lfp.VerpackEH) AS int) [Kartons],
            (lfp.Menge / lfp.VerpackEH) [KartonsBerechnet],
            lfp.Kurztext1,
            lfp.Kurztext2,
            lfp.Langtext [Langtext],
            lfp.Menge,
            lfp.MengenEh,
            lfp.PosNummer,
            art.RabattGr,
            lfp.Ultrakurztext,
            lfp.uid,
            art.UrsprungsLand,
            lfp.UserD1,
            lfp.UserD2,
            lfp.UserI1,
            lfp.UserI2,
            lfp.UserI3,
            lfp.UserN1,
            lfp.UserN2,
            lfp.UserN3,
            lfp.UserVC1,
            lfp.UserVC2,
            lfp.UserVC3,
            lfp.VerpackEh,
            art.WarenGr,
            art.WarenNr
        FROM Master_LieferscheinPos [lfp]
        JOIN Lieferschein [lf] ON lf.Id = lfp.KopfId
        JOIN Artikel [art] ON art.Id = lfp.ArtikelId
        WHERE $(Get-DeliveryLink @paramsDelivery -alias 'lf')
"@
        $result =  [string[]]@($sqlMaster,$sqlDetail)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DeliverySql -deliveryId 28096 -debug
}

function Get-DeliveryStatus {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        if ($deliveryId)  {
            [string]$sqlFrag = "Id = $deliveryId"
        } else {
            [string]$sqlFrag = "KopfNummer = $deliveryNo"
        }

        [string]$sql = "SELECT Status FROM Lieferschein WHERE $sqlFrag"
        $rs = $Null
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                [int]$result = $rs.fields('Status').value
            } else { $rs = $null }
        }

        if (! $rs) {
            throw ((Get-ResStr 'DELIVERYNOTE_NOT_LOADED') -f $sql)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DeliveryStatus -deliveryId 28096 -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-DesktopDir {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = [Environment]::GetFolderPath("Desktop")
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DesktopDir
}

function Get-Distance {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)] # Coordinates of the first point
        [ValidateRange(-90,90)]
        [Alias('lat1')]
        [double]$startLatitude = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'startLatitude', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(-180,180)]
        [Alias('long1')]
        [double]$startLongitude = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'startLongitude', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)] # Coordinates of the second point
        [ValidateRange(-90,90)]
        [Alias('lat2')]
        [double]$endLatitude = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'endLatitude', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(-180,180)]
        [Alias('long2')]
        [double]$endLongitude = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'endLongitude', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }


    process {
        $earthRadiusKm = 6371 # Earth's radius in kilometers

        # Convert degrees to radians
        $deltaLatitudeRadians = ($endLatitude - $startLatitude) * [Math]::PI / 180
        $deltaLongitudeRadians = ($endLongitude - $startLongitude) * [Math]::PI / 180

        # Haversine formula: a = sin²(Δlat/2) + cos(lat1).cos(lat2).sin²(Δlong/2)
        $halfChordSquared = [Math]::Sin($deltaLatitudeRadians / 2) * [Math]::Sin($deltaLatitudeRadians / 2) +
                            [Math]::Cos($startLatitude * [Math]::PI / 180) * [Math]::Cos($endLatitude * [Math]::PI / 180) *
                            [Math]::Sin($deltaLongitudeRadians / 2) * [Math]::Sin($deltaLongitudeRadians / 2)

        # Haversine formula: c = 2.atan2(√a, √(1−a))
        $angularDistanceRadians = 2 * [Math]::Atan2([Math]::Sqrt($halfChordSquared), [Math]::Sqrt(1 - $halfChordSquared))

        # Haversine formula: d = R.c
        $result = $earthRadiusKm * $angularDistanceRadians
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Distance -startLatitude 52.52 -startLongitude 13.405 -endLatitude 48.8566 -endLongitude 2.3522
    # Returns distance from Berlin to Paris which is 877 km
}

function Get-DmsFolderDelivery {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$dmsBaseFolder = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'dmsBaseFolder', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'addressPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'deliveryPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'match' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        if ($deliveryNo) {
            [string]$sqlFrag = "lf.KopfNummer = $deliveryNo"
        } else {
            [string]$sqlFrag = "lf.Id = $deliveryId"
        }

        [string]$match = ""
        [int]$deliveryNo = 0

        [string]$sql = @"
            SELECT
                (SELECT ladr.Match FROM Lieferschein [lf] JOIN Adresse [ladr] ON lf.AdresseId = ladr.Id AND $sqlFrag) AS [Match],
                (SELECT lf.KopfNummer FROM Lieferschein [lf] JOIN Adresse [ladr] ON lf.AdresseId = ladr.Id AND $sqlFrag) AS [DeliveryNo],
                (SELECT Valtext FROM cnf_RegValues('\VENDOR\esol\MODULES\DMS\DATAOBJECTS\Eulanda.Adresse') WHERE Name = 'FolderPath') AS [AddressPath],
                (SELECT Valtext FROM cnf_RegValues('\VENDOR\esol\MODULES\DMS\DATAOBJECTS\Eulanda.Lieferschein') WHERE Name = 'FolderPath') AS [DeliveryPath]
"@

        $rs = $Null
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                $match = $rs.fields('Match').value
                $deliveryNo = $rs.fields('DeliveryNo').value
                $addressPath = $rs.fields('AddressPath').value
                $deliveryPath = $rs.fields('DeliveryPath').value
            }
        } else {
            throw ((Get-ResStr 'DELIVERYNOTE_NOT_FOUND_CONDITION') -f $sqlFrag, $myInvocation.Mycommand)
        }

        [string]$result = "$dmsBaseFolder\$addressPath\$match\$deliveryPath\$deliveryNo"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DmsFolderDelivery -dmsBaseFolder 'C:\dms' -deliveryId 28096 -udl 'C:\temp\Eulanda_1 Eulanda.udl' -debug
}

function Get-DmsFolderSalesOrder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$dmsBaseFolder = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'dmsBaseFolder', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$salesOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$salesOrderId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$customerOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleSalesOrderKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'addressPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'match' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'salesOrderPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        if ($salesOrderId) {
            [string]$sqlFrag = "so.Id = $salesOrderId"
        } elseif ($salesOrderNo) {
            [string]$sqlFrag = "so.KopfNummer = $salesOrderNo"
        } elseif ($customerOrderNo) {
            [string]$sqlFrag = "so.Bestellnummer = '$customerOrderNo'"
        } else {
            throw ((Get-ResStr 'SALESORDER_NOT_FOUND_PARAMETER') -f $($myInvocation.MyCommand))
        }

        [string]$sql = @"
            SELECT
                (SELECT radr.Match FROM Auftrag [so] JOIN Adresse [radr] ON so.AdresseId = radr.Id AND $sqlFrag) As [Match],
                (SELECT so.KopfNummer FROM Auftrag [so] JOIN Adresse [radr] ON so.AdresseId = radr.Id AND $sqlFrag) As [SalesOrderNo],
                (SELECT Valtext FROM cnf_RegValues('\VENDOR\esol\MODULES\DMS\DATAOBJECTS\Eulanda.Adresse') WHERE Name = 'FolderPath') AS [AddressPath],
                (SELECT Valtext FROM cnf_RegValues('\VENDOR\esol\MODULES\DMS\DATAOBJECTS\Eulanda.Auftrag') WHERE Name = 'FolderPath') AS [SalesOrderPath]
"@

        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                $match = $rs.fields('Match').value
                $salesOrderNo = $rs.fields('SalesOrderNo').value
                $addressPath = $rs.fields('AddressPath').value
                $salesOrderPath = $rs.fields('SalesOrderPath').value
            }
        } else {
            throw ((Get-ResStr 'SALESORDER_NOT_FOUND_CONDITION') -f $sqlFrag, $($myInvocation.MyCommand))
        }

        [string]$result = "$dmsBaseFolder\$addressPath\$match\$salesOrderPath\$salesOrderNo"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DmsFolderSalesOrder -dmsBaseFolder 'C:\dms' -salesOrderNo 20230348 -udl 'C:\temp\Eulanda_1 Eulanda.udl' -debug
}

function Get-FieldTruncated {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        $rs = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'rs', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$fieldname = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'fieldname', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange("Positive")]
        [int]$maxLen = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'maxLen', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = $rs.fields($fieldName).Value
        $result = $result.Trim()
        $result = $result.Substring(0, [System.Math]::Min($maxLen, $result.Length))
        $result = $result.Trim()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-FieldTruncated -rs (Get-Conn -udl 'C:\temp\Eulanda_1 Eulanda.udl').Execute('SELECT top 1 Kurztext1 FROM Artikel WHERE LEN(Kurztext1) = (SELECT MAX(LEN(Kurztext1)) FROM Artikel)') -fieldname 'Kurztext1' -maxLen 20
}

function Get-Filename {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            switch ($PSItem[-1]) {
                '.' {Throw 'A valid filepath cannot end with a period.'}
                '\' {Throw 'A valid filepath cannot end with a backslash.'}
                {$PSItem -match '\s'} {Throw 'A valid filepath cannot end with a blank character.'}
                Default {$true}
            }
        })]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = [string](Split-Path -Path $path -Leaf)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Filename -path 'C:\temp\test.txt'
}

function Get-FirstIp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$networkId
        ,
        [Parameter(Mandatory = $false)]
        [string]$ip
        ,
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [int]$cidr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if ((! $subnet) -and (! $Cidr)) {
                $subnet = Get-Subnet # get it from loacalIp
            }

            if (! $networkId) {
                $networkId = Get-NetworkId -ip $ip -subnet $subnet -cidr $cidr
            }
            $result = Get-NextIp -ip $networkId
        }

        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-FirstIp -cidr 30 -ip '192.168.41.10'
}

function Get-GatewayIp {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $result= (Get-NetRoute -DestinationPrefix '0.0.0.0/0' `
                -ErrorAction SilentlyContinue | `
                Sort-Object -Property RouteMetric | `
                Select-Object -First 1).NextHop
        }
        catch {
            $result='0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-GatewayIp
}

function Get-Hostname {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$ip
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! $ip) {
                $ip= Get-LocalIp
            }
            $result= [System.Net.Dns]::GetHostByAddress($ip).Hostname
        }
        catch {
            $result= ''
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Hostname
}

function Get-HtmlEncoded {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$taggedString
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $taggedString
        $result = $result.replace('\r', '')
        $result = $result.replace('\n', '{br/}')

        # Replace <br> and <strong> tags with placeholders
        $result = $result -replace "`r", ''
        $result = $result -replace "`n", '{br/}'
        $result = $result -replace '<br>', '{br/}'
        $result = $result -replace '<br/>', '{br/}'
        $result = $result -replace '<br />', '{br/}'

        $result = $result -replace '<strong>', '{strong}'
        $result = $result -replace '</strong>', '{/strong}'
        $result = $result -replace '<b>', '{b}'
        $result = $result -replace '</b>', '{/b}'
        $result = $result -replace '<i>', '{i}'
        $result = $result -replace '</i>', '{/i}'
        $result = $result -replace '<h1>', '{h1}'
        $result = $result -replace '</h1>', '{/h1}'
        $result = $result -replace '<h2>', '{h2}'
        $result = $result -replace '</h2>', '{/h2}'
        $result = $result -replace '<h3>', '{h3}'
        $result = $result -replace '</h3>', '{/h3}'
        $result = $result -replace '<p>', '{p}'
        $result = $result -replace '</p>', '{/p}'
        $result = $result -replace '<pre>', '{pre}'
        $result = $result -replace '</pre>', '{/pre}'
        $result = $result -replace '<ul>', '{ul}'
        $result = $result -replace '</ul>', '{/ul}'
        $result = $result -replace '<ol>', '{ol}'
        $result = $result -replace '</ol>', '{/ol}'
        $result = $result -replace '<li>', '{li}'
        $result = $result -replace '</li>', '{/li}'

        # Encode the string
        [string]$result = [System.Web.HttpUtility]::HtmlEncode($result)

        # Replace the placeholders with the original tags
        $result = $result -replace '{br/}', '<br/>'
        $result = $result -replace '{strong}', '<strong>'
        $result = $result -replace '{/strong}', '</strong>'
        $result = $result -replace '{b}', '<b>'
        $result = $result -replace '{/b}', '</b>'
        $result = $result -replace '{i}', '<i>'
        $result = $result -replace '{/i}', '</i>'
        $result = $result -replace '{h1}', '<h1>'
        $result = $result -replace '{/h1}', '</h1>'
        $result = $result -replace '{h2}', '<h2>'
        $result = $result -replace '{/h2}', '</h2>'
        $result = $result -replace '{h3}', '<h3>'
        $result = $result -replace '{/h3}', '</h3>'
        $result = $result -replace '{p}', '<p>'
        $result = $result -replace '{/p}', '</p>'
        $result = $result -replace '{pre}', '<pre>'
        $result = $result -replace '{/pre}', '</pre>'
        $result = $result -replace '{ul}', '<ul>'
        $result = $result -replace '{/ul}', '</ul>'
        $result = $result -replace '{ol}', '<ol>'
        $result = $result -replace '{/ol}', '</ol>'
        $result = $result -replace '{li}', '<li>'
        $result = $result -replace '{/li}', '</li>'
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-HtmlEncoded -taggedString 'This is <b>bold</b> and this > > not'
}

function Get-HtmlMetaData {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$description
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [hashtable]$result = @{
            author="EULANDA Software GmbH - ERP-Systems - Germany"
            generator="Powershell $($PsVersiontable.GitCommitId) by function ConvertTo-Html"
            keywords="eulanda, erp, powershell, convertto-html, html"
            viewport="width=device-width, initial-scale=1.0"
        }
        if ($description) {
            $result.Add('description', $description) | Out-Null
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-HtmlMetaData -description 'My meta description'
}

function Get-HtmlStyle {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = @"
        <style>
        html {
            margin:    0 auto;
            max-width: 800px;
        }
        body {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
        }
        h1 {
            font-family: Arial, Helvetica, sans-serif;
            color: #e68a00;
            font-size: 28px;
        }
        h2 {
            font-family: Arial, Helvetica, sans-serif;
            color: #000099;
            font-size: 16px;
        }
        h3 {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 16px;
        }
        table {
            font-size: 12px;
            border: 0px;
            width: 600px;
            height: auto;
            font-family: Arial, Helvetica, sans-serif;
        }
        td {
            padding: 4px;
            margin: 0px;
            border: 0;
            vertical-align: top;
        }
        th {
            background: #395870;
            background: linear-gradient(#49708f, #293f50);
            color: #fff;
            font-size: 11px;
            text-transform: uppercase;
            padding: 10px 15px;
            vertical-align: middle;
        }
        tbody tr:nth-child(even) {
        background-color: #f0f0f2;
        }
        #CreationDate {
            font-family: Arial, Helvetica, sans-serif;
            color: #ff3300;
            font-size: 12px;
        }
        .StatusAttention {
            color: #ff0000;
        }
        .StatusNormal {
            color: #008000;
        }
        </style>
"@
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-HtmlStyle
}

function Get-IniBool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$section = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'section', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$variable = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'variable', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (test-path variable:global:ini) {
            [string]$test = $global:ini[$section][$variable]
            $result = Get-Bool -boolStr $test
        } else {
            $result = $false
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-IniBool -section 'Settings' -variable 'Name'
}

function Get-IpGeoInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$ip = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'ip', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$age = 6  # default age is 6 months
        ,
        [Parameter(Mandatory = $false)]
        [int]$apiWait = 2000  # default apiWait is 2000 milliseconds
        ,
        [Parameter(Mandatory = $false)]
        [string]$xmlGeoPath = 'IpGeoInfo.xml'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'entry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'eulandaConnectFolderPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'homeFolderPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($xmlGeoPath -notmatch '\\') {
            # Use the user home folder and the '.eulandaconnect' folder
            $homeFolderPath = [Environment]::GetFolderPath('UserProfile')
            $eulandaConnectFolderPath = Join-Path -Path $homeFolderPath -ChildPath '.eulandaconnect'

            # Creates the '.eulandaconnect' folder if it does not exist
            if (-not (Test-Path $eulandaConnectFolderPath)) {
                New-Item -ItemType Directory -Path $eulandaConnectFolderPath | Out-Null
            }

            $xmlGeoPath = Join-Path -Path $eulandaConnectFolderPath -ChildPath $xmlGeoPath
        }

        Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_PATH') -f $xmlGeoPath)
        if (! (Test-Path variable:global:geoHashTable)) {
            if (Test-Path $xmlGeoPath) {
                $global:geoHashTable = Import-Clixml -Path $xmlGeoPath

                <#
                    # Check and update the existing entries to use the new structure
                    # We have added createdate and changedate
                    $keys = $global:geoHashTable.Keys
                    $tempHashTable = @{}
                    foreach ($key in $keys) {
                        $entry = $global:geoHashTable[$key]
                        if (-not ($entry | Get-Member -Name createDate -ErrorAction SilentlyContinue)) {
                            $tempHashTable[$key] = New-Object PSObject -Property @{
                                createDate = Get-Date
                                changeDate = Get-Date
                                data = $entry
                            }
                        }
                        else {
                            $tempHashTable[$key] = $entry
                        }
                    }
                    $global:geoHashTable = $tempHashTable
                    $global:geoHashTable | Export-Clixml -Path $xmlGeoPath
                #>
            } else {
                $global:geoHashTable = @{}
            }
        }
        $result = '-1'  # Default for exceptions

        if (!(Test-Path variable:global:lastGeoIpInfoCall)) {
            $global:lastGeoIpInfoCall = Get-Date
        }

        if (! (Test-IpAddress -ip $ip)) {
            $result = '-2'
        } elseif (Test-PrivateIP -ip $ip) {
            $result = '-3'
        } elseif (Test-ReservedIP -ip $ip) {
            $result = '-4'
        } elseif ($global:geoHashTable.ContainsKey($ip)) {
            # If it is a known Ip then retrieve it from cache
            $entry = $global:geoHashTable[$ip]
            $result = $entry.data.countryCode

            # Check if the entry is older than $age months
            if ($entry.changeDate.AddMonths($age) -lt (Get-Date)) {
                try {
                    $currentTime = Get-Date
                    $elapsedTime = $currentTime - $global:lastGeoIpInfoCall
                    $waitTime = [Math]::Max(0, $apiWait - $elapsedTime.TotalMilliseconds)
                    if ($waitTime -gt 0) {
                        Start-Sleep -Milliseconds $waitTime
                    }
                    Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_WAITTIME') -f $waitTime)
                    $response = Invoke-RestMethod -Uri "http://ip-api.com/json/$ip"
                    $global:lastGeoIpInfoCall = Get-Date

                    if ($response.status -eq 'fail') {
                        $result = '-1'
                        Write-Error ((Get-ResStr 'GEOINFO_API_FAILED') -f $($response.message))
                    } else {
                        # Update the entry and save it
                        $entry.data = $response
                        $result = $response.countryCode
                        $entry.changeDate = Get-Date
                        $global:geoHashTable[$ip] = $entry
                        $global:geoHashTable | Export-Clixml -Path $xmlGeoPath
                        Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_NEW_ENTRY') -f $ip, $result.ToString())
                    }
                }
                catch {
                    $result = '-1'
                    Write-Error ((Get-ResStr 'GEOINFO_GENERAL_ERROR') -f $_)
                }
            }
        }
        else {
            try {
                $currentTime = Get-Date
                $elapsedTime = $currentTime - $global:lastGeoIpInfoCall
                $waitTime = [Math]::Max(0, $apiWait - $elapsedTime.TotalMilliseconds)
                if ($waitTime -gt 0) {
                    Start-Sleep -Milliseconds $waitTime
                }
                Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_WAITTIME') -f $waitTime)
                $response = Invoke-RestMethod -Uri "http://ip-api.com/json/$ip"
                $global:lastGeoIpInfoCall = Get-Date

                if ($response.status -eq 'fail') {
                    $result = '-1'
                    Write-Error ((Get-ResStr 'GEOINFO_API_FAILED') -f $($response.message))
                } else {
                    # Add new entry and save it
                    $entry = New-Object PSObject -Property @{
                        createDate = Get-Date
                        changeDate = Get-Date
                        data = $response
                    }
                    $result = $response.countryCode
                    $global:geoHashTable.Add($ip, $entry)
                    $global:geoHashTable | Export-Clixml -Path $xmlGeoPath
                    Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_NEW_ENTRY') -f $ip, $result.ToString())
                }
            }
            catch {
                $result = '-1'
                Write-Error ((Get-ResStr 'GEOINFO_GENERAL_ERROR') -f $_)
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Get-IpGeoInfo -ip 79.42.55.123 -verbose -debug
}

function Get-LastIp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$networkId
        ,
        [Parameter(Mandatory = $false)]
        [string]$ip
        ,
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [int]$cidr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'maxHosts' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if ((! $subnet) -and (! $Cidr)) {
                $subnet = Get-Subnet # get it from localIp
            }

            if (! $networkId) {
                $networkId = Get-NetworkId -ip $ip -subnet $subnet -cidr $cidr
            }
            $maxHosts = Get-MaxHosts -subnet $subnet -cidr $cidr
            $result = Get-NextIp -ip $networkId -inc ($maxHosts)
        }

        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-LastIp -networkId 192.168.172.8 -cidr 30
}

function Get-LocalIp {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'gatewayIp' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'gatewayIpObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ip' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'ipObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'localIps' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'subnetMask' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'subnetMaskObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $gatewayIp= Get-GatewayIp
            $gatewayIpObj= [IPAddress]::Parse($gatewayIp)

            [string[]]$localIps= (Get-NetIPAddress -AddressFamily IPV4 -PrefixOrigin DHCP,MANUAL).IpAddress

            foreach ($ip in $localIps) {
                $ipObj = [IPAddress]::Parse($ip)
                $subnetMask = Get-Subnet -localIp $ip
                $subnetMaskObj = [IPAddress]::Parse($subnetMask)
                if (($ipObj.Address -band $subnetMaskObj.Address) -eq ($gatewayIpObj.Address -band $subnetMaskObj.Address)) {
                    $result = $ip
                    break
                }
            }
        }
        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-LocalIp
}

function Get-LogName {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$ident
        ,
        [parameter(Mandatory = $false)]
        [string]$dateMask = "yyyy-MM-dd--HH-mm-ss-fff"
    )
    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'datePart' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (! $ident) {$ident = 'DEF'}

        [string]$datePart = Get-Date -date $ecStartTime -format $dateMask
        [string]$result = "LOG-$ident-$datePart.txt"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-LogName -ident 'STANDARD'
}


function Get-LoremIpsum {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [int]$minParagraphs = 1
        ,
        [Parameter(Mandatory = $false)]
        [int]$maxParagraphs = 5
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'numParagraphs' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'paragraph' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paragraphs' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $numParagraphs = Get-Random -Minimum $minParagraphs -Maximum $maxParagraphs

        $paragraphs = @()
        for ($i = 1; $i -le $numParagraphs; $i++) {
            $paragraph = "$(Get-RandomParagraph)"
            if (! $paragraphs) {
                $paragraphs = $paragraph
            } else { $paragraphs += "`r`n$paragraph" }

        }
        $result = $paragraphs.TrimEnd()
    }

    end {
        Get-CurrentVariables -initialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-LoremIpsum -minParagraphs 2
}

function Get-MaxHosts {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [int]$cidr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ((! $subnet) -and (! $cidr)) {
            $subnet= Get-Subnet # get it from localIp
        }

        try {
            if (! $cidr) {
                $cidr = Get-Cidr -subnet $subnet
            }

            [int]$result = [math]::Pow(2,(32-$cidr)) - 2
        }

        catch {
            [int]$result = 0
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-MaxHosts -cidr 30
}

function Get-ModulePath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$module = 'EulandaConnect'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = ((Get-Module -Name $module).ModuleBase)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ModulePath
}

function Get-MssqlInstances {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [switch]$show
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'backupPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'tempFilesObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tcpIp' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'sqlService' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sqlServerRule' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'sqlBrowserRule' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'sharedMemory' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'regKeyCombi' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'regKey' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'pipeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'patchLevel' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'namedPipes' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'mdfFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'mdfFilePath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'tempObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'mdfFileInfo' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ldfFileInfo' -Scope 'Private' -Value ($null)
        New-Variable -Name 'binnPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'browserService' -Scope 'Private' -Value ($null)
        New-Variable -Name 'collation' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'combi' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'databaseLastModified' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'databaseName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'mdfFile' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'version' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'dataPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'filesResult' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        New-Variable -Name 'firewallChecked' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'instance' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'item' -Scope 'Private' -Value ($null)
        New-Variable -Name 'databaseSize' -Scope 'Private' -Value ([double]0.0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $regKey = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL"
        $result = New-Object System.Collections.ArrayList

        try {
            foreach ($instance in (Get-Item -Path $regKey | Select-Object -ExpandProperty Property)) {
                $regKey = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$instance\MSSQLServer\CurrentVersion"
                $version = (Get-ItemProperty -Path $regKey).CurrentVersion
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL"
                $combi = (Get-ItemProperty -Path $regKeyCombi).$instance
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\MSSQLServer"
                $backupPath = (Get-ItemProperty -Path $regKeyCombi).BackupDirectory
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\Setup"
                $binnPath = (Get-ItemProperty -Path $regKeyCombi).SQLBinRoot
                $collation = (Get-ItemProperty -Path $regKeyCombi).Collation
                $patchLevel = (Get-ItemProperty -Path $regKeyCombi).PatchLevel
                $dataPath = "$((Get-ItemProperty -Path $regKeyCombi).SQLDataRoot)\DATA"
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\MSSQLServer\SuperSocketNetLib\Tcp"
                $tcpIp = (Get-ItemProperty -Path $regKeyCombi).Enabled
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\MSSQLServer\SuperSocketNetLib\Sm"
                $sharedMemory = (Get-ItemProperty -Path $regKeyCombi).Enabled
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\MSSQLServer\SuperSocketNetLib\Np"
                $namedPipes = (Get-ItemProperty -Path $regKeyCombi).Enabled
                $pipeName = (Get-ItemProperty -Path $regKeyCombi).PipeName

                $sqlService = Get-Service -Name "MSSQL`$${instance}" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Status
                $browserService = Get-Service -Name "SQLBrowser" -ErrorAction SilentlyContinue  | Select-Object -ExpandProperty Status

                [bool]$firewallChecked = $false
                [bool]$sqlBrowserRule= $false
                [bool]$sqlServerRule= $false

                try {
                    $firewallBrowser= Get-NetFirewallPortFilter -ErrorAction Stop | Where-Object LocalPort -eq 1434 | Get-NetFirewallRule -ErrorAction Stop | Where-Object Enabled -eq True | Where-Object Direction -eq Inbound
                    if ($firewallBrowser) {
                        [bool]$sqlBrowserRule= $true
                    }
                    # No Exception, so it was checked
                    [bool]$firewallChecked = $true
                }

                catch [Microsoft.Management.Infrastructure.CimException]  {
                }

                try {
                    $firewallSqlServer = Get-NetFirewallApplicationFilter -ErrorAction Stop | Where-Object Program -match "$($binnPath.Replace('\','\\'))\\sqlservr.exe" | Get-NetFirewallRule -ErrorAction Stop
                    if ($firewallSqlServer) {
                        [bool]$sqlServerRule= $true
                    }
                    # No Exception, so it was checked
                    [bool]$firewallChecked = $true
                }

                catch [Microsoft.Management.Infrastructure.CimException]  {
                }

                $mdfFiles = Get-ChildItem -Path "$dataPath\*.mdf" -Name | Sort-Object
                $filesResult = New-Object System.Collections.ArrayList
                foreach ($mdfFile in $mdfFiles) {
                    $databaseName = [System.IO.Path]::GetFileNameWithoutExtension($mdfFile)
                    $ldfFile = Get-ChildItem -Path "$dataPath\$databaseName*.ldf" -Name | Select-Object -First 1
                    if ($ldfFile) {
                        $mdfFilePath = [System.IO.Path]::Combine($dataPath, $mdfFile)
                        $mdfFileInfo = New-Object System.IO.FileInfo ([System.IO.Path]::Combine($dataPath, $mdfFile))
                        $ldfFileInfo = New-Object System.IO.FileInfo ([System.IO.Path]::Combine($dataPath, $ldfFile))
                        $databaseSize = [math]::Round(($mdfFileInfo.Length + $ldfFileInfo.Length) / 1MB, 2)
                        $databaseLastModified = [System.IO.File]::GetLastWriteTime($mdfFilePath).ToString("yyyy-MM-dd HH:mm:ss")
                        $tempFilesObj = [PSCustomObject]@{
                            MdfFile = [string]$mdfFile
                            LdfFile = [string]$ldfFile
                            MdfSize = [double]$mdfFileInfo.Length / 1MB
                            LdfSize = [double]$ldfFileInfo.Length / 1MB
                            TotalSize = [double]$databaseSize
                            LastModified = [string]$databaseLastModified
                        }
                        $filesResult.Add($tempFilesObj) | Out-Null
                    }
                }
                $tempObj = [PSCustomObject]@{
                    Instance = [string]$instance
                    Version = [version]$version
                    PatchLevel = [version]$patchLevel
                    Collation = [string]$collation
                    BinnPath = [string]$binnPath
                    DataPath = [string]$dataPath
                    BackupPath = [string]$BackupPath
                    SqlService = [string]$sqlService
                    BrowserService = [string]$browserService
                    TcpIp = [boolean]$tcpIp
                    SharedMemory = [boolean]$sharedMemory
                    NamedPipes = [boolean]$namedPipes
                    PipeName = [string]$pipeName
                    FirewallChecked = [bool]$firewallChecked
                    SqlBrowserRule = [bool]$sqlBrowserRule
                    SqlServerRule = [bool]$sqlServerRule
                    Files = [PSCustomObject]$filesResult
                }

                $result.Add($tempObj) | Out-Null
            }

            if ($show) {
                foreach ($item in $result) {
                    Write-Host ((Get-ResStr 'SERVER_SETTINGS_FOR') -f  $($item.Instance)) -ForegroundColor Yellow
                    $item  | Select-Object -Property Instance, Version, PatchLevel, Collation, BinnPath, DataPath, BackupPath, SqlService, BrowserService, NamedPipes, TcpIp, SharedMemory, FirewallChecked, SqlBrowserRule, SqlServerRule | Format-List | Out-Host
                    Write-Host ((Get-ResStr 'DATABASE_FILES_FOR') -f  $($item.Instance)) -ForegroundColor Blue
                    Write-Host (Get-ResStr 'SIZES_IN_MB') -ForegroundColor Blue
                    $item.Files | Format-List | Out-Host
                }
                If (! (Test-Administrator)) {
                    Write-Host (Get-ResStr 'FIREWALL_NOT_CHECKED') -ForegroundColor Red
                  }
            }

        }

        catch {
            if ($show) {
                Write-Host "$_" -ForegroundColor Red
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-MssqlInstances -show
}

function Get-MultipleOptions {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$values = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$list = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'list', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'idx' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'item' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'newValues' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'valuesArray' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$newValues = ''

        if ($values) {
            [string[]]$valuesArray = $values.Split(',')
            foreach ($value in $valuesArray) {
                [int]$idx = $list.ToUpper().IndexOf($value.ToUpper())
                if ($idx -eq -1 ) { [string]$item = $list[0]
                } else { [string]$item = $list[$idx] }
                if ($newValues) {
                    $i = $newValues.ToUpper().IndexOf($item.ToUpper())
                    if ($i -eq -1) {
                        [string]$newValues +=  (',' + $item)
                    }
                } else { [string]$newValues = $Item }
            }
            $result = $newValues
        } else { [string]$result = $list[0] }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-MultipleOptions -values 'alpha,bravo,charlie' -list @('default','bravo','charlie','delta','echo')
}

function Get-NetworkId {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$ip
        ,
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [int]$cidr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ipObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'subnetObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! $ip) {
                $ip= Get-LocalIp
                $subnet= Get-Subnet -localIp $ip
            }
            $ipObj= [IpAddress]$ip
            if (! $subnet) {
                $subnet = Get-Subnet -cidr $cidr
            }
            $subnetObj= [IpAddress]$subnet
            $result = ([IpAddress]($ipObj.Address -band $subnetObj.Address)).IpAddressToString
        }

        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-NetworkId -ip 192.168.178.9 -cidr 30
}

function Get-NewNumberFromSeries {
    [CmdletBinding()]
    Param(
        [string]$seriesName
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        # Configuring an ADODB.Command object
        $cmd = New-Object -comobject ADODB.Command
        $cmd.ActiveConnection = $myConn
        $cmd.CommandType = 4 # adCmdStoredProc
        $cmd.CommandText = "cn_NumGetNext"

        # ADODB.Parameter object for each parameter
        $param1 = $cmd.CreateParameter("@nr_Name", 200, 1, 50, $seriesName) # adVarWChar, adParamInput
        $cmd.Parameters.Append($param1)
        $adParamOutput = 2
        $param2 = $cmd.CreateParameter("@nr_NextNr", $adLockOptimistic, $adParamOutput, 0, 0) # adInteger, adParamOutput
        $cmd.Parameters.Append($param2)

        $cmd.Execute() | Out-Null
        $result = $cmd.Parameters.Item("@nr_NextNr").Value
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }

    # Test: $i = Get-NewNumberFromSeries -seriesName 'KrAuftrag' -udl 'C:\temp\EULANDA_1 JohnDow.udl'
}
function Get-NextIp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$ip = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'ip', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$inc = 1
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ipBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ipInt' -Scope 'Private' -Value ([uint32]0)
        New-Variable -Name 'ipObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newIp' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nextIpBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nextIpInt' -Scope 'Private' -Value ([uint32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $ipObj = [IPAddress]$ip
            $ipBytes = $ipObj.GetAddressBytes()
            [System.Array]::Reverse($ipBytes)
            $ipInt = [System.BitConverter]::ToUInt32($ipBytes, 0)
            $nextIpInt = $ipInt + $inc
            $nextIpBytes = [System.BitConverter]::GetBytes($nextIpInt)
            [System.Array]::Reverse($nextIpBytes)
            if ([IntPtr]::Size -eq 4) { # x86
                $newIp = New-Object System.Net.IPAddress ([System.Array]::CreateInstance([byte], 4))
                [System.Buffer]::BlockCopy($nextIpBytes, 0, $nextIp.GetAddressBytes(), 0, 4)
            } else { # x64
                $newIp = New-Object System.Net.IPAddress -ArgumentList (,$nextIpBytes)
            }
            $result = $newIp.IPAddressToString
        }

        catch {
            $result = '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-NextIp -ip '192.168.178.20' -inc 5
}

function Get-OldestFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'entry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $entry = Get-ChildItem -Path $path | Sort-Object -Property LastWriteTime | select-object -First 1
        if ($entry) {
            [string]$result = $entry.Name
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-OldestFile -path 'C:\temp'
}

function Get-Path32 {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ( $($env:PROCESSOR_ARCHITECTURE) -eq "x86") {
            $result = $($env:PROGRAMFILES)
        } else {
            $result = $(${env:PROGRAMFILES(x86)})
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Path32
}

function Get-PropertySql {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingTablename) })]
        [string]$tablename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tablename', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)
        New-Variable -Name 'BreadcrumbSql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$BreadcrumbSql = Get-BreadcrumbId -breadcrumbPath $breadcrumbPath -tablename $tablename

        [string]$sql = @"
            $BreadcrumbSql
            -- Select the tree starting with the BreadcrumpID. If no ID is provided, select the entire tree.
            WITH CTE AS (
                SELECT
                    ID, ParentID, Name, UID,
                    CASE WHEN MerkmalTyp = 2 THEN 1 Else MerkmalTyp END [Sort],
                    Beschreibung, SqlBedingung, Color
                FROM Merkmal
                WHERE
                    ID = @BreadcrumbID
                    AND Tabelle = '$tablename'
                    AND NOT Name LIKE '.%'
                UNION ALL
                SELECT
                    t.ID, t.ParentID, t.Name, t.UID,
                    CASE WHEN t.MerkmalTyp = 2 THEN 1 Else MerkmalTyp END [Sort],
                    t.Beschreibung, t.SqlBedingung, t.Color
                FROM Merkmal t
                    JOIN CTE c ON t.ParentID = c.ID
                WHERE
                    t.Tabelle = '$tablename'
                    AND NOT t.Name LIKE '.%'
            )
            SELECT ID, ParentID, Name, UID, Sort, Color
            FROM CTE
            ORDER BY ParentId, Sort, Name;
"@
        [string[]]$result = @($sql)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-PropertySql -breadcrumbPath '\Shop' -tablename 'Article'
}

function Get-PublicIp {
    [CmdletBinding()]
    Param ()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = ""

        if (! $result) {
            try {
                $result = (Resolve-DnsName myip.opendns.com -Server resolver1.opendns.com -type A -ErrorAction SilentlyContinue).IPAddress
            }

            catch {
            }
        }

        if (! $result)  {
            try {
                $html = Invoke-RestMethod https://checkip.eurodyndns.org
                $lines = $html.split("`n")
                foreach ($line in $lines) {
                    $p = $Line.IndexOf("IP Address:")
                    if ($p -gt 0) {
                        $p = $line.IndexOf(":")
                        if ($p -gt 0) {
                            $result = $line.SubString($p +1).Trim()
                        }
                    }
                }
            }

            catch {
            }
        }

        if (! $result) {
            try {
                $result = Invoke-RestMethod https://ifconfig.me/ip
            }

            catch {
            }
        }

        if (! $result) {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-PublicIp
}

Function Get-RemoteDir {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("file", "directory")]
        [string]$dirType = "file"
        ,
        [Parameter(Mandatory = $false)]
        [string]$mask = "*"
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder

    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                $result = Get-SftpDir -server $server -port $port -certificate $certificate -user $user -password $password -dirType $dirType -mask $mask -remoteFolder $remoteFolder
            } else {
                $result = Get-FtpDir -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -dirType $dirType -mask $mask -remoteFolder $remoteFolder
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-RemoteDir -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -verbose
}

Function Get-RemoteFileAge {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                $result = Get-SftpFileAge -server $server -port $port -certificate $certificate -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
            } else {
                $result = Get-FtpFileAge -server $server -protocol $protocol -Port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-RemoteFileAge -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'Eulanda_JohnDoe.zip' -verbose
}

Function Get-RemoteFileDate {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                $result = Get-SftpFileDate -server $server -port $port -certificate $certificate -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
            } else {
                $result = Get-FtpFileDate -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-RemoteFileDate -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'Eulanda_JohnDoe.zip' -verbose
}

Function Get-RemoteFileSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                $result = Get-SftpFileSize -server $server -port $port -certificate $certificate -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
            } else {
                $result = Get-FtpFileSize -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-RemoteFileSize -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA'  -remoteFile 'Eulanda_JohnDoe.zip' -verbose
}


Function Get-RemoteNextFilename {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [parameter(Mandatory = $false)]
        [string]$mask = '*'
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder

    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                $result = Get-SftpNextFilename -server $server -port $port -certificate $certificate -user $user -password $password -mask $mask -remoteFolder $remoteFolder
            } else {
                $result = Get-FtpNextFilename -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -mask $mask -remoteFolder $remoteFolder
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-RemoteNextFile -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure' -mask '*.xml' -remoteFolder '/EULANDA'  -verbose
}

function Get-ResStr {
    [CmdletBinding()]
    param (
        [string]$Key
    )

    begin {
        # Here we could not write STARTING_FUNCTION because of a recursion
        New-Variable -Name 'data' -Scope 'Private' -Value ($null)
        New-Variable -Name 'path' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'reslang' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'values' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'xml' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlContent' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlFile' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($ecResx.count -eq 0) {
            Write-Verbose "Get-ResX Init"
            [string]$path = (Get-Module -Name EulandaConnect | Select-Object -ExpandProperty Path)
            [string]$path = Split-path $path

            $xmlFiles = Get-ChildItem "$path\*.resx"
            foreach ($xmlFile in $xmlFiles) {
                $reslang = $xmlFile.Name.Split('.')[1]

                $xmlContent = Get-Content $xmlFile -Raw
                $xml = [xml]$xmlContent

                foreach ($data in $xml.root.data) {
                    if ($ecResx[$data.name]) {
                        $ecResx[$data.name][$reslang]= $data.value
                    } else {
                        $values = @{}
                        $values[$reslang] = $data.value
                        $ecResx[$data.name] = $values
                    }
                }
            }
        }

        if ($ecResx.ContainsKey($key)) {
            if ($ecResx[$key].ContainsKey($ecCulture)) {
                $result = $ecResx[$Key][$ecCulture]
            } elseif ($ecResx[$key].ContainsKey('en-US')) {
                $result = $ecResx[$Key]['en-US']
            } else {
                $result = "?[$ecCulture`:$key]"
            }
        } else {
            $result = "?[$key]"
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ResStr -key 'OUT_WELCOME_COPYRIGHT'
}

function Get-SalesOrderId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$salesOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$salesOrderId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$customerOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleSalesOrderKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsSalesOrder' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsSalesOrder = Get-UsedParameters -validParams (Get-SingleSalesOrderKeys) -boundParams $PSBoundParameters
        $firstEntry = $paramsSalesOrder.GetEnumerator() | Select-Object -First 1
        $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingSalesOrderKeys)
        $value = $firstEntry.Value

        $sqlFrag = "$key = '$value'"
        [string]$sql = "SELECT Id [salesOrderId] FROM Auftrag WHERE $sqlFrag"
        $rs = $myConn.Execute($sql)
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            [int]$result = $rs.fields('salesOrderId').Value
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SalesOrderId -salesOrderNo '20230430' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-ScriptDir {
    [CmdletBinding()]
    Param ()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'invocation' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (!(test-path variable:hostinvocation)) {$hostinvocation = $null}
        if ($null -ne $hostinvocation)
          { $result = (Split-Path $hostinvocation.MyCommand.path) }
        else
        {
            # scope 1 is the parent scope of the actual scope
            $invocation=(get-variable MyInvocation -Scope 1).Value
            if ($invocation.scriptname) {
                $result = (Split-Path $invocation.scriptname)
            }
        }
        if (-not (Test-Path $result)) { $result = $PSScriptRoot }
        if (-not (Test-Path $result)) { $result = (Get-Item -Path ".\" -Verbose).FullName}
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ScriptDir
}

function Get-SignToolPath {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'folders' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'newestFolder' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rootPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sortedFolders' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'versionRegex' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$rootPath = "$(Get-Path32)\Windows Kits\10\bin\"
        [string]$versionRegex = '^10\.\d+\.\d+\.\d+$'
        $folders = Get-ChildItem -Path $rootPath -Directory | Where-Object { $_.Name -match $versionRegex }
        $sortedFolders = $folders | Sort-Object -Property @{Expression = {[version] $_.Name}; Descending = $true}
        $newestFolder = $sortedFolders | Select-Object -First 1
        $result = Join-Path -Path $newestFolder.FullName -ChildPath 'x64\signtool.exe'
        if (! (Test-Path $result)) {
            throw ((Get-ResStr 'SIGNTOOL_NOT_FOUND') -f $rootPath)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SignToolPath
}

function Get-SingleOption {
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $false)]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string[]]$list = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'list', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'idx' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [int]$idx = $list.ToUpper().IndexOf($value.ToUpper())
        if ($idx -eq -1) {
            [string]$result = $list[0]
        } else {
          [string]$result = $list[$idx]
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SingleOption -value 'alpha' -list @('default','bravo','charlie','delta','echo')
}

function Get-Spaces {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateRange(0,10KB)]
        [int]$count = 1
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = ' ' * $count
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Spaces -count 5
}

function Get-StockSql {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$alias = 'articleNo'
        ,
        [parameter(Mandatory = $false)]
        [int]$qtyStatic
        ,
        [parameter(Mandatory = $false)]
        [string]$warehouse
        ,
        [parameter(Mandatory = $false)]
        [switch]$legacy
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)
        New-Variable -Name 'qtyFields' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlDetail' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFilter' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlLink' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlMaster' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($filter) {
            [string]$sqlFilter= " AND $($filter -join(' AND ')) "
        } else {
            [string]$sqlFilter= ''
        }

        if ($warehouse) {
            # -----------------------------------------------------------------------------
            # Only one warehouse
            # -----------------------------------------------------------------------------
            # Master
            # ------------------------------------------
            [string]$sqlMaster = @"
            SELECT CONVERT(VARCHAR(100),art.$alias) [ID.ALIAS]
            FROM [dbo].Lagerort lo
            JOIN [dbo].LagerKonto lk on lk.Lagerort = lo.id
            JOIN [dbo].Artikel [art] ON art.id = lk.artikelId
                AND art.ArtNummer not like '.MUSTER%'
                $sqlFilter
            WHERE lo.id >= 1000
                AND lo.id < 1400
                AND lk.IdentId IS NULL
                AND lk.PlatzId IS NULL
                AND lo.Bezeichnung = '$warehouse'
            ORDER BY 1
"@

            # ------------------------------------------
            # Detail
            # ------------------------------------------
            if ($qtyStatic) {
                [string]$qty = $qtyStatic
            } else {
                [string]$qty = 'lk.Menge'
            }

            if ($legacy) {
                [string]$sqlLegacy= ", $qty [BESTANDVERFUEGBAR1], $qty [BESTANDVERFUEGBAR2]"
            } else {
                [string]$sqlLegacy = ""
            }

            [string]$sqlDetail = @"
            SELECT $qty [BESTANDVERFUEGBAR] $sqlLegacy
            FROM [dbo].Lagerort lo
            JOIN [dbo].LagerKonto lk on lk.Lagerort = lo.id
            JOIN [dbo].Artikel [art] ON art.$alias = '{0}'
            WHERE  lk.ArtikelId = (SELECT TOP 1 Id FROM [dbo].Artikel WHERE $alias = '{0}')
                AND lk.IdentId IS NULL
                AND lk.PlatzId IS NULL
                AND lo.Bezeichnung = '$warehouse'
"@
        } elseif ($legacy) {

            # -----------------------------------------------------------------------------
            # All warehouses with sales and purchase correction. Pur legacy support
            # -----------------------------------------------------------------------------
            # Master
            # ------------------------------------------
            [string]$sqlMaster = @"
            SELECT CONVERT(VARCHAR(100),art.$alias) [ID.ALIAS]
            FROM [dbo].Artikel [art]
            WHERE art.ArtNummer not like '.MUSTER%'
                $sqlFilter
            ORDER BY 1
"@

            # ------------------------------------------
            # Detail
            # ------------------------------------------
            if ($qtyStatic) {
                [string]$qtyFields = `
                    "$qtyStatic [BestandVerfuegbar], " +`
                    "$qtyStatic [BestandVerfuegbar1], " +`
                    "$qtyStatic [BestandVerfuegbar2]"
            } else {
                [string]$qtyFields = `
                    "[dbo].[cnf_BestandVerfuegbarGesamt](art.Id,0) [BestandVerfuegbar], " +`
                    "[dbo].[cnf_BestandVerfuegbar1](art.Id,0) [BestandVerfuegbar1], " +`
                    "[dbo].[cnf_BestandVerfuegbar2](art.Id,0) [BestandVerfuegbar2]"
            }

            [string]$sqlDetail = @"
            -- Total inventory from all own warehouses with sales and purchase output fields
            SELECT $qtyFields
            FROM [dbo].Artikel [art]
            WHERE art.$alias = '{0}'
"@

        } else {

            # -----------------------------------------------------------------------------
            # All warehouses , all suplier and totals with sales and purchase correction
            # -----------------------------------------------------------------------------
            # Master
            # ------------------------------------------
            [string]$sqlMaster = @"
            SELECT
                CONVERT(VARCHAR(100),art.$alias) [ID.ALIAS],
                art.Id [ID],
                CONVERT(varchar(36), art.Uid) [UID],
                art.ArtNummer [ARTNUMMER],
                art.Barcode [BARCODE],
                art.ChangeDate [CHANGEDATE],
                art.ShopFreigabeFlg [SHOPFREIGABEFLG],
                art.ShopExportDatum [SHOPEXPORTDATUM]
            FROM [dbo].Artikel [art]
            WHERE art.ArtNummer not like '.MUSTER%'
                $sqlFilter
            ORDER BY 1
"@

            # ------------------------------------------
            # Detail
            # ------------------------------------------
            if ($qtyStatic) {
                $sqlStaticWarehouse = $qtyStatic
                $sql0 = $qtyStatic
                $sql1 = $qtyStatic
                $sql2 = $qtyStatic
                $sqlSupplier = $qtyStatic
            } else {
                $sqlStaticWarehouse = 'lk.Menge'
                $sql0 = '[dbo].[cnf_BestandVerfuegbarGesamt](art.Id,0)'
                $sql1 = '[dbo].[cnf_BestandVerfuegbar1](art.Id,0)'
                $sql2 = '[dbo].[cnf_BestandVerfuegbar2](art.Id,0)'
                $sqlSupplier = 'IsNull(kart.Bestand,0)'
            }

            [string]$sqlDetail = @"
            SELECT * FROM (
                SELECT lo.id [KONTO], UPPER(lo.Bezeichnung) [BEZEICHNUNG], $sqlStaticWarehouse [MENGE]
                FROM [dbo].Lagerort lo
                JOIN [dbo].LagerKonto lk ON lk.Lagerort = lo.id
                JOIN [dbo].Artikel [art] ON art.$alias = '{0}'
                WHERE lo.id >= 1000
                    AND lo.id < 1400
                    AND lk.ArtikelId = (SELECT TOP 1 Id FROM [dbo].Artikel WHERE $alias = '{0}')
                    AND lk.IdentId IS NULL
                    AND lk.PlatzId IS NULL

                -- Total inventory from all own warehouses that is physically present
                UNION
                SELECT 10000+0 [KONTO], 'BESTANDVERFUEGBAR' [BEZEICHNUNG], $sql0 [MENGE]
                FROM [dbo].Artikel [art]
                WHERE  art.$alias = '{0}'

                -- Total inventory from all own warehouses less sales orders
                UNION
                SELECT 10000+1 [KONTO], 'BESTANDVERFUEGBAR1' [BEZEICHNUNG], $sql1 [MENGE]
                FROM [dbo].Artikel [art]
                WHERE  art.$alias = '{0}'

                -- Total inventory from all own warehouses less sales orders
                UNION
                SELECT 10000+1 [KONTO], 'BESTANDVERFUEGBAR2' [BEZEICHNUNG], $sql2 [MENGE]
                FROM [dbo].Artikel [art]
                WHERE  art.$alias = '{0}'

                -- Inventory of suppliers, external goods
                UNION
                SELECT 20000+k.id [KONTO], adr.Match [BEZEICHNUNG], $sqlSupplier [MENGE]
                FROM [dbo].Kreditor [k]
                JOIN [dbo].Adresse [adr] ON adr.id = k.AdresseID
                JOIN [dbo].KrArtikel [kart] ON
                    kart.ArtikelId = (SELECT TOP 1 Id FROM [dbo].Artikel WHERE $alias = '{0}') AND
                    kart.KreditorID = k.id
                JOIN [dbo].Artikel [art] ON art.id = kart.ArtikelID
            ) [INVENTORYREPORT] ORDER BY KONTO

"@
        }

    <#
            # This model 'flat' is experimental and not yet fully parameterized

            [string]$sqlMaster = @"
            SELECT  GTIN [ID.ALIAS] FROM
            (SELECT ArtNummer [ArticleNo], Barcode [GTIN] FROM Artikel) [Master]
            WHERE GTIN>='1000000' AND GTIN <='8888889'
    @"

            [string]$sqlDetail = @"
            DECLARE @Id INT
            DECLARE @IdList TABLE (Id INT)

            INSERT INTO @IdList SELECT Id FROM Artikel order by id -- VALUES (31), (32), (33)
            DECLARE @Result TABLE ([Uid] VARCHAR(36), ArticleId INT, ArticleNo VARCHAR(80), GTIN VARCHAR(80),
                ChangeDate DateTime, ExportFlag Bit, ExportDate DateTime, StockGroup INT, Warehouse VARCHAR(50), Quantity INT)
            DECLARE IdCursor CURSOR FOR SELECT Id FROM @IdList

            OPEN IdCursor
            FETCH NEXT FROM IdCursor INTO @Id

            WHILE @@FETCH_STATUS = 0
            BEGIN
            INSERT INTO @Result
                -- Inventory from own warehouses
                SELECT CONVERT(varchar(36), art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode,'') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    lo.id [StockGroup], UPPER(lo.Bezeichnung) [Warehouse], lk.Menge [Quantity]
                FROM Lagerort lo
                JOIN dbo.LagerKonto lk on lk.Lagerort = lo.id
                JOIN Artikel [art] ON art.id = @Id AND art.ArtNummer not like '.MUSTER%'
                WHERE lo.id >= 1000
                    AND lo.id < 1400
                    AND lk.ArtikelId = @Id
                    AND lk.IdentId IS NULL
                    AND lk.PlatzId IS NULL

                -- Total inventory from all own warehouses that is physically present
                UNION
                SELECT CONVERT(varchar(36), art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode,'') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    10000+1 [StockGroup], 'AVAILABLE' [Warehouse], [dbo].[cnf_BestandVerfuegbarGesamt](@Id,0) [Quantity]
                FROM Artikel [art]
                WHERE art.id = @Id AND art.ArtNummer not like '.MUSTER%'

                -- Total inventory from all own warehouses less sales orders
                UNION
                SELECT CONVERT(varchar(36),art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode, '') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    10000+2 [StockGroup], 'SALES' [Warehouse], [dbo].[cnf_BestandVerfuegbar1](@Id,0) [Quantity]
                FROM Artikel [art]
                WHERE art.id = @Id AND art.ArtNummer not like '.MUSTER%'

                -- Total inventory from all own warehouses less sales orders and plus purchase orders
                UNION
                SELECT CONVERT(varchar(36),art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode, '') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    10000+3 [StockGroup], 'PURCHASE' [Warehouse], [dbo].[cnf_BestandVerfuegbar2](@Id,0) [Quantity] FROM Artikel [art]
                WHERE art.id = @Id AND art.ArtNummer not like '.MUSTER%'

                -- Inventory of suppliers, external goods
                UNION
                SELECT CONVERT(varchar(36),art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode, '') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    20000+k.id [StockGroup], adr.Match [Warehouse], IsNull(kart.Bestand,0) [Quantity]
                FROM Kreditor [k]
                JOIN Adresse [adr] ON adr.id = k.AdresseID
                JOIN KrArtikel [kart] ON  kart.ArtikelId = @Id AND kart.KreditorID = k.id
                JOIN Artikel [art] ON art.id = kart.ArtikelID AND art.ArtNummer not like '.MUSTER%'

                FETCH NEXT FROM IdCursor INTO @Id
            END

            CLOSE IdCursor
            DEALLOCATE IdCursor

            SELECT GTIN [ARTNUMMER], Quantity [BESTANDVERFUEGBAR],  Quantity [BESTANDVERFUEGBAR1], Quantity [BESTANDVERFUEGBAR2] FROM
            (SELECT [Uid], ArticleId, ArticleNo, GTIN,
                    ChangeDate, ExportFlag, ExportDate,
                    StockGroup, Warehouse, Quantity
            FROM @Result) [Details]

            WHERE StockGroup = 1001 AND GTIN>='1000000' AND GTIN <='8888889' AND GTIN = '{0}'
"@

    #>

       [string]$sqlLink= 'ID.ALIAS'

       $result = @($sqlMaster, $sqlDetail, $sqlLink)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
   # Test:  Get-StockSql -legacy -filter "ArtNummer='130100'"
}

function Get-Subnet {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [int]$cidr
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        [string]$localIp
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'localIpObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! $Cidr) {
                if (! $localIp) {
                    $localIp= Get-LocalIp
                }
                $localIpObj= [IPAddress]::Parse($localIp)
                $cidr =  (Get-NetIPAddress -AddressFamily IPv4 -IPAddress $localIpObj).PrefixLength
            }
            $result= ([IpAddress]([math]::pow(2, 32) -1 -bxor [math]::pow(2, (32 - $cidr))-1)).IpAddressToString
        }

        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Subnet -cidr 24
}

function Get-SupplierAddressId {
    [CmdletBinding()]
    param(
        [int]$supplierID
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $sql = @"
            SELECT ans.ID [SupplierAddressId]
            FROM Kreditor k
            JOIN Adresse adr ON adr.Id = k.AdresseID
            JOIN (
                SELECT ID, AdresseID, AdresseRevision
                FROM (
                    SELECT ID, AdresseID, AdresseRevision,
                        ROW_NUMBER() OVER (PARTITION BY AdresseID ORDER BY AdresseRevision DESC) as row_num
                    FROM cnAnschrift
                ) sub
                WHERE sub.row_num = 1
            ) ans ON ans.AdresseID = adr.ID
            WHERE k.ID = $supplierID;
"@

        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                [int]$result = $rs.fields('SupplierAddressId').value
            }
        }
    }


    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test $id = Get-SupplierAddressId -supplierID 15 -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
}
function Get-SupplierId {
    [CmdletBinding()]
    param(
        [string]$addressMatch
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $sql = @"
            SELECT k.Id [Id]
            FROM Kreditor k
            JOIN Adresse adr ON adr.Id = k.AdresseID and Match = '$addressMatch'
"@

        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                [int]$result = $rs.fields('Id').value
            }
        }
    }


    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: $id = Get-SupplierId -addressMatch 'WUERTH' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
}
function Get-TempDir {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = [System.IO.Path]::GetTempPath()
        if ($result.Substring($result.Length-1) -eq '\') {
            $result = $result.substring(0, $result.Length - 1)
        }
        if ($result -eq "\") { $result = "" }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-TempDir
}

function Get-TranslateSection {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$text = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'text', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        [ValidateLength(2,2)]
        [string]$iso = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'iso', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$sub
        ,
        [Parameter(Mandatory = $false)]
        [string]$subDefault
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'arrLines' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'arrResult' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        New-Variable -Name 'delim' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'isoCurrent' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'isoTemp' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'line' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'subCurrent' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'subTemp' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $iso = $iso.ToUpper()
        $sub = $sub.ToUpper()
        $subDefault = $subDefault.ToUpper()

        [string]$isoTemp = ""
        [string]$subTemp = ""
        [string]$isoCurrent = ""
        [string]$subCurrent = ""

        [System.Collections.ArrayList]$arrResult = @()
        $arrLines = $text.Replace("`r`n", "`n").Split("`n")

        Foreach ($line in $arrLines) {
            if ((Get-TranslateIsDelim -value $line) -eq $true) {
                [string[]]$delim = Get-TranslateExtractTag -value $line
                [string]$isoTemp = $delim[0]
                [string]$subTemp = $delim[1]

                If (($isoCurrent -eq $iso) -and ($subCurrent -eq $sub)) {
                    break
                }

                if ((! $isoCurrent) -and ($isoTemp -eq $iso) -and ($subTemp -eq $sub)) {
                    [System.Collections.ArrayList]$arrResult = @()
                    $isoCurrent = $isoTemp
                    $subCurrent = $subTemp
                }
            } else {
                # Iso tag language separator found and sort by it
                if ((($isoCurrent -eq $iso) -and ($subCurrent -eq $sub)) -or
                    ((! $isoCurrent) -and (! $isoTemp) -and (!$sub)) -or
                    ((! $isoCurrent) -and ($isoTemp -eq "00") -and ($subTemp -eq $sub))) {
                       $arrResult.add($line) | Out-Null
                    }
            }
        }
        if (($arrResult.count -eq 0) -and ($sub) -and ($subDefault)) { $arrResult.Add($subDefault) | Out-Null }
        $result = $arrResult -join "`r`n"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-TranslateSection -text "This is my default text, It is used when no language is found`r`n[EN]`r`nThe moon always has the same face`r`n[DE]`r`nDer Mond hat immer das selbe Gesicht`r`n[IT]`r`nLa luna ha sempre la stessa faccia" -iso 'IT'
}

function Get-UpsellingFromVariants {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'item' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        try {
            if ($barcode) {
                [string]$sqlFrag = "Barcode = '$barcode'"
            } elseif ($articleNo) {
                [string]$sqlFrag = "ArtNummer = '$articleNo'"
            } elseif($articleUid) {
                [string]$sqlFrag = "Uid = '$articleUid'"
            } else {
                [string]$sqlFrag = "Id = $articleId"
            }
            [string]$sql = @"
            DECLARE @Master VARCHAR(100);
            DECLARE @Variant VARCHAR(100);

            SELECT @Variant = ArtNummer FROM Artikel WHERE $sqlFrag
            SET @Master = NULL;

            SELECT @Master = eart.MasterArticle FROM esolArtikelshop [eart]
            JOIN Artikel [art] on art.Id = eart.Id
            WHERE art.ArtNummer =  @Variant;
            SELECT art.ArtNummer [ArticleNo] FROM Artikel [art]
            JOIN esolArtikelShop [eart] ON art.Id = eart.Id
            WHERE eart.MasterArticle = @Master AND art.ArtNummer <> @Variant
            ORDER BY 1;
"@

            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            if (! (Test-ShopExtension -conn $myConn)) {
                Throw ((Get-ResStr 'FUNCTION_NEEDS_SHOP_EXTENSIONS') -f $($myInvocation.Mycommand))
            }

            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                while (! $rs.eof) {
                    [string]$item = $rs.fields('ArticleNo').Value
                    $result += $item
                    $rs.MoveNext()
                }
            }
        } catch {
            Throw  ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-UpsellingFromVariants -articleNo '130100' -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}

function Get-XmlEulandaAddress {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateSelect -strParam $_ })]
        [string]$select= '*'
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingAddressKeys) })]
        [string]$alias = 'addressMatch'
        ,
        [parameter(Mandatory = $false)]
        [string]$order = $alias
        ,
        [parameter(Mandatory = $false)]
        [switch]$reorder
        ,
        [parameter(Mandatory = $false)]
        [switch]$revers
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingAddressKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingAddressKeys)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'ParamsAddress' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $ParamsAddress = Get-UsedParameters -validParams (Get-SetAddressFilter) -boundParams $PSBoundParameters
        [string[]]$sql= Get-AddressSql @ParamsAddress
        $rs = $Null
        $rs = $myConn.Execute($sql[0])
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            # Creating a MemoryStream object to store the XML text
            $memoryStream = New-Object System.IO.MemoryStream

            # Use xmlWriterSettings to change the default settings of the xmlWriter
            $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
            $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
            # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
            $xmlWriterSettings.OmitXmlDeclaration = $true

            # Creating an XmlWriter object to write the XML structure
            $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
            # Writing the XML structure with the XmlWriter object
            $writer.WriteStartElement('ADRESSELISTE')
            while (! $rs.eof) {
                $writer.WriteStartElement('ADRESSE')
                for ($i=0; $i -lt $rs.fields.count; $i++) {
                    [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                    [string]$nodeValue = [string]$rs.fields[$i].value
                    $writer.WriteElementString($nodeName,$nodeValue)
                }
                $writer.WriteEndElement()
                $rs.MoveNext()
            }
            $writer.WriteEndElement()
            # Exiting the XmlWriter object
            $writer.Flush()
            $writer.Close()

            # Read memoryStream with streamreader
            $memoryStream.Position = 0
            $streamReader = New-Object System.IO.StreamReader($memoryStream)
            [string]$result = $streamReader.ReadToEnd()
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaAddress -filter "Match='EULANDA'" -select 'Match,Name1,Name2,Name3,Strasse,Plz,Ort' -alias 'addressMatch' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Get-XmlEulandaArticle {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateSelect -strParam $_ })]
        [string]$select= (Get-DefaultSelectArticle)
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$alias = 'articleNo'
        ,
        [parameter(Mandatory = $false)]
        [string]$order= $alias
        ,
        [parameter(Mandatory = $false)]
        [switch]$reorder
        ,
        [parameter(Mandatory = $false)]
        [switch]$revers
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateCustomerGroups -CustomerGroups $_ })]
        [string]$customerGroups
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingArticleKeys)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'articleNo' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlString' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = ""
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SetArticleFilter) -boundParams $PSBoundParameters

        [string[]]$sql= Get-ArticleSql @paramsArticle
        $rs = $myConn.Execute($sql[0])
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            # Creating a MemoryStream object to store the XML text
            $memoryStream = New-Object System.IO.MemoryStream

            # Use xmlWriterSettings to change the default settings of the xmlWriter
            $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
            $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()

            # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
            $xmlWriterSettings.OmitXmlDeclaration = $true

            # Creating an XmlWriter object to write the XML structure
            $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)

            # Writing the XML structure with the XmlWriter object
            $writer.WriteStartElement('ARTIKELLISTE')

            while (! $rs.eof) {
                # ADD NODE ARTIKEL (one article including other sub nodes like shop)
                $writer.WriteStartElement('ARTIKEL')

                    # ADD NODE FIELDS ARTIKEL (article fields)
                    for ($i=0; $i -lt $rs.fields.count; $i++) {
                        [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                        [string]$nodeValue = [string]$rs.fields[$i].value
                        $writer.WriteElementString($nodeName,$nodeValue)
                    }

                    # GET ARTICLENO for inserting all other nodes
                    $articleNo = $rs.fields['ARTNUMMER'].value

                    # ADD NODE SHOP (online shop items)
                    if (Test-ShopExtension -conn $myConn) {
                        $xmlString = Get-XmlEulandaShop -articleNo $articleNo -conn $myConn
                        $writer.WriteRaw($xmlString)
                    }

                    # ADD NODE LAGER (stock)
                    $xmlString= Get-XmlEulandaStock -articleNo $articleNo -conn $myConn
                    $writer.WriteRaw($xmlString)

                    # ADD NODE PREISLISTE (price list)
                    $xmlString= Get-XmlEulandaTierPrice -articleNo $articleNo -customerGroups $customerGroups -conn $myConn
                    $writer.WriteRaw($xmlString)

                    # ADD NODE MERKMALLISTE (list of breadcrumb)
                    $xmlString= Get-XmlEulandaBreadcrumb -articleNo $articleNo -tablename 'Article' -breadcrumbpath '\shop' -conn $myConn
                    $writer.WriteRaw($xmlString)

                $writer.WriteEndElement()
                $rs.MoveNext()
            }

            $writer.WriteEndElement()

            # Exiting the XmlWriter object
            $writer.Flush()
            $writer.Close()

            # Read memoryStream with streamreader
            $memoryStream.Position = 0
            $streamReader = New-Object System.IO.StreamReader($memoryStream)
            [string]$result = $streamReader.ReadToEnd()
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaArticle -filter "ArtNummer='1100'"  -customerGroups 'HA,HB,HC' -alias 'Barcode' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
    # Test:  Get-XmlEulandaArticle -filter "ArtNummer='130100'" -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}

Function Get-XmlEulandaBreadcrumb {
    param(
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingTablename) })]
        [string]$tablename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tablename', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $articleId = Get-ArticleId  @paramsArticle  -conn $myConn

            [string]$sql = @"
            DECLARE @root VARCHAR(128)
            DECLARE @keyid int
            DECLARE @bs VARCHAR(2)
            DECLARE @blank VARCHAR(2)
            SET @bs = '\'
            SET @blank = ''
            SET @root = '$breadcrumbPath'
            IF @root = @blank SET @root=@bs
            IF LEN(@root)>1 AND SUBSTRING(@root,LEN(@root),1) <> @bs SET @root = @root + @bs
            EXEC cn_MerkOpenPath @keyid=@keyid OUT, @basekeyid=0, @path=@root, @tablename='$tablename'
            SELECT @bs + dbo.cnf_merkpfad(m.id,@keyid) [PFAD]
            FROM Merkmalelement me
            LEFT JOIN merkmal m ON m.id=me.kopfid
            WHERE m.tabelle = '$tablename' and
            m.merkmaltyp = 1 and
            me.objektid = (SELECT id FROM $tablename WHERE Id = $articleId) and
            @bs + dbo.cnf_merkpfad(m.id,@keyid) <> '\' and
            not @bs + dbo.cnf_merkpfad(m.id,@keyid) like '%.USER%'
            ORDER BY @bs + dbo.cnf_merkpfad(m.id,@keyid)
"@
            $rs = $Null
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                # Creating a MemoryStream object to store the XML text
                $memoryStream = New-Object System.IO.MemoryStream

                # Use xmlWriterSettings to change the default settings of the xmlWriter
                $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
                $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
                # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
                $xmlWriterSettings.OmitXmlDeclaration = $true

                # Creating an XmlWriter object to write the XML structure
                $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
                # Writing the XML structure with the XmlWriter object
                $writer.WriteStartElement('MERKMALLISTE')
                while (! $rs.eof) {
                    $writer.WriteStartElement('MERKMAL')
                        [string]$nodeName = $rs.fields[0].Name.ToUpper()
                        [string]$nodeValue = [string]$rs.fields[0].value
                        $writer.WriteElementString($nodeName,$nodeValue)
                    $writer.WriteEndElement()

                   $rs.movenext()
                }
                $writer.WriteEndElement()
                # Exiting the XmlWriter object
                $writer.Flush()
                $writer.Close()

                # Read memoryStream with streamreader
                $memoryStream.Position = 0
                $streamReader = New-Object System.IO.StreamReader($memoryStream)
                [string]$result = $streamReader.ReadToEnd()
            }

        }

        catch {
            if ($Error.Count -gt 0) {
                $line = $myInvocation.ScriptLineNumber - 1
                Throw ((Get-ResStr 'EXCEPTION_GENERAL_EXT') -f $_, $($myInvocation.Mycommand), $($line), $($Error[0].Exception.Message) )
            } else {
                Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
            }
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaBreadcrumb -articleNo '130100' -tablename 'Article' -breadcrumbpath '\shop' -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}
function Get-XmlEulandaDelivery {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [switch]$includeEmpty
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$sql = $(
            if ($deliveryId) {
                Get-DeliverySql -deliveryId $deliveryId
            } else {
                Get-DeliverySql -deliveryNo $deliveryNo
            }
        )
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsDelivery' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlString' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            [string]$result = ""
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $paramsDelivery = Get-UsedParameters -validParams (Get-SingleDeliveryKeys) -boundParams $PSBoundParameters

            $rs = $Null
            $rs = $myConn.Execute($sql[0])
            $rs = Get-AdoRs -recordset $rs

            if ($rs) {
                # Creating a MemoryStream object to store the XML text
                $memoryStream = New-Object System.IO.MemoryStream

                # Use xmlWriterSettings to change the default settings of the xmlWriter
                $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
                $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
                # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
                $xmlWriterSettings.OmitXmlDeclaration = $true

                # Creating an XmlWriter object to write the XML structure
                $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
                # Writing the XML structure with the XmlWriter object

                $writer.WriteStartElement('LIEFERSCHEINLISTE')
                while (! $rs.eof) {
                    $writer.WriteStartElement('LIEFERSCHEIN')
                    for ($i=0; $i -lt $rs.fields.count; $i++) {
                       if (($includeEmpty) -or (![string]::IsNullOrEmpty($rs.fields[$i].Value))) {
                            [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                            [string]$xmlValue = ConvertTo-XmlString -adoField $rs.fields[$i] -includeEmpty:$includeEmpty
                            if (($includeEmpty) -or ($xmlValue)) {
                                $writer.WriteElementString($nodeName, $xmlValue)
                            }
                        }
                    }

                    [string]$xmlString = Get-XmlEulandaDeliveryPos @paramsDelivery -includeEmpty:$includeEmpty -sql $sql -conn $myConn
                    $writer.WriteRaw($xmlString)

                    $writer.WriteEndElement()
                    $rs.MoveNext()
                }
                $writer.WriteEndElement()
                # Exiting the XmlWriter object
                $writer.Flush()
                $writer.Close()

                # Read memoryStream with streamreader
                $memoryStream.Position = 0
                $streamReader = New-Object System.IO.StreamReader($memoryStream)
                [string]$result = $streamReader.ReadToEnd()
            }

        }

        catch {
            if ($Error.Count -gt 0) {
                $line = $myInvocation.ScriptLineNumber - 1
                Throw ((Get-ResStr 'EXCEPTION_GENERAL_EXT') -f $_, $($myInvocation.Mycommand), $($line), $($Error[0].Exception.Message) )
            } else {
                Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:   Get-XmlEulandaDelivery -DeliveryNo 430952 -Udl 'C:\Temp\Eulanda_1 JohnDoe.udl' -debug
}

function Get-XmlEulandaDeliveryPos {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [switch]$includeEmpty
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$sql = $(
            if ($deliveryId) {
                Get-DeliverySql -deliveryId $deliveryId
            } else {
                Get-DeliverySql -deliveryNo $deliveryNo
            }
        )
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            [string]$result = ""
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            $rs = $Null
            $rs = $myConn.Execute("$($sql[1]) ORDER BY 1" )
            $rs = Get-AdoRs -recordset $rs

            if ($rs) {
                # Creating a MemoryStream object to store the XML text
                $memoryStream = New-Object System.IO.MemoryStream

                # Use xmlWriterSettings to change the default settings of the xmlWriter
                $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
                $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
                # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
                $xmlWriterSettings.OmitXmlDeclaration = $true

                # Creating an XmlWriter object to write the XML structure
                $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
                # Writing the XML structure with the XmlWriter object

                $writer.WriteStartElement('LIEFERSCHEINPOSLISTE')
                while (! $rs.eof) {
                    $writer.WriteStartElement('LIEFERSCHEINPOS')
                    for ($i=0; $i -lt $rs.fields.count; $i++) {
                        if (($includeEmpty) -or (![string]::IsNullOrEmpty($rs.fields[$i].Value))) {
                            [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                            [string]$xmlValue = ConvertTo-XmlString -adoField $rs.fields[$i] -includeEmpty:$includeEmpty
                            if (($includeEmpty) -or ($xmlValue)) {
                                $writer.WriteElementString($nodeName, $xmlValue)
                            }
                        }
                    }
                    $writer.WriteEndElement()
                    $rs.MoveNext()
                }

                $writer.WriteEndElement()
                # Exiting the XmlWriter object
                $writer.Flush()
                $writer.Close()

                # Read memoryStream with streamreader
                $memoryStream.Position = 0
                $streamReader = New-Object System.IO.StreamReader($memoryStream)
                [string]$result = $streamReader.ReadToEnd()
            }

        }

        catch {
            if ($Error.Count -gt 0) {
                $line = $myInvocation.ScriptLineNumber - 1
                Throw ((Get-ResStr 'EXCEPTION_GENERAL_EXT') -f $_, $($myInvocation.Mycommand), $($line), $($Error[0].Exception.Message) )
            } else {
                Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:   Get-XmlEulandaDeliveryPos -DeliveryNo 430952 -Udl 'C:\Temp\Eulanda_1 JohnDoe.udl'
}

function Get-XmlEulandaMetadata {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [switch]$noUsername
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noPcName
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Creating a MemoryStream object to store the XML text
        $memoryStream = New-Object System.IO.MemoryStream

        # Use xmlWriterSettings to change the default settings of the xmlWriter
        $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
        $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
        # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
        $xmlWriterSettings.OmitXmlDeclaration = $true

        # Creating an XmlWriter object to write the XML structure
        $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)

        # Writing the XML structure with the XmlWriter object
        $writer.WriteStartElement('METADATA')
            $writer.WriteElementString('VERSION',$global:ecModuleVersion.ToString())
            $writer.WriteElementString('GENERATOR',$global:ecModuleName)
            $writer.WriteElementString('DATEFORMAT','ISO8601')
            $writer.WriteElementString('FLOATFORMAT','US')
            $writer.WriteElementString('COUNTRYFORMAT','ISO2')
            $writer.WriteElementString('FIELDNAMES','NATIVE')
            $writer.WriteElementString('DATE',(Convert-DateToIso -value $(Get-Date) -noTimeZone ))
            if (! $noPcName) {
                $writer.WriteElementString('PCNAME', "$env:COMPUTERNAME".ToUpper())
            }
            if (! $noUserName) {
                $writer.WriteElementString('USERNAME', "$env:USERNAME".ToUpper())
            }
        $writer.WriteEndElement()

        # Exiting the XmlWriter object
        $writer.Flush()
        $writer.Close()

        # Read memoryStream with streamreader
        $memoryStream.Position = 0
        $streamReader = New-Object System.IO.StreamReader($memoryStream)
        [string]$result = $streamReader.ReadToEnd()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaMetadata
}

function Get-XmlEulandaProperty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingTablename) })]
        [string]$tablename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tablename', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'child' -Scope 'Private' -Value ($null)
        New-Variable -Name 'data' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'idMap' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'parent' -Scope 'Private' -Value ($null)
        New-Variable -Name 'parentId' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'properties' -Scope 'Private' -Value ($null)
        New-Variable -Name 'property' -Scope 'Private' -Value ($null)
        New-Variable -Name 'root' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rootId' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'subNode' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlFlat' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlHierarchy' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            [string[]]$sql= Get-PropertySql -breadcrumbPath $breadcrumbPath -tablename $tablename
            [System.Object]$data = Get-DataFromSql -sql $sql -conn $myConn
            [xml]$xmlFlat = Convert-DataToXml -data $data -root 'EULANDA' -arrRoot 'MERKMALLISTE' -arrSubRoot 'MERKMAL'

            # Create a hash map with all ID values
            # MERKMAL (engl. =Property)
            $idMap = @{}
            foreach ($property in $xmlFlat.SelectNodes("//MERKMAL")) {
                $idMap[$property.Id] = $true
            }

            # Traversing all ParentId values and searching for the rootId
            # MERKMAL (engl. =Property)
            $rootId = $null
            foreach ($property in $xmlFlat.SelectNodes("//MERKMAL")) {
                $parentId = $property.ParentId
                if ($parentId -ne "" -and !$idMap.ContainsKey($parentId)) {
                    $rootId = $parentId
                    break
                }
            }

            # Create a new XML document for the hierarchy
            $xmlHierarchy = New-Object System.Xml.XmlDocument
            $root = $xmlHierarchy.CreateElement("MERKMALBAUM")
            $xmlHierarchy.AppendChild($root) | Out-Null

            # Converting the list of flat properties into a hierarchy
            $properties = $xmlFlat.SelectNodes("//MERKMAL")
            foreach ($property in $properties) {
                $parentId = $property.ParentId
                if ($parentId -eq $rootId) {
                    $root.AppendChild($xmlHierarchy.ImportNode($property, $true)) | Out-Null
                } else {
                    $parent = $xmlHierarchy.SelectSingleNode("//MERKMAL[ID=$parentId]")
                    $parent.AppendChild($xmlHierarchy.ImportNode($property, $true)) | Out-Null
                }
            }

            # Move all the child elements of 'MERKMALBAUM' to 'MERKMALBAUM\ARTIKEL' or what ever
            # MERKMALBAUM (eng. =PropertyTree), ARTIKEL (eng. = Article)
            $subNode = $xmlHierarchy.CreateElement($tablename.ToUpper())
            foreach ($child in $xmlHierarchy.SelectNodes("//MERKMALBAUM/*")) {
                $subNode.AppendChild($child.CloneNode($true)) | Out-Null
            }
            # Remove the original child nodes of the root
            $xmlHierarchy.DocumentElement.RemoveAll()
            # Add the subnode like ARTIKEL as the new child of the root
            $xmlHierarchy.DocumentElement.AppendChild($subNode) | Out-Null

            $result = $xmlHierarchy.OuterXml
        }

        catch {
            Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaProperty -breadcrumbPath '\Produkte' -tablename 'Adresse' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

Function Get-XmlEulandaRoot {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'xml' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [xml]$xml = [xml]"<EULANDA></EULANDA>"
        $result = $xml.OuterXml
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaRoot
}

function Get-XmlEulandaShop {
    param (
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [Alias('id')]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [Alias('uid')]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'idx' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'upselling' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters

        try {
            [string]$result = ''

            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            if (! (Test-ShopExtension -conn $myConn)) {
                Throw ((Get-ResStr 'FUNCTION_NEEDS_SHOP_EXTENSIONS') -f $($myInvocation.Mycommand))
            }

            [int]$articleId = Get-ArticleId @paramsArticle -conn $myConn
            [string]$sql = @"
            DECLARE @ShopFields NVARCHAR(MAX);
            SET @ShopFields = STUFF(
                    (
                        SELECT ', Arts.' + COLUMN_NAME
                        FROM INFORMATION_SCHEMA.COLUMNS
                        WHERE TABLE_NAME = 'esolArtikelShop'
                        AND COLUMN_NAME NOT IN ('ID', 'VariantText1', 'VariantText2', 'VariantText3', 'VariantText4', 'VariantText5')
                        FOR XML PATH('')
                    ), 1, 2, ''
            );

            DECLARE @MasterFields NVARCHAR(MAX);
            SET @MasterFields = 'Master.VariantText1, Master.VariantText2, Master.VariantText3, Master.VariantText4, Master.VariantText5';

            DECLARE @AddressFields NVARCHAR(MAX);
            SET  @AddressFields = 'adr.Match [MANUFACTURER]';

            DECLARE @sql NVARCHAR(MAX);
            SET @sql = N'
            SELECT ' + @ShopFields + ', ' + @MasterFields + ', ' + @AddressFields + '
            FROM esolArtikelShop [arts]
            LEFT JOIN Artikel art ON art.ID = arts.ID
            LEFT JOIN Adresse adr ON adr.ID = art.HerstellerID
            LEFT JOIN esolArtikelShop Master ON Master.ID = (SELECT ID FROM Artikel WHERE ArtNummer = arts.MasterArticle)
            WHERE art.Id = $articleId';

            EXEC sp_executesql @sql;
"@

            $rs = $Null
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs

            if ($rs) {
                # Creating a MemoryStream object to store the XML text
                $memoryStream = New-Object System.IO.MemoryStream

                # Use xmlWriterSettings to change the default settings of the xmlWriter
                $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
                $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
                # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
                $xmlWriterSettings.OmitXmlDeclaration = $true

                # Creating an XmlWriter object to write the XML structure
                $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
                # Writing the XML structure with the XmlWriter object

                $upselling= Get-UpsellingFromVariants @paramsArticle -conn $myConn

                $writer.WriteStartElement('SHOP')
                while (! $rs.eof) {
                    for ($i=0; $i -lt $rs.fields.count; $i++) {
                        [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                        [string]$nodeValue = [string]$rs.fields[$i].value
                        # An automatic upselling is set up when dealing with variants that consist of more
                        # than one unit. If no upselling has been specified, it is formed from these variants.
                        if (($upselling) -and ($upselling.count -gt 0)) {
                            if ($nodeName -match "^Up[1-8]$") {
                                if (! $nodeValue) {
                                    [int]$idx = [int]$nodeName.Substring(2)
                                    if ($upselling.count -ge $idx) {
                                        $nodeValue = $upselling[$idx-1]
                                    };
                                }
                            }
                        }

                        $writer.WriteElementString($nodeName,$nodeValue)
                    }
                    $rs.MoveNext()
                }
                $writer.WriteEndElement()
                # Exiting the XmlWriter object
                $writer.Flush()
                $writer.Close()

                # Read memoryStream with streamreader
                $memoryStream.Position = 0
                $streamReader = New-Object System.IO.StreamReader($memoryStream)
                [string]$result = $streamReader.ReadToEnd()
            }
        }

        catch {
            if ($Error.Count -gt 0) {
                $line = $myInvocation.ScriptLineNumber - 1
                Throw ((Get-ResStr 'EXCEPTION_GENERAL_EXT') -f $_, $($myInvocation.Mycommand), $($line), $($Error[0].Exception.Message) )
            } else {
                Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
            }
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaShop -articleNo '130100' -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}
function Get-XmlEulandaStock {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rawSql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters

        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            [int]$articleId = Get-ArticleId @paramsArticle -conn $myConn
            [string]$rawSql = (Get-StockSql -legacy -alias 'articleId')[1]
            [string]$sql= ($rawSql -f $articleId )
            $rs = $Null
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                # Creating a MemoryStream object to store the XML text
                $memoryStream = New-Object System.IO.MemoryStream

                # Use xmlWriterSettings to change the default settings of the xmlWriter
                $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
                $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
                # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
                $xmlWriterSettings.OmitXmlDeclaration = $true

                # Creating an XmlWriter object to write the XML structure
                $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
                # Writing the XML structure with the XmlWriter object

                $writer.WriteStartElement('LAGER')

                for ($i=0; $i -lt $rs.fields.count; $i++) {
                    [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                    [string]$nodeValue = [string]$rs.fields[$i].value
                    $writer.WriteElementString($nodeName,$nodeValue)
                }

                $writer.WriteEndElement()
                # Exiting the XmlWriter object
                $writer.Flush()
                $writer.Close()

                # Read memoryStream with streamreader
                $memoryStream.Position = 0
                $streamReader = New-Object System.IO.StreamReader($memoryStream)
                [string]$result = $streamReader.ReadToEnd()
            }
        }

        catch {
            if ($Error.Count -gt 0) {
                $line = $myInvocation.ScriptLineNumber - 1
                Throw ((Get-ResStr 'EXCEPTION_GENERAL_EXT') -f $_, $($myInvocation.Mycommand), $($line), $($Error[0].Exception.Message) )
            } else {
                Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
            }
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaStock -articleNo '130100' -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}

Function Get-XmlEulandaTierPrice {
    param(
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateCustomerGroups -customerGroups $_ })]
        [string]$customerGroups
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlTierPrice' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlTierPriceSimulation' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriter' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters

        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $articleId = Get-ArticleId  @paramsArticle  -conn $myConn

            # Get's the tier prices from regular tier price table
            [string]$sqlTierPrice = @"
            DECLARE @ArticleId INT = $articleId
            SELECT pl.Name, pl.Waehrung, pl.BruttoFlg, p.Staffel, p.MengeAb, p.Vk
            FROM PreisListe [pl]
            JOIN Preis [p] ON pl.Id = p.PreisListe
            JOIN Artikel art ON art.Id = p.ArtikelId
            WHERE art.Id = @ArticleId
            ORDER BY pl.Name, p.Staffel
"@

            # Simulates the tier price structure for an article
            # based on its rebate group and a list of customer groups
            [string]$sqlTierPriceSimulation = @"
            DECLARE @ArticleId INT = $articleId
            DECLARE @CustomerGroups VARCHAR(100) =  '$customerGroups'
            DECLARE @GroupList TABLE (GroupName VARCHAR(50))

            -- Split the @CustomerGroups into individual group names and into a table
            WHILE LEN(@CustomerGroups) > 0
            BEGIN
                DECLARE @CommaIndex INT
                SET @CommaIndex = CHARINDEX(',', @CustomerGroups)
                IF @CommaIndex = 0
                BEGIN
                    INSERT INTO @GroupList (GroupName) VALUES (LTRIM(RTRIM(@CustomerGroups)))
                    SET @CustomerGroups = ''
                END
                ELSE
                BEGIN
                    INSERT INTO @GroupList (GroupName) VALUES (LTRIM(RTRIM(LEFT(@CustomerGroups, @CommaIndex - 1))))
                    SET @CustomerGroups = SUBSTRING(@CustomerGroups, @CommaIndex + 1, LEN(@CustomerGroups) - @CommaIndex)
                END
            END

            DECLARE @Results TABLE (ArtNummer VARCHAR(50), Preis FLOAT, KG VARCHAR(50))
            DECLARE @Group VARCHAR(50)
            DECLARE groupCursor CURSOR FOR SELECT GroupName FROM @GroupList
            OPEN groupCursor
            FETCH NEXT FROM groupCursor INTO @Group

            WHILE @@FETCH_STATUS = 0
            BEGIN
                INSERT INTO @Results (ArtNummer, Preis, KG)

                SELECT
                    art.ArtNummer,
                    art.VkNetto / 100.0 * (100.0 - rg.Rabatt),
                    @Group
                FROM
                    Artikel [art]
                    JOIN KonRgKG [rg] ON art.RabattGr = rg.Rg AND rg.KG = @Group
                WHERE
                    art.Id = @ArticleId

                FETCH NEXT FROM groupCursor INTO @Group
            END

            CLOSE groupCursor
            DEALLOCATE groupCursor

            SELECT KG [Name], 'EUR' [Waehrung], 0 [BruttoFlg], 1 [Staffel], 1.00 [MengeAb], Preis [Vk]
            FROM @Results
            ORDER BY ArtNummer, KG
"@

            if ($customerGroups) {
                [string]$sql = $sqlTierPriceSimulation
            } else {
                [string]$sql = $sqlTierPrice
            }

            $rs = $Null
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                # Creating a MemoryStream object to store the XML text
                $memoryStream = New-Object System.IO.MemoryStream

                # Use xmlWriterSettings to change the default settings of the xmlWriter
                $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
                $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
                # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
                $xmlWriterSettings.OmitXmlDeclaration = $true

                # Creating an XmlWriter object to write the XML structure
                $xmlWriter = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
                # Writing the XML structure with the XmlWriter object
                $xmlWriter.WriteStartElement('PREISLISTE')
                while (! $rs.eof) {
                    $xmlWriter.WriteStartElement('PREIS')

                    for ($i=0; $i -lt $rs.fields.count; $i++) {
                        [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                        [string]$nodeValue = [string]$rs.fields[$i].value
                        $xmlWriter.WriteElementString($nodeName,$nodeValue)
                    }

                    $xmlWriter.WriteEndElement()

                   $rs.movenext()
                }
                $xmlWriter.WriteEndElement()
                # Exiting the XmlWriter object
                $xmlWriter.Flush()
                $xmlWriter.Close()

                # Read memoryStream with streamreader
                $memoryStream.Position = 0
                $streamReader = New-Object System.IO.StreamReader($memoryStream)
                [string]$result = $streamReader.ReadToEnd()
            }
        }

        catch {
            if ($Error.Count -gt 0) {
                $line = $myInvocation.ScriptLineNumber - 1
                Throw ((Get-ResStr 'EXCEPTION_GENERAL_EXT') -f $_, $($myInvocation.Mycommand), $($line), $($Error[0].Exception.Message) )
            } else {
                Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
            }
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaTierPrice -articleNo '1100' -customerGroups 'HA,HB,HC' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

function Hide-Extensions {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        Push-Location
        Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
        if ((Get-ItemProperty .).HideFileExt -eq 0) {
            Set-ItemProperty . HideFileExt 1
            Start-Sleep -Milliseconds 500
            Update-Desktop
        }
        Pop-Location
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Hide-Extensions
}

function Import-ArticleFromXml {
    param(
        [string]$xml
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathXML -path $_  })]
        [string]$path
        ,
        [switch]$cuSurcharge
        ,
        [switch]$show
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        if ($path) {
            [xml]$xml = Get-Content -Path $path
        } else {
            [xml]$xml = $xml
        }

        $rs = new-object -comObject ADODB.Recordset
        $rs.CursorLocation = $adUseClient

        # ------------------------------------------------
        # HANDLE READONLY FIELDS
        # ------------------------------------------------
        $readOnlyFields = Get-ReadOnlyFields -conn $myConn -tablename 'Artikel'

        # We dont support these field in this moment
        $readOnlyFields += 'BasisArtikelId', 'ChargenPflichtFlg', 'HauptLieferantID', 'HerstellerID', `
            'IdentTyp', 'KasseVorfallTyp', 'LangtextRevision', 'Locked', 'LoeschFlg', 'Multi', 'MwStGr', `
            'MwstSatz', 'ProduktManagerId', 'Revision', 'SNPflichtFlg', 'Sperre_Lager', 'Stamp', `
            'StatistikArtikelId', 'StatistikFlg', 'Status', 'StkLstProdFlg', 'StueckMulti', 'Typ', `
            'VarianteFlg', 'VarianteHauptArtikelId', 'VarianteHauptFlg', 'VertreterID'

        # We are making special handlings with these price fields
        $readOnlyFields = $readOnlyFields | Where-Object { $_ -ne "VKNETTO" -and $_ -ne "VKBRUTTO" }

        $readOnlyFields = $readOnlyFields | Select-Object -Unique

        # ------------------------------------------------
        # HANDLE OTHER STUFF
        # ------------------------------------------------

        # If only this fields are in an XML then it is a pricelist update
        $pricelistProperties = @("ARTNUMMER", "EKNETTO", "VKNETTO", "VKBRUTTO", "BRUTTOFLG", "VK", "EK2NETTO")


        # ------------------------------------------------
        # FILL ALL GROUPS TO ENHANCE PERFORMANCE
        # ------------------------------------------------
        $RabattGr = New-Object -TypeName 'System.Collections.Generic.HashSet[string]'([StringComparer]::InvariantCultureIgnoreCase)
        $rs = $myConn.Execute('SELECT GR FROM KonRG')
        while(-not $rs.EOF) {
            $RabattGr.Add($rs.Fields.Item(0).Value) | Out-Null
            $rs.MoveNext()
        }
        $rs.Close()

        $WarenGr = New-Object -TypeName 'System.Collections.Generic.HashSet[string]'([StringComparer]::InvariantCultureIgnoreCase)
        $rs = $myConn.Execute('SELECT GR FROM KonWG')
        while(-not $rs.EOF) {
            $WarenGr.Add($rs.Fields.Item(0).Value) | Out-Null
            $rs.MoveNext()
        }
        $rs.Close()

        $MengenEh = New-Object -TypeName 'System.Collections.Generic.HashSet[string]'([StringComparer]::InvariantCultureIgnoreCase)
        $rs = $myConn.Execute('SELECT GR FROM KonMengenEh')
        while(-not $rs.EOF) {
            $MengenEh.Add($rs.Fields.Item(0).Value) | Out-Null
            $rs.MoveNext()
        }
        $rs.Close()

        $ErloesGr = New-Object -TypeName 'System.Collections.Generic.HashSet[string]'([StringComparer]::InvariantCultureIgnoreCase)
        $rs = $myConn.Execute('SELECT ErloesGR FROM KonErloesKonto')
        while(-not $rs.EOF) {
            $ErloesGr.Add($rs.Fields.Item(0).Value) | Out-Null
            $rs.MoveNext()
        }
        $rs.Close()



        if ($show) {
            try {
                $totalItems = $xml.EULANDA.ARTIKELLISTE.ARTIKEL.count
            } catch {
                $totalItems = 1
            }
            $currentItem = 0
            $item = [string]""
        }

        foreach($article in $xml.EULANDA.ARTIKELLISTE.ARTIKEL) {

            # ------------------------------------------------
            # IGNORE NODE WITHOUT UNIQUE KEY
            # ------------------------------------------------
            if ($article.PSObject.Properties.Name -contains "ARTNUMMER") {
                $articleNo = $article.ARTNUMMER
                $id = Get-ArticleId -articleNo $articleNo -conn $myConn
            } else {
                ARTICLENO_MISSING_IN_XML
                Write-Error ((Get-ResStr 'ARTICLENO_MISSING_IN_XML') -f  $myInvocation.Mycommand) -ErrorAction Continue
                Continue
            }

            if ($show) {
                $currentItem++
                $percentage = ($currentItem / $totalItems) * 100
                $item = $articleNo
                Write-Progress `
                    -Activity (Get-ResStr 'PROGBAR_XML_PROMPT') `
                    -Status ((Get-ResStr 'PROGBAR_XML_STATUS') -f $item, $currentItem, $totalItems) `
                    -PercentComplete $percentage
            }


            # ------------------------------------------------
            # CHECK IF IT IS ONLY AN PRICELIST UPDATE
            # ------------------------------------------------
            $articleChildNodes = $article.ChildNodes | Select-Object -ExpandProperty Name
            if ((@($articleChildNodes | Where-Object {$_ -notin $pricelistProperties})).Count -gt 0) {
                $onlyUpdateAllowed = $false
            } else {
                $onlyUpdateAllowed = $true
            }


            # ------------------------------------------------
            # NEW OR UPDATE
            # ------------------------------------------------
            if ($id) {
                # if we found an article we wont to update prices or an article
                $rs.Open("SELECT TOP 1 * FROM Artikel WHERE ID = $id", $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
            } else  {
                if (! $onlyUpdateAllowed) {
                    $rs.Open("SELECT TOP 0 * FROM Artikel", $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
                    $rs.AddNew()
                    $rs.fields('ARTNUMMER').value = Convert-Accent -value $articleNo -strCase 'upper'
                } else {
                    # A price was found, but the article does not exist
                    # We do not want to insert an article with only prices
                    continue
                }
            }

            # ------------------------------------------------
            # PROCESS ANY XML NODE
            # ------------------------------------------------
            foreach ($node in $articleChildNodes) {
                if ((-not ($readOnlyFields -icontains $node)) -and (-not ($node -ieq 'ARTNUMMER'))) {
                    if (-not [string]::IsNullOrEmpty($article.$node)) {

                        # some special handlings
                        if ($node -ieq 'ARTMATCH') {
                            $rs.fields($node).value = Convert-Accent -value $article.$node -strCase 'upper'
                        } elseif ($node -ieq 'VK') {
                            $rs.fields('VK').value = $article.$node
                            # if not special BRUTTOFLG is found it is a price without VAT
                            if (-not ($article.PSObject.Properties.Name -contains 'BRUTTOFLG')) {
                                $rs.fields('BruttoFlg').value = 0
                            }
                        } elseif ($node -ieq 'VKNETTO') {
                            $rs.fields('VK').value = $article.$node
                            $rs.fields('BruttoFlg').value = 0
                        } elseif ($node -ieq 'VKBRUTTO') {
                            $rs.fields('VK').value = $article.$node
                            $rs.fields('BruttoFlg').value = 1
                        } elseif ($node -ieq 'VERPACKEH') {
                            if ($MengenEh.Contains($article.$node)) {
                                if ($article.$node -gt 1) {
                                    $rs.fields($node).value = $article.$node
                                } else {
                                    $rs.fields($node).value = 1
                                }
                            }
                        } elseif ($node -ieq 'MENGENEH') {
                            if ($MengenEh.Contains($article.$node)) {
                                $rs.fields($node).value = $article.$node
                            }
                        } elseif ($node -ieq 'WARENGR') {
                            if ($WarenGr.Contains($article.$node)) {
                                $rs.fields($node).value = $article.$node
                            }
                        } elseif ($node -ieq 'ERLOESGR') {
                            if ($ErloesGr.Contains($article.$node)) {
                                $rs.fields($node).value = $article.$node
                            }
                        } elseif ($node -ieq 'RABATTGR') {
                            if ($RabattGr.Contains($article.$node)) {
                                $rs.fields($node).value = $article.$node
                            }
                        }
                        else {
                            $rs.fields($node).value = $article.$node
                        }
                    }
                }
            }

            # ------------------------------------------------
            # POST PROCESS e.g. COPPER SURCHARGE
            # ------------------------------------------------
            if ($cuSurcharge) {
                if ($rs.fields('USERN3').value -gt 0.001) {
                    $priceUnit = $rs.fields('PREISEH').value
                    if (! $priceUnit) {
                        $priceUnit = 1
                        $rs.fields('PREISEH').value = $priceUnit
                    }
                    # Copper surchagre must be multiplied, because it is a per unit price
                    if ($priceUnit -gt 1.001) {
                        $surcharge = [float]($rs.fields('PREISEH').value * $rs.fields('USERN3').value)
                    } else {
                        $surcharge = [float]$rs.fields('USERN3').value
                    }
                    $price = [float][math]::Round(($rs.fields('VK').value + $surcharge), 2)
                    $rs.fields('VK').value = [float]$price
                    $price = [float][math]::Round(($rs.fields('EKNetto').value + $surcharge), 2)
                    $rs.fields('EkNetto').value = [float]$price
                }
            }

            $rs.Update()
            $rs.Close()
        }
        $myConn.Close()

        if ($show) {
            Write-Progress -Activity (Get-ResStr 'PROGBAR_XML_PROMPT') -Completed
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Tets:  Import-ArticleFromXml -xml $xml -udl 'C:\temp\Eulanda_1 JohnDoe.udl' -cuSurcharge
}

function Import-TieredPrices {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [Alias('barcode')]
        [string]$barcodeName
        ,
        [Parameter(Mandatory = $false)]
        [Alias('articleNo')]
        [string]$articleNoName
        ,
        [Parameter(Mandatory = $false)]
        [Alias('articleId')]
        [string]$articleIdName
        ,
        [Parameter(Mandatory = $false)]
        [Alias('articleUid')]
        [string]$articleUidName
        ,
        [Alias('price1')]
        [string]$price1Name
        ,
        [Alias('qty1')]
        [string]$qty1Name
        ,
        [Alias('price2')]
        [string]$price2Name
        ,
        [Alias('qty2')]
        [string]$qty2Name
        ,
        [Alias('price3')]
        [string]$price3Name
        ,
        [Alias('qty3')]
        [string]$qty3Name
        ,
        [Alias('price4')]
        [string]$price4Name
        ,
        [Alias('qty4')]
        [string]$qty4Name
        ,
        [Alias('price5')]
        [string]$price5Name
        ,
        [Alias('qty5')]
        [string]$qty5Name
        ,
        [string]$priceList
        ,
        [int]$priceListId
        ,
        [Alias('delim')]
        [string]$csvDelimiter = ';'
        ,
        [Alias('decimal')]
        [string]$decimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
        ,
        [string]$path
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams 'articleNoName','articleIdName','Barcode','articleUid' @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'row' -Scope 'Private' -Value ($null)
        New-Variable -Name 'qty' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'priceQtyPairs' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'price' -Scope 'Private' -Value ([double]0.0)
        New-Variable -Name 'pair' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileExtension' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'data' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'barcode' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'artId' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'articleUid' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'articleNo' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'articleId' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Group values to a hash table
        $priceQtyPairs = @{
            "1" = @{ "price" = $price1Name; "qty" = $qty1Name }
            "2" = @{ "price" = $price2Name; "qty" = $qty2Name }
            "3" = @{ "price" = $price3Name; "qty" = $qty3Name }
            "4" = @{ "price" = $price4Name; "qty" = $qty4Name }
            "5" = @{ "price" = $price5Name; "qty" = $qty5Name }
        }

        $myConn = Get-Conn -udl $udl -connStr $connStr -conn $conn
        if ($priceList) {
            $rs = $myConn.execute("SELECT ID FROM Preisliste where [Name] = '$priceList'")
            [int]$priceListId = $rs.fields('ID').Value
        }

        if ($priceListId) {
            $fileExtension = [System.IO.Path]::GetExtension($path)
            switch ($fileExtension) {
                ".csv" {
                    $data = Import-Csv -Path $path -Delimiter $csvDelimiter
                }

                ".xlsx" {
                    if ([bool](Get-Module -ListAvailable -Name ImportExcel)) {
                        Import-Module ImportExcel
                        $data = Import-Excel -Path $path
                    } else {
                        Throw ((Get-ResStr 'IMPORTEXCEL_NOTFOUND') -f $myInvocation.Mycommand)
                    }
                }

                default {
                    Throw ((Get-ResStr 'ONLY_CSV_AND_XSLX_SUPPORTED') -f $myInvocation.Mycommand)
                }
            }

            if (! $decimalSeparator) {
                $decimalSeparator = ','
            }

            foreach ($row in $data) {
                $articleNo = [string]""
                $articleId = [int]0
                $barcode = [string]""
                $articleUid = [string]""

                $params = @{}
                if ($articleNoName) {
                    $articleNo = [string]$row.$($articleNoName)
                    $params.Add('articleNo', $articleNo)
                } elseif ($articleIdName) {
                    $articleId = [int]$row.$($articleIdName)
                    $params.Add('articleId', $articleId)
                } elseif ($BarcodeName) {
                    $barcode = [string]$row.$($barcodeName)
                    $params.Add('Barcode', $Barcode)
                } elseif ($articleUidName) {
                        $articleUid = [string]$row.$($articleUidName)
                        $params.Add('articleUid', $articleUid)
                } else {
                    Throw ((Get-ResStr 'PARAMS_AT_LEAST_ONE') -f 'articleNoName, articleIdName, BarcodeName, articleUidName', $myInvocation.Mycommand)
                }

                $artId = Get-ArticleId @params -conn $myConn
                if ($artId) {
                    for ($i = 1; $i -le 5; $i++) {
                        $pair = $priceQtyPairs["$i"]
                        if (![string]::IsNullOrEmpty($pair['price']))  {
                            $price = $row.$($pair['price'])
                            if ([string]::IsNullOrEmpty($pair['qty'])) {
                                $qty = [string]"1"
                            } else {
                                $qty = [string]$row.$($pair['qty'])
                            }

                            # csv is string based excel normally double
                            if ($decimalSeparator -eq ".") {
                                if ($price.GetType.Name -eq 'String') {
                                    $price = [double]::Parse($price.Replace(',', '.'))
                                }

                                if ($qty.GetType.Name -eq 'String') {
                                    $qty = [double]::Parse($qty.Replace(',', '.'))
                                }
                            }
                            else {
                                if ($price.GetType.Name -eq 'String') {
                                    $price = [double]::Parse($price.Replace('.', ','))
                                }
                                if ($qty.GetType.Name -eq 'String') {
                                    $qty = [double]::Parse($qty.Replace('.', ','))
                                }
                            }

                            try {
                                Write-Verbose "ArticleNo: $articleNo"
                                $rs = New-Object -comobject ADODB.Recordset
                                $sql = "SELECT p.Id, p.Preisliste, p.Staffel, p.MengeAb, p.ArtikelId, p.Vk FROM Preis p " + `
                                "JOIN Artikel art ON art.Id = p.ArtikelId AND PreisListe = $priceListId AND art.ID = $artId " + `
                                "AND Staffel = $i"
                                $rs.Open($sql, $myConn, 3, 3)
                                if (! $rs.eof) {
                                    $rs.fields('Vk').value = [double]$price
                                    $rs.fields('MengeAb').value = [double]$qty
                                    $rs.update()
                                } else {
                                    $rs.AddNew()
                                    $rs.fields('Preisliste').value = $priceListId
                                    $rs.fields('Staffel').value = $i
                                    $rs.fields('ArtikelId').value = $artId
                                    $rs.fields('Vk').value = [double]$price
                                    $rs.fields('MengeAb').value = [double]$qty
                                    $rs.update()
                                }
                            }

                            catch {
                                Write-Error -Message $_.Exception -ErrorAction Continue
                            }
                        } # if actual price
                    } # for each 1-5 tired price
                } # if article
            }  # for each row im import file
        }  else {
            Throw ((Get-ResStr 'PARAMS_AT_LEAST_ONE') -f 'priceList, priceListId', $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Import-TieredPrices -path 'C:\temp\test.xslx' -articleNo 'ArticleNo' -price1 'SalesPrice' -priceList 'Retail' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
}

Function Install-SignTool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$signToolBasePath= "$env:TEMP"
        ,
        [Parameter(Mandatory = $false)]
        [string]$isoBasePath= "$env:TEMP"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateUrl -Url $_ })]
        [string]$url = "https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/"
        ,
        [Parameter(Mandatory = $false)]
        [switch]$leaveIso
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noBuild
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noInstall
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'build' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'cookieContainer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'downloadLink' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'filename' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'headers' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'installer' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'isoDrive' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'isoPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'link' -Scope 'Private' -Value ($null)
        New-Variable -Name 'response' -Scope 'Private' -Value ($null)
        New-Variable -Name 'signToolPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sourcePath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'StorageHistoryCharts' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [hashtable]$headers = @{"User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36 Edge/16.16299"}

        # ------------------------
        # Download Link
        # ------------------------
        $response = Invoke-WebRequest -uri $url -Headers $headers -UseDefaultCredentials -UseBasicParsing -SessionVariable cookieContainer
        [string]$downloadLink= $null
        foreach ($link in $response.Links) {if ($link.outerHTML -match "Download the \.iso") {$downloadLink = $link.href; break } }

        # ------------------------
        # Download Iso
        # ------------------------
        if ($downloadLink) {
            $response = Invoke-WebRequest -uri $downloadLink -Headers $headers -Method Head -UseBasicParsing -SessionVariable cookieContainer
            [string]$filename = $response.Headers['Content-Disposition'].Split('; ')[1].Split('=')[1]
            [string]$build= $filename.Split('.')[0]
            [string]$isoPath= "$isoBasePath\$filename"
            # Invoke-WebRequest -uri $downloadLink -Headers $headers -UseBasicParsing -SessionVariable cookieContainer -OutFile "$isoPath"
            Write-Host -NoNewline ((Get-ResStr 'DOWNLOADING_WINSDK')) -ForegroundColor Blue
            (New-Object System.Net.WebClient).DownloadFile($downloadLink, $isoPath)
            Write-Host " $(Get-ResStr 'READY')"
        } else {
            throw ((Get-ResStr 'DOWNLOADLINK_MISSING'))
        }

        # ------------------------
        # Extract ISO
        # ------------------------
        Mount-DiskImage -ImagePath $isoPath -StorageType ISO | Out-Null
        [string]$isoDrive = (Get-Volume -FriendlyName "KSDK*" | Select-Object -ExpandProperty DriveLetter) + ":\"
        [string]$sourcePath = "$isoDrive\Installers"
        if ($noBuild) {
            [string]$signToolPath = "$signToolBasePath\Signtool"
        } else {
            [string]$signToolPath = "$signToolBasePath\Signtool($build)"
        }
        if (! (Test-Path $signToolPath )) {
            New-Item -ItemType Directory -Path $signToolPath -force | Out-Null
        }
        [string]$installer= "Windows SDK Signing Tools-x86_en-us.msi"
        if (! (Test-path "$sourcePath\$installer")) {
            [string]$installer= "Windows SDK Signing Tools-x86_en-us.exe"
        }

        # Extracting Items
        Copy-Item "$sourcePath\$installer" $signToolPath -force
        Copy-Item "$sourcePath\4c3ef4b2b1dc72149f979f4243d2accf.cab" $signToolPath -force
        Copy-Item "$sourcePath\685f3d4691f444bc382762d603a99afc.cab" $signToolPath -force
        Copy-Item "$sourcePath\e5c4b31ff9997ac5603f4f28cd7df602.cab" $signToolPath -force
        Copy-Item "$sourcePath\e98fa5eb5fee6ce17a7a69d585870b7c.cab" $signToolPath -force

        Dismount-DiskImage -ImagePath $isoPath | Out-Null
        if (! $leaveIso) {
            Remove-Item $isoPath -Force
        }

        # ------------------------
        # Install SignTool
        # ------------------------
        if (! $noInstall) {
            $msiPath = "$signToolPath\$installer"
            $arguments = "/i `"$msiPath`" /qn"
            Start-Process msiexec.exe -ArgumentList $arguments -Wait -Verb RunAs

            Remove-Item -Path "$signToolPath\*.cab" -Force
            Remove-Item -Path "$signToolPath\$installer" -Force
            Remove-Item -Path "$signToolPath" -Force
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Install-SignTool -leaveIso -noInstall
}

function Merge-IpGeoInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$xmlFile1 = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'xmlFile1', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$xmlFile2 = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'xmlFile2', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$outputFile = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'outputFile', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ipGeoInfos1' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ipGeoInfos2' -Scope 'Private' -Value ($null)
        New-Variable -Name 'mergedIpGeoInfos' -Scope 'Private' -Value ([System.Collections.Hashtable]::new())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Deserialize XML files into objects
        $ipGeoInfos1 = Import-Clixml -Path $xmlFile1
        $ipGeoInfos2 = Import-Clixml -Path $xmlFile2

        # Add all entries from the first set to the result
        foreach ($info in $ipGeoInfos1) {
            $mergedIpGeoInfos[$info.IP] = $info
        }

        # Merge the second set into the result
        foreach ($info in $ipGeoInfos2) {
            if (-not $mergedIpGeoInfos.ContainsKey($info.IP) -or
                ($mergedIpGeoInfos.ContainsKey($info.IP) -and $mergedIpGeoInfos[$info.IP].ChangeDate -lt $info.ChangeDate)) {
                $mergedIpGeoInfos[$info.IP] = $info
            }
        }
    }

    end {
        # Serialize the merged data back into an XML file
        $mergedIpGeoInfos.Values | Export-Clixml -Path $outputFile
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Merge-IpGeoInfo -xmlFile1 'path\to\file1.xml' -xmlFile2 'path\to\file2.xml' -outputFile 'path\to\output.xml'
}

function New-ConnStr {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$database = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'database', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [string]$password
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (($user) -and ($password)) {
            [string]$result = `
                "Provider=SQLOLEDB.1;Data Source=$server;Initial Catalog=$database;" +`
                "Persist Security Info=True;User ID=$user;Password=$password"
        } else {
            [string]$result = "Provider=SQLOLEDB.1;Data Source=$server;Initial Catalog=$database;Integrated Security=SSPI"
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  New-ConnStr -database 'EULANDA_Truccamo' -Server '.\SQL2019'
}

function New-Delivery {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$salesOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$salesOrderId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$customerOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleSalesOrderKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsSalesOrder' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'relevantError' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [int]$result = 0
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsSalesOrder = Get-UsedParameters -validParams (Get-SingleSalesOrderKeys) -boundParams $PSBoundParameters
        $salesOrderId = Get-SalesOrderId @paramsSalesOrder -conn $myConn
        try {
            $sql = @"
                SET NOCOUNT ON
                DECLARE @Af_Id int
                DECLARE @Lf_Id int
                SET @Af_Id = $salesOrderId
                EXEC dbo.cn_TraAfLf_SingleAf @Lf_Id=@Lf_Id OUT, @af_id=@Af_Id
                SELECT @Lf_Id [Id]
"@
            $rs = new-object -comObject ADODB.Recordset
            $rs.CursorLocation = $adUseClient
            $rs.Open($sql, $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                if (! $rs.eof) {
                    [int]$result = $rs.fields('Id').value
                }
            } else {
                Throw ((Get-ResStr 'RECORDSET_CLOSED') -f $($myInvocation.MyCommand), $sql)
            }
        }

        catch {
            $relevantError = Get-ErrorFromConn -conn $myConn
            Throw ((Get-ResStr 'ADO_ERROR_EXT') -f $_, $relevantError)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  New-Delivery -salesOrderNo 131 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function New-DeliveryPropertyItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$propertyId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'propertyId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        if ($deliveryId) {
            [string]$sqlFrag = "Id = $deliveryId"
        } else {
            [string]$sqlFrag = "KopfNummer = $deliveryNo"
        }

        [string]$sql = @"
            DECLARE @KopfId INT;
            DECLARE @ObjektId INT;
            SELECT TOP 1 @ObjektId = ID FROM Lieferschein WHERE $sqlFrag;
            SET @KopfId = $propertyId;
            INSERT INTO MerkmalElement (KopfId, ObjektId)
            SELECT @KopfId, @ObjektId
            WHERE NOT EXISTS (SELECT 1 FROM MerkmalElement WHERE KopfId = @KopfId AND ObjektId = @ObjektId);
"@
        $myConn.Execute($sql) | out-null
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  New-DeliveryPropertyItem -deliveryNo 66 -propertyId 2710 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

class EulException : Exception {
    [string] $additionalData
    EulException($message, $additionalData) : base($message) {
        $this.additionalData = $additionalData
    }
}

function New-EulException {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$message
        ,
        [Parameter(Mandatory = $false)]
        $additionalData
    )

    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    return [EulException]::New($message,$additionalData)
}

Class EulLog : System.IDisposable  {
    [string]$filePath
    [string]$name

    EulLog($name, $path) {
        $this.Name = $name
        $this.FilePath = $this.ChkPath($path)
        $this.Put('Initialization')
    }

    [void]Dispose() {
        $this.Put('Finalization')
    }

    [string]Fname($name) {
        $monthYear = Get-Date -Uformat "%Y-%b"
        return "LOG_$name`_$monthYear.txt"
    }

    [string]ChkPath($path) {
        $fName = $this.Fname($this.name)
        if (!(Get-Content "$path\events\$fName")) {
            [void](New-Item -Path "$path\events\$fName" -ItemType File -Force)
        }
        return "$path\events\$fName"
    }

    # main entry for logging an event
    [void]Put($level, $group, $message) {
        $now = (Get-Date).tostring("yyyy-MM-dd HH:mm:ss")
        if (! (test-path variable:global:ecProcessId)) {
            $global:ecProcessId = "$([System.Guid]::NewGuid())"
        }
        $delim = "`t"
        $log= "{1}{0}{2}{0}{3}{0}{4}{0}{5}{0}{6}" -f $delim, $now, ($this.name), $global:ecProcessId,  $level,  $group,  $message
        Write-Verbose $log
        [int]$maxRetries = 30
        [int]$i = 0
        while ($i -lt $maxRetries) {
            try {
                $log | Out-File -FilePath $this.filePath -Append -NoClobber
                $i = $maxRetries
            }
            catch {
                $i++
                Write-Verbose ((Get-ResStr 'LOGFILE_RETRY') -f $_, $log, $i, $maxRetries)
                Start-Sleep -Seconds 0.1
            }
        }
    }

    # short way to log an event
    [void]Put($level, $message) {
        $this.Put($level,'(default)',$message)
    }

    # shortest way to log an event
    [void]Put($message) {
        $this.Put(0,'(default)',$message)
    }
}

function New-EulLog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$name = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'name', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
    return [EulLog]::New($name, $path)
}

function New-PurchaseOrder {
    [CmdletBinding()]
    param(
        [int]$supplierID
        ,
        [string]$processedBy
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $cmd = New-Object -ComObject ADODB.Command
        $cmd.ActiveConnection = $myConn
        $cmd.CommandType = 4 #adCmdStoredProc
        $cmd.CommandText = "[dbo].[cn_KfNew]"

        $cmd.Parameters.Append(($cmd.CreateParameter("@KreditorId", 3, 1,4, $supplierID))) #adInteger
        $cmd.Parameters.Append(($cmd.CreateParameter("@KopfId", 3, 2))) #adInteger, adParamOutput
        $cmd.Parameters.Append(($cmd.CreateParameter("@KopfNummer", 200, 2, 255))) #adVarWChar, adParamOutput
        $cmd.Parameters.Append(($cmd.CreateParameter("@BearbeitetDurch", 200, 1, 255, $processedBy))) #adVarWChar

        $cmd.Execute() | Out-Null

        $result = $cmd.Parameters.Item("@KopfId").Value

        if ($result) {
            $PurchaseOrderNo = Get-NewNumberFromSeries -seriesName 'KrAuftrag' -conn $myConn
            $sql = "UPDATE KrAuftrag SET KopfNummer = $PurchaseOrderNo WHERE ID = $result"
            $myConn.Execute($sql) | Out-Null
        }
        <#
            # Actually we dont need that field
            $output = @{
                KopfId = $cmd.Parameters.Item("@KopfId").Value
                KopfNummer = $cmd.Parameters.Item("@KopfNummer").Value
            }
        #>
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: $id = New-PurchaseOrder -supplierID 15 -processedBy robot -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
}

function New-PurchaseOrderLineItem {
    [CmdletBinding()]
    param(
        [int]$purchaseOrderId
        ,
        [int]$purchaseOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [decimal]$quantity
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $result = 0

        if (! $purchaseOrderId) {
            $sql = "SELECT Id FROM KrAuftrag WHERE KopfNummer = $purchaseOrderNo"
            $rs =  $myConn.Execute($sql)
            if ($rs -and !$rs.EOF) {
                $purchaseOrderId = $rs.Fields('Id').Value
            }
            if (! $purchaseOrderId) {
                Throw ((Get-ResStr 'PURCHASEORDER_NOT_FOUND') -f $myInvocation.Mycommand)
            }
        }

        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        $articleId = Get-ArticleId @paramsArticle -conn $myConn
        if (! $articleId) {
            Throw ((Get-ResStr 'ARTCILEID_NOT_FOUND') -f $myInvocation.Mycommand)
        }

        $cmd = New-Object -ComObject ADODB.Command
        $cmd.ActiveConnection = $myConn
        $cmd.CommandType = 4 #adCmdStoredProc
        $cmd.CommandText = "[dbo].[cn_KfpNew]"

        $cmd.Parameters.Append(($cmd.CreateParameter("@KopfId", 3, 1,4, $purchaseOrderId))) #adInteger
        $cmd.Parameters.Append(($cmd.CreateParameter("@ArtikelId", 3, 1,4, $articleId))) #adInteger
        $cmd.Parameters.Append(($cmd.CreateParameter("@AutoAddKrArtikel", 11, 1, 1, 0))) #adBoolean, setting it to False
        $cmd.Parameters.Append(($cmd.CreateParameter("@Menge", 5, 1,4, $quantity))) #adDouble

        $cmd.Execute() | Out-Null

        $sql = "SELECT MAX(Id) AS LastId FROM KrAuftragPos WHERE KopfId = $purchaseOrderId"
        $rs =  $myConn.Execute($sql)
        if ($rs -and !$rs.EOF) {
            $result = $rs.Fields('LastId').Value
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: $id = New-PurchaseOrderLineItem -purchaseOrderId 200 -articleId 123 -quantity 5 -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
}

Function New-RemoteFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                New-SftpFolder -server $server -port $port -certificate $certificate -user $user -password $password -remoteFolder $remoteFolder
            } else {
                New-FtpFolder -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  New-RemoteFolder -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -verbose
}


function New-SalesOrder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$invoiceAddressId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'invoiceAddressId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        # Create an empty sales order head
        [string]$sql = "SET NOCOUNT ON`r`n" +`
            "DECLARE @Af_Id int`r`n" +`
            "DECLARE @Ad_Id int`r`n" +`
            "SET @Ad_Id = $invoiceAddressId`r`n" +`
            "EXEC dbo.cn_CreAf @Af_Id = @Af_Id out, @Ad_Id = @Ad_Id`r`n" +`
            "SELECT @Af_Id [Id]"

        $rs = new-object -comObject ADODB.Recordset
        $rs.CursorLocation = $adUseClient
        $rs.Open($sql, $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)

        # Toggle all record sets until you find an open one
        Do {
            If ($rs.State -ne $adStateOpen) {
                $rs = $rs.NextRecordset()
            }
        } until ( (! $rs) -or ($rs.State -eq $adStateOpen) )

        # Get the id of the new order
        if (! $rs.eof) {
            [int]$result = $rs.fields('Id').value
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  New-SalesOrder -invoiceAddressId 3 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function New-Shortcut {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$file = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'file', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$link = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'link', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'shortcut' -Scope 'Private' -Value ($null)
        New-Variable -Name 'wshShell' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! (Test-Path $link)) {
                if (Test-Path $file) {
                    $wshShell = New-Object -comObject WScript.Shell
                    $shortcut = $wshShell.CreateShortcut($link)
                    $shortcut.TargetPath = $file
                    $shortcut.Save()
                } else {
                    throw ((Get-ResStr 'NO_FILE_FOR_SHORTCUT') -f $file, $($myInvocation.MyCommand))
                }
            }
        }

        catch {
            if ($ErrorActionPreference -eq "SilentlyContinue") {
                # do nothing
            } elseif ($ErrorActionPreference -eq "Stop") {
                throw $_.Exception.Message
            } else {
                Write-Host $_.Exception.Message -ForegroundColor Red
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  New-Shortcut -file 'C:\Temp\eulanda.exe' -link "$(Get-DesktopDir)\MyEulanda.lnk -ErrorAction Continue"
}

function New-Snapshot {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if ($_ -match "^[a-zA-Z]:$") {
                if (Test-Path $_) {
                    $true
                }
                else {
                    throw (( Get-ResStr 'DRIVE_NOT_EXISTS') -f $_, $myInvocation.Mycommand)
                }
            }
            else {
                throw (( Get-ResStr 'DRIVE_FORMAT_ERROR') -f 'volume', $myInvocation.Mycommand)
            }
        })]
        [string]$volume = $($ENV:SystemDrive)
        ,
        [Parameter(Mandatory = $false)]
        $symbolicLink = "$volume\ecSnapshot"
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'snapshot' -Scope 'Private' -Value ($null)
        New-Variable -Name 'snapshotPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (Test-Administrator) {
            Write-Verbose ((Get-ResStr 'VERBOSE_SNAPSHOT_CREATING') -f $volume, $symbolicLink)
            $snapshot = Invoke-CimMethod -ClassName Win32_ShadowCopy -MethodName Create -Arguments @{Volume = "$volume\"}
            $snapshotPath = (Get-CimInstance -ClassName Win32_ShadowCopy | Where-Object { $_.ID -eq $snapshot.ShadowID }).DeviceObject
            if (! ($snapshotPath.EndsWith('\'))) {
                $snapshotPath += '\'
            }

            # If for some reason exists from prior operations
            Remove-SymbolicLink -symbolicLink $symbolicLink

            # The output as function result must be prevented
            # $cmdOutput = Invoke-Expression -Command "cmd /c mklink /d '$symbolicLink' '$snapshotPath'"
            # Write-Verbose $cmdOutput
            New-SymbolicLink -symbolicLink $symbolicLink -target $snapshotPath

            $result = [PSCustomObject]@{
                shadowId = $snapshot.ShadowID
                volume = $volume
                snapshotPath = $snapshotPath
                symbolicLink = $symbolicLink
            }
        } else {
            throw ((Get-ResStr 'ADMIN_RIGHTS_NEEDED') -f $myInvocation.MyCommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $result
    }
    # Test:   $snap = NewSnapshot
}

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

function New-Table {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$tableName = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tableName', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$columnNames = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'columnNames', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'count' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($columnNames.GetType().Name -eq "String") {
            [string[]]$columnNames = $columnNames.split(',')
        } elseif ($columnNames.GetType().BaseType.Name -ne "Array") {
            throw ((Get-ResStr 'COLUMNNAMES_STRING_ONLY') -f $myInvocation.Mycommand)
        }

        $tempTable = New-Object System.Data.DataTable

        if ($columnNames.count -ne 0) {
            do {
                Remove-Variable -Name datatype -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                $tempTable.Columns.Add() | Out-Null
                if ($columnNames[$count] -like "*/?*") {
                    $datatype = $columnNames[$count].Substring($columnNames[$count].IndexOf("/?")+2)
                    if ($datatype -eq 'int') {$datatype = 'Int32'}
                    if ($datatype -eq 'long') {$datatype = 'Int64'}
                    $columnNames[$count] = $columnNames[$count].Substring(0,$columnNames[$count].IndexOf("/?"))
                    $tempTable.Columns[$count].DataType = "System.$datatype"
                }
                $tempTable.Columns[$count].ColumnName = $columnNames[$count]
                $tempTable.Columns[$count].Caption = $columnNames[$count]
                $count++
            } until ($count -eq $columnNames.Count)
        }
        Set-Variable -Name $tableName -Scope Global -Value (New-Object System.Data.DataTable)
        Set-Variable -Name $tableName -Scope Global -Value $tempTable
        Remove-Variable -Name TempTable -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  New-Table -tableName 'MyTable' -columnNames 'Name,Value/?Int'
}

function New-TempDir {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'name' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'parent' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $parent = [System.IO.Path]::GetTempPath()
        [string]$name = [System.Guid]::NewGuid()
        [string]$result = (Join-Path $parent $name)
        New-Item -ItemType Directory -Path $result | Out-Null
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: New-TempDir
}

function Open-Delivery {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsDelivery' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsDelivery = Get-UsedParameters -validParams (Get-SingleDeliveryKeys) -boundParams $PSBoundParameters
        $deliveryId = Get-DeliveryId @paramsDelivery -conn $myConn

        if ($deliveryId) {
            $sql = @"
                SET NOCOUNT ON;
                DECLARE @DeliveryId int
                SET @DeliveryId = $deliveryId
                EXEC dbo.cn_lfErfassen @lf_id=@DeliveryId
"@ }
        try {
            $myConn.Execute($sql) | out-null
        }

        catch {
            $relevantError = Get-ErrorFromConn -conn $myConn
            Throw "Error: $_! $relevantError"
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Open-Delivery -deliveryNo 69 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Out-Beep {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
    }

    process {
        [Console]::Beep()
    }

    end {
    }
    # Test: Out-Beep
}

function Out-Goodbye {
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $false)]
        [switch]$normally
        ,
        [parameter(Mandatory = $false)]
        [switch]$abnormally
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'duration' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        New-Variable -Name 'ecEndTime' -Scope 'Global'  -Option ReadOnly -Force -Value ([datetime](Get-Date)) -Description 'End time of EulandaConnect module'
        $duration = New-Timespan -end $ecEndTime -start $ecStartTime
        write-host ((Get-ResStr 'OUT_WELCOME_STARTTIME') -f $(Use-Culture -culture $ecCulture -script {$($ecStartTime.toString())})) -ForegroundColor Blue
        write-host ((Get-ResStr 'OUT_GOODBYE_ENDTIME') -f $(Use-Culture -culture $ecCulture -script {$($ecEndTime.toString())})) -ForegroundColor Blue
        Write-Host ((Get-ResStr 'OUT_GOODBYE_DURATION') -f $duration.TotalSeconds)  -ForegroundColor "blue"

        if ($normally) { Write-Host (Get-ResStr 'OUT_GOODBYE_NORMALLY') -ForegroundColor "blue" }
        if ($abnormally) { Write-Host (Get-ResStr 'OUT_GOODBYE_ABNORMALLY') -ForegroundColor "red" }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Out-Goodbye -normally
}

function Out-Welcome {
    [CmdletBinding()]
    Param (
        [parameter(Position = 0, Mandatory = $false)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ) {
                throw "File or folder '$_' does not exist!"
             } else {
                 $true
            }
        })]
        [ValidateScript({
            if($_ -notmatch "(\.ps1)") {
                throw "The file '$_' specified in the path argument must of type .ps1"
            } else {
                 $true
            }
        })]
        [string]$projectScript
        ,
        [parameter(Position = 1, Mandatory = $false)]
        [switch]$noBanner
        ,
        [parameter(Position = 2, Mandatory = $false)]
        [switch]$noInfo
        ,
        [parameter(Position = 3, Mandatory = $false)]
        [string]$culture
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'banner' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'cultureObj' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $banner = @"
              ________  ____    ___    _   ______  ___
             / ____/ / / / /   /   |  / | / / __ \/   |
            / __/ / / / / /   / /| | /  |/ / / / / /| |
           / /___/ /_/ / /___/ ___ |/ /|  / /_/ / ___ |
          /_____/\____/_____/_/  |_/_/ |_/_____/_/  |_|
             _____       ______
            / ___/____  / __/ /__      ______ _________
            \__ \/ __ \/ /_/ __/ | /| / / __  / ___/ _ \
           ___/ / /_/ / __/ /_ | |/ |/ / /_/ / /  /  __/
          /____/\____/_/  \__/ |__/|__/\__,_/_/   \___/

"@
        if (! $noBanner) {
            write-host $banner -ForegroundColor "blue"
        }

        New-Variable -Name 'ecStartTime' -Scope 'Global'  -Option ReadOnly -Force -Value ([datetime](Get-Date)) -Description 'Start time of EulandaConnect module'

        if (! $culture) {
            $culture = [System.Threading.Thread]::CurrentThread.CurrentCulture.Name
        } else {
            $cultureObj = [System.Globalization.CultureInfo]::GetCultureInfo($culture)
            [System.Threading.Thread]::CurrentThread.CurrentCulture = $cultureObj
            [System.Threading.Thread]::CurrentThread.CurrentUiCulture = $cultureObj
            New-Variable -Name 'ecCulture' -Scope 'Global' -Option ReadOnly -Force -Value ([string]$culture) -Description 'User language like en-US of EulandaConnect module'
        }

        if ($projectScript) {
            if ($PsVersionTable.PsVersion.Major -gt 5) {
                $leafBase = ([string](Split-Path -LeafBase $projectScript))
            } else {
                [string]$leafBase = (Get-Item $projectScript).BaseName
            }
            New-Variable -Name 'ecProjectName' -Scope 'Global'  -Option ReadOnly -Force -Value $leafBase -Description 'Project name using EulandaConnect module'
            New-Variable -Name 'ecProjectVersion' -Scope 'Global' -Option ReadOnly -Force -Value ([version](Read-VersionFromSynopsis -path $projectScript)) -Description 'Project version using for the EulandaConnect module'
        }

        Write-Verbose "$myInvocation.Mycommand $((get-module -Name EulandaConnect).path)"

        if (! $noInfo) {
            Write-Host  ( (Get-ResStr 'OUT_WELCOME_VERSION') -f $ecModuleName, $($ecModuleVersion.ToString()))  -ForegroundColor Blue
            Write-Host  ( (Get-ResStr 'OUT_WELCOME_COPYRIGHT') -f $($ecModuleCopyright))  -ForegroundColor Blue
            Write-Host  ( (Get-ResStr 'OUT_WELCOME_LICENSEURI') -f $($ecModuleLicenseURI)) -ForegroundColor Blue
            Write-Host  ( (Get-ResStr 'OUT_WELCOME_PATH') -f $($ecModulePath)) -ForegroundColor Blue
            write-host  ( (Get-ResStr 'OUT_WELCOME_STARTTIME') -f $(Use-Culture -culture $ecCulture -script {$($ecStartTime.toString())})) -ForegroundColor Blue
            if ($ecProjectVersion -gt [version]"0.0") {
                write-host  ( (Get-ResStr 'OUT_WELCOME_PROJECTVERSION') -f $($ecProjectName), $($ecProjectVersion.ToString())) -ForegroundColor Green
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Out-Welcome -culture 'en-US'
}

function Protect-String {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$plainText = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'plainText', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        $key = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'key', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'char' -Scope 'Private' -Value ($null)
        New-Variable -Name 'chars' -Scope 'Private' -Value ($null)
        New-Variable -Name 'securestring' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $key = Get-ProtectedKey $key
        $securestring = New-Object System.Security.SecureString
        $chars = $plainText.toCharArray()
        foreach ($char in $chars) {
            $secureString.AppendChar($char)
        }
        $result = ConvertFrom-SecureString -SecureString $secureString -Key $key
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Protect-String -plainText 'Hallo, i am John, John Doe!' -key 'MySpecialKey'
}

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

function Read-VersionFromSynopsis {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ) {
                throw ((Get-ResStr 'FILE_OR_FOLDER_DOES_NOT_EXIST') -f $_)
             } else {
                 $true
            }
        })]
        [ValidateScript({
            if($_ -notmatch "(\.ps1)") {
                throw ((Get-ResStr 'MUST_BE_PS1FILE') -f $_)
            } else {
                 $true
            }
        })]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(2, [int]::MaxValue)]
        [int]$maxLines = 250
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'arrSynopsis' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'content' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'endIndex' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'line' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'startIndex' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'synopsis' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [version]$result = "0.0"
        try {
            $content = Get-Content -Path $path -TotalCount $maxLines | Out-String
            $startIndex = $content.IndexOf(".NOTES")
            $endIndex = $content.IndexOf("#>") + 2
            if ($endIndex -gt $startIndex) {
                $synopsis = $content.Substring($startIndex, $endIndex - $startIndex)
                $arrSynopsis = $synopsis.Split("`n")
                foreach ($line in $arrSynopsis) {
                    if ($line.ToLower().Contains('version:')) {
                        [version]$result = $line.Substring($line.IndexOf(":") + 1).Trim()
                        break
                    }
                }
            }
        } catch { }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Read-VersionFromSynopsis -path '.\Debug.ps1'
}

Function Receive-RemoteFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeAge = 60*60*3
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeRetries = 7
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                Receive-SftpFile -server $server -port $port -certificate $certificate -user $user -Password $password -remoteFolder $remoteFolder -remoteFile $remoteFile -localFolder $localFolder -localFile $localFile
            } else {
                Receive-FtpFile -server $server -protocol $protocol -port $port -activeMode:$activeMode -resumeRetries $resumeRetries -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile  -localFolder $localFolder -localFile $localFile
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Receive-RemoteFile -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -localFolder 'C:\temp' -localFile 'newTest.txt'
}

function Remove-DeliveryPropertyItem {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$propertyId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'propertyId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        if ($deliveryId) {
            [string]$sqlFrag = "Id = $deliveryId"
        } else  {
            [string]$sqlFrag = "KopfNummer = $deliveryNo"
        }

        [string]$sql = @"
            DECLARE @KopfId INT;
            DECLARE @ObjektId INT;
            SELECT TOP 1 @ObjektId = ID FROM Lieferschein WHERE $sqlFrag;
            SET @KopfId = $propertyId;
            DELETE MerkmalElement WHERE KopfId = @KopfId AND ObjektId = @ObjektId;
"@
        $myConn.Execute($sql) | out-null
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Remove-DeliveryPropertyItem -deliveryNo 66 -propertyId 2710 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Remove-ItemWithRetry {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'retryCount' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'stopLoop' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $stopLoop = $false
        [int]$retryCount = "0"

        do {
            try {
                if (Test-Path $path) {
                    if ($path.ToUpper().IndexOf('\TEMP\')) {
                        Remove-Item -Path $path -Recurse -Force
                    } else {
                        Remove-Item -Path $path -Force
                    }
                }
                $stopLoop = $true
        } catch {
            if ($retryCount -gt 5) {
                Write-Host ((Get-ResStr 'REMOVE_FILE_ERROR') -f $($myInvocation.MyCommand), $path, $_) -foregroundcolor "red"
                $stopLoop = $true
                $Error.Clear()
        } else {
            $Error.Clear()
            Write-Verbose ((Get-ResStr 'REMOVE_FILE_RETRY') -f $path, $retryCount)
            Start-Sleep -Seconds 10
            $retryCount = $retryCount + 1
        } } }
        While ($stopLoop -eq $false)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Remove-ItemWithRetry -path 'C:\temp\readme.txt'
}

Function Remove-RemoteFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                Remove-SftpFile -server $server -port $port -certificate $certificate -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
            } else {
                Remove-FtpFile -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Remove-RemoteFile -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA'  -remoteFile 'Eulanda_JohnDoe.zip' -verbose
}

function Remove-RemoteFingerprint {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("sftp")]
        [string]$protocol = 'sftp'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($protocol -eq 'sftp') {
            if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
                Import-Module -Name POSH-SSH -global
                Remove-SSHTrustedHost -HostName $server
            } else {
                Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Remove-RemoteFingerprint -server 'myftp.eulanda.eu'
}

Function Remove-RemoteFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }
        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            try {
                if ($protocol -eq 'sftp') {
                    Remove-SftpFolder -server $server -port $port -certificate $certificate -user $user -password $password -remoteFolder $remoteFolder
                } else {
                    Remove-FtpFolder -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder
                }
            }
            catch {
                Throw ((Get-ResStr 'REMOTE_FOLDER_NOT_DELETED') -f $_)
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Remove-RemoteFolder -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -verbose
}

function Remove-Snapshot {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        $snapshot = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'snapshot', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'shadowId' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'volume' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'symbolicLink' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (Test-Administrator) {
            [string]$shadowId = $snapshot.shadowID
            [string]$volume = $snapshot.volume
            [string]$symbolicLink = $snapshot.symbolicLink
            Remove-SymbolicLink -symbolicLink $symbolicLink
            [void](Invoke-Expression -command "cmd /c vssadmin delete shadows /Shadow='$shadowId' /Quiet")
        }  else {
            Throw ((Get-ResStr 'ADMIN_RIGHTS_NEEDED') -f $myInvocation.MyCommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Remove-Snapshot -snapshot $snap
}

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

function Rename-MssqlDatabase {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$oldName = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'oldName', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$newName = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'newName', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$server
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [string]$password
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'dbId' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newLogicalLdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'newLogicalMdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'newPhysicalLdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'newPhysicalMdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldLogicalLdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldLogicalMdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPhysicalLdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPhysicalMdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsConn' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $paramsConn = Get-UsedParameters -validParams (@('server','user','password')) -boundParams $PSBoundParameters
        $paramsConn.Add('database','Master')

         # Initialize connection and command objects
        $myConn= Get-Conn -connStr (New-ConnStr @paramsConn)

        [string]$sql = "SELECT  DB_ID('$oldName') [DbId]"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [int]$dbId= $rs.fields('DbId').value
            if (! $dbId) { throw ((Get-ResStr 'RENAMEDB_ERROR_NO_DBID') -f $oldName) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        # Get path the logical file names
        [string]$sql = "SELECT name FROM sys.sysaltfiles WHERE dbid = $dbId and filename like N'%.mdf'"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [string]$oldLogicalMdf= $rs.fields('name').value
            if (! $oldLogicalMdf) { throw ((Get-ResStr 'RENAMEDB_NO_LOGICAL_MDF_PATH') -f $myInvocation.Mycommand) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        [string]$sql = "SELECT name FROM sys.sysaltfiles WHERE dbid = $dbId and filename like N'%.ldf'"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [string]$oldLogicalLdf= $rs.fields('name').value
            if (! $oldLogicalLdf) { throw ((Get-ResStr 'RENAMEDB_NO_LOGICAL_LDF_PATH') -f $myInvocation.Mycommand) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        # Get path the physical file names
        [string]$sql = "SELECT filename FROM sys.sysaltfiles WHERE dbid = $dbId and filename like N'%.mdf'"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [string]$oldPhysicalMdf= $rs.fields('filename').value
            if (! $oldPhysicalMdf) { throw ((Get-ResStr 'RENAMEDB_NO_PHYSICAL_MDF_PATH') -f $myInvocation.Mycommand) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        [string]$sql = "SELECT filename FROM sys.sysaltfiles WHERE dbid = $dbId and filename like N'%.ldf'"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [string]$oldPhysicalLdf= $rs.fields('filename').value
            if (! $oldPhysicalLdf) { throw ((Get-ResStr 'RENAMEDB_NO_PHYSICAL_LDF_PATH') -f $myInvocation.Mycommand) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        # Get the path from the data folder and the names from the MDF and LDF file
        [string]$path = Split-Path $oldPhysicalMdf
        $oldPhysicalMdf = Split-Path $oldPhysicalMdf -Leaf
        $oldPhysicalLdf = Split-Path $oldPhysicalLdf -Leaf

        # Rename the database, to do this log out all logged in users by putting
        # the database into single user mode
        [string]$sql =  `
            "ALTER DATABASE [$oldName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE", `
            "ALTER DATABASE [$oldName] MODIFY NAME = [$newName]", `
            "ALTER DATABASE [$newName] SET MULTI_USER"
        $myConn.Execute($sql) | Out-Null

        # Build the new logical filenames
        [string]$newLogicalMdf = $newName
        [string]$newLogicalLdf = $newName + "_Log"

        # Build the new physical filenames
        [string]$newPhysicalMdf = $newName + ".mdf"
        [string]$newPhysicalLdf = $newName + "_log.ldf"

        # Rename the logical file names, this is only possible under their new name,
        # then take them offline to rename the files in the file system as well
        [string]$sql =  `
            "ALTER DATABASE [$newName] MODIFY FILE (NAME = [$oldLogicalMdf], NEWNAME = [$newLogicalMdf])", `
            "ALTER DATABASE [$newName] MODIFY FILE (NAME = [$oldLogicalLdf], NEWNAME = [$newLogicalLdf])", `
            "ALTER DATABASE [$newName] SET offline"
        $myConn.Execute($sql) | Out-Null

        # Prepare sql server for xp_cmdshell
        [string]$sql = `
            "EXEC sp_configure 'show advanced options', 1", `
            "RECONFIGURE", `
            "EXEC sp_configure 'xp_cmdshell', 1", `
            "RECONFIGURE"
        $myConn.Execute($sql) | Out-Null

        # Calls to the sql command shell to rename the file to the new file
        [string]$sql =  `
            "EXEC master..xp_cmdshell 'RENAME ""$path\$oldPhysicalMdf"" ""$newPhysicalMdf""'", `
            "EXEC master..xp_cmdshell 'RENAME ""$path\$oldPhysicalLdf"" ""$newPhysicalLdf""'"
        $myConn.Execute($sql) | Out-Null

        # Makes the new physical files for the database known and puts the DB back online
        [string]$sql =  `
            "ALTER DATABASE [$newName] MODIFY FILE (NAME = [$newLogicalMdf], FILENAME = '$path\$newPhysicalMdf')", `
            "ALTER DATABASE [$newName] MODIFY FILE (NAME = [$newLogicalLdf], FILENAME = '$path\$newPhysicalLdf')", `
            "ALTER DATABASE [$newName] SET online"
        $myConn.Execute($sql) | Out-Null
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Rename-MssqlDatabase -oldName 'Eulanda_Truccamo' -newName 'Eulanda_MyTruccamo' -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

Function Rename-RemoteFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'remoteParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }
        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            $remoteParams = @{
                server = $server
                port = $port
                user = $user
                password = $password
            }

            if ($protocol -eq 'sftp') {
                Rename-SftpFile @remoteParams  -certificate $certificate -remoteFolder $remoteFolder -remoteFile $remoteFile -newFolder $newFolder -newFile $newFile
            } else {
                Rename-FtpFile @remoteParams -protocol $protocol -activeMode:$activeMode -remoteFolder $remoteFolder -remoteFile $remoteFile -newFolder $newFolder -newFile $newFile
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Rename-RemoteFile -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -remoteFile 'Eulanda_JohnDoe.zip' -newFile 'John.zip' -verbose
}

Function Rename-RemoteFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            $remoteParams = @{
                server = $server
                port = $port
                user = $user
                password = $password
            }

            if ($protocol -eq 'sftp') {
                Rename-SftpFolder @remoteParams  -certificate $certificate -remoteFolder $remoteFolder -newFolder $newFolder
            } else {
                Rename-FtpFolder @remoteParams -protocol $protocol -activeMode:$activeMode -remoteFolder $remoteFolder -newFolder $newFolder
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Rename-RemoteFolder -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -newFolder '/BELAND' -verbose
}

function Resize-Image {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Position = 0, Mandatory = $false)]
        [ValidateScript({
            if (Test-Path $_) { $true } else { throw ((Get-ResStr 'PATH_NOT_EXISTS') -f $_) }
        })]
        [string]$pathIn = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'pathIn', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        [string]$pathOut
        ,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$modifier = "-resized"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange(10, 100)]
        [int]$quality = 65
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange(32, 5000)]
        [int]$maxWidth = 1200
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange(32, 5000)]
        [int]$maxHeight = 1200
        ,
        [Parameter(Mandatory = $false)]
        [switch]$passthru
    )
    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'directoryIn' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'directoryOut' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'extensionIn' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'extensionOut' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'filenameIn' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'filenameOut' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'img' -Scope 'Private' -Value ($null)
        New-Variable -Name 'imgNew' -Scope 'Private' -Value ($null)
        New-Variable -Name 'imgProcess' -Scope 'Private' -Value ($null)
        New-Variable -Name 'module' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'pathOutOrg' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'results' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'useDefaultOutputPath' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'wiaFormatJpg' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference

        try {
            $useDefaultOutputPath = $pathOut -eq ''
            $pathOutOrg = $pathOut
            [string]$module= "WIA.ImageFile"
            $img = New-Object -COMObject $module
            $imgNew = New-Object -COMObject $module
            [string]$module= "WIA.ImageProcess"
            $imgProcess = New-Object -COMObject $module
            $wiaFormatJpg = "{B96B3CAE-0728-11D3-9D7B-0000F81EF32E}"
            $results = @()
        }
        catch {
            throw ((Get-ResStr 'WIA_NOT_INSTALLED') -f $module)
        }
    }

    Process {
        if ($useDefaultOutputPath) {
            $directoryIn = Split-Path $pathIn
            $filenameIn = [System.IO.Path]::GetFileNameWithoutExtension($pathIn)
            $extensionIn = [System.IO.Path]::GetExtension($pathIn)
            $pathOut = Join-Path $directoryIn ("$($filenameIn)$($modifier)$($extensionIn)")
        } else {
            $pathOut = $pathOutOrg
            $directoryOut = Split-Path $pathOut
            $filenameOut = [System.IO.Path]::GetFileNameWithoutExtension($pathOut)
            $extensionOut = [System.IO.Path]::GetExtension($pathOut)

            $directoryIn = Split-Path $pathIn
            $filenameIn = [System.IO.Path]::GetFileNameWithoutExtension($pathIn)
            $extensionIn = [System.IO.Path]::GetExtension($pathIn)

            write-verbose (Get-ResStr 'WIA_OUTPUT')
            write-verbose ((Get-ResStr 'WIA_DIR_OUT') -f $directoryOut)
            write-verbose ((Get-ResStr 'WIA_FILE_OUT') -f $filenameOut)
            write-verbose ((Get-ResStr 'WIA_EXT_OUT') -f $extensionOut)

            write-verbose (Get-ResStr 'WIA_INPUT')
            write-verbose ((Get-ResStr 'WIA_DIR_IN') -f $directoryIn)
            write-verbose ((Get-ResStr 'WIA_FILE_IN') -f $filenameIn)
            write-verbose ((Get-ResStr 'WIA_EXT_IN') -f $extensionIn)

            if ($directoryOut -eq $directoryIn) {
                if ($filenameOut -eq $filenameIn) {
                    $filenameOut = $filenameIn + "$modifier"
                }
            } elseif (($filenameOut -eq $filenameIn) -and ($extensionOut -eq $extensionIn)) {
                $filenameOut = $filenameIn + "$modifier"
            } elseif (! $extensionOut) {
                $filenameOut = $filenameIn
                $extensionOut = $extensionIn
                $directoryOut = $pathOut
            }

            $pathOut = Join-Path $directoryOut ($filenameOut + $extensionOut)
        }

        write-verbose (Get-ResStr 'WIA_USED')
        write-verbose ((Get-ResStr 'WIA_PATH_IN') -f $pathIn)
        write-verbose ((Get-ResStr 'WIA_PATH_OUT') -f $pathOut)

        $img.LoadFile($pathIn)

        $imgProcess.Filters.Add($imgProcess.FilterInfos("Scale").FilterID)
        $imgProcess.Filters(1).Properties("MaximumWidth") = $maxWidth
        $imgProcess.Filters(1).Properties("MaximumHeight") = $maxHeight

        $imgProcess.Filters.Add($imgProcess.FilterInfos("Convert").FilterID)
        $imgProcess.Filters(2).Properties("FormatID").Value = $wiaFormatJpg
        $imgProcess.Filters(2).Properties("Quality").Value =  [string]$quality

        $imgNew = $imgProcess.Apply($img)
        If (Test-Path $pathOut) { Remove-Item -path $pathOut -force }
        $imgNew.SaveFile($pathOut)
        $imgProcess.Filters.Remove(2) # Remove the filter backwards
        $imgProcess.Filters.Remove(1)

        $result = [PSCustomObject]@{
            PathOut = $pathOut
        }

        $results += $result

        if ($passthru) {
            # Return $result
        }
    }

    End {
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$imgProcess)
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$img)
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$imgNew)
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        if ($passthru) {
            Return $results
        }
    }
    # Test: Resize-Image -pathIn c:\temp\eulanda.jpg -pathOut c:\temp\eulanda-neu.jpg -maxWidth 50
}

function Select-OutdatedFilenames {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string[]]$filenames = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'filenames', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$basename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'basename', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$extension = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'extension', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$history = 3
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'filteredFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'mask' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'Matches' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'outdatedFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'sortedFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Object[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($filenames) {
            if ($extension) {
                if ($extension[0] -ne ".") {
                    $extension = "." + $extension
                }
            }

            $mask = '^' + $basename + '-\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-\d{4}\' + $extension + '$'
            $filteredFiles = $filenames | Where-Object {
                $_ -match $mask
            }

            if ($filteredFiles) {
                if ($history) {
                    $sortedFiles =  [System.Array]($filteredFiles | Sort-Object -Property @{ Expression = {
                                try {
                                    [datetime]::ParseExact(($_.Name -match $dateRegex), "yyyy-MM-dd-HH-mm-ss-ffff", $null)
                                } catch {
                                    [datetime]::MinValue
                                }
                            }  }  )

                    $outdatedFiles = @()
                    if ($history -lt $sortedFiles.Count) {
                        foreach ($file in $sortedFiles[0..($sortedFiles.Count - ($history+1))]) {
                            $outdatedFiles = $outdatedFiles += $file
                        }
                    }
                    $result = $outdatedFiles
                } else {
                    $result = $filteredFiles
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Select-OutdatedFilenames -Filenames @('MyDatabase-2023-05-15-10-30-0001.zip', 'OtherFile.txt', 'MyDatabase-2023-05-15-11-45-0002.zip') -basename 'MyDatabase' -extension '.zip'
}

function Send-Mail {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$from = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'from', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$to = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'to', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$cc
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$bcc
        ,
        [Parameter(Mandatory = $false)]
        [string]$replyTo = $from
        ,
        [Parameter(Mandatory = $false)]
        [Alias('server')]
        [string]$smtpServer = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'smtpServer', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('Normal', 'High', 'Low', IgnoreCase = $true)]
        [string]$priority= 'Normal'
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('utf8NoBOM', 'ascii','bigendianunicode','bigendianutf32', 'oem', 'unicode', 'utf7', 'utf8', 'utf8BOM', 'utf8NoBOM', 'utf32', IgnoreCase = $true)]
        [string]$encoding= 'utf8'
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [string]$password
        ,
        [Parameter(Mandatory = $false)]
        [secureString]$secPassword
        ,
        [Parameter(Mandatory = $false)]
        [psCredential]$credential
        ,
        [Parameter(Mandatory = $false)]
        [switch]$useSsl
        ,
        [Parameter(Mandatory = $false)]
        [Alias('useHtml')]
        [switch]$bodyAsHtml
        ,
        [Parameter(Mandatory = $false)]
        [int]$port= 25
        ,
        [Parameter(Mandatory = $false)]
        [Alias('DNO')]
        [ValidateSet('None', 'OnSuccess', 'OnFailure', 'Delay', 'Never')]
        [string[]]$deliveryNotificationOption = 'None'
        ,
        [Parameter(Mandatory = $false)]
        [string]$subject = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'subject', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$body
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$attachment
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'mailParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'message' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPref' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        Set-Tls
        # Get Credential by Dialog  : $Credential = Get-Credential
        # Retruning user is like    : $User = $credential.Username
        # Returning plain pPassword : $Password = $credential.GetNetworkCredential().Password

        [System.Object]$credential = $null
        if ( ($user) -and ($password ) ) {
            $secPassword = ConvertTo-SecureString $password -AsPlainText -Force
            $credential = New-Object System.Management.Automation.PSCredential ($user, $secPassword)
        }

        $mailParams = @{
            From = $from
            To = $to.Split(',')
            Subject = $subject
            Port = $port
            Priority = $priority
            Encoding = $encoding
            SmtpServer = $smtpServer
            DeliveryNotificationOption = $deliveryNotificationOption
        }

        if ($cc) {$mailParams.Add('CC', $cc.split(',')) }
        if ($bcc) {$mailParams.Add('BCC', $bcc.split(',')) }
        if ($useSsl) {$mailParams.Add('useSSL', $true) }
        if ($credential) { $mailParams.Add('Credential', $credential ) }
        if ($bodyAsHtml) {$mailParams.Add('bodyAsHtml', $true) }
        if ($body) {$mailParams.Add('Body', $body) }
        if ($attachment) { $mailParams.Add('Attachments', $attachment) }
        if (( $PSVersionTable.PsVersion.Major -gt 6 ) -or `
            (($PSVersionTable.PsVersion.Major -eq 6) -and `
            ($PSVersionTable.PsVersion.Minor -ge 2))) {
            if ($replyTo) {
                $mailParams.Add('ReplyTo', $replyTo )
            }
        }

        try {
            $oldPref = $WarningPreference
            $WarningPreference = 'SilentlyContinue'
            Send-MailMessage @mailParams
            $WarningPreference = $oldPref
            if ($attachment) {
                [string]$message = ((Get-ResStr 'EMAIL_SENT_WITH_ATTACHMENT') -f $subject, $attachment)
            } else {
                [string]$message = ((Get-ResStr 'EMAIL_SENT') -f $subject)
            }
            write-verbose $message
        }

        catch {
            write-host ((Get-ResStr 'EMAIL_SENT_ERROR') -f $to, $subject, $_) -foregroundcolor Red
        }

        Start-Sleep -Seconds 1
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Send-Mail -from 'cn@eulanda.de' -to 'info@eulanda.de' -server '192.168.41.1' -user 'noreply@eulanda.eu' -password 'JohnDoe' -subject 'One Testmail' -body 'Is better then nothing'
}

Function Send-RemoteFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeAge = 60*60*3
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeRetries = 7
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                Send-SftpFile -server $server -port $port -certificate $certificate -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile -localFolder $localFolder -localFile $localFile
            } else {
                Send-FtpFile -server $server -protocol $protocol -port $port -activeMode:$activeMode -resumeAge $resumeAge -resumeRetries $resumeRetries -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile  -localFolder $localFolder -localFile $localFile
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Send-RemoteFile -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -localFolder 'C:\temp' -localFile 'text.txt'
}

function Send-TelegramMap() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$token
        ,
        [Parameter(Mandatory = $false)]
        [Alias("eToken")]
        [string]$encryptedToken
        ,
        [Parameter(Mandatory = $false)]
        [Alias("sToken")]
        [securestring]$secureToken
        ,
        [Alias("path")]
        [Parameter(Mandatory = $false)]
        [string]$pathToToken
        ,
        [Parameter(Mandatory = $false)]
        [Alias("id")]
        [String]$chatId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'chatId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange(-90,90)]
        [Alias('lat')]
        [Single]$latitude
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange(-180,180)]
        [Alias('lon')]
        [Single]$longitude
        ,
        [Parameter(Mandatory = $false)]
        [ipaddress]$ip = $null
        ,
        [Parameter(Mandatory = $false)]
        [Alias("noNotify")]
        [Switch]$disableNotification
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleToken) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [bool]$result = $false

        try {
            if ($PsVersionTable.PsVersion.Major -gt 5) {
                # This part runs on PowerShell 6.x, 7.x
                if ($pathToToken) {
                    [securestring]$secureToken = Import-Clixml -Path $pathToToken
                    [string]$token = ConvertFrom-SecureString -SecureString $secureToken -AsPlainText
                } elseif ($secureToken) {
                    [string]$token = ConvertFrom-SecureString -SecureString $secureToken -AsPlainText
                } elseif ($encryptedToken) {
                    [string]$token = ConvertFrom-SecureString -SecureString (ConvertTo-SecureString -String $encryptedToken) -AsPlainText
                }
            } else {
                # This part runs on PowerShell 5.x, 6.x, 7.x
                if ($pathToToken) {
                    [securestring]$secureToken = Import-Clixml -Path $pathToToken
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                } elseif ($secureToken) {
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                } elseif ($encryptedToken) {
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR((ConvertTo-SecureString -String $encryptedToken))
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                }
            }

            if ((! $latitude) -and (! $latitude) -and (! $ip)) {
                $ip = Get-PublicIp
            }

            if ($ip) {
                Get-IpGeoInfo -ip $ip.IpAddressToString | Out-Null
                $latitude = $global:geoHashTable[$ip.IpAddressToString].data.lat
                $longitude = $global:geoHashTable[$ip.IpAddressToString].data.lon
            }

            $formParams = @{
                chat_id                 = $chatId
                latitude                = $Latitude
                longitude               = $Longitude
                disable_notification    = $disableNotification
            }


            $invokeParams = @{
                Uri         = "https://api.telegram.org/bot$token/sendLocation"
                ErrorAction = 'Stop'
                Method      = 'Post'
            }

            if ($PsVersionTable.PsVersion.Major -gt 5) {
                # This part runs on PowerShell 6.x, 7.x
                $invokeParams.Add('Form', $formParams)
            } else {
                # This part runs on PowerShell 5.x, 6.x, 7.x
                # Requires multipart conversion for binary files
                $boundary = [System.Guid]::NewGuid().ToString()
                $form = Convert-ToMultipart -params $formParams -boundary $boundary
                $invokeParams.Add('ContentType', "multipart/form-data; boundary=`"$boundary`"")
                $invokeParams.Add('Body', $form)
            }

            Set-Tls
            $response = Invoke-RestMethod @invokeParams
            $result = $response.ok
        }

        catch {
            $result = $false
            Write-Error ((Get-ResStr 'TELEGRAM_SEND_MESSAGE_ERROR') -f $_)
        }

        finally {
            # Purge token, because it contains plain text
            $token = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 50 | ForEach-Object { [char]$_ })
            Remove-Variable token
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    <#
        Test:
        https://core.telegram.org/bots/api#sendlocation

        $pathToToken = "$home\.EulandaConnect\secureTelegramToken.xml"
        $chatId = "-713022389"

        # Paris -lon 2.3522 -lat 48.8566
        Send-TelegramMap -pathToToken $pathToToken -chatId $chatId -lon 2.3522 -lat 48.8566

        # The longitude and latitude of the position of your router ofer Get-PublicIp
        Send-TelegramMap -pathToToken $pathToToken -chatId $chatId

        # The longitude and latitude of the position over an geo api
        Send-TelegramMap -pathToToken $pathToToken -chatId $chatId -ip '5.1.80.40'
    #>
}

Function Send-TelegramMessage {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$token
        ,
        [Parameter(Mandatory = $false)]
        [Alias("eToken")]
        [string]$encryptedToken
        ,
        [Parameter(Mandatory = $false)]
        [Alias("sToken")]
        [securestring]$secureToken
        ,
        [Alias("path")]
        [Parameter(Mandatory = $false)]
        [string]$pathToToken
        ,
        [Parameter(Mandatory = $false)]
        [Alias("id")]
        [String]$chatId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'chatId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [String]$message = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'message', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('html', 'markdown')]
        [Alias("mode")]
        [String]$parseMode = 'html'
        ,
        [Parameter(Mandatory = $false)]
        [Alias("noNotify")]
        [Switch]$disableNotification
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleToken) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if ($PsVersionTable.PsVersion.Major -gt 5) {
                # This part runs on PowerShell 6.x, 7.x
                if ($pathToToken) {
                    [securestring]$secureToken = Import-Clixml -Path $pathToToken
                    [string]$token = ConvertFrom-SecureString -SecureString $secureToken -AsPlainText
                } elseif ($secureToken) {
                    [string]$token = ConvertFrom-SecureString -SecureString $secureToken -AsPlainText
                } elseif ($encryptedToken) {
                    [string]$token = ConvertFrom-SecureString -SecureString (ConvertTo-SecureString -String $encryptedToken) -AsPlainText
                }
            } else {
                # This part runs on PowerShell 5.x, 6.x, 7.x
                if ($pathToToken) {
                    [securestring]$secureToken = Import-Clixml -Path $pathToToken
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                } elseif ($secureToken) {
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                } elseif ($encryptedToken) {
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR((ConvertTo-SecureString -String $encryptedToken))
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                }
            }

            Set-Tls
            [string]$disableNotificationText = if ($disableNotification) { "true" } else { "false" }
            $response = Invoke-RestMethod -Uri "https://api.telegram.org/bot$token/sendMessage?chat_id=$chatId&text=$message&parse_mode=$parseMode&DisableNotification=$disableNotificationText"
            $result = $response.ok
        }

        catch {
            $result = $false
            Write-Error ((Get-ResStr 'TELEGRAM_SEND_MESSAGE_ERROR') -f $_)
        }

        finally {
            # Purge token, because it contains plain text
            $token = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 50 | ForEach-Object { [char]$_ })
            Remove-Variable token
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }

    <#
        Test:
        API-Doc: https://core.telegram.org/bots/api#senddocument

        $pathToToken = "$home\.eulandaconnect\secureTelegramToken.xml"
        $chatId = "-713022389"

        $markdownMessage = "This is a MARKDOWN *test* with encrypted token from EulandaConnect"
        Send-TelegramMessage -pathToToken $pathToToken -chatId $chatId -parseMode 'markdown' -message $markdownMessage

        $htmlMessage = "This is an HTML <b>test</b> with encrypted token from EulandaConnect"
        Send-TelegramMessage -pathToToken $pathToToken -chatId $chatId -message $htmlMessage
    #>
}

function Send-TelegramPhoto() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$token
        ,
        [Parameter(Mandatory = $false)]
        [Alias("eToken")]
        [string]$encryptedToken
        ,
        [Parameter(Mandatory = $false)]
        [Alias("sToken")]
        [securestring]$secureToken
        ,
        [Alias("path")]
        [Parameter(Mandatory = $false)]
        [string]$pathToToken
        ,
        [Parameter(Mandatory = $false)]
        [Alias("id")]
        [String]$chatId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'chatId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [String]$caption = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'caption', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]  # could be a local file or an internet resource url
        [String]$uri = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'photoUri', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('html', 'markdown')]
        [Alias("mode")]
        [String]$parseMode = 'html'
        ,
        [Parameter(Mandatory = $false)]
        [Alias("noDetection")]
        [Switch]$disableContentTypeDetection
        ,
        [Parameter(Mandatory = $false)]
        [Alias("noNotify")]
        [Switch]$disableNotification
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleToken) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [bool]$result = $false

        try {
            if ($PsVersionTable.PsVersion.Major -gt 5) {
                # This part runs on PowerShell 6.x, 7.x
                if ($pathToToken) {
                    [securestring]$secureToken = Import-Clixml -Path $pathToToken
                    [string]$token = ConvertFrom-SecureString -SecureString $secureToken -AsPlainText
                } elseif ($secureToken) {
                    [string]$token = ConvertFrom-SecureString -SecureString $secureToken -AsPlainText
                } elseif ($encryptedToken) {
                    [string]$token = ConvertFrom-SecureString -SecureString (ConvertTo-SecureString -String $encryptedToken) -AsPlainText
                }
            } else {
                # This part runs on PowerShell 5.x, 6.x, 7.x
                if ($pathToToken) {
                    [securestring]$secureToken = Import-Clixml -Path $pathToToken
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                } elseif ($secureToken) {
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                } elseif ($encryptedToken) {
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR((ConvertTo-SecureString -String $encryptedToken))
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                }
            }

            $formParams = @{
                chat_id                        = $chatId
                caption                        = $caption
                parse_mode                     = $parseMode
                disable_content_type_detection = $disableContentTypeDetection
                disable_notification           = $disableNotification
            }

            if ($uri -like 'http*') {
                $formParams.Add('photo', $uri)
            }
            else {
                $fileObject = Get-Item $uri -ErrorAction Stop
                $formParams.Add('photo', $fileObject)
            }

            $invokeParams = @{
                Uri         = "https://api.telegram.org/bot$token/sendPhoto"
                ErrorAction = 'Stop'
                Method      = 'Post'
            }

            if ($PsVersionTable.PsVersion.Major -gt 5) {
                # This part runs on PowerShell 6.x, 7.x
                $invokeParams.Add('Form', $formParams)
            } else {
                # This part runs on PowerShell 5.x, 6.x, 7.x
                # Requires multipart conversion for binary files
                $boundary = [System.Guid]::NewGuid().ToString()
                $form = Convert-ToMultipart -params $formParams -boundary $boundary
                $invokeParams.Add('ContentType', "multipart/form-data; boundary=`"$boundary`"")
                $invokeParams.Add('Body', $form)
            }

            Set-Tls
            $response = Invoke-RestMethod @invokeParams
            $result = $response.ok
        }

        catch {
            $result = $false
            Write-Error ((Get-ResStr 'TELEGRAM_SEND_MESSAGE_ERROR') -f $_)
        }

        finally {
            # Purge token, because it contains plain text
            $token = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 50 | ForEach-Object { [char]$_ })
            Remove-Variable token
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    <#
        Test:
        https://core.telegram.org/bots/api#sendphoto

        $pathToToken = "$home\.EulandaConnect\secureTelegramToken.xml"
        $chatId = "-713022389"
        Send-TelegramPhoto -pathToToken $pathToToken -chatId $chatId -caption "My simple caption..." -uri 'c:\temp\logo.png'
    #>
}

function Set-DeliveryQty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if($_.Count -lt 1) {
                throw (Get-ResStr 'STOCK_BOOKING_BATCH')
            }
            $true
        })]
        [array]$quantities = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'quantities', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [string]$bookingInfo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlFrag' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        if ($deliveryId) {
            [string]$sqlFrag = "@lf_id = $deliveryId,"
        } else {
            [string]$sqlFrag = "@KopfNummer = $deliveryNo,"
        }

        $xmlFrag = @(
            $quantities.foreach({
                "<UPDATE><ARTNUMMER>" + [Security.SecurityElement]::Escape($_.articleNo) + "</ARTNUMMER>" +
                "<MENGE>$($_.qty)</MENGE></UPDATE>"})
        );
        $xmlFrag = $xmlFrag -join "`r`n"

        $sql = @"
        set nocount on;
        declare @Updates xml = N'$xmlFrag';
        declare @exec int;

        exec @exec = dbo.cn_LfUpdateArFromXml
        $sqlFrag
        @Updates = @Updates,
        @xmlVersion = 1,
        @AfStornoRest = 1,
        @AfStornoGrund = '$bookingInfo'

        if @exec < 0 PRINT 'FEHLER'
"@
        $myConn.Execute($sql) | out-null
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Set-DeliveryQty -quantities @(@{articleNo = '206003'; qty = 1}, @{articleNo = '206003'; qty = 5}) -deliveryNo 69 -bookingInfo 'Correction' -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Set-StockQty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if($_.Count -lt 1) {
                throw (Get-ResStr 'STOCK_BOOKING_BATCH')
            }
            $true
        })]
        [array]$quantities = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'quantities', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$stockGroup = 1
        ,
        [Parameter(Mandatory = $false)]
        [string]$bookingInfo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlFrag' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $xmlFrag = @(
            $quantities.foreach({
                "<item><ARTNUMMER>" + [Security.SecurityElement]::Escape($_.articleNo) + "</ARTNUMMER>" +
                "<MENGE>$($_.qty)</MENGE></item>"})
        );
        $xmlFrag = $xmlFrag -join "`r`n"

        $bookingInfo = if ($bookingInfo) {"'" + $bookingInfo.replace("'","''") + "'"} else {'null'};

        $sql = @"
        set nocount on;
        declare @x xml = N'$xmlFrag';

        select error from dbo.cnf_ExtractArMenge(@x,1) where error is not null;

        declare @Mengen [dbo].[TIdQtyTable], @ll_id int;

        insert @Mengen (id, quantity)
        select ArtikelId, Menge
        from dbo.cnf_ExtractArMenge(@x,0);

        exec dbo.cn_LL_SetBestandAbsolut
            @LagerGr = $stockGroup,
            @Mengen = @Mengen,
            @Objekt = $bookingInfo,
            @ll_id = @ll_id OUT;
"@

        $myConn.Execute($sql) | out-null
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Set-StockQty -quantities @(@{articleNo = '206003'; qty = 100}, @{articleNo = '206003'; qty = 500}) -bookingInfo 'Correction' -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Set-TrackingNo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [System.Array]$trackingNo = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'trackingNo', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'carrierNo' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'oldUnits' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'oldValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'tempArray' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'tempStr' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        if ($deliveryId) {
            [string]$sqlFrag = "Id = $deliveryId"
        } else {
            [string]$sqlFrag = "KopfNummer = $deliveryNo"
        }

        [string]$sql = "SELECT Id, KopfNummer [DeliveryNo], SpedAuftragNr [CarrierNo], TrackingNr [TrackingNo], " +`
                        "AnzahlPakete [Units], VersandDatum [ShippingDate] FROM Lieferschein WHERE $sqlFrag"

        $rs = $Null
        $rs = new-object -comObject ADODB.Recordset
        $rs.CursorLocation = $adUseClient
        $rs.Open($sql, $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
        if (! $rs.eof) {
            [string]$carrierNo = $rs.fields('CarrierNo').value
            # Only if this is the secoond document we have for this delivery note
            # be need to keep the old trackings also. This is indicated by an existing carrierNo.
            if ($carrierNo) {
                [string]$tempStr = $rs.fields('TrackingNo').value
                [int]$oldUnits = $rs.fields('Units').value
            } else {
                [string]$tempStr = ""
                [int]$oldUnits = 0
            }
            [string]$oldValue = $tempStr
            $tempStr = $tempStr.Replace("`r","").Trim()
            [System.Array]$tempArray = [System.Collections.ArrayList]::new()
            $tempArray = $tempStr.split("`n")
            $tempArray = $tempArray + $trackingNo
            $tempArray = $tempArray | Select-Object -Unique
            $tempArray = $tempArray | Sort-Object -Descending
            $tempStr = $tempArray -join "`r`n"
            $tempStr = $tempStr.Trim()
            $tempArray = $tempStr.Split("`r`n")
            # Avoid unnecessary change dates in the database
            if (($oldValue -ne $tempStr) -or ($oldUnits -ne $tempArray.count)) {
                $rs.fields('TrackingNo').value = $tempStr
                $rs.fields('Units').value = [int]$tempArray.count
                $rs.fields('ShippingDate').value = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                $rs.update()
            }
        } else {
            throw ((Get-ResStr 'DELIVERYNO_NOT_EXISTS') -f $deliveryNo, $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Set-TrackingNo -trackingNo @('4711','0815') -deliveryNo 69 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Show-Extensions {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        Push-Location
        Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
        if ((Get-ItemProperty .).HideFileExt -eq 1) {
            Set-ItemProperty . HideFileExt 0
            Start-Sleep -Milliseconds 500
            Update-Desktop
        }
        Pop-Location
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Show-Extensions
}

function Show-MsgBox {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$prompt = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'prompt', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        [ValidateSet(0,1,2,3,4,5)]
        [int]$btn = $mbYesNo
        ,
        [Parameter(Position = 2, Mandatory = $false)]
        [string]$title = 'Info'
        ,
        [Parameter(Position = 3, Mandatory = $false)]
        [ValidateSet(0,16,32,48,64)]
        [int]$icon = $mbInfo
        ,
        [Parameter(Position = 4, Mandatory = $false)]
        [ValidateSet(0,256,512,768)]
        [int]$btnDef = $mbNone
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        Add-Type -AssemblyName PresentationFramework | Out-Null
        [int]$result = [System.Windows.MessageBox]::Show((new-object System.Windows.Window -Property @{TopMost = $True}), $prompt, $title, $btn, $icon, $btnDef)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Show-MsgBox -prompt 'Do you want to continue?'
}

function Show-MsgBoxYes {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$prompt = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'prompt', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'answer' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [int]$answer = Show-MsgBox -prompt $prompt -title 'Info' -icon $mbNone -btnDef $mbNone
        if ($answer -eq $mbrYes) {
            [bool]$result = $true
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Show-MsgBoxYes -prompt 'Do you want more?'
}

function Split-LogFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            $path = [System.IO.Path]::GetDirectoryName($_)
            if (Test-Path -Path $path) {
                $true
            }
            else {
                throw ((Get-ResStr 'LOGFILE_PATH_MISSED') -f $path, $myInvocation.Mycommand)
            }
        })]
        [string]$inputPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'inputPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if (Test-Path -Path $_) {
                $true
            }
            else {
                throw ((Get-ResStr 'PATHIN_DOES_NOT_EXIST') -f $_)
            }
        })]
        [string]$outputFolder = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'outputFolder', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if ($_ -notmatch '\{1\}') {
                throw (Get-ResStr 'VALIDATE_PARAM__ELEMENT_MISSED')
            }
            if ($_ -match '\{0\}') {
                $index0 = $_.IndexOf("{0}")
                $index1 = $_.IndexOf("{1}")
                if ($index0 -eq 0 -or $index0 -gt $index1) {
                    throw (Get-ResStr 'VALIDATE_PARAM_SEQUENCE')
                }
            }
            return $true
        })]
        [string]$outputMask = "filezilla-server.{0}-{1}.log"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            $validDateMasks = 'yyyy', 'MM', 'dd', 'HH', 'mm', 'ss', 'ffff'
            $isValid = $true
            foreach ($mask in $validDateMasks) {
                if ($_ -notmatch $mask) {
                    $isValid = $false
                    break
                }
            }
            if ($isValid) {
                $true
            } else {
                throw ((Get-ResStr 'VALIDATE_PARAM_DATEMASK') -f $_)
            }
        })]
        [string]$dateMask = "yyyy-MM-dd-HH-mm-ss-ffff"
        ,
        [Parameter(Mandatory = $false)]
        [int]$maxFileSize = 2MB
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $inputFolder = Split-Path -Path $inputPath

        $files = Get-ChildItem -Path $inputPath
        $sortedFiles = $files | Sort-Object LastWriteTime -Descending
        $fileNames = $sortedFiles | ForEach-Object { $_.Name }

        $currentFileSize = 0
        $lines = New-Object System.Collections.Generic.List[System.Object]

        # Searches files that match the pattern and extracts the highest counter
        $splitPattern = $outputMask -split '\{[0-9]\}'  # filezilla-server.{0}-{1}.log
        $pre = $splitPattern[0]   # "filezilla-server."
        $post = $splitPattern[2]  # ".log"

        $fileCounter = (Get-ChildItem -Path $outputFolder -Filter "$pre*$post" |
                        ForEach-Object { if($_.BaseName -match "-(\d+)$") { [int]$matches[1] } } |
                        Sort-Object -Descending | Select-Object -First 1)


        # If nothing was found, it is started with 0
        if ($null -eq $fileCounter -or $fileCounter -eq '') {
            $fileCounter = 0
        }

        # Check if the last file size is less than the max size, if so, add contents to $lines and update $currentFileSize
        if ($fileCounter) {
            $latestSplitFile = Get-ChildItem -Path $outputFolder -Filter "$pre*$post" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
            if ($latestSplitFile.Length -lt $maxFileSize) {
                $fileContent = Get-Content -Path $latestSplitFile.FullName
                foreach ($line in $fileContent) {
                    $lineSize = ([System.Text.ASCIIEncoding]::ASCII.GetByteCount($line) + 2) # +2 für Zeilenumbruch
                    $lines.Add($line)
                    $currentFileSize += $lineSize
                }
                Remove-Item -Path $latestSplitFile.FullName -Force # Removes the file because it will be overwritten
                $fileCounter-- # Decrement the file counter because the file was deleted and its content will be used in the next process
            }
        }

        # Reads the file content line by line
        foreach ($inputFile in $fileNames) {
            Write-Verbose "Source log file: $inputFile"
            Get-Content (Join-Path -path $inputFolder -ChildPath $inputFile) | ForEach-Object {
                $line = $_
                $lineSize = ([System.Text.ASCIIEncoding]::ASCII.GetByteCount($line) + 2) # +2 für Zeilenumbruch

                # Writes the collected content to the file if the current file size exceeds the maxFileSize
                if ($currentFileSize + $lineSize -gt $maxFileSize) {
                    $fileCounter++
                    $dateString = Get-Date -Format $dateMask
                    $fileName = $outputMask -f $dateString, $fileCounter
                    $outputFile = Join-Path -Path $outputFolder -ChildPath $fileName
                    Write-Verbose ((Get-ResStr 'OUTPUT_SPLITFILE') -f $outputFile)
                    $currentFileSize = 0
                    $lines | Out-File -FilePath $outputFile
                    $lines.Clear()
                    Start-Sleep -Milliseconds 1 # Wait to be sure that the next time the file name changes
                }

                # Adds the current line to the collection
                $lines.Add($line)

                # Updates the current file size
                $currentFileSize += $lineSize
            }
        }
        # Writes the remaining lines to the file
        if ($lines.Count -gt 0) {
            $fileCounter++
            $dateString = Get-Date -Format $dateMask
            $fileName = $outputMask -f $dateString, $fileCounter
            $outputFile = Join-Path -Path $outputFolder -ChildPath $fileName
            Write-Verbose ((Get-ResStr 'OUTPUT_SPLITFILE') -f $outputFile)
            $currentFileSize = 0
            $lines | Out-File -FilePath $outputFile
            $lines.Clear()
            Start-Sleep -Milliseconds 1 # Wait to be sure that the next time the file name changes
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Split-LogFile -inputPath 'C:\FileZillaLog\Logs\filezilla-server.*.log' -outputFolder 'C:\FileZillaLog\SplitLogs'
}

function Test-Administrator {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'User' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $User = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
        $result = $User.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-Administrator
}

function Test-ArticlePropertyItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange("Positive")]
        [int]$propertyId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'propertyId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        $articleId = Get-ArticleId @paramsArticle -conn $myConn

        [bool]$result = $false

        [string]$sql = @"
        SELECT CASE WHEN EXISTS
            (SELECT me.ObjektId
                FROM MerkmalElement me
                JOIN Merkmal m ON
                    m.Id = me.KopfId AND
                    m.id = $propertyId AND
                    m.Tabelle = 'Artikel' AND m.MerkmalTyp = 1
            WHERE me.ObjektId = $articleId )
        THEN 1 ELSE 0 END [Item]
"@
        $rs = $Null
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                if ($rs.fields('Item').Value -eq 1) {
                    $result = $true
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-ArticlePropertyItem -articleNo '206003' -propertyId 1358 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Test-Console {
    [CmdletBinding()]
    param( )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'hasRdpSession' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'sessionList' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        <#
            # Deprecated, only for information
            [string]$str = quser.exe | Select-String -Quiet '\brdp-'
            if ($str -eq 'True') {[boolean]$result = $false} else { [boolean]$result = $true }
        #>

        $sessionList = Get-CimInstance -ClassName Win32_LogonSession
        $hasRdpSession = $sessionList.LogonType -contains 10 # 10 corresponds to RDP sessions in Win32_LogonSession class

        if ($hasRdpSession) {
            $result = $false
        } else {
            $result = $true
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-Console
}

function Test-HasProperty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        $inputVar = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'inputVar', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$propertyName = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'propertyName', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($propertyName) {
            if ($inputVar) {
                if ($null -ne $inputVar -and -not $inputVar.GetType().IsValueType) {
                    [bool]$result = ($propertyName -in $inputVar.PSobject.Properties.Name)
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $result
    }
    # Test:  Test-HasProperty -inputVar $error -propertyName 'Count'
}

function Test-IpAddress {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$ip = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'ip', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ipPattern' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $ipPattern = '^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'

        if ($ip -match $ipPattern) {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Test-IpAddress -ip 260.1.2.3 -verbose -debug
}

function Test-Numeric() {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$value,

        [parameter(Mandatory = $false)]
        [switch]$allowZero
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'Matches' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [bool]$result = $value -match "^[\d\.]+$"
        if (! $allowZero) {
            if ($result) {
                $value = $value.replace('0','')
                if (! $value) { $result = $false }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:   Test-Numeric -value '45x'
}

function Test-PrivateIp {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$ip = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'ip', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'endBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ipBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'privateIPRanges' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'range' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'startBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $false
        $privateIPRanges = @(
            @{
                Start = [System.Net.IPAddress]::Parse("10.0.0.0")
                End = [System.Net.IPAddress]::Parse("10.255.255.255")
            },
            @{
                Start = [System.Net.IPAddress]::Parse("172.16.0.0")
                End = [System.Net.IPAddress]::Parse("172.31.255.255")
            },
            @{
                Start = [System.Net.IPAddress]::Parse("192.168.0.0")
                End = [System.Net.IPAddress]::Parse("192.168.255.255")
            }
        )

        $ipBytes = ([System.Net.IPAddress]::Parse($ip)).GetAddressBytes()
        foreach ($range in $privateIPRanges) {
            $startBytes = $range.Start.GetAddressBytes()
            $endBytes = $range.End.GetAddressBytes()

            if (($ipBytes[0] -ge $startBytes[0] -and $ipBytes[0] -le $endBytes[0]) -and
                ($ipBytes[1] -ge $startBytes[1] -and $ipBytes[1] -le $endBytes[1]) -and
                ($ipBytes[2] -ge $startBytes[2] -and $ipBytes[2] -le $endBytes[2]) -and
                ($ipBytes[3] -ge $startBytes[3] -and $ipBytes[3] -le $endBytes[3])) {
                $result = $true
                break
            }
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-PrivateIP -ip '192.168.178.2'
}

Function Test-RemoteFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            $remoteParams = @{
                server = $server
                port = $port
                user = $user
                password = $password
            }

            if ($protocol -eq 'sftp') {
                $result = Test-SftpFile @remoteParams -certificate $certificate -remoteFolder $remoteFolder -remoteFile $remoteFile
            } else {
                $result = Test-FtpFile @remoteParams -protocol $protocol -activeMode:$activeMode -remoteFolder $remoteFolder -remoteFile $remoteFile
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-RemoteFile -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -verbose
}


Function Test-RemoteFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            $remoteParams = @{
                server = $server
                port = $port
                user = $user
                password = $password
            }

            if ($protocol -eq 'sftp') {
                $result = Test-SftpFolder @remoteParams -certificate $certificate -remoteFolder $remoteFolder
            } else {
                $result = Test-FtpFolder @remoteParams -protocol $protocol -activeMode:$activeMode -remoteFolder $remoteFolder
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-RemoteFolder -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -verbose
}


function Test-ReservedIp {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$ip = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'ip', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'endBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ipBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'range' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'reservedIPRanges' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'startBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $false
        $reservedIPRanges = @(
            # Current network (only valid as source address)
            @{
                Start = [System.Net.IPAddress]::Parse("0.0.0.0")
                End = [System.Net.IPAddress]::Parse("0.255.255.255")
            },
            # Private network
            @{
                Start = [System.Net.IPAddress]::Parse("10.0.0.0")
                End = [System.Net.IPAddress]::Parse("10.255.255.255")
            },
            # Shared Address Space for communications between a service provider and its subscribers
            @{
                Start = [System.Net.IPAddress]::Parse("100.64.0.0")
                End = [System.Net.IPAddress]::Parse("100.127.255.255")
            },
            # Loopback
            @{
                Start = [System.Net.IPAddress]::Parse("127.0.0.0")
                End = [System.Net.IPAddress]::Parse("127.255.255.255")
            },
            # Link local
            @{
                Start = [System.Net.IPAddress]::Parse("169.254.0.0")
                End = [System.Net.IPAddress]::Parse("169.254.255.255")
            },
            # Private network
            @{
                Start = [System.Net.IPAddress]::Parse("172.16.0.0")
                End = [System.Net.IPAddress]::Parse("172.31.255.255")
            },
            # IETF protocol assignments
            @{
                Start = [System.Net.IPAddress]::Parse("192.0.0.0")
                End = [System.Net.IPAddress]::Parse("192.0.0.255")
            },
            # TEST-NET-1, for documentation and example code
            @{
                Start = [System.Net.IPAddress]::Parse("192.0.2.0")
                End = [System.Net.IPAddress]::Parse("192.0.2.255")
            },
            # IPv6 to IPv4 relay
            @{
                Start = [System.Net.IPAddress]::Parse("192.88.99.0")
                End = [System.Net.IPAddress]::Parse("192.88.99.255")
            },
            # Private network
            @{
                Start = [System.Net.IPAddress]::Parse("192.168.0.0")
                End = [System.Net.IPAddress]::Parse("192.168.255.255")
            },
            # Network benchmark tests
            @{
                Start = [System.Net.IPAddress]::Parse("198.18.0.0")
                End = [System.Net.IPAddress]::Parse("198.19.255.255")
            },
            # TEST-NET-2, for documentation and example code
            @{
                Start = [System.Net.IPAddress]::Parse("198.51.100.0")
                End = [System.Net.IPAddress]::Parse("198.51.100.255")
            },
            # TEST-NET-3, for documentation and example code
            @{
                Start = [System.Net.IPAddress]::Parse("203.0.113.0")
                End = [System.Net.IPAddress]::Parse("203.0.113.255")
            },
            # Multicast
            @{
                Start = [System.Net.IPAddress]::Parse("224.0.0.0")
                End = [System.Net.IPAddress]::Parse("239.255.255.255")
            }
        )

        $ipBytes = ([System.Net.IPAddress]::Parse($ip)).GetAddressBytes()
        foreach ($range in $reservedIPRanges) {
            $startBytes = $range.Start.GetAddressBytes()
            $endBytes = $range.End.GetAddressBytes()

            if (($ipBytes[0] -ge $startBytes[0] -and $ipBytes[0] -le $endBytes[0]) -and
                ($ipBytes[1] -ge $startBytes[1] -and $ipBytes[1] -le $endBytes[1]) -and
                ($ipBytes[2] -ge $startBytes[2] -and $ipBytes[2] -le $endBytes[2]) -and
                ($ipBytes[3] -ge $startBytes[3] -and $ipBytes[3] -le $endBytes[3])) {
                $result = $true
                break
            }
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-ReservedIP -ip '127.0.0.0'
}

function Test-SalesOrder {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$salesOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$salesOrderId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$customerOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleSalesOrderKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsSalesOrder' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'Sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsSalesOrder = Get-UsedParameters -validParams (Get-SingleSalesOrderKeys) -boundParams $PSBoundParameters
        $firstEntry = $paramsSalesOrder.GetEnumerator() | Select-Object -First 1
        $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingSalesOrderKeys)
        $value = $firstEntry.Value

        $sqlFrag = "$key = '$value'"

        [string]$Sql = "SELECT Id FROM Auftrag WHERE $sqlFrag"
        [bool]$result = $false
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                [bool]$result = $true
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-SalesOrder -customerOrderNo '4711' -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Test-ShopExtension {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nullValue' -Scope 'Private' -Value ($null)
        New-Variable -Name 'objectId' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'Sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        try {
            [string]$Sql = "SELECT OBJECT_ID('esolArtikelShop') [ObjectId]"
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                $nullValue = [DBNull]::Value
                $objectId = $rs.fields('ObjectId').value
                if ($nullValue -eq $objectId) {
                    [bool]$result = $false
                } else {
                    [bool]$result = $true
                }
            }
        }

        catch {
            Throw "$_ Function: $($myInvocation.Mycommand)"
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-ShopExtension -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}

function Test-Verbose {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = [bool](Write-Verbose ([String]::Empty) 4>&1)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-Verbose
}

function Test-XmlSchema {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$xmlFile = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'xmlFile', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$schemaFile = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'schemaFile', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'schema' -Scope 'Private' -Value ($null)
        New-Variable -Name 'schemaReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'validationEventHandler' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xml' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string[]]$Script:xmlValidationErrorLog = @()
        [scriptblock] $validationEventHandler = {
            $Script:xmlValidationErrorLog += "$($args[1].Exception.Message)`r`n"
        }

        $xml = New-Object System.Xml.XmlDocument
        $schemaReader = New-Object System.Xml.XmlTextReader $schemaFile
        $schema = [System.Xml.Schema.XmlSchema]::Read($schemaReader, $validationEventHandler)
        $xml.Schemas.Add($schema) | Out-Null
        $xml.Load($XmlFile)
        $xml.Validate($validationEventHandler)

        if ($Script:xmlValidationErrorLog) {
            # $result = $false
            Write-Warning ((Get-ResStr 'TOTAL_ERRORS_FOUND') -f $Script:xmlValidationErrorLog.Count)
            Throw "$Script:xmlValidationErrorLog"
        }
        else {
            # $result = $true
            Write-Verbose ((Get-ResStr 'XML_SCHEMA_VALIDATED') -f (Get-Filename -path $xmlFile), (Get-Filename -path $schemaFile))
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Test-XmlSchema -xmlFile 'c:\temp\article.xml' -schemaFile  'c:\temp\article.xsd'
}

function Unprotect-String {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        $protectedText = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'protectedText', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        $key = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'key', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $key = Get-ProtectedKey $key
        $result = $protectedText | ConvertTo-SecureString -key $key |
            ForEach-Object {
                [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($_))
            }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Unprotect-String -protectedText "76492d1116743f0423413b16050a5345MgB8AEUAUgAxAEkASwBQAGUAWAA4AFcAMwBhADgANgArAFUANAA3AHIAZgBvAEEAPQA9AHwAZAA5AGEAMAA2ADQAZAAxAGEAZgA1ADkAYgA3ADcANwBlADAAOQBmADUAZgA4ADcANAA3ADUAOAA1ADgAYgAwADUAMAA1AGMAOABmADMAOAA0ADIAOQAzADQAMQA1AGQAMgAzADgAYwBlADkAMgBhADAAYwAyADAAOABiAGUANwA5AGIAOQBkAGUANQA5AGUAYwA4ADMAZQAxAGQANgA0ADIAMABkADYAYwA2ADEAZQA1ADEAZQBjADQAMAAxADkAOQA5AGYAOABkADcAYQA2AGYAZAA5ADEAYwBmADYANwAyADUAOAA1ADYAZQAxADQANgA0AGYAOQBjAGUAMQAyAA==" -key 'MySpecialKey'
}

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

Function Use-Culture {
    [CmdletBinding()]
    param(
        [System.Globalization.CultureInfo]
        $culture = $(throw (Get-ResStr 'HELP_USE_CULTURE'))
        ,
        [ScriptBlock]
        $script = $(throw (Get-ResStr 'HELP_USE_CULTURE'))
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    $oldCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
    trap
    {
        [System.Threading.Thread]::CurrentThread.CurrentCulture = $oldCulture
    }
    [System.Threading.Thread]::CurrentThread.CurrentCulture = $culture
    Invoke-Command $script
    [System.Threading.Thread]::CurrentThread.CurrentCulture = $oldCulture
}

function Write-XmlMetadata {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        $writer = $(Throw (Get-ResStr 'PARAM_OBJECT_WRITER_MISSED'))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'upper'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$nodeName = (Convert-StringCase -value ('Metadata') -strCase $strCase)
        $writer.WriteStartElement($nodeName)
            [string]$nodeName = (Convert-StringCase -value ('Version') -strCase $strCase)
            $writer.WriteElementString($nodeName,$ecModuleVersion.toString())

            [string]$nodeName = (Convert-StringCase -value ('Generator') -strCase $strCase)
            $writer.WriteElementString($nodeName,'EulandaConnect')

            [string]$nodeName = (Convert-StringCase -value ('Dateformat') -strCase $strCase)
            $writer.WriteElementString($nodeName,'ISO8601')

            [string]$nodeName = (Convert-StringCase -value ('Floatformat') -strCase $strCase)
            $writer.WriteElementString($nodeName,'US')

            [string]$nodeName = (Convert-StringCase -value ('Countryformat') -strCase $strCase)
            $writer.WriteElementString($nodeName,'ISO2')

            [string]$nodeName = (Convert-StringCase -value ('Fieldnames') -strCase $strCase)
            $writer.WriteElementString($nodeName,'NATIVE')

            [string]$nodeName = (Convert-StringCase -value ('Date') -strCase $strCase)
            $writer.WriteElementString($nodeName,(Convert-DateToIso -value $(Get-Date) -noTimeZone ))

            [string]$nodeName = (Convert-StringCase -value ('PCName') -strCase $strCase)
            $writer.WriteElementString($nodeName, "$env:COMPUTERNAME".ToUpper())

            [string]$nodeName = (Convert-StringCase -value ('UserName') -strCase $strCase)
            $writer.WriteElementString($nodeName, "$env:USERNAME".ToUpper())

        $writer.WriteEndElement()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $writer
    }
    # Test: $stream = New-Object System.IO.MemoryStream;$settings = New-Object System.Xml.XmlWriterSettings;$writer = [System.XML.XmlWriter]::Create($stream, $settings);Write-XmlMetadata -writer $writer
}




# -----------------------------------------------------------------------------
# Private functions
# -----------------------------------------------------------------------------

function Add-DecimalPoint {
    [CmdletBinding()]
    param(
        [string]$number
        ,
        [int]$decimalPlaces = 2
        ,
        [Alias('decimal')]
        [string]$decimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
    )

    <#
        .SYNOPSIS
        Returns a number as a string with a specified number of decimal places.

        .DESCRIPTION
        The function takes a string representation of a number,
        and returns it with the specified number of decimal places.
        If the input string is empty, it will return "0,00".

        .PARAMETER number
        A string representation of the number to which the decimal point is to be added.

        .PARAMETER decimalPlaces
        The number of decimal places to be added to the number. Default is 2.

        .PARAMETER decimalSeparator
        The character to use as a decimal separator. The default is the current system's decimal separator.

        .EXAMPLE
        PS C:\> Add-DecimalPoint -number '10000' -decimalPlaces 2
        This command will return '100,00'.

        .EXAMPLE
        PS C:\> Add-DecimalPoint -number '10000' -decimalPlaces 3
        This command will return '10,000'.

        .EXAMPLE
        PS C:\> Add-DecimalPoint -number '10000' -decimalPlaces 2 -decimalSeparator '.'
        This command will return '100.00'.

        .NOTES
        The function appends leading zeros to numbers that are shorter than the number of decimal places specified.
        If a number starts with a decimal separator after the transformation, a '0' is prepended.
    #>


    # If the string is empty, return "0,00" (with two decimal places)
    if ([string]::IsNullOrEmpty($number)) {
        return "0," + "0" * $decimalPlaces
    }

    # If the number of digits is less than the decimalPlaces, prepend it with 0's
    while ($number.Length -lt $decimalPlaces) {
        $number = "0" + $number
    }

    # Insert the comma at the correct place
    $number = $number.Insert($number.Length - $decimalPlaces, $decimalSeparator)

    # If the number now starts with a comma, prepend it with a 0
    if ($number[0] -eq $decimalSeparator) {
        $number = "0" + $number
    }

    return $number
}

function Convert-DatanormDateFormat {
    [CmdletBinding()]
    param(
        [string]$date
    )
    <#
        .SYNOPSIS
        Converts a date string from the Datanorm date format (TTMMJJ) to the ISO 8601 date format (YYYY-MM-DD).

        .DESCRIPTION
        This function takes a date string formatted according to the Datanorm date standard (day, month, two-digit year) and converts it to the ISO 8601 date format.
        The function assumes that the input year is in the 2000s.

        .PARAMETER date
        The input date string to be converted from Datanorm format to ISO 8601 format.

        .EXAMPLE
        PS C:\> Convert-DatanormDateFormat -date '310122'
        This command converts the Datanorm date string '310122' (January 31, 2022) to the ISO 8601 date string '2022-01-31'.

        .NOTES
        This function is useful for processing Datanorm files, which use a different date format (TTMMJJ) than the widely used ISO 8601 standard.
        Invalid date strings that don't follow the expected format will trigger an exception.
    #>

    # Ensure the date string is in the expected format
    if ($date -match '^(\d{2})(\d{2})(\d{2})$') {
        # Extract the day, month and year
        $day = $Matches[1]
        $month = $Matches[2]
        $year = $Matches[3]

        # Construct a new date string in the format "YYYY-MM-DD"
        # Here we assume the year is in the 2000s
        $newDate = "20$year-$month-$day"

        return $newDate
    } else {
        Throw ((Get-ResStr 'WRONG_DATANORM_DATE_FORMAT') -f $myInvocation.Mycommand)
    }
}

function Convert-ToMultipart() {
    Param(
        [Parameter(Mandatory = $false)]
        [hashtable]$params = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'params', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$boundary = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'boundary', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = ""
        $crlf = "`r`n"

        foreach ($entry in $params.GetEnumerator()) {
            switch ($entry.value.GetType().Name) {
                "FileInfo" {
                    $fileBinary = [IO.File]::ReadAllBytes($entry.value.FullName)
                    $encoding = [System.Text.Encoding]::GetEncoding("iso-8859-1")
                    $encodedContent = $encoding.GetString($fileBinary)
                    $FileName = Split-Path $entry.value.FullName -leaf

                    $result = "$result--$boundary$crlf" +
                        "Content-Disposition: form-data; name=`"$($entry.Name)`"; filename=`"$fileName`"$crlf" +
                        "Content-Type: application/octet-stream$crlf" +
                        "$crlf" +
                        "$encodedContent$crlf"
                }
                Default {
                    $result = "$result--$boundary$crlf" +
                        "Content-Type: text/plain; charset=utf-8$crlf" +
                        "Content-Disposition: form-data; name=`"$($entry.Name)`"$crlf" +
                        "$crLf" +
                        "$(Convert-ToUTF7 $entry.Value)$crLf"

                }
            }
            Write-Verbose "$myInvocation.Mycommand | Name: $($entry.Name) | Type: $($entry.Value.GetType().Name) | Value: $($entry.Value)"
        }
        $result = "$result--$boundary--$crLf"
    }

    end {
        Get-CurrentVariables -initialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test
}

function Convert-ToUTF7 {
    Param(
        [Parameter(Mandatory = $false)]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($value)
        [string]$result = [System.Text.Encoding]::UTF7.GetString($bytes)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Convert-ToUTF7
}

function Get-ConnFromStr {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'connStr', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'conn' -Scope 'Private' -Value ($null)
    }

    process {
        $conn = new-object -comObject ADODB.Connection
        $conn.CursorLocation = $adUseClient
        $conn.ConnectionString = $connStr
        $conn.CommandTimeout = $adTimeout
        $conn.open()
    }

    end {
        Return $conn
    }
    # Because its private function the test is like this:
    # Test:  $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
    #        & $Features { Get-ConnFromStr -connStr 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID=Eulanda;Initial Catalog=Eulanda_Truccamo;Data Source=.\SQL2019' }
}

function Get-ConnFromUdl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'udl', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'conn' -Scope 'Private' -Value ($null)
    }

    process {
        $conn = new-object -comObject ADODB.Connection
        $conn.CursorLocation = $adUseClient
        $conn.ConnectionString = "File Name=$udl"
        $conn.CommandTimeout = $adTimeout
        $conn.open()
    }

    end {
        Return $conn
    }
    # Because its private function the test is like this:
    # Test:  $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
    #        & $Features {  Get-ConnFromUdl -udl 'C:\temp\Eulanda_1 Eulanda.udl' }

}

function Get-DatanormCuSurcharge {
    [CmdletBinding()]
    param (
        [int]$divisionCode
        ,
        [double]$cuIncluded
        ,
        [double]$cuWeight
        ,
        [double]$cuDel = 879 # last official cuDel (Copper-DEL Notation) price 02/2022
    )

    <#
        .SYNOPSIS
        Calculates the copper surcharge for a product based on various parameters
        including the copper weight, the division code, and the included and actual copper prices.

        .DESCRIPTION
        The `Get-DatanormCuSurcharge` function calculates the copper surcharge that applies to a product
        in a Datanorm file. The calculation is based on the weight of copper in the product,
        the division code that indicates how the weight is measured (per unit, per 100 units, or per 1000 units),
        and the difference between the included and actual copper prices.

        The copper weight must be specified in kilograms. The division code is an integer value where 0 indicates
        no copper processing, 1 indicates that the weight is per 100 units,
        and 2 indicates that the weight is per 1000 units.

        The included copper price and actual copper price (known as `cuDel`) should be specified per 100 kg.
        The function returns the calculated copper surcharge. If the surcharge would be
        negative (i.e., the actual price is less than the included price), the function returns 0.

        .PARAMETER divisionCode
        The division code for the copper weight. Valid values are 0 (no copper processing),
        1 (weight is per 100 units), and 2 (weight is per 1000 units).

        .PARAMETER cuIncluded
        The copper price already included in the base product price, specified per 100 kg.

        .PARAMETER cuWeight
        The weight of copper in the product, specified in kilograms but depends also on the devisionCode

        .PARAMETER cuDel
        The actual copper price, specified per 100 kg. The default value is 879.

        .EXAMPLE
        Get-DatanormCuSurcharge -cuWeight 2.5 -divisionCode 1 -cuDel 879 -cuIncluded 150

        This example calculates the copper surcharge for a product with a copper weight of 2.5 kg,
        a division code of 1 (indicating that the weight is per 100 units),
        and an included copper price of 150 per 100 kg. The actual copper price (cuDel)
        is assumed to be the default value of 879 per 100 kg.

        The result is in this case: 0,18225 EUR
    #>

    $copperSurcharge = 0

    $weightPerUnit = Get-DatanormCuWeight -cuWeight $cuWeight -divisionCode $divisionCode

    # Calculate the copper surcharge
    if ($weightPerUnit -gt 0) {
        $copperSurcharge = $weightPerUnit * ($cuDel - $cuIncluded) / 100
        if ($copperSurcharge -lt 0.0) {
            $copperSurcharge = [double]0.0
        }
    }

    return $copperSurcharge

    # Test: Get-DatanormCuSurcharge -cuWeight 2.5 -divisionCode 1 -cuDel 879 -cuIncluded 150
}

function Get-CurrentVariables {
<#
.SYNOPSIS
    A helper function to identify new local variables in the current scope
    when debugging PowerShell scripts.

.DESCRIPTION
    The Get-CurrentVariables function is a debugging tool designed to help
    identify new local variables created in the current scope of a script.
    The function works by comparing the current set of variables to an
    initial set and outputting the difference.
    This allows the user to easily identify new variables and their types.
    When the Debug switch is set, the function generates the code necessary
    to initialize these new variables with their appropriate default values.

.PARAMETER InitialVariables
    An array of variable names representing the initial set of variables
    before executing the main code. If this parameter is not provided,
    the function returns the current set of variables in the scope.

.EXAMPLE
    function ExampleFunction {
        [CmdletBinding()]
        param ()

        begin {
            $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
        }

        process {
            # Your main code here and now some new variables...
            $localVar1 = "Example 1"
            $localVar2 = "Example 2"
            $localVar3 = [version]"0.0"
        }

        end {
            Get-CurrentVariables -initialVariables $initialVariables -Debug:$DebugPreference
        }
    }
    ExampleFunction -Debug

    The above example demonstrates how to use Get-CurrentVariables in a script to
    identify new local variables when debugging is enabled.
    The function is called in the begin and end blocks of the script,
    and the new variables are output with their initialization code when the
    Debug switch is set.

    Screenoutput is:
    Neue lokale Variablen:
    New-Variable -Name 'localVar1' -Scope 'Private' -Value ('')
    New-Variable -Name 'localVar2' -Scope 'Private' -Value ('')
    New-Variable -Name 'localVar3' -Scope 'Private' -Value ([System.Version]::new())
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string[]]$initialVariables
    )

    function Test-IsComObject {
        param ( $inputObject )
        return ($inputObject -is [System.__ComObject])
    }

    if ($PSBoundParameters['Debug']) {
        New-Variable -Name 'currentVariables' -Scope 'Private' -Value @()
        New-Variable -Name 'newVariables' -Scope 'Private' -Value @()
        New-Variable -Name 'firstTime' -Scope 'Private' -Value ([bool]$false)
        New-Variable -Name 'variableName' -Scope 'Private' -Value ''
        New-Variable -Name 'variable' -Scope 'Private' -Value ([PsVariable]$null)
        New-Variable -Name 'type' -Scope 'Private' -Value ''
        New-Variable -Name 'initValue' -Scope 'Private' -Value ''
        New-Variable -Name 'privateVariableCode' -Scope 'Private' -Value ''

        $currentVariables = (Get-Variable).Name

        if ($initialVariables) {
            $newVariables = $currentVariables | Where-Object { $_ -notin $initialVariables } | Sort-Object -Property @{Expression = { $_ -eq 'result' }; Ascending = $true }

            # $newVariables = $currentVariables | Where-Object { $_ -notin $initialVariables }
            $firstTime = $true
            foreach ($variableName in $newVariables) {
                $variable = Get-Variable $variableName

                if (($null -ne $variable.Value) -and ($variable.name -notlike '_*')) {
                    # $type = $variable.Value.GetType().ToString()  # $type = $variable.Value.GetType().FullName
                    if (Test-IsComObject $variable.Value) {
                        $type = "COM-Object"
                    } elseif ($null -ne $variable.Value) {
                        $type = $variable.Value.GetType().ToString()
                    } else {
                        $type = "null"
                    }

                    if ($type.StartsWith("System.Text.UTF8Encoding")) {
                        $type = 'System.Text.Encoding'
                        $initValue = '[System.Text.Encoding]::UTF8'
                    } else {
                        # Set initialization values by type
                        # Write-Host "$($variable.Name) : $type"
                        switch ($type) {
                            'System.Boolean' { $initValue = '[boolean]$false' }
                            'System.Byte' { $initValue = '[byte]0' }
                            'System.Int16' { $initValue = '[int16]0' }
                            'System.Int32' { $initValue = '[int32]0' }
                            'System.Int64' { $initValue = '[int64]0' }
                            'System.UInt16' { $initValue = '[uint16]0' }
                            'System.UInt32' { $initValue = '[uint32]0' }
                            'System.UInt64' { $initValue = '[uint64]0' }
                            'System.Single' { $initValue = '[single]0.0' }
                            'System.Double' { $initValue = '[double]0.0' }
                            'System.Decimal' { $initValue = '[decimal]0.0' }
                            'System.String' { $initValue = "[string]''" }
                            'System.String[]' { $initValue = '[string[]]@()' }
                            'System.Array' { $initValue = '[array]@()' }
                            'System.Hashtable' { $initValue = '[hashtable]@{}' }
                            'System.Collections.ArrayList' { $initValue = '[System.Collections.ArrayList]@()' }
                            'System.Collections.Hashtable' { $initValue = '[System.Collections.Hashtable]@{}' }
                            'System.Object' { $initValue = '[System.Object]::New()' }
                            'System.Object[]' { $initValue = '[System.Object[]]@()' }
                            'System.IO.StringWriter' { $initValue = '[System.IO.StringWriter]::new()' }
                            default { $initValue = '$null' } # Set to null for all other types
                        }
                    }
                    $privateVariableCode = "New-Variable -Name '$($variable.Name)' -Scope 'Private' -Value ($initValue)"

                    if ($firstTime) { Write-Host (Get-ResStr 'NEW_VARIABLES') -ForegroundColor Yellow }
                    Write-Host $privateVariableCode -ForegroundColor Yellow
                    $firstTime = $false
                }
            }
        } else {
            return $currentVariables
        }
    } else {
        Return @()
    }
}

function Get-DatanormConditionDecimals {
    [CmdletBinding()]
    param(
        [string]$condition,
        [int]$indicator
    )
    <#
        .SYNOPSIS
        Returns a Datanorm condition with decimal places based on the provided condition indicator.

        .DESCRIPTION
        In Datanorm files, there is a condition indicator in the type P record,
        which determines the number of decimal places of another field.
        This function returns the condition with the correct number of decimal
        places based on the indicator.

        .PARAMETER condition
        A string representing the Datanorm condition.

        .PARAMETER indicator
        An integer representing the Datanorm condition indicator.
        The number of decimal places is determined based on this indicator.

        .EXAMPLE
        PS C:\> Get-DatanormConditionDecimals -condition '10000' -indicator 1
        This command will return '100,00'.

        .EXAMPLE
        PS C:\> Get-DatanormConditionDecimals -condition '10000' -indicator 2
        This command will return '10,000'.

        .EXAMPLE
        PS C:\> Get-DatanormConditionDecimals -condition '10000' -indicator 3
        This command will return '100,00'.

        .NOTES
        The function throws an exception if an invalid condition indicator is passed.
    #>

    switch ($indicator) {
        0 { return $condition }
        1 { return $condition.Insert($condition.Length - 2, ",") }
        2 { return $condition.Insert($condition.Length - 3, ",") }
        3 { return $condition.Insert($condition.Length - 2, ",") }
        default { Throw ((Get-ResStr 'INVALID_DATANORM_INDICATOR') -f $indicator, $myInvocation.Mycommand) }
    }
}

function Get-DatanormCuWeight {
    [CmdletBinding()]
    param (
        [int]$divisionCode
        ,
        [double]$cuWeight
    )

    <#
        .SYNOPSIS
        Calculates the copper weight per unit for a given item based on the supplied division code and copper weight.

        .DESCRIPTION
        The `Get-DatanormCuWeight` function calculates the copper weight per unit for a specific
        item based on the supplied division code and the total copper weight of the item.
        The division code determines how the total copper weight is divided:

        - Division code 0: The item doesn't involve any copper processing, so the copper weight per unit is 0.
        - Division code 1: The copper weight provided is for 100 units, so the total copper weight is
          divided by 100 to get the copper weight per unit.
        - Division code 2: The copper weight provided is for 1000 units, so the total copper weight is
          divided by 1000 to get the copper weight per unit.

        .PARAMETER divisionCode
        The division code indicating how the total copper weight is to be divided to get the copper
        weight per unit. Accepted values are 0, 1, and 2.

        .PARAMETER cuWeight
        The total copper weight for the item. This will be divided according to the
        division code to calculate the copper weight per unit.

        .EXAMPLE
        Get-DatanormCuWeight -cuWeight 2.5 -divisionCode 1
        This command calculates the copper weight per unit for an item with a total copper
        weight of 2.5kg, where this weight is for 100 units.

        Result is: 0,025 kg per unit copper

        .INPUTS
        System.Int32, System.Double

        .OUTPUTS
        System.Double

        .NOTES
        The division code must be one of the following values:
        0 - The item does not involve any copper processing.
        1 - The copper weight provided is for 100 units.
        2 - The copper weight provided is for 1000 units.
        Any other value will cause an error.
    #>


    # Calculate the weight per unit depending on the Merker value
    switch ($divisionCode) {
        0 { $weightPerUnit = 0 } # no copper processing
        1 { $weightPerUnit = $cuWeight / 100 } # weight is per 100 units
        2 { $weightPerUnit = $cuWeight / 1000 } # weight is per 1000 units
        default { throw (Get-ResStr 'DATANORM_DEVISIONCODE_ERROR') -f $divisionCode, $myInvocation.Mycommand }
    }

    return $weightPerUnit

    # Test: Get-DatanormCuWeight -cuWeight 2.5 -divisionCode 1
}

Function Get-DatanormPricePerUnit {
    param(
        [double]$price
        ,
        [int]$priceUnitCode
    )

    $priceUnit = Get-DatanormPriceUnit -priceUnitCode $priceUnitCode
    if ($priceUnit -gt 1) {
        $result = $price / $priceUnit
    } else {
        $result = $price
    }

    Return $result
}

Function Get-DatanormPriceUnit {
    param(
        [int]$priceUnitCode
    )

    switch ($priceUnitCode) {
        0 { $priceUnit = [int]1 }
        1 { $priceUnit = [int]10 }
        2 { $priceUnit = [int]100 }
        3 { $priceUnit = [int]1000 }
        default { throw (Get-ResStr 'DATANORM_PRICEUNITCODE_ERROR') -f $priceUnitCode, $myInvocation.Mycommand }
    }

    Return $priceUnit
}

function Get-DefaultSelectArticle {
    [CmdletBinding()]
    param()

    [string]$result = 'CHANGEDATE, ARTNUMMER, BARCODE, MWSTSATZ, MWSTGR, WAEHRUNG, GEWICHT, ' +`
        'SHOPEXPORTDATUM, SHOPFREIGABEFLG, AUSLAUFFLG, NEUFLG, SONDERFLG, LOESCHFLG, ' +`
        'VERPACKEH, PREISEH, EKNETTO, VK, BRUTTOFLG, VKNETTO, VKBRUTTO, LAGERTYP, ' +`
        'URSPRUNGSLAND, WARENNR, VOLUMEN, KURZTEXT1, KURZTEXT2, ULTRAKURZTEXT, LANGTEXT, INFO'

    Return $result
}
function Get-ErrorFromConn {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [object]$conn = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'conn', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'description' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'err' -Scope 'Private' -Value ($null)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($conn -and $conn.ConnectionString) {
            for ($i = 0; $i -lt $conn.Errors.Count; $i++) {
                $err = $conn.Errors.Item($i)
                $description = $err.Description

                # Check if the error description contains the relevant part
                if ($description -match '\[VENDOR:CNSOFT\]\[ADDRESS:USER\]\[LANGUAGE:DE\]\[PROC:<unknown_proc>\](.*)') {
                    $result = $Matches[1].Trim()
                    break
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Because its private function the test is like this:
    # Test:  $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
    #        $myConn = Get-Conn -udl 'C:\temp\EULANDA_1 Truccamo.udl'
    #        $myConn.execute("Select *") # force an error
    #        & $Features {  Get-ErrorFromConn -conn $myConn -debug }
}

Function Get-FtpDir {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("file", "directory")]
        [string]$dirType = "file"
        ,
        [Parameter(Mandatory = $false)]
        [string]$mask = "*"
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'directoryName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'fileName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'line' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'Matches' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'reader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tokens' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string[]]$result = @()

        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($remoteFolder)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectoryDetails
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false

        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }

        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        Try {
            $ftpResponse = $ftpRequest.GetResponse()
            Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)

            $reader = New-Object System.IO.StreamReader($ftpResponse.GetResponseStream())

            while (!$reader.EndOfStream) {
                $line = $reader.ReadLine()

                $tokens = $line.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

                if ($line -match '^d') {
                    if ($dirType -eq "directory") {
                        $directoryName = [string]::Join(" ", $tokens[8..($tokens.Length-1)])
                        $result += $directoryName
                    }
                } elseif ($line -match '^-') {
                    if ($dirType -eq "file") {
                        $fileName = [string]::Join(" ", $tokens[8..($tokens.Length-1)])
                        $result += $fileName
                    }
                }
            }

            $reader.Close()
            $ftpResponse.Close()


            if (($mask) -and ($mask -ne '*')) {
                $result = $result | Where-Object { $_ -like $mask }
            }

            $result = $result | Sort-Object
        } catch {
            Throw ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-FtpDir -server 'mysftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -mask '*.zip' -dirType file -verbose -debug
}


function Get-FtpFileAge {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileAge' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)/$remoteFolder/$remoteFile")
            $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
            $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetDateTimestamp

            $ftpResponse = $ftpRequest.GetResponse()
            $fileAge = [DateTime]::Now - $ftpResponse.LastModified
            Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)

            $result = [int]$fileAge.TotalSeconds
        } catch [System.Net.WebException] {
            Write-Verbose ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f ($remoteFolder/$remoteFile), $myInvocation.Mycommand)
        } catch {
            Write-Verbose ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
        } finally {
            if ($null -ne $ftpResponse) {
                try {
                    $ftpResponse.Close()
                } catch {
                    Write-Warning ((Get-ResStr 'REMOTE_COULD_NOT_CLOSE') -f $myInvocation.Mycommand, $_)
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Get-FtpFileAge -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFfolder '/EULANDA' -remoteFile 'test.txt' -verbose
}

function Get-FtpFileDate {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $result = [datetime]::MinValue
            $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($erver):$($port)/$remoteFolder/$remoteFile")
            $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
            $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetDateTimestamp

            $ftpResponse = $ftpRequest.GetResponse()
            $result = $ftpResponse.LastModified
            Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
            $ftpResponse.Close()

        } catch [System.Net.WebException] {
            Write-Verbose ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f ($remoteFolder/$remoteFile), $myInvocation.Mycommand)
        } catch {
            Write-Verbose ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Get-FtpFileDate -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -verbose
}
function Get-FtpFileSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'fileSize' -Scope 'Private' -Value ([int64]0)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int64]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)/$remoteFolder/$remoteFile")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetFileSize
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false
        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }
        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        try {
            $ftpResponse = $ftpRequest.GetResponse()
            $fileSize = $ftpResponse.ContentLength
            Write-Verbose "$($myInvocation.Mycommand) status: $($ftpResponse.StatusDescription.Trim())"
            $ftpResponse.Close()
            $result = $fileSize
        } catch {
            Throw ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }

    # Test: Get-FtpFileSize -server 'myftp.eulanda.eu'  -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -remoteFile 'Eulanda_JohnDoe.zip' -verbose
}


function Get-FtpNextFilename {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [parameter(Mandatory = $false)]
        [string]$mask = '*'
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder

    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'date' -Scope 'Private' -Value ($null)
        New-Variable -Name 'dateRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'dateResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileInfo' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'lastColonIndex' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'line' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'list' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'nextSpaceIndex' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'oldestFile' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileSlash' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'reader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($remoteFolder) {
            $remoteFolder = $($remoteFolder.TrimEnd('/'))
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {$remoteFolder = '/'}

        if ($remoteFolder -eq '/') {
            $fileSlash = ''
        } else {
            $fileSlash = '/'
        }

        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($remoteFolder)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectoryDetails
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false

        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }

        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        try {
            $ftpResponse = $ftpRequest.GetResponse()
            $reader = New-Object IO.StreamReader $ftpResponse.GetResponseStream()
            $list = @()
            while(-not $reader.EndOfStream){
                $line = $reader.ReadLine()
                # Each line looks like: '-rw-rw-rw- 1 ftp ftp        51153987 May 11 16:11 Eulanda_JohnDoe - Copy (2).zip'
                $lastColonIndex = $line.LastIndexOf(':')
                $nextSpaceIndex = $line.IndexOf(' ', $lastColonIndex)
                if ($nextSpaceIndex -gt $lastColonIndex) {
                    $fileName = $line.Substring($nextSpaceIndex + 1)
                }

                # Get LastWriteDate for each file
                $dateRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($remoteFolder)$($fileSlash)$($fileName)")
                $dateRequest.Credentials = $ftpRequest.Credentials
                $dateRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetDateTimestamp
                $dateResponse = $dateRequest.GetResponse()
                $date = $dateResponse.LastModified

                $fileInfo = New-Object PSObject -Property @{
                    Name = $fileName
                    LastWriteTime = $date
                }
                $list += ,$fileInfo
            }

            $reader.Close()
            Write-Verbose "$($myInvocation.Mycommand) status: $($ftpResponse.StatusDescription.Trim())"
            $ftpResponse.Close()

            # Filter the list
            $list = $list | Where-Object { $_.Name -like $mask }

            # Sort the list to get oldest
            if ($list) {
                if ($list.Count -gt 0) {
                    $oldestFile = $list | Sort-Object LastWriteTime | Select-Object -First 1
                    $result = $oldestFile.Name
                }
            }

        } catch {
            Throw ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-FtpNextFilename -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -mask '*.xml' -remoteFolder '/EULANDA'
}

function Get-MappingAddressKeys {
    [CmdletBinding()]
    param()

    $result = @{
        'addressId'   = 'Id';
        'addressMatch'= 'Match';
        'addressUid'  = 'Uid';
    }

    Return $result
}

function Get-MappingArticleKeys {
    [CmdletBinding()]
    param()

    $result = @{
        'articleId'   = 'Id';
        'articleNo'   = 'ArtNummer';
        'articleUid'  = 'Uid';
        'Barcode'  = 'Barcode';
    }

    Return $result
}

function Get-MappingSalesOrderKeys {
    [CmdletBinding()]
    param()

    $result = @{
        'salesOrderId'   = 'Id';
        'salesOrderNo'   = 'KopfNummer';
        'customerOrderNo'  = 'Bestellnummer';
    }

    Return $result
}

function Get-MappingTablename {
    [CmdletBinding()]
    param()

    $result = @{
        'article'   = 'artikel';
        'address'   = 'adresse';
        'delivery'  = 'lieferschein';
    }

    Return $result
}

function Get-ProtectedKey {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$key = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'key', $myInvocation.Mycommand))
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    if ($key.length -lt 16) {
        $key = $key.PadRight(16,' ')
    } elseif ($key.length -lt 32) {
        $key = $key.PadRight(32,' ')
    } else {
        Throw ((Get-ResStr 'KEY_LENGTH32_ERROR') -f $myInvocation.Mycommand)
    }

    $length = $key.length
    $pad = 32-$length
    $encoding = New-Object System.Text.ASCIIEncoding
    $bytes = $encoding.GetBytes($key + "0" * $pad)

    return $bytes
}

function Get-PunctuationIdx {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$text
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    [int]$idx = -1

    [int]$i = Get-PunctuationIdxByChar -text $text -Match '.'
    if ($i -gt $idx) { $idx = $i }

    [int]$i = Get-PunctuationIdxByChar -text $text -Match '!'
    if ($i -gt $idx) { $idx = $i }

    [int]$i = Get-PunctuationIdxByChar -text $text -Match '?'
    if ($i -gt $idx) { $idx = $i }

    if ($idx -eq -1) {
        # if no punctuation is found, then take space char
        [int]$i = Get-PunctuationIdxByChar -text  $text -Match  ' '
        if ($i -gt $idx) { $idx = $i }
    }

    if ($idx -eq -1 ) { $idx = $text.Length-1 }
    return $idx
}

function Get-PunctuationIdxByChar {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$text
        ,
        [Parameter(Mandatory = $false)]
        [string]$match
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    [int]$idx = -1
    while (1 -eq 1 ) {
        [Int]$Idx = $text.lastIndexOf($match)
        if ($match -ne ' ') {
            if (($idx -ne -1) -and ($idx -lt $text.length-1)) {
                if ($text.Substring($idx+1, 1) -eq ' ') {
                    break
                } else {
                    if ($text.length -gt 1) {
                        $text = $Text.SubString(0, $idx)
                    } else { break }
                }
            } else { break }
        } else { break }
    }

    if ($idx -le 0) {
        return -1
    } else {
        if ($match -eq ' ') {
            return $idx
        } else { return $idx+1 }
    }
}

function Get-RandomParagraph {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [int]$minSentences = 2
        ,
        [Parameter(Mandatory = $false)]
        [int]$maxSentences = 4
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    $sentences = @()
    $numSentences = Get-Random -Minimum $minSentences -Maximum $maxSentences
    for ($i = 1; $i -le $numSentences; $i++) {
        $sentence = "$(Get-RandomWords)$(Get-RandomPunctuation)"
        if (! $sentences) {
            $sentences = $sentence
        } else { $sentences += " $sentence" }
    }

    return $sentences.TrimEnd()
}

function Get-RandomPunctuation {
    [CmdletBinding()]
    param()

    $punctuations = @(".", ".", ".", ".", ".", "!", "!", "!", "?", "?")
    $index = Get-Random -Minimum 0 -Maximum $punctuations.Count

    return $punctuations[$index]
}

function Get-RandomWords {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [int]$MinWords = 5
        ,
        [Parameter(Mandatory = $false)]
        [int]$MaxWords = 20
    )

    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    $loremIpsum = "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do " +`
        "eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim " +`
        "veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea " +`
        "commodo consequat Duis aute irure dolor in reprehenderit in voluptate " +`
        "velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat " +`
        "cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est " +`
        "laborum"


    $words = $loremIpsum.Split() | Where-Object { $_.Length -gt 1 }
    $numWords = Get-Random -Minimum $MinWords -Maximum $MaxWords

    $result = ""

    for ($i = 1; $i -le $numWords; $i++) {
        $word = $words[(Get-Random -Minimum 0 -Maximum $words.Count)]

        if ($i -eq 1) {
            $word = $word.Substring(0, 1).ToUpper() + $word.Substring(1)
        }

        if ((Get-Random -Minimum 0 -Maximum 10) -eq 0) {
            $word = $word.Substring(0, 1).ToUpper() + $word.Substring(1)
        }

        $result += $word + " "
    }

    return $result.TrimEnd()
}

function Get-ReadOnlyFields {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$tableName
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $readOnlyFields = @()

        $rs = New-Object -ComObject ADODB.Recordset
        $query = "SELECT TOP 0 * FROM $tableName"
        $rs.Open($query, $myConn)

        for ($i=0; $i -lt $rs.Fields.Count; $i++) {
            $field = $rs.Fields.Item($i)
            # write-host "$($field.name) $($field.attributes)"
            if (-not ($field.Attributes -band 0x8)) {  # 0x8 is adFldUpdatable
                $readOnlyFields += $field.Name
            }
        }
        $rs.Close()
        # $readOnlyFields | ForEach-Object { $_.ToUpper() }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $readOnlyFields
    }
}

function Get-SetAddressFilter {
    [CmdletBinding()]
    param()

    return @('select','filter','order','alias','reorder','revers')
}

function Get-SetArticleFilter {
    [CmdletBinding()]
    param()

    return @('select','filter','order','alias','reorder','revers')
}

function Get-SetArticleWithGroupsFilter {
    [CmdletBinding()]
    param()

    return @('select','filter','order','alias','reorder','revers','customerGroups')
}

function Get-SetStringCase {
    [CmdletBinding()]
    param()

    return @('none', 'upper', 'lower', 'capital')
}

function Get-SftpDir {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("file", "directory")]
        [string]$dirType = "file"
        ,
        [Parameter(Mandatory = $false)]
        [string]$mask = "*"
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'entry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'filename' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'list' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string[]]$result = @()

        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {
                $remoteFolder = '/'
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams

            try {
                if ($dirType -eq 'file') {
                    $list = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -File
                } elseif ($dirType -eq 'directory') {
                    $list = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -Directory
                }
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            foreach ($entry in $list) {
                $filename = Split-Path $entry.FullName -Leaf
                $result += $filename
            }

            if (($mask) -and ($mask -ne '*')) {
                $result = $result | Where-Object { $_ -like $mask }
            }

            $result = $result | Sort-Object
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }
    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SftpDir -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -verbose
}
Function Get-SftpFileAge {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileInfo' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'date' -Scope 'Private' -Value ([datetime]::MinValue)
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                $fileInfo = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path "$($remoteFolder.TrimEnd('/'))" -File
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            foreach ($file in $fileInfo) {
                if ($file.FullName -eq "$($remoteFolder.TrimEnd('/'))/$remoteFile") {
                    $date = [datetime]::Now - $file.LastWriteTime
                    break
                }
            }
            $result = [int]$date.TotalSeconds


        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SftpFileAge -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -remoteFile 'Eulanda_JohnDoe.zip' -verbose
}

Function Get-SftpFileDate {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileInfo' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([datetime]::MinValue)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                $fileInfo = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path "$($remoteFolder.TrimEnd('/'))" -File
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            foreach ($file in $fileInfo) {
                if ($file.FullName -eq "$($remoteFolder.TrimEnd('/'))/$remoteFile") {
                    $result = $file.LastWriteTime
                    break
                }
            }

        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SftpFileDate -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -remoteFile 'Eulanda_JohnDoe.zip' -verbose
}

Function Get-SftpFileSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileInfo' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int64]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                $fileInfo = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path "$($remoteFolder.TrimEnd('/'))" -File
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            foreach ($file in $fileInfo) {
                if ($file.FullName -eq "$($remoteFolder.TrimEnd('/'))/$remoteFile") {
                    $result = $file.Length
                    break
                }
            }


        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SftpFileSize -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -remoteFile 'Eulanda_JohnDoe.zip' -verbose
}

function Get-SftpNextFilename {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [parameter(Mandatory = $false)]
        [string]$mask
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFolder

    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'filteredList' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'list' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'oldestFile' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sortedList' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {$remoteFolder = '/'}

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                $list = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -File
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            if ($mask) {
                $filteredList = $list | Where-Object { $_.Name -like "$mask" }
            } else {
                $filteredList = $list
            }

            if ($filteredList) {
                $sortedList = $filteredList | Sort-Object { $_.LastWriteTime }
                $oldestFile = $sortedList[0].Name
                [string]$result = Split-Path $oldestFile -Leaf
            }

        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SftpNextFilename -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -mask '*.xml' -remoteFolder '/EULANDA'
}

function Get-SingleAddressKeys {
    [CmdletBinding()]
    param()

    return (Get-MappingAddressKeys).Keys
}

function Get-SingleArticleKeys {
    [CmdletBinding()]
    param()

    return (Get-MappingArticleKeys).Keys
}

function Get-SingleConnection {
    [CmdletBinding()]
    param()

    return @("conn", "connStr", "udl")
}

function Get-SingleDeliveryKeys {
    [CmdletBinding()]
    param()

    return @("deliveryId", "deliveryNo")
}

function Get-SingleSalesOrderKeys {
    [CmdletBinding()]
    param()

    Return (Get-MappingSalesOrderKeys).Keys
}

function Get-SingleToken {
    [CmdletBinding()]
    param()

    return @("token", "encryptedToken", "secureToken", "pathToToken")
}
function Get-TranslateExtractTag {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$value
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    [string]$iso = ""
    [string]$SubVar = ""
    [string[]]$result = @("", "")

    $value = $value.Substring(0, $value.Length-1) # delete last
    $value = $value.Substring(1, $value.Length-1) # delete first
    $value = $value.ToUpper()

    # check for an optional part
    $p = $value.IndexOf(":")
    if ($p -eq -1) {
        $iso = $value.ToUpper()
    } else {
        if ($p -eq 0 ) {
            $subVar = $value.Substring(1, $value.Length-1).ToUpper()
            $iso = "00" # Default
        } else {
            $iso = $value.Substring(0, 2).ToUpper()
            $subVar = $value.SubString(3, $value.Length-3).ToUpper()
        }

    }
    $result[0] = $iso
    $result[1] = $subVar
    Return $result
}

function Get-TranslateIsDelim {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$value
    )

    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

    [bool]$result = $false
    # test if the first character is an open bracket
    if ($value.SubString(0,1) -eq "[") {
        $value = $value.TrimEnd()
        # test if the last character is a closed bracket
        if ($value.Substring($value.Length-1) -eq "]") {
            $value = $value.Substring(0, $value.Length-1)  # delete last
            $value = $value.Substring(1, $value.Length-1)  # delete first

            # check if there is an optional part
            $p = $value.IndexOf(":")
            if ($p -eq -1) {
                # without optional part the iso tag must be 2 characters long
                if ($value.Length -eq 2) {$result = $True } else { $result = $False }
            } else {
                # valid positions for the colon are the first or the third (after the iso-tag)
                if (($p -eq 0) -or ($p -eq 2)) { $result = $True } else { $result = $False }
            }
        }
    }
    Return $result
}

function Get-UsedParameters {
    param (
        [Parameter(Mandatory = $false)]
        [string[]]$validParams = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'validParams', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [System.Collections.Hashtable]$boundParams = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'boundParams', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'keyLower' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'validParamsLower' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
      # Convert the valid parameters to lowercase letters
      $validParamsLower = $validParams | ForEach-Object { $_.ToLower() }

      foreach ($key in $boundParams.Keys) {
          # Convert the current key to lowercase letters
          $keyLower = $key.ToLower()

          # Check if the lowercase key is included in the valid parameters
          if ($validParamsLower -contains $keyLower) {
              # Add the element with the original key to the result
              $result[$key] = $boundParams[$key]
          }
      }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $result
    }

}

function New-FtpFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'folder' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'folders' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $folders = $remoteFolder -split '/'
        $path = ""
        foreach ($folder in $folders) {
            if ($folder) {
                $path = $path + '/' + $folder
                if (-not(Test-FtpFolder -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $path  )) {
                    $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$path")
                    $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
                    $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
                    $ftpRequest.UseBinary = $true
                    $ftpRequest.KeepAlive = $false
                    if ($protocol -eq 'ftps') {
                        $ftpRequest.EnableSsl = $true
                    } else {
                        $ftpRequest.EnableSsl = $false
                    }
                    if ($activeMode) {
                        $ftpRequest.UsePassive = $false
                    } else {
                        $ftpRequest.UsePassive = $true
                    }
                    $ftpResponse = $ftpRequest.GetResponse()
                    Write-Verbose "$($myInvocation.Mycommand) status: $($ftpResponse.StatusDescription.Trim())"
                    $ftpResponse.Close()
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
     # Test:  New-FtpFolder -server 'myftp.eulanda.eu'  -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -verbose -debug
}

Function New-SftpFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'folder' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'folders' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                $folders = $remoteFolder -split '/'
                [string]$path = ""
                foreach ($folder in $folders) {
                    if ($folder) {
                        $path = $path + '/' + $folder
                        if (-not(Test-SftpFolder -server $server -port $port -user $user -password $password -remoteFolder $path  )) {
                            New-SFTPItem -SessionId $SFTPSession.SessionId -Path $path -ItemType Directory | Out-Null
                        }
                    }
                }
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  New-SftpFolder -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -verbose
}

Function Receive-FtpFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeRetries = 7
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'buffer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fullLocalPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'fullRemotePath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'localFileStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'read' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'responseStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'retryCount' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [int]$retryCount = 0

        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($remoteFolder -eq '/') {
            $fullRemotePath = "/$remoteFolder/$remoteFile"
        } else {
            $fullRemotePath = "$remoteFolder/$remoteFile"
        }

        if (! $localFile) {
            $localFile = $remoteFile
        }

        if ($localFolder) {
            if ($localFolder -ne '\' ) {
                $localFolder = "$($localFolder.TrimEnd('\'))"
            }
        }

        $fullLocalPath = (Join-Path $localFolder $localFile)

        # Create target folder, also recursiv, if folder does not exists
        New-Item -ItemType Directory -Path $localFolder -Force | Out-Null

        while ($retryCount -lt $resumeRetries) {
            try {
                $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($fullRemotePath)")
                $ftpRequest.Credentials = New-Object System.Management.Automation.PSCredential($user, $password)
                $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::DownloadFile

                $ftpRequest.UseBinary = $true
                $ftpRequest.KeepAlive = $false

                if ($protocol -eq 'ftps') {
                    $ftpRequest.EnableSsl = $true
                } else {
                    $ftpRequest.EnableSsl = $false
                }

                if ($activeMode) {
                    $ftpRequest.UsePassive = $false
                } else {
                    $ftpRequest.UsePassive = $true
                }

                $ftpResponse = $ftpRequest.GetResponse()
                $responseStream = $ftpResponse.GetResponseStream()

                $localFileStream = [System.IO.File]::Create($fullLocalPath)
                $buffer = New-Object byte[] 1024
                while (($read = $responseStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
                    $localFileStream.Write($buffer, 0, $read)
                }

                $responseStream.Close()
                $responseStream.Dispose()
                $localFileStream.Close()
                $localFileStream.Dispose()
                Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
                $ftpResponse.Close()
                break

            } catch {
                $retryCount++
                Remove-Item -path $fullLocalPath -force -ErrorAction SilentlyContinue
                if ($retryCount -ge $resumeRetries) {
                    throw ((Get-ResStr 'MAX_RETRY_COUNT_REACHED') -f $resumeRetries, $myInvocation.Mycommand)
                } else {
                    Write-Warning ((Get-ResStr 'REMOTEFILE_ERROR_RESUMING') -f $myInvocation.Mycommand, 'Download', $retryCount, $resumeRetries)
                }
            }
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Receive-FtpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -localFolder 'C:\temp' -localFile 'newText.txt'
}

function Receive-SftpFile {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [int]$port= 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [parameter(Mandatory = $false)]
        [string]$localFolder
        ,
        [parameter(Mandatory = $false)]
        [string]$localFile

    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fullRemotePath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tempFolder' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global


            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {
                $remoteFolder = '/'
            }

            if ($remoteFolder -eq '/') {
                $fullRemotePath = "/$remoteFolder/$remoteFile"
            } else {
                $fullRemotePath = "$remoteFolder/$remoteFile"
            }

            if (! $localFile) {
                $localFile = $remoteFile
            }

            if ($localFolder) {
                if ($localFolder -ne '\' ) {
                    $localFolder = "$($localFolder.TrimEnd('\'))"
                }
            }

            if ($localFile -ne $remoteFile) {
                # Create Tempfolder with (local) file name
                [string]$tempFolder = $(New-TempDir)
            } else {
                [string]$tempFolder = $localFolder
            }

            # Create target folder, also recursiv, if folder does not exists
            New-Item -ItemType Directory -Path $localFolder -Force | Out-Null

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                Get-SFTPItem -SessionId $SFTPSession.SessionId -Path $fullRemotePath -destination $tempFolder -Force
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            if ($tempFolder -ne $localFolder) {
                if (Test-Path -Path (Join-Path $localFolder $localFile)) {
                    Remove-Item -Path (Join-Path $localFolder $localFile) -Force
                }

                Move-Item -Path (Join-Path $tempFolder $remoteFile) -Destination (Join-Path $localFolder $localFile)
                Remove-Item -Path $tempFolder -recurse -force -ErrorAction SilentlyContinue
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Receive-SftpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -localFolder 'C:\temp' -localFile 'newTest.txt'
}

function Remove-FtpFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder = '/'
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fullPath' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (! $remoteFolder -or $remoteFolder -eq "/") {
            $fullPath = "/$remoteFile"
        } else {
            $fullPath = "$($remoteFolder.TrimEnd('/'))/$remoteFile"
        }

        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($fullPath)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::DeleteFile
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false

        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }

        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        $ftpResponse = $ftpRequest.GetResponse()
        Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
        $ftpResponse.Close()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Remove-FtpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt'
}

function Remove-FtpFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder = '/'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($remoteFolder)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::RemoveDirectory
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false

        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }

        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        try {
            $ftpResponse = $ftpRequest.GetResponse()
            Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
        }
        finally {
            $ftpResponse.Close()
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Remove-FtpFolder -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA'
}

function Remove-SftpFile {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [int]$port= 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFile = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'remoteFile', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fullPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if (! $remoteFolder -or $remoteFolder -eq "/") {
                $fullPath = "/$remoteFile"
            } else {
                $fullPath = "$($remoteFolder.TrimEnd('/'))/$remoteFile"
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                Remove-SFTPItem -SessionId $SFTPSession.SessionId -Path "$fullPath"
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Remove-SftpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt'
}

function Remove-SftpFolder {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [int]$port= 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fullPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {
                $remoteFolder = '/'
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                Remove-SFTPItem -SessionId $SFTPSession.SessionId -Path $remoteFolder
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Remove-SftpFolder -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA'
}

function Rename-FtpFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder = '/'
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'remoteParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($newFolder) {
            [string]$newFolder = "$($newFolder.TrimEnd('/'))"
            if (! $newFolder) { $newFolder = '/'}
        }

        if ($remoteFolder -eq '/') {
            $oldPath = "$($remoteFolder)$remoteFile"
        } else {
            $oldPath = "$remoteFolder/$remoteFile"
        }

        if ($newFolder -and $newFile) {
            if ($newFolder -eq '/') {
                $newPath = "$($newFolder)$newFile"
            } else {
                $newPath = "$newFolder/$newFile"
            }
        } elseif ($newFolder) {
            if ($newFolder -eq '/') {
                $newPath = "$($newFolder)$remoteFile"
            } else {
                $newPath = "$newFolder/$remoteFile"
            }
        } else {
            if ($remoteFolder -eq '/') {
                $newPath = "$($remoteFolder)$newFile"
            } else {
                $newPath = "$remoteFolder/$newFile"
            }
            $newFolder = $remoteFolder
        }

        $remoteParams = @{
            server = $server
            protocol = $protocol
            port = $port
            activeMode = $activeMode
            user = $user
            password = $password
        }

        # Old path must exist
        if (! (Test-FtpFolder @remoteParams -remoteFolder $oldPath)) {
            Throw ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f $oldPath, $myInvocation.Mycommand)
        }



        # Create target folder if it not exists
        if ($newFolder) {
            if (! (Test-FtpFolder @remoteParams -remoteFolder $newFolder)) {
                New-FtpFolder @remoteParams -remoteFolder $newFolder
            }
        }

        # Delete the destination, if the target file exists
        if ((Test-FtpFolder @remoteParams -remoteFolder $newPath)) {
            Remove-FtpFile @remoteParams -remoteFolder $newPath
        }


        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($oldPath)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::Rename
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false

        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }

        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        $ftpRequest.RenameTo = $newPath
        $ftpResponse = $ftpRequest.GetResponse()
        Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
        $ftpResponse.Close()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Rename-FtpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' newFile 'newTest.txt'
}

function Rename-FtpFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder = '/'
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($newFolder) {
            [string]$newFolder = "$($newFolder.TrimEnd('/'))"
            if (! $newFolder) { $newFolder = '/'}
        } else {
            $newFolder = '/'
        }

        if ($remoteFolder -eq '/') {
            Throw ((Get-ResStr 'REMOTE_FOLDER_ISEMPTY_OR_ROOT') -f 'old', $myInvocation.Mycommand)
        }

        if ($newFolder -eq '/') {
            Throw ((Get-ResStr 'REMOTE_FOLDER_ISEMPTY_OR_ROOT') -f 'new', $myInvocation.Mycommand)
        }

        $remoteParams = @{
            server = $server
            protocol = $protocol
            port = $port
            activeMode = $activeMode
            user = $user
            password = $password
        }

        if (! (Test-FtpFolder @remoteParams -remoteFolder $remoteFolder)) {
            Throw ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f $remoteFolder, $myInvocation.Mycommand)
        }

        if (Test-FtpFolder @remoteParams -remoteFolder $newFolder) {
            Throw ((Get-ResStr 'REMOTE_FOLDER_EXISTS_ALREADY') -f $newFolder, $myInvocation.Mycommand)
        }

        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($remoteFolder)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::Rename
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false

        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }

        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        $ftpRequest.RenameTo = $newFolder
        $ftpResponse = $ftpRequest.GetResponse()
        Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
        $ftpResponse.Close()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Rename-FtpFolder -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' newFolder '/BELANDA'
}

function Rename-SftpFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder = '/'
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'remoteParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {
                $remoteFolder = '/'
            }

            if ($newFolder) {
                [string]$newFolder = "$($newFolder.TrimEnd('/'))"
                if (! $newFolder) { $newFolder = '/'}
            }

            if ($remoteFolder -eq '/') {
                $oldPath = "$($remoteFolder)$remoteFile"
            } else {
                $oldPath = "$remoteFolder/$remoteFile"
            }

            if ($newFolder -and $newFile) {
                if ($newFolder -eq '/') {
                    $newPath = "$($newFolder)$newFile"
                } else {
                    $newPath = "$newFolder/$newFile"
                }
            } elseif ($newFolder) {
                if ($newFolder -eq '/') {
                    $newPath = "$($newFolder)$remoteFile"
                } else {
                    $newPath = "$newFolder/$remoteFile"
                }
            } else {
                if ($remoteFolder -eq '/') {
                    $newPath = "$($remoteFolder)$newFile"
                } else {
                    $newPath = "$remoteFolder/$newFile"
                }
                $newFolder = $remoteFolder
            }

            $remoteParams = @{
                server = $server
                port = $port
                certificate = $certificate
                user = $user
                password = $password
            }

            # Old path must exist
            if (! (Test-SftpFolder @remoteParams -remoteFolder $oldPath)) {
                Throw ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f $oldPath, $myInvocation.Mycommand)

            }

            # Create target folder if it not exists
            if ($newFolder) {
                if (! (Test-SftpFolder @remoteParams -remoteFolder $newFolder)) {
                    New-SftpFolder @remoteParams -remoteFolder $newFolder
                }
            }

            # Delete the destination, if the target file exists
            if ((Test-SftpFolder @remoteParams -remoteFolder $newPath)) {
                Remove-SftpFile @remoteParams -remoteFolder $newPath
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                Move-SFTPItem -SessionId $SFTPSession.SessionId -Path $oldPath -Destination $newPath
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Rename-SftpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' newFile 'newTest.txt'
}

function Rename-SftpFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder = '/'
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {
                $remoteFolder = '/'
            }

            if ($newFolder) {
                [string]$newFolder = "$($newFolder.TrimEnd('/'))"
                if (! $newFolder) { $newFolder = '/'}
            } else {
                $newFolder = '/'
            }

            if ($remoteFolder -eq '/') {
                Throw ((Get-ResStr 'REMOTE_FOLDER_ISEMPTY_OR_ROOT') -f 'old', $myInvocation.Mycommand)
            }

            if ($newFolder -eq '/') {
                Throw ((Get-ResStr 'REMOTE_FOLDER_ISEMPTY_OR_ROOT') -f 'new', $myInvocation.Mycommand)
            }

            $remoteParams = @{
                server = $server
                port = $port
                certificate = $certificate
                user = $user
                password = $password
            }

            if (! (Test-SftpFolder @remoteParams -remoteFolder $remoteFolder)) {
                Throw ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f $remoteFolder, $myInvocation.Mycommand)
            }

            if (Test-SftpFolder @remoteParams -remoteFolder $newFolder) {
                Throw ((Get-ResStr 'REMOTE_FOLDER_EXISTS_ALREADY') -f $newFolder, $myInvocation.Mycommand)
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                Move-SFTPItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -Destination $newFolder
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Rename-FtpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' newFile 'newTest.txt'
}

Function Send-FtpFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeAge = 60*60*3
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeRetries = 7
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [int]$retryCount = 0

        if (! $remoteFile) {
            $remoteFile = $localFile
        }

        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($remoteFolder -eq "/") {
            $fullRemotePath = "/$remoteFile"
        } else {
            $fullRemotePath = "$($remoteFolder)/$remoteFile"
        }

        $fullLocalPath = Join-Path $localFolder $localFile

        if (! (Test-FtpFolder -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder)) {
            New-FtpFolder -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder
        }

        while ($retryCount -lt $resumeRetries) {
            try {
                # Delete old file if exists, if its a younger we try to resume upload
                $fileAge = Get-FtpFileAge -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
                # Resume works only if not older then 3 hours
                if ($fileAge -gt $resumeAge) {
                    Remove-FtpFile -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
                    Write-Verbose ((Get-ResStr 'REMOTEFILE_TO_OLD_TO_RESUME') -f $remoteFile, $myInvocation.Mycommand)
                    $fileAge = 0
                }

                $remoteFileSize = Get-FtpFileSize -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
                $localFileSize = (Get-Item $fullLocalPath).Length
                Write-Verbose "Local Filesize: $localFileSize"
                Write-Verbose "Remote file size: $remoteFileSize"

                # Delete when remote has greater file size
                if ($remoteFileSize -gt $localFileSize) {
                    Remove-FtpFile -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
                    Write-Verbose ((Get-ResStr 'REMOTEFILE_TO_BIG_TO_RESUME') -f $remoteFile, $myInvocation.Mycommand)
                    $fileAge = 0
                }

                if ($fileAge) {
                    Write-Verbose ((Get-ResStr 'REMOTEFILE_IS_RESUMING') -f $localFile, $myInvocation.Mycommand)

                    if ($remoteFileSize -lt $localFileSize) {
                        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$fullRemotePath")

                        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
                        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
                        $ftpRequest.UseBinary = $true
                        $ftpRequest.KeepAlive = $false

                        if ($protocol -eq 'ftps') {
                            $ftpRequest.EnableSsl = $true
                        } else {
                            $ftpRequest.EnableSsl = $false
                        }

                        if ($activeMode) {
                            $ftpRequest.UsePassive = $false
                        } else {
                            $ftpRequest.UsePassive = $true
                        }

                        $ftpRequest.ContentOffset = $remoteFileSize

                        $fileStream = New-Object System.IO.FileStream($fullLocalPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read)
                        $fileStream.Position = $remoteFileSize
                        $bufferSize = 1024
                        $buffer = New-Object byte[] $bufferSize
                        $bytesRead = $fileStream.Read($buffer, 0, $bufferSize)

                        $requestStream = $ftpRequest.GetRequestStream()
                        while ($bytesRead -gt 0) {
                            $requestStream.Write($buffer, 0, $bytesRead)
                            $bytesRead = $fileStream.Read($buffer, 0, $bufferSize)
                        }

                        $fileStream.Close()
                        $fileStream.Dispose()
                        $requestStream.Close()
                        $requestStream.Dispose()

                        $ftpResponse = $ftpRequest.GetResponse()
                        Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
                        $ftpResponse.Close()
                    } else {
                        Write-Verbose ((Get-ResStr 'REMOTEFILE_UPLOAD_BYPASSED') -f $localFile, $myInvocation.Mycommand)
                    }
                } else {
                    Write-Verbose ((Get-ResStr 'REMOTEFILE_IS_UPLOADED_NEW') -f $localFile, $myInvocation.Mycommand)

                    $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$fullRemotePath")
                    $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
                    $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile

                    $ftpRequest.UseBinary = $true
                    $ftpRequest.KeepAlive = $false

                    if ($protocol -eq 'ftps') {
                        $ftpRequest.EnableSsl = $true
                    } else {
                        $ftpRequest.EnableSsl = $false
                    }

                    if ($activeMode) {
                        $ftpRequest.UsePassive = $false
                    } else {
                        $ftpRequest.UsePassive = $true
                    }

                    $fileContent = [System.IO.File]::ReadAllBytes($fullLocalPath)
                    $ftpRequest.ContentLength = $fileContent.Length

                    $requestStream = $ftpRequest.GetRequestStream()
                    $requestStream.Write($fileContent, 0, $fileContent.Length)
                    $requestStream.Close()
                    $requestStream.Dispose()

                    $ftpResponse = $ftpRequest.GetResponse()
                    Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
                    $ftpResponse.Close()
                }
                break

            } catch {
                $retryCount++
                if ($retryCount -ge $resumeRetries) {
                    Throw ((Get-ResStr 'MAX_RETRY_COUNT_REACHED') -f $resumeRetries, $myInvocation.Mycommand)
                } else {
                    Write-Warning ((Get-ResStr 'REMOTEFILE_ERROR_RESUMING') -f $myInvocation.Mycommand, 'Upload', $retryCount, $resumeRetries)
                }
            }
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Send-FtpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -localFolder 'C:\temp' -localFile 'text.txt'
}

function Send-SftpFile {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server
        ,
        [parameter(Mandatory = $false)]
        [int]$port= 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFolder = '/'
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [parameter(Mandatory = $false)]
        [string]$localFolder
        ,
        [parameter(Mandatory = $false)]
        [string]$localFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fullLocalPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'fullTempPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tempPath' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if (! $remoteFile) {
                $remoteFile = $localFile
            }

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {
                $remoteFolder = '/'
            }

            [string]$fullLocalPath = Join-Path $localFolder $localFile
            if (! (Test-Path $fullLocalPath)) {
                Throw ((Get-ResStr 'LOCALFILE_OR_FOLDER_DONT_EXISTS') -f $fullLocalPath, $myInvocation.Mycommand)
            }

            if ($localFile -ne $remoteFile) {
                # Create Tempfolder with destination (remote) file name
                [string]$tempPath = $(New-TempDir)
                [string]$fullTempPath = Join-Path $tempPath $remoteFile
                Copy-Item -Path $fullLocalPath -Destination $fullTempPath -Force
            } else {
                [string]$fullTempPath = $fullLocalPath
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                # Create remote folder if not exists
                if (! (Test-SftpPath -SessionId $SFTPSession.SessionId -Path $remoteFolder)) {
                    New-SFTPItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -ItemType 'Directory' -Recurse | Out-Null
                }

                Set-SFTPItem -SessionId $SFTPSession.SessionId -Path $fullTempPath -Destination $remoteFolder -Force
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            # Remove folder only, if the file was copied prior
            if ($tempPath) {
                Write-Verbose ((Get-ResStr 'REMOVE_TEMPFILES') -f $tempPath, $myInvocation.Mycommand)
                Remove-Item -Path $tempPath -recurse -force -ErrorAction SilentlyContinue
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Send-SftpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -localFolder 'C:\temp' -localFile 'text.txt'
}

function Set-Tls() {
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Valid values: SystemDefault, SSL3, Tls, Tls11, Tls12, Tls13
        # Since 2012-2023: Tls, Tls11 and Tls12 are working
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor `
        [Net.SecurityProtocolType]::Tls11 -bor `
        [Net.SecurityProtocolType]::Tls12
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:   Set-Tls
}

Function Test-FtpFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'path' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($remoteFolder -eq '/') {
            $path = "/$remoteFile"
        } else {
            $path = "$remoteFolder/$remoteFile"
        }

        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($path)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetFileSize
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false

        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }

        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        try {
            $ftpResponse = $ftpRequest.GetResponse()
            Write-Verbose "$($myInvocation.Mycommand) status: $($ftpResponse.StatusDescription.Trim())"
            $ftpResponse.Close()
            $result = $true
        } catch {
            $result = $false
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-FtpFile -server 'mysftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -verbose -debug
}


Function Test-FtpFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'path' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($remoteFolder -eq '/') {
            $path = "/$remoteFile"
        } else {
            $path = "$remoteFolder/$remoteFile"
        }

        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($path)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectoryDetails
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false

        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }

        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        try {
            $ftpResponse = $ftpRequest.GetResponse()
            Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
            $ftpResponse.Close()
            $result = $true
        } catch {
            $result = $false
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-FtpFolder -server 'mysftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -verbose -debug
}


Function Test-SftpFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'path' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {
                $remoteFolder = '/'
            }

            if ($remoteFolder -eq '/') {
                $path = "/$remoteFile"
            } else {
                $path = "$remoteFolder/$remoteFile"
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                $result = Test-SFTPPath -SessionId $SFTPSession.SessionId -Path $path
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-SftpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -verbose -debug
}

Function Test-SftpFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'path' -Scope 'Private' -Value ([string]'/')
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if ($remoteFolder) {
                [string]$path = "$($remoteFolder.TrimEnd('/'))"
                if (! $path) { $path = '/'}
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                $result = Test-SFTPPath -SessionId $SFTPSession.SessionId -Path $path
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-SftpFolder -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -verbose -debug
}

function Test-ValidateConn {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [object]$conn
    )

    if ($conn -and $conn -is [System.__ComObject]) {
        return $true
    }
    else {
        throw "The connection object is not a valid COM object."
    }
}

function Test-ValidateConnStr {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$connStr
    )

    $regex = "^(?=.*Data Source=)(?=.*Initial Catalog=).*"
    if (![string]::IsNullOrEmpty($connStr) -and $connStr -notmatch $regex) {
        Throw "The connection string '$connStr' is not valid."
    }

    return $true
}

function Test-ValidateCustomerGroups {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)]
        [AllowEmptyString()]
        [string]$customerGroups
    )
    begin {
        $regexPattern = '^[\w\s-]*((,[\w\s-]+)+)?$'
    }
    process {
        if (-not [string]::IsNullOrEmpty($customerGroups)) {
            if ($customerGroups -notmatch $regexPattern) {
                throw ((Get-ResStr 'CUSTOMERGROPUP_NOT_VALID') -f $customerGroup, $myInvocation.Mycommand)
            }
        }
    }
    end {
        $true
    }
}

function Test-ValidateFileExists {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    process {
        if (-not (Test-Path $path)) {
            throw ((Get-ResStr 'FILE_DOES_NOT_EXIST') -f $path, $myInvocation.Mycommand)
        }
        return $true
    }
}

function Test-ValidateId {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)]
        [ValidateRange(-2147483648,2147483647)]
        [int]$id = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'id', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$name = 'ID'
    )

    if ($id -lt 1) {
        if ($name) {
            throw ((Get-ResStr 'VALIDATE_NAMED_INT_ERROR') -f $name, $id, $myInvocation.Mycommand)
        } else {
            throw ((Get-ResStr 'VALIDATE_INT_ERROR') -f $id, $myInvocation.Mycommand)
        }
    }

    return $id
}

Function Test-ValidateLeastOne {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $false)]
        [string[]]$validParams = @()
        ,
        [Parameter(ValueFromRemainingArguments = $false)]
        [string[]]$remainingArguments = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'remainingArguments', $myInvocation.Mycommand))
    )

    begin {
        $count = 0

        $parentFunctionName = ""
        $callStack = Get-PSCallStack
        for ($i = 1; $i -lt $callStack.Count; $i++) {
            $fn = $callStack[$i].FunctionName
            if ($fn -ne $MyInvocation.MyCommand.Name) {
                $parentFunctionName = $fn
                break
            }
        }

        $parentFunctionName = $parentFunctionName.Replace("<Begin>", "").TrimEnd()
        $parentFunction = Get-Command -Name $parentFunctionName -All | Where-Object { $_.CommandType -eq 'Function' } | Select-Object -First 1
        $commonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters
        $parentParameters = $parentFunction.Parameters.Keys | Where-Object { $_ -ne 'RemainingArguments' -and $commonParameters -notcontains $_ }

        if ($null -eq $remainingArguments -or $remainingArguments.Count -eq 0) {
            $remainingArguments = @()
            foreach ($param in $parentParameters) {
                $remainingArguments += "-$param"
                $remainingArguments += $null
            }
        }

        if ($validParams.Count -eq 0) {
            $validParams = $parentParameters
        }

        for ($i = 0; $i -lt $remainingArguments.Count; $i += 2) {
            $paramName = $remainingArguments[$i].Substring(1).TrimEnd(':')
            $paramValue = $remainingArguments[$i+1]
            if (-not [string]::IsNullOrEmpty($paramValue)) {
                if ($validParams -contains $paramName) {
                    $count++
                }
            }
        }
    }

    process {
        if ($count -lt 1) {
            $validParamsList = $ValidParams -join ', '
            $message = ((Get-ResStr 'PARAMS_AT_LEAST_ONE') -f $validParamsList, $parentFunctionName)
            throw $message
        }
    }
}

function Test-ValidateMapping {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$strValue
        ,
        [Parameter(Mandatory = $false)]
        [hashtable]$mapping
    )

    $allValidValues = $mapping.Keys + $mapping.Values

    if ($strValue -notin $allValidValues) {
        throw ((Get-ResStr 'VALIDATE_FROM_SET_ERROR') -f $strValue, $($allValidValues -join ', '), $myInvocation.Mycommand)
    }

    if ($mapping.ContainsKey($strValue)) {
        $result = $mapping[$strValue]
    } else {
        $result = $strValue
    }

    Return $result
}

function Test-ValidateNo {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)]
        [Alias('no')]
        [ValidateRange(-2147483648,2147483647)]
        [int]$transactionNo
        ,
        [parameter(Mandatory = $false)]
        [string]$name = 'Transaction Number'
    )

    if ($transactionNo -lt 1) {
        if ($name) {
            throw ((Get-ResStr 'VALIDATE_NAMED_INT_ERROR') -f $name, $transactionNo, $myInvocation.Mycommand)
        } else {
            throw ((Get-ResStr 'VALIDATE_INT_ERROR') -f $transactionNo, $myInvocation.Mycommand)
        }
    }

    return $transactionNo
}

function Test-ValidateNotEmpty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$strParam
    )

    if ($strParam -eq "") {
        throw ((Get-ResStr 'PARAMETER_IS_EMPTY') -f 'strParam', $myInvocation.Mycommand)
    }

    return $true
}

function Test-ValidatePathPS {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$path
    )

    if ($path) {
        $Extension = [System.IO.Path]::GetExtension($path)
        $pathOnly = Split-Path $path

        if (!(Test-Path $pathOnly)) {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'PATH_NOT_EXISTS') -f $path)
        }
        if ($Extension -ne '.ps1') {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'MUST_BE_PS1FILE') -f $path)
        }
    }
    return $true
}

function Test-ValidatePathUDL {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [Alias('udl')]
        [string]$path
    )

    if ($path) {
        $Extension = [System.IO.Path]::GetExtension($path)
        $pathOnly = Split-Path $path

        if (!(Test-Path $pathOnly)) {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'PATH_NOT_EXISTS') -f $path)
        }
        if ($Extension -ne '.udl') {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'MUST_BE_UDLFILE') -f $path)
        }
    }
    return $true
}

function Test-ValidatePathXML {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$path
    )

    if ($path) {
        $Extension = [System.IO.Path]::GetExtension($path)
        $pathOnly = Split-Path $path

        if (!(Test-Path $pathOnly)) {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'PATH_NOT_EXISTS') -f $path)
        }
        if ($Extension -ne '.xml') {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'MUST_BE_XMLFILE') -f $path)
        }
    }
    return $true
}

function Test-ValidateSelect {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$strParam
    )

    if ($strParam -eq "") {
        throw ((Get-ResStr 'PARAMETER_IS_EMPTY') -f 'select', $myInvocation.Mycommand)
    }

    return $true
}

Function Test-ValidateSingle {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [string[]]$validParams = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'validParams', $myInvocation.Mycommand))
        ,
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$remainingArguments
    )

    begin {
        $count = 0
        # $RemainingArguments contains all parameters of the calling function.
        # In $RemainingArguments each entry with even index is a parameter name and each odd is
        # the parameter value. Each parameter name is stored as with a leading hyphen and a
        # closing colon, such as '-udl:'. Before comparison the characters are removed.
        if ($null -ne $remainingArguments -and $remainingArguments.GetType().IsArray) {
            for ($i = 0; $i -lt $remainingArguments.Count; $i += 2) {
                $paramName = $remainingArguments[$i].Substring(1, $remainingArguments[$i].Length - 2)
                $paramValue = $remainingArguments[$i+1]
                if (-not [string]::IsNullOrEmpty($paramValue)) {
                    if ($validParams -contains $paramName) {
                        $count++
                    }
                }
            }
        }
    }

    process {
        if ($count -ne 1) {
            $validParamsList = $ValidParams -join ', '
            $parentFunctionName = ""
            $callStack = Get-PSCallStack
            for ($i = 1; $i -lt $callStack.Count; $i++) {
                $fn = $callStack[$i].FunctionName
                if ($fn -ne $MyInvocation.MyCommand.Name) {
                    $parentFunctionName = $fn
                    break
                }
            }
            $parentFunctionName = $parentFunctionName.Replace("<Begin>", "").TrimEnd()
            $message = ((Get-ResStr 'PARAMS_EXACTLY_ONE') -f $validParamsList, $parentFunctionName)
            throw $message
        }
    }
}

function Test-ValidateStringCase {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$value
    )

    if ($value -in (Get-SetStringCase)) {
        return $true
    } else {
        throw ((Get-ResStr 'PARAMS_INVALID_VALUE') -f ((Get-SetStringCase) -join ', ') )
    }
}

function Test-ValidateUrl {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$url = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'url', $myInvocation.Mycommand))
    )

    if ($url -match "^(http|https)://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$") {
        return $true
    } else {
        throw ((Get-ResStr 'PARAMS_INVALID_URL') -f $url)
    }
}


# SIG # Begin signature block
# MIIpiQYJKoZIhvcNAQcCoIIpejCCKXYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCOvks9haA0M2wn
# xM8D/4kH+CSj6iZ1BKrLbZLkA4bmYqCCEngwggVvMIIEV6ADAgECAhBI/JO0YFWU
# jTanyYqJ1pQWMA0GCSqGSIb3DQEBDAUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQI
# DBJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoM
# EUNvbW9kbyBDQSBMaW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2Vy
# dmljZXMwHhcNMjEwNTI1MDAwMDAwWhcNMjgxMjMxMjM1OTU5WjBWMQswCQYDVQQG
# EwJHQjEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMS0wKwYDVQQDEyRTZWN0aWdv
# IFB1YmxpYyBDb2RlIFNpZ25pbmcgUm9vdCBSNDYwggIiMA0GCSqGSIb3DQEBAQUA
# A4ICDwAwggIKAoICAQCN55QSIgQkdC7/FiMCkoq2rjaFrEfUI5ErPtx94jGgUW+s
# hJHjUoq14pbe0IdjJImK/+8Skzt9u7aKvb0Ffyeba2XTpQxpsbxJOZrxbW6q5KCD
# J9qaDStQ6Utbs7hkNqR+Sj2pcaths3OzPAsM79szV+W+NDfjlxtd/R8SPYIDdub7
# P2bSlDFp+m2zNKzBenjcklDyZMeqLQSrw2rq4C+np9xu1+j/2iGrQL+57g2extme
# me/G3h+pDHazJyCh1rr9gOcB0u/rgimVcI3/uxXP/tEPNqIuTzKQdEZrRzUTdwUz
# T2MuuC3hv2WnBGsY2HH6zAjybYmZELGt2z4s5KoYsMYHAXVn3m3pY2MeNn9pib6q
# RT5uWl+PoVvLnTCGMOgDs0DGDQ84zWeoU4j6uDBl+m/H5x2xg3RpPqzEaDux5mcz
# mrYI4IAFSEDu9oJkRqj1c7AGlfJsZZ+/VVscnFcax3hGfHCqlBuCF6yH6bbJDoEc
# QNYWFyn8XJwYK+pF9e+91WdPKF4F7pBMeufG9ND8+s0+MkYTIDaKBOq3qgdGnA2T
# OglmmVhcKaO5DKYwODzQRjY1fJy67sPV+Qp2+n4FG0DKkjXp1XrRtX8ArqmQqsV/
# AZwQsRb8zG4Y3G9i/qZQp7h7uJ0VP/4gDHXIIloTlRmQAOka1cKG8eOO7F/05QID
# AQABo4IBEjCCAQ4wHwYDVR0jBBgwFoAUoBEKIz6W8Qfs4q8p74Klf9AwpLQwHQYD
# VR0OBBYEFDLrkpr/NZZILyhAQnAgNpFcF4XmMA4GA1UdDwEB/wQEAwIBhjAPBgNV
# HRMBAf8EBTADAQH/MBMGA1UdJQQMMAoGCCsGAQUFBwMDMBsGA1UdIAQUMBIwBgYE
# VR0gADAIBgZngQwBBAEwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC5jb21v
# ZG9jYS5jb20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5jcmwwNAYIKwYBBQUHAQEE
# KDAmMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJKoZI
# hvcNAQEMBQADggEBABK/oe+LdJqYRLhpRrWrJAoMpIpnuDqBv0WKfVIHqI0fTiGF
# OaNrXi0ghr8QuK55O1PNtPvYRL4G2VxjZ9RAFodEhnIq1jIV9RKDwvnhXRFAZ/ZC
# J3LFI+ICOBpMIOLbAffNRk8monxmwFE2tokCVMf8WPtsAO7+mKYulaEMUykfb9gZ
# pk+e96wJ6l2CxouvgKe9gUhShDHaMuwV5KZMPWw5c9QLhTkg4IUaaOGnSDip0TYl
# d8GNGRbFiExmfS9jzpjoad+sPKhdnckcW67Y8y90z7h+9teDnRGWYpquRRPaf9xH
# +9/DUp/mBlXpnYzyOmJRvOwkDynUWICE5EV7WtgwggYcMIIEBKADAgECAhAz1wio
# kUBTGeKlu9M5ua1uMA0GCSqGSIb3DQEBDAUAMFYxCzAJBgNVBAYTAkdCMRgwFgYD
# VQQKEw9TZWN0aWdvIExpbWl0ZWQxLTArBgNVBAMTJFNlY3RpZ28gUHVibGljIENv
# ZGUgU2lnbmluZyBSb290IFI0NjAeFw0yMTAzMjIwMDAwMDBaFw0zNjAzMjEyMzU5
# NTlaMFcxCzAJBgNVBAYTAkdCMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxLjAs
# BgNVBAMTJVNlY3RpZ28gUHVibGljIENvZGUgU2lnbmluZyBDQSBFViBSMzYwggGi
# MA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQC70f4et0JbePWQp64sg/GNIdMw
# hoV739PN2RZLrIXFuwHP4owoEXIEdiyBxasSekBKxRDogRQ5G19PB/YwMDB/NSXl
# wHM9QAmU6Kj46zkLVdW2DIseJ/jePiLBv+9l7nPuZd0o3bsffZsyf7eZVReqskmo
# PBBqOsMhspmoQ9c7gqgZYbU+alpduLyeE9AKnvVbj2k4aOqlH1vKI+4L7bzQHkND
# brBTjMJzKkQxbr6PuMYC9ruCBBV5DFIg6JgncWHvL+T4AvszWbX0w1Xn3/YIIq62
# 0QlZ7AGfc4m3Q0/V8tm9VlkJ3bcX9sR0gLqHRqwG29sEDdVOuu6MCTQZlRvmcBME
# Jd+PuNeEM4xspgzraLqVT3xE6NRpjSV5wyHxNXf4T7YSVZXQVugYAtXueciGoWnx
# G06UE2oHYvDQa5mll1CeHDOhHu5hiwVoHI717iaQg9b+cYWnmvINFD42tRKtd3V6
# zOdGNmqQU8vGlHHeBzoh+dYyZ+CcblSGoGSgg8sCAwEAAaOCAWMwggFfMB8GA1Ud
# IwQYMBaAFDLrkpr/NZZILyhAQnAgNpFcF4XmMB0GA1UdDgQWBBSBMpJBKyjNRsjE
# osYqORLsSKk/FDAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAT
# BgNVHSUEDDAKBggrBgEFBQcDAzAaBgNVHSAEEzARMAYGBFUdIAAwBwYFZ4EMAQMw
# SwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdv
# UHVibGljQ29kZVNpZ25pbmdSb290UjQ2LmNybDB7BggrBgEFBQcBAQRvMG0wRgYI
# KwYBBQUHMAKGOmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1B1YmxpY0Nv
# ZGVTaWduaW5nUm9vdFI0Ni5wN2MwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNl
# Y3RpZ28uY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBfNqz7+fZyWhS38Asd3tj9lwHS
# /QHumS2G6Pa38Dn/1oFKWqdCSgotFZ3mlP3FaUqy10vxFhJM9r6QZmWLLXTUqwj3
# ahEDCHd8vmnhsNufJIkD1t5cpOCy1rTP4zjVuW3MJ9bOZBHoEHJ20/ng6SyJ6UnT
# s5eWBgrh9grIQZqRXYHYNneYyoBBl6j4kT9jn6rNVFRLgOr1F2bTlHH9nv1HMePp
# GoYd074g0j+xUl+yk72MlQmYco+VAfSYQ6VK+xQmqp02v3Kw/Ny9hA3s7TSoXpUr
# OBZjBXXZ9jEuFWvilLIq0nQ1tZiao/74Ky+2F0snbFrmuXZe2obdq2TWauqDGIgb
# MYL1iLOUJcAhLwhpAuNMu0wqETDrgXkG4UGVKtQg9guT5Hx2DJ0dJmtfhAH2KpnN
# r97H8OQYok6bLyoMZqaSdSa+2UA1E2+upjcaeuitHFFjBypWBmztfhj24+xkc6Zt
# CDaLrw+ZrnVrFyvCTWrDUUZBVumPwo3/E3Gb2u2e05+r5UWmEsUUWlJBl6MGAAjF
# 5hzqJ4I8O9vmRsTvLQA1E802fZ3lqicIBczOwDYOSxlP0GOabb/FKVMxItt1UHeG
# 0PL4au5rBhs+hSMrl8h+eplBDN1Yfw6owxI9OjWb4J0sjBeBVESoeh2YnZZ/WVim
# VGX/UUIL+Efrz/jlvzCCBuEwggVJoAMCAQICEGilgQZhq4aQSRu7qELTizkwDQYJ
# KoZIhvcNAQELBQAwVzELMAkGA1UEBhMCR0IxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
# aXRlZDEuMCwGA1UEAxMlU2VjdGlnbyBQdWJsaWMgQ29kZSBTaWduaW5nIENBIEVW
# IFIzNjAeFw0yMjAxMjcwMDAwMDBaFw0yNDAxMjcyMzU5NTlaMIGmMRIwEAYDVQQF
# EwlIUkIgMTg4NzAxEzARBgsrBgEEAYI3PAIBAxMCREUxHTAbBgNVBA8TFFByaXZh
# dGUgT3JnYW5pemF0aW9uMQswCQYDVQQGEwJERTEPMA0GA1UECAwGSGVzc2VuMR4w
# HAYDVQQKDBVFVUxBTkRBIFNvZnR3YXJlIEdtYkgxHjAcBgNVBAMMFUVVTEFOREEg
# U29mdHdhcmUgR21iSDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMzT
# O8Mbj+llr7AC7DuCfXcQUJJsAnYeHudXCXyw/vCpdBJLvd3IMkk0EGtl/owTlq9t
# m6tdzPTjh4bUjJQVqmsdfo15EldPOI9fTuaoG4xBDeJwhdFC/tiNfq/JsCWWclca
# 50QBBo5JDAZvCJSrw71t7s5LLzs0rHMUnDjKyjAWwd7qC+tTZdwaGAppx6bpL9vd
# CzLZDQZGbOkZL1eaPikwkou98XY7DeaF/SzpAuQP6oVfgjoe82fLlgXBhl92KGB8
# M+E96okXJNrNFPY3iYWLRJk5D/r0NUkJR+NY/hxC8wnRqLyc9ANh99ykTSe5OlD9
# kx4DlStypnmQIm9oV+oRKr3cXKH+QvWh23sjdw42pkiHK0MP39RJDs5Jk0NG8FUY
# MrMTFiTmsxg9sJsLKWmFy/MzvJycVHnyKe6WTMeVz63ouCK/Ep41BIuajW/ivcCx
# LfSYAwzxpGQgEdta2eZrvna9+EzTiuEBoaV4mDGTdg1/P8Hjr/9a6fREl82Rqw3W
# CCt6ymOb31fxkUSr6Be26CY3JEHnxbb30PsVmNFCdayKjKbjf39zzTEWQRGSywC7
# +bgQWHu2kFvSH9YSWTxDjZdsdrL2bUvmobCTmaDCxTgjRiaBh+jSzhQ0M1MkQNzf
# W/gwP4z6a0FO2YatdXJFVGpV4rOzlHOsulFiyvgNAgMBAAGjggHXMIIB0zAfBgNV
# HSMEGDAWgBSBMpJBKyjNRsjEosYqORLsSKk/FDAdBgNVHQ4EFgQUsZ5evsRYcZpr
# WcPwOErnS2ZxP7cwDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAwEwYDVR0l
# BAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQMEkGA1UdIARCMEAwNQYM
# KwYBBAGyMQECAQYBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20v
# Q1BTMAcGBWeBDAEDMEsGA1UdHwREMEIwQKA+oDyGOmh0dHA6Ly9jcmwuc2VjdGln
# by5jb20vU2VjdGlnb1B1YmxpY0NvZGVTaWduaW5nQ0FFVlIzNi5jcmwwewYIKwYB
# BQUHAQEEbzBtMEYGCCsGAQUFBzAChjpodHRwOi8vY3J0LnNlY3RpZ28uY29tL1Nl
# Y3RpZ29QdWJsaWNDb2RlU2lnbmluZ0NBRVZSMzYuY3J0MCMGCCsGAQUFBzABhhdo
# dHRwOi8vb2NzcC5zZWN0aWdvLmNvbTA2BgNVHREELzAtoBwGCCsGAQUFBwgDoBAw
# DgwMREUtSFJCIDE4ODcwgQ1jbkBldWxhbmRhLmRlMA0GCSqGSIb3DQEBCwUAA4IB
# gQBNj78jtsmPrpiGXPRt/DAyJJDd8CHHbH7SQpEC2abBc4ypmnseXbSIQlZdySaJ
# BOrDqj75gjB5FOSbir9FsIzPLgP2qjTyxsd3FtRcNcXDK7VIZgxmeJh2ipsXAqsB
# nivA9Vut2mu72wQ877VSkoUYIe7JMAUDKG0qwHU4LyMXoNYttto2y7yR6odDYwGC
# YxXNlPNx9wNVzJOMhnRalP1fwRC9RwjUoizGAEUg5BNh7dKNkSFRzimHh2iAvgeV
# akhbV2+IkekWo7GdEwGLLUSUG8tLwLxOXQ2qsJyOPv0bK/OXiqkgyvqzJ3TRZWiS
# KNX5jSiwwUBrA8vNyCh6d8ZCorwimYkDyGtstF0D9UoU9dX66QrfTsK+zxO7/0QF
# 1qIc5CTZe6Kcsuxe99p5UbPU665d5BvOwq0lJKg59k+6exo1Cc5awip+d4krfyWl
# D1sMkS0eiRSN1UNVs3Hg5gbaEEBx98sQMBF45vv0DFgY/SQVRp9yaFayTyfbb/qk
# jc8xghZnMIIWYwIBATBrMFcxCzAJBgNVBAYTAkdCMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxLjAsBgNVBAMTJVNlY3RpZ28gUHVibGljIENvZGUgU2lnbmluZyBD
# QSBFViBSMzYCEGilgQZhq4aQSRu7qELTizkwDQYJYIZIAWUDBAIBBQCgfDAQBgor
# BgEEAYI3AgEMMQIwADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEE
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQg9qbsPcgXx+JJ
# b4kG0JRTvf9IJ1r1YkJxOnsnGGzdoTowDQYJKoZIhvcNAQEBBQAEggIAhX5Dfzjy
# Y9ln8R3Flq/yWOeL6ZalqkRbRekUDlKtLBCBgay6sXM8sdAWppL6FT20b2vhrwlY
# TF/huWSqhkHTdOLpryPHJsOWN9O/mWAUdQnma75BdnEP9IeQxmT08kc2F96bEfpI
# mJsNyfPTRHO7a3/WLpJvwJI0PEfk70KmsMORKX8moC9dl++XKAJiSkI+udjk/Qyn
# orjCYZinNW/3JE3feWEssJCP0w14OwxbBgTEiD10azan2csoCf1m7aErmiJpi5MK
# NYepanG17AcgszsVny4p9GB/djTJPJ2d4WxVoQfCOVnX2CG93jX1s6XovX2bhUmB
# jxPGsIvBvcmgxe22pQxL5BaPpB9HUiHKamcBnl9I3U2irxxiiJ6pd2AZH2Te1jPi
# xzpaXgtJygyV8W9tZS0Ewcy/yfgdpFICYPj4o1ykDse7jvGx1SvGe3iDkv/pVc0y
# EY+gkkGw2T1vn6aDMTmcu/3p3Lhn9GLxjkN+RDhZ3hXTUImh8C2BbDzdHHBr7vk3
# 1nrf6zsZViMQMYNl7knWe5orj+zLoNTm0FAo8MgUuCY4j1I2aNqIThcGnVtGQqLP
# QNQvYimFjU2TwstjxKVeyOHMaUpnn5dFaGoiVKVTguBwLBaz6o7zqQ6sb87oCxBt
# aHgXfghQxWrxUo73fXgIESM43Kc8bm5sKjWhghNPMIITSwYKKwYBBAGCNwMDATGC
# EzswghM3BgkqhkiG9w0BBwKgghMoMIITJAIBAzEPMA0GCWCGSAFlAwQCAgUAMIHw
# BgsqhkiG9w0BCRABBKCB4ASB3TCB2gIBAQYKKwYBBAGyMQIBATAxMA0GCWCGSAFl
# AwQCAQUABCCdSv4nJ7mBYKTYzC2ypXk/d5fUHVA/PJD4Wv3oh+8BuwIVAMLAq+go
# hRy76+wjlFuWkIsd99hfGA8yMDIzMDYyODE4MjA0OVqgbqRsMGoxCzAJBgNVBAYT
# AkdCMRMwEQYDVQQIEwpNYW5jaGVzdGVyMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
# ZWQxLDAqBgNVBAMMI1NlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgU2lnbmVyICM0
# oIIN6TCCBvUwggTdoAMCAQICEDlMJeF8oG0nqGXiO9kdItQwDQYJKoZIhvcNAQEM
# BQAwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
# MA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSUwIwYD
# VQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBMB4XDTIzMDUwMzAwMDAw
# MFoXDTM0MDgwMjIzNTk1OVowajELMAkGA1UEBhMCR0IxEzARBgNVBAgTCk1hbmNo
# ZXN0ZXIxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGln
# byBSU0EgVGltZSBTdGFtcGluZyBTaWduZXIgIzQwggIiMA0GCSqGSIb3DQEBAQUA
# A4ICDwAwggIKAoICAQCkkyhSS88nh3akKRyZOMDnDtTRHOxoywFk5IrNd7BxZYK8
# n/yLu7uVmPslEY5aiAlmERRYsroiW+b2MvFdLcB6og7g4FZk7aHlgSByIGRBbMfD
# CPrzfV3vIZrCftcsw7oRmB780yAIQrNfv3+IWDKrMLPYjHqWShkTXKz856vpHBYu
# sLA4lUrPhVCrZwMlobs46Q9vqVqakSgTNbkf8z3hJMhrsZnoDe+7TeU9jFQDkdD8
# Lc9VMzh6CRwH0SLgY4anvv3Sg3MSFJuaTAlGvTS84UtQe3LgW/0Zux88ahl7brst
# RCq+PEzMrIoEk8ZXhqBzNiuBl/obm36Ih9hSeYn+bnc317tQn/oYJU8T8l58qbEg
# Wimro0KHd+D0TAJI3VilU6ajoO0ZlmUVKcXtMzAl5paDgZr2YGaQWAeAzUJ1rPu0
# kdDF3QFAaraoEO72jXq3nnWv06VLGKEMn1ewXiVHkXTNdRLRnG/kXg2b7HUm7v7T
# 9ZIvUoXo2kRRKqLMAMqHZkOjGwDvorWWnWKtJwvyG0rJw5RCN4gghKiHrsO6I3J7
# +FTv+GsnsIX1p0OF2Cs5dNtadwLRpPr1zZw9zB+uUdB7bNgdLRFCU3F0wuU1qi1S
# Etklz/DT0JFDEtcyfZhs43dByP8fJFTvbq3GPlV78VyHOmTxYEsFT++5L+wJEwID
# AQABo4IBgjCCAX4wHwYDVR0jBBgwFoAUGqH4YRkgD8NBd0UojtE1XwYSBFUwHQYD
# VR0OBBYEFAMPMciRKpO9Y/PRXU2kNA/SlQEYMA4GA1UdDwEB/wQEAwIGwDAMBgNV
# HRMBAf8EAjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEoGA1UdIARDMEEwNQYM
# KwYBBAGyMQECAQMIMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20v
# Q1BTMAgGBmeBDAEEAjBEBgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3JsLnNlY3Rp
# Z28uY29tL1NlY3RpZ29SU0FUaW1lU3RhbXBpbmdDQS5jcmwwdAYIKwYBBQUHAQEE
# aDBmMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29S
# U0FUaW1lU3RhbXBpbmdDQS5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNl
# Y3RpZ28uY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBMm2VY+uB5z+8VwzJt3jOR63dY
# 4uu9y0o8dd5+lG3DIscEld9laWETDPYMnvWJIF7Bh8cDJMrHpfAm3/j4MWUN4Ott
# UVemjIRSCEYcKsLe8tqKRfO+9/YuxH7t+O1ov3pWSOlh5Zo5d7y+upFkiHX/XYUW
# NCfSKcv/7S3a/76TDOxtog3Mw/FuvSGRGiMAUq2X1GJ4KoR5qNc9rCGPcMMkeTqX
# 8Q2jo1tT2KsAulj7NYBPXyhxbBlewoNykK7gxtjymfvqtJJlfAd8NUQdrVgYa2L7
# 3mzECqls0yFGcNwvjXVMI8JB0HqWO8NL3c2SJnR2XDegmiSeTl9O048P5RNPWURl
# S0Nkz0j4Z2e5Tb/MDbE6MNChPUitemXk7N/gAfCzKko5rMGk+al9NdAyQKCxGSoY
# IbLIfQVxGksnNqrgmByDdefHfkuEQ81D+5CXdioSrEDBcFuZCkD6gG2UYXvIbrnI
# Z2ckXFCNASDeB/cB1PguEc2dg+X4yiUcRD0n5bCGRyoLG4R2fXtoT4239xO07aAt
# 7nMP2RC6nZksfNd1H48QxJTmfiTllUqIjCfWhWYd+a5kdpHoSP7IVQrtKcMf3jim
# wBT7Mj34qYNiNsjDvgCHHKv6SkIciQPc9Vx8cNldeE7un14g5glqfCsIo0j1FfwE
# T9/NIRx65fWOGtS5QDCCBuwwggTUoAMCAQICEDAPb6zdZph0fKlGNqd4LbkwDQYJ
# KoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5
# MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBO
# ZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0
# aG9yaXR5MB4XDTE5MDUwMjAwMDAwMFoXDTM4MDExODIzNTk1OVowfTELMAkGA1UE
# BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
# Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSUwIwYDVQQDExxTZWN0aWdv
# IFJTQSBUaW1lIFN0YW1waW5nIENBMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAyBsBr9ksfoiZfQGYPyCQvZyAIVSTuc+gPlPvs1rAdtYaBKXOR4O168TM
# STTL80VlufmnZBYmCfvVMlJ5LsljwhObtoY/AQWSZm8hq9VxEHmH9EYqzcRaydvX
# XUlNclYP3MnjU5g6Kh78zlhJ07/zObu5pCNCrNAVw3+eolzXOPEWsnDTo8Tfs8Vy
# rC4Kd/wNlFK3/B+VcyQ9ASi8Dw1Ps5EBjm6dJ3VV0Rc7NCF7lwGUr3+Az9ERCleE
# yX9W4L1GnIK+lJ2/tCCwYH64TfUNP9vQ6oWMilZx0S2UTMiMPNMUopy9Jv/TUyDH
# YGmbWApU9AXn/TGs+ciFF8e4KRmkKS9G493bkV+fPzY+DjBnK0a3Na+WvtpMYMyo
# u58NFNQYxDCYdIIhz2JWtSFzEh79qsoIWId3pBXrGVX/0DlULSbuRRo6b83XhPDX
# 8CjFT2SDAtT74t7xvAIo9G3aJ4oG0paH3uhrDvBbfel2aZMgHEqXLHcZK5OVmJyX
# nuuOwXhWxkQl3wYSmgYtnwNe/YOiU2fKsfqNoWTJiJJZy6hGwMnypv99V9sSdvqK
# QSTUG/xypRSi1K1DHKRJi0E5FAMeKfobpSKupcNNgtCN2mu32/cYQFdz8HGj+0p9
# RTbB942C+rnJDVOAffq2OVgy728YUInXT50zvRq1naHelUF6p4MCAwEAAaOCAVow
# ggFWMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQa
# ofhhGSAPw0F3RSiO0TVfBhIEVTAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgw
# BgEB/wIBADATBgNVHSUEDDAKBggrBgEFBQcDCDARBgNVHSAECjAIMAYGBFUdIAAw
# UAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJU
# cnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGow
# aDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVz
# dFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2Vy
# dHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBtVIGlM10W4bVTgZF13wN6Mgst
# JYQRsrDbKn0qBfW8Oyf0WqC5SVmQKWxhy7VQ2+J9+Z8A70DDrdPi5Fb5WEHP8ULl
# EH3/sHQfj8ZcCfkzXuqgHCZYXPO0EQ/V1cPivNVYeL9IduFEZ22PsEMQD43k+Thi
# vxMBxYWjTMXMslMwlaTW9JZWCLjNXH8Blr5yUmo7Qjd8Fng5k5OUm7Hcsm1BbWfN
# yW+QPX9FcsEbI9bCVYRm5LPFZgb289ZLXq2jK0KKIZL+qG9aJXBigXNjXqC72NzX
# StM9r4MGOBIdJIct5PwC1j53BLwENrXnd8ucLo0jGLmjwkcd8F3WoXNXBWiap8k3
# ZR2+6rzYQoNDBaWLpgn/0aGUpk6qPQn1BWy30mRa2Coiwkud8TleTN5IPZs0lpoJ
# X47997FSkc4/ifYcobWpdR9xv1tDXWU9UIFuq/DQ0/yysx+2mZYm9Dx5i1xkzM3u
# J5rloMAMcofBbk1a0x7q8ETmMm8c6xdOlMN4ZSA7D0GqH+mhQZ3+sbigZSo04N6o
# +TzmwTC7wKBjLPxcFgCo0MR/6hGdHgbGpm0yXbQ4CStJB6r97DDa8acvz7f9+tCj
# hNknnvsBZne5VhDhIG7GrrH5trrINV0zdo7xfCAMKneutaIChrop7rRaALGMq+P5
# CslUXdS5anSevUiumDGCBCwwggQoAgEBMIGRMH0xCzAJBgNVBAYTAkdCMRswGQYD
# VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNV
# BAoTD1NlY3RpZ28gTGltaXRlZDElMCMGA1UEAxMcU2VjdGlnbyBSU0EgVGltZSBT
# dGFtcGluZyBDQQIQOUwl4XygbSeoZeI72R0i1DANBglghkgBZQMEAgIFAKCCAWsw
# GgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMBwGCSqGSIb3DQEJBTEPFw0yMzA2
# MjgxODIwNDlaMD8GCSqGSIb3DQEJBDEyBDBenzxz3aSKxPwaWsFD/5wPXCfwvNS1
# pf5B6UzuEAyimv3ZjvWROWsW/Jj8QFPx2NYwge0GCyqGSIb3DQEJEAIMMYHdMIHa
# MIHXMBYEFK5ir3UKDL1H1kYfdWjivIznyk+UMIG8BBQC1luV4oNwwVcAlfqI+SPd
# k3+tjzCBozCBjqSBizCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJz
# ZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
# IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBB
# dXRob3JpdHkCEDAPb6zdZph0fKlGNqd4LbkwDQYJKoZIhvcNAQEBBQAEggIAL5oU
# egowjqnStZ9gOSgorZMOF7GP/ZVtQlKd6NeacZnpEh9oG0RNojPoNEgeiKeQMnli
# tfGFVhuQXO19VhmQsBaGlPWtixd8mmce8+YZwCnIitA35ZRpYo2Ud5jRrf5oh2SP
# aNoAYmOROBKHbyaYK7BR6R0pJen7dQtv1o6Yj0WNYJV5zj7UqsTWVZCWZEWY8g9o
# /X0GJ24DU7QGd2w/8AnhCJokpU5IgZV8D/ZyKjw6+nWJvzc8ZZu9hx94O8f4PpEl
# JDMap7pxCOxti9uJQTDFxwgV6LgA5MOnubpLaZ4H1mfEi/PF8OiiWBlE9FKpQ6mZ
# II4g88ttEB9est0T9vWC4nZrrKP2dczL+xc1g2FkX2W/zpP74UwLDsmhjjrESurZ
# lAJEu29Wgld3r4WpTbjnsrLo0SPD2JvfM0fyS19OQ0FUwf5wsc/IkMn3As/Q41hT
# 8aWzY+b4kktcTMVSrRY18nKNjGYL94GBudsH+7+z6UF0pKm6MEOYZn3Sy0lExRVx
# VUPqTry8VeeqSJsiMkBbz525W0tuzo9Gmvbe7+PN4si3tHHe78S03MA+mfmg/A9O
# 5KnSq7wyWBwZ+zuqtsPzKPqC4YLitqnRk1NWOVI/abWOF06OG7p0oOVG14XwlDOM
# CjYCgEAJmeC9PiCgr6as1IfBl2dnGe/4fc5xP6A=
# SIG # End signature block
