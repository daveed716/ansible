function debug{
	param($variable)
	if ($debug = 1) {
		write-host($variable)
		cmd /c pause
	}
}

#define log file
$Logfile = "./log.txt"

#define logging function
Function WriteLog
{
   Param ([string]$logstring)
   Add-content $Logfile -value $logstring
}

$DateForLogs = get-date -format g
writeLog($DateForLogs)
writeLog("Script executed.")

#function getUniqueKey{
#		param($fullServerName)
#		$trim1 = $fullserverName.trimStart("brnchn01x")
#		$uniqueKey = $trim1.trimEnd("001")
#}

#Enable debugging with 1, disable debugging with 0
$debug = 1

#import sourse server data from text file
$import = Get-Content -Path c:\scripts\sourceServers.txt
debug $import
$import | add-content -path $logFile

#$uniqueKeyArray = @()
$data=@{}

foreach ($Server in $import){
	$trim1 = $Server.trimStart("brnchn01x")
	$uniqueKey = $trim1.trimEnd("001")
#	$uniqueKeyArray += $uniqueKey
	$data.add($Server,$uniqueKey)
	}
#debug $uniqueKeyArray

foreach ($server in $import){
	$shareDetail = Invoke-Command -computerName $server -ScriptBlock {get-smbshare}
	$shareDetail >> shareDetail.txt
}



#$data.add("SERVER1","SERVER1_UNIQUE_KEY")
#data.add("SERVER2","SERVER2_UNIQUE_KEY")

$data
#$data.SERVER2


<#
#Output summary of source server shares


PSUEDO CODE:

import source server list into array from text file
import destination server list into array from text file

begin looping through source server list Array
	increase counter for source server list index
		if trimmed hostname = trimmed destination hostname



#>
