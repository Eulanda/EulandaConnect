# Pester installation

> **ATTENTION**
>
> This section is under active revision. In the upcoming weeks, we will be providing more detailed information on Pester installation and its prerequisites. Our current focus, however, is on completing Pester tests to ensure timely delivery of the module.

Follow the instructions on the Pester website for the installation process. Once installed, you may uninstall the old version of Pester from your Windows system. This will facilitate easier updates in the future.

You must be logged in as an administrator to install Pester.

```powershell
# This is for Windows 10 and above with PowerShell 5.x and above

# REMOVE OLD BUILD IN PESTER 3.4
module = "C:\Program Files\WindowsPowerShell\Modules\Pester"
takeown /F $module /A /R
icacls $module /reset
icacls $module /grant "*S-1-5-32-544:F" /inheritance:d /T
Remove-Item -Path $module -Recurse -Force -Confirm:$false
Install-Module -Name Pester -Force

# ACTIVATE TLS 1.2 if not alredy done
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

# Install new Pester
Install-Module -Name Pester -Force -SkipPublisherCheck

# Future updates with
Update-Module -Name Pester

```



## Pester.ini

For specific tests against SQL and FTP servers, a Pester ini-file is required. It is located in the Pester root folder of the project `(project)\source\tests`. Security tokens and settings are stored under the Windows system home folder. The user should be a designated Pester test user.

```
[SFTP]
Server=192.168.42.1
User=pester
SecurePasswordPath=$home\.eulandaconnect\PesterSftp.xml

[TELEGRAM]
SecureToken=$home\.eulandaconnect\secureTelegramToken.xml

```



## MSSQL-Server

Certain Pester tests require a SQL server. This server should be installed locally on the PESTER instance. For pure tests that do not specifically involve EULANDA ERP, Windows authentication is sufficient. If tests are to be conducted against an EULANDA database, mixed mode authentication should be enabled during installation.

## EULANDA-ERP

Only the EULANDA.exe is required in the Pester test folder. Following the SQL server installation, a PESTER client can be directly created. For this, the EULANDA.exe should be placed in the Pester `tests` root folder. Creating the database generates a UDL file `EULANDA_1 Pester.udl` locally next to EULANDA.exe. The database is named `EULANDA_Pester`.

After installation and running the client once, we recommend performing a SQL data backup from EULANDA. This backup allows you to restore the database to its original state after conducting tests.

Currently, the Backup-MssqlBackup-Pestertest uses an EULANDA database. The test involves backing up the database, copying it to local storage, and transferring it via SFTP to the SFTP server. After the test, the data are removed. At present, an EULANDA database is necessary for this test, but efforts are underway to make this test more independent.

## SFTP and FTP Server

Testing the FTP functions requires an SFTP or FTP server. If only FTP tests are needed and no SFTP tests will be conducted, the free version of the FileZilla FTP server is sufficient. For SFTP tests, you will need the commercial version of the FileZilla server.

The server should contain two root directories (`inbox` and `outbox`), which are utilized by the Pester test. Additionally, a `License.md` file must be present in the root directory. This file's date should be between 01.01.2023 and 10 minutes before the current time. It will be assessed during FTP Pester tests. The credentials are stored in the root folder of the Pester tests.
