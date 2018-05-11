<# 
    .SYNOPSIS 
        Get all shp groups for all users 
 
    .DESCRIPTION 
        To run this script you need to have acces to sharepoint database. 
        Can chceck it with Get-SPContentDatabase. 
        To add permission Add-SPShellAdmin -UserName GPEC\milo -database database_id
             
    .OUTPUTS 
        Txt file save in current user desktop
 
#>


if((Get-PSSnapin "Microsoft.SharePoint.PowerShell") -eq $null)
{
      Add-PSSnapin Microsoft.SharePoint.PowerShell
}

$profilepath = (Get-ChildItem env:\userprofile).value 
$filepath = $profilepath+"\desktop\UserAccessReport.txt"

$urlweb = "http://shpsite.domain.corp"
Get-SPUser -web $urlweb -Limit All | 
foreach {$_.Name; $_.Groups | select Name } | Out-File $filepath
