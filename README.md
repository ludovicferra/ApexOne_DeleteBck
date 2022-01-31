# ApexOne_DeleteBck
Au fur et à mesure des multiples mises à jour de Trendmicro Apex One,  
le dossier de sauvegarde prend de l'espace disque (Environs 1.5Go par mise à jour).  
Pour les version d'Apex One Server, Trendmicro ne fournit pas d'outil de suppression mais propose une suppression manuelle.  
###### Sources : https://success.trendmicro.com/solution/1113979-files-that-can-be-deleted-to-free-up-the-disk-space-in-officescan
### -----------------------------------------------------------------------------
Outil de suppression des backups de Trend Micro Apex One Server via PowerShell
   
![Remove-ApexOneBck-Capture](https://github.com/ludovicferra/ApexOne_DeleteBck/raw/main/Remove-ApexOneBck-Capture.png)

## Utilisation
#### Depuis le serveur Apex One dans une console Powershell 'en tant qu'administrateur'
### Charger la fonction depuis GitHub directement :  
```PowerShell
Invoke-WebRequest "https://github.com/ludovicferra/ApexOne_DeleteBck/raw/main/Remove-ApexOneBackups-Console.ps1" -outfile "$Env:Temp\Get-VPNComputerInfo.ps1"
Import-Module "$Env:Temp\Get-VPNComputerInfo.ps1" -Force
```
### Lancer le manuel de la fonction chargée :
```PowerShell
Get-Help Remove-ApexOneBck
```
### Lancer la commande :
```PowerShell
Remove-ApexOneBck
```
