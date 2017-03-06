function Expand-ZIPFile($File, $Destination) {
    $shell = new-object -com shell.application
    $zip = $shell.NameSpace($file)
    foreach($item in $zip.items()) {
        $shell.Namespace($destination).copyhere($item)
    }
}
$StorageSubsystem = Get-StorageSubSystem
$PhysicalDisks = $StorageSubsystem | Get-PhysicalDisk -CanPool $True
$StoragePool = New-StoragePool -FriendlyName StoragePoolPrtg01 -StorageSubsystemFriendlyName $StorageSubsystem.FriendlyName -PhysicalDisks $PhysicalDisks
$StoragePoolFriendlyName = $StoragePool.FriendlyName
$VirtualDisk = New-VirtualDisk -StoragePoolFriendlyName $storagePoolFriendlyName -FriendlyName VirtualDiskPrtg01 -Size 500GB -ResiliencySettingName Simple -ProvisioningType Fixed
$Disk = Initialize-Disk -VirtualDisk $VirtualDisk -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -Confirm:$false

$SourceUri = "https://prtgdownload.com/prtg.zip"
$FileName = [System.IO.Path]::GetFileName($SourceUri)
$DestinationFolder = "$($Disk.DriveLetter):\Installer\PRTG"
$DestinationFile = "$DestinationFolder\$FileName"

New-Item $DestinationFolder -ItemType Directory 
Start-BitsTransfer -Source $SourceUri -Destination $DestinationFile
Expand-ZIPFile -File $DestinationFile -Destination $DestinationFolder