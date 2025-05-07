param([string]$user_hr_id) 

$SF_Name_Read = 'Shared_Folder_READ_' + $user_hr_id
$SF_Name_Edit = 'Shared_Folder_EDIT_' + $user_hr_id
$SF_Name_Folder = 'SF_' + $user_hr_id
$SF_Name_Path = 'C:\Shared Folder\' + $SF_Name_Folder
$date = Get-Date -Format "yyyyMMddHHmm"
$SF_NEW_Name_Folder = 'ARC_' + $date + '_SF_' + $user_hr_id

#delete groups from shared folder ACL
$acl = Get-Acl $SF_Name_Path
$groupid = New-Object System.Security.Principal.Ntaccount($SF_Name_Read)
$acl.PurgeAccessRules($groupid)
$acl | Set-Acl $SF_Name_Path
$acl = Get-Acl $SF_Name_Path
$groupid = New-Object System.Security.Principal.Ntaccount($SF_Name_Edit)
$acl.PurgeAccessRules($groupid)
$acl | Set-Acl $SF_Name_Path

#delete share folder capability not data
Remove-FileShare -Name $SF_Name_Folder -confirm:$false
#rename ex shared folder
Rename-Item -Path $SF_Name_Path -NewName $SF_NEW_Name_Folder
#delete groups
Remove-ADGroup -Identity $SF_Name_Read  -confirm:$false
Remove-ADGroup -Identity $SF_Name_Edit  -confirm:$false
