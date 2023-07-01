# Pester installation

Install Pester according to the instructions on the Pester website. Afterwards the old version of Pester can be uninstalled from Windows. This has advantages for future Pester updates.

> With admin account

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

A pester ini-file is needed für special tests against sql and ftp. It is stored in the pester root folder of the project `(project)\source\tests`. Tokens and all security settings are under the home folder of the windows system. The user should be a special pester test user.

```
[SFTP]
Server=192.168.42.1
User=pester
SecurePasswordPath=$home\.eulandaconnect\PesterSftp.xml

[TELEGRAM]
SecureToken=$home\.eulandaconnect\secureTelegramToken.xml

```



## MSSQL-Server

Some of the Pester tests require an SQL server. This must be installed locally in the PESTER instance. For pure tests that are not specific to EULANDA ERP, Windows authentication is sufficient. If tests are to be made also against a EULANDA database, then the mixed authentication should be selected with the installation.

## EULANDA-ERP

Here only one EULANDA.exe is needed in the Pester test folder. After the SQL server was installed a PESTER client can be created directly. The EULANDA.exe is for this in the Pester tests root folder. The creation of the database generates locally to the EULANDA.exe a UDL file `EULANDA_1 Pester.udl`.

It is recommended after the installation and the call of the client once to carry out a SQL data backup from EULANDA. Through this the database can be used after tests at any time again on the original state.

## SFTP and FTP Server

To test the FTP functions you need a SFTP or FTP server. If only a FTP server is needed and no SFTP tests are to be made, the free FileZilla FTP server is sufficient, otherwise the commercial version of the FileZilla server is needed.

The server should have two directories in the root (`inbox` and `outbox`), which are used by the pester test. There must also be a `License.md` file in the root. This must be in the file date between 01.01.2023 and 10 minutes before now. The file is evaluated during FTP pester tests. The credentials are saved in root folder of pester tests.
