function Initialize-GlobalWShell {
    # Check if it already exists to avoid creating multiple COM objects
    if (-not $global:wshell) {
        $global:wshell = New-Object -ComObject WScript.Shell
        Write-Host "Global WShell object created." -ForegroundColor Cyan
    } else {
        Write-Warning "Global WShell already initialized!"
    }
}

function Invoke-GlobalEnter {
    # This function now pulls from the Global scope automatically
    if ($global:wshell) {
        $global:wshell.AppActivate($TITLE)
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    } else {
        Write-Warning "Global WShell not initialized!"
    }
}
function Remove-GlobalWShell {
    if ($global:wshell) {
        # 1. Tell Windows to release the COM handle
        [Runtime.Interopservices.Marshal]::ReleaseComObject($global:wshell) | Out-Null
        
        # 2. Force a Garbage Collection (highly recommended for COM objects)
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        
        # 3. Remove the variable name from the Global scope
        Remove-Variable -Name wshell -Scope Global
        
        Write-Host "Global WShell cleaned and removed." -ForegroundColor Yellow
    }
}