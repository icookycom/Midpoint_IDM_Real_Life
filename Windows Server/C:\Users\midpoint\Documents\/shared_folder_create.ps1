param([string]$user_hr_id) 

$SF_Name_Read = 'Shared_Folder_READ_' + $user_hr_id
$SF_Name_Edit = 'Shared_Folder_EDIT_' + $user_hr_id
$SF_Name_Folder = 'SF_' + $user_hr_id
$SF_Name_Path = 'C:\Shared Folder\' + $SF_Name_Folder

#Create AD Groups
New-ADGroup -Name $SF_Name_Read -SamAccountName $SF_Name_Read -GroupCategory Security -GroupScope Global -DisplayName $SF_Name_Read -Path "OU=Groups,OU=OOO_ODIN,DC=168testserverhome,DC=com" -Description $user_hr_id
New-ADGroup -Name $SF_Name_Edit -SamAccountName $SF_Name_Edit -GroupCategory Security -GroupScope Global -DisplayName $SF_Name_Read -Path "OU=Groups,OU=OOO_ODIN,DC=168testserverhome,DC=com" -Description $user_hr_id
#add owner user to edit group
Get-ADUser -Properties employeeNumber -Filter 'employeeNumber -eq $user_hr_id' | ForEach-Object {Add-ADGroupMember -Identity $SF_Name_Edit -Members $_.SamAccountName} 

#Create Shared Folder
New-Item -Path 'C:\Shared Folder\' -Name $SF_Name_Folder -ItemType 'directory'
$Parameters = @{
Name = $SF_Name_Folder
Path = $SF_Name_Path
ReadAccess = $SF_Name_Read
ChangeAccess = $SF_Name_Edit
}
New-SmbShare @Parameters
#Set access rights for AD groups
$ACL = Get-Acl -Path $SF_Name_Path
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($SF_Name_Edit,"ListDirectory,Read,ReadAndExecute,Write,Modify,FullControl","3","0","Allow") 
$AccessRule2 = New-Object System.Security.AccessControl.FileSystemAccessRule($SF_Name_Read,"ListDirectory,Read,ReadAndExecute","3","0","Allow")
$ACL.SetAccessRule($AccessRule)
$ACL.SetAccessRule($AccessRule2)
$ACL | Set-Acl -Path $SF_Name_Path
