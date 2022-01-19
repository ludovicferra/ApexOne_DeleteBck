<#
.Synopsis
Outil de suppression des backups ApexOne Server
.Description
Permet de rechercher et supprimer les fichiers de sauvegarde de versions antérieure
ApexOne Server.
Sources TrendMicro : https://success.trendmicro.com/solution/1113979-files-that-can-be-deleted-to-free-up-the-disk-space-in-officescan
.Parameter BackupName
Nom du backup à supprimé (Présent dans le répertoire d'installation \Trend Micro\Apex One\PCCSRV\Backup\)
.Parameter ApexPCCSRVLocation
Spécification du répertoire d'installation (Présent dans le répertoire d'installation 'C:\Program Files\Trend Micro\Apex One\PCCSRV\')
.Example
   #Le programme va rechercher le répertoire d'installation grâce à la base de registre puis lister les sauvegardes actuelle
   Remove-ApexOneBck
.Example
   #Le programme va rechercher le répertoire d'installation grâce à la base de registre puis supprimer le patch stipulé
   Remove-ApexOneBck -BackupName CriticalPatch_B9204
.Example
   #Le programme va rechercher le répertoire d'installation grâce à la base de registre puis lister les sauvegardes actuelle
   Remove-ApexOneBck -ApexPCCSRVLocation 'C:\Program Files\Trend Micro\Apex One\PCCSRV\'
.Example
   #Le programme va rechercher le répertoire d'installation grâce à la base de registre puis supprimer le patch stipulé
   Remove-ApexOneBck -ApexPCCSRVLocation 'C:\Program Files\Trend Micro\Apex One\PCCSRV\' -BackupName CriticalPatch_B9204
.Notes
Version:        1.0
Author:         Ludovic Ferra
Creation Date:  2022-01-19
#>
function Remove-ApexOneBck {
    Param ( 
        [Parameter(Mandatory = $false,Position=1)] [string] $BackupName = $null,
        [Parameter(Mandatory = $false,Position=2)] [string] $ApexPCCSRVLocation = $(try { Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\TrendMicro\OfficeScan\service\Information\" -Name "Local_Path" -ErrorAction Stop | Select-Object -ExpandProperty Local_Path } catch { $null })
    )
    if ($(New-Object System.Security.Principal.WindowsPrincipal($([System.Security.Principal.WindowsIdentity]::GetCurrent()))).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        $BackupFolder = Join-Path -Path $ApexPCCSRVLocation -Childpath "Backup"
        if ( Test-Path $BackupFolder ) {
            if ( $BackupName ) {
                $ValidBckFiles = Get-ChildItem -Path $BackupFolder | Where-Object Name -like "*$BackupName*"
                if ( $ValidBckFiles.Count -gt 0 ) { $FinalChoice = $BackupName }
                else { Write-Warning "Aucune sauvegarde avec le nom indiqué n'a découverte dans '$BackupFolder'"; $FinalChoice = $Null }
            }
            else {
                $BackupList = (Get-ChildItem -Path $BackupFolder -Directory).Name | Sort-Object
                $iList = 0
                $ListOfChoice = $BackupList | ForEach-Object { "$iList - $_"; $iList++ }
                Clear-Host
                Write-Host ("-" * 90)
                "Liste de choix de sauvegardes" | ForEach-Object { $Side = ("=" * (((90 - $_.Length) /2) -1) ); Write-Host $side $_ $side }
                Write-Host ("-" * 90)
                $ListOfChoice | Foreach-Object { Write-Host "|  $_" }
                Write-Host ("-" * 90)
                $NumberChoice = Read-Host "Entrer le chiffre de la sauvegarde à supprimer puis 'entrée'"
                $FinalChoice = $BackupList[$NumberChoice]
            }
            if ( $FinalChoice ) {
                Write-Host ("-" * 90)
                Write-Warning "Supprimer une sauvegarde empèche tout retour en arrère vers celle-ci"
                $ContinueResponse = read-host "Confirmer la suppression de '$FinalChoice' ?`r`nOui (O) ou Non (N)"
                if ($ContinueResponse -eq "O" -or $ContinueResponse -eq "Oui") {
                    Get-ChildItem -Path $BackupFolder | Where-Object Name -like "*$FinalChoice*" | Foreach-Object {
                        Write-Host "Suppression de '$($_.FullName)'" -ForegroundColor Yellow
                        Remove-Item -Path $_.FullName -Recurse -Force
                    }
                }
            }
        }
        else { Write-Warning "Le repertoire de localisation indiqué n'a pas été trouvé de sous-dossier 'Backup' :`r`n'$ApexPCCSRVLocation'" }
    }
    else { Write-Warning "Le script doit être lancé en tant qu'administrateur" }
}