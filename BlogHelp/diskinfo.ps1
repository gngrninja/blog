function Get-DiskSpace {

    #Create empty array to use (this type of array out-performs the other)
    [System.Collections.ArrayList]$diskArray = @()

    #Collect disk info via WMI (may want to eventually switch to Get-CimInstance) (Get-CimInstance -ClassName win32_logicaldisk)
    $diskInfo = Get-WmiObject win32_logicaldisk

    foreach($drive in $diskinfo) {

        #We want to create the objects in the array, and in this loop null out all variables we use
        $diskObject = $null
        $totalSpace = $null
        $freeSpace  = $null
        $usedSpace  = $null

        #Calculate totals/used outside the object so we can get used
        $totalSpace = [int]($drive.Size/1GB)
        $freeSpace  = [int]($drive.FreeSpace/1GB)
        $usedSpace  = $totalSpace - $freeSpace

        #Create custom object 
        $diskObject = [PSCustomObject]@{

            'Drive Name'       = $drive.DeviceId
            'Total Space (GB)' = $totalSpace
            'Free Space (GB)'  = $freeSpace
            'Used Space (GB)'  = $usedSpace

        }
        
        #Add custom object to array
        $diskarray.Add($diskObject) | Out-Null
        
    } 

    #return array from function
    return $diskArray

}

#Exmple of using the function
$info = Get-Diskspace
$info