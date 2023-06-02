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
