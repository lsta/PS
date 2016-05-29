
#add local accounts
$computername = $env:computername   # place computername here for remote access
$desc = 'Automatically created local admin account'

$computer = [ADSI]"WinNT://$computername,computer"
$user = $computer.Create("user", $username)
$user.SetPassword($password)
$user.Setinfo()
$user.description = $desc
$user.setinfo()
$user.UserFlags = 65536
$user.SetInfo()
$group = [ADSI]("WinNT://$computername/administrators,group")
$group.add("WinNT://$username,user")


wmic useraccount where "name='ITCOAdmin'" set passwordexpires=FALSE
net localgroup "Administrators" ITCOAdmin /add

#windows 7
NetSh getAdvfirewall set allrprofiles state on
