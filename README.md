# ApexOne_DeleteBck
Outil de suppression des backup de Trand Micro Apex One Server  
![Remove-ApexOneBck-Capture](https://github.com/ludovicferra/ApexOne_DeleteBck/raw/main/Remove-ApexOneBck-Capture.png)

# Utilisation
#### Depuis le serveur Apex One dans une console Powershell 'en tant qu'administrateur'
### Charger la fonction depuis GitHub directement :  
Invoke-WebRequest "https://github.com/ludovicferra/ApexOne_DeleteBck/raw/main/Remove-ApexOneBackups-Console.ps1" -outfile "$Env:Temp\Get-VPNComputerInfo.ps1" ; Import-Module "$Env:Temp\Get-VPNComputerInfo.ps1"
### Lancer le manuel de la fonction chargée :
Get-Help Remove-ApexOneBck
### Lancer la commande :
Remove-ApexOneBck
