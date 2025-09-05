$TITLE = "FINAL FANTASY"
$DELAY = 0.6
$confirm = "V"
$cancel = "C"
$u = "{UP}"
$d = "{DOWN}"
$l = "{LEFT}"
$r = "{RIGHT}"

function press_key ([string]$key) {   
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.AppActivate($TITLE)
    Sleep $DELAY
    #$wshell.SendKeys('~')
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait($key);
}
function grind ([int]$time = 30){
    for ($i = 0; $i -lt $time; $i++){
        $remaining = $time - $i
        echo "Remaining: $remaining"
        #echo "Starting $i"
        press_key $l
        sleep $DELAY
        press_key $r 
        #echo "Ending $i"
    }

}
function leave_melmond_inn(){
    press_key $l
    press_key $l
    press_key $l
    press_key $l
    press_key $l
    press_key $l
press_key $d
press_key $d
press_key $d

press_key $l
press_key $l
press_key $l
 sleep -s 5
press_key $u
press_key $u



}
function start_game(){
    ii "C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY PR\FINAL FANTASY.exe"
    Sleep 60;
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.AppActivate($TITLE);
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}");
}
function load_game([int]$fileno=0){    
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.AppActivate($TITLE);
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait($confirm);
    <#if (fileno){
        # press down # times for file no. zero for quick save, -1 to go up for autosave.
        print()
        }#>
}
function ss (){
$timestamp = Get-Date -Format FileDateTime
$file_extenstion = ".png"
Add-Type -AssemblyName System.Drawing

# Define the filename and path
$filename = "screenshot"
$filepath = "C:\Users\rhade\build\data\" + $filename + $timestamp + $file_extenstion


$wshell = New-Object -ComObject wscript.shell;
    $wshell.AppActivate($TITLE);
    
[Windows.Forms.Sendkeys]::SendWait("{PrtSc}")
sleep 20;
[Clicker]::LeftClickAtPoint(300,300)



<#


# Capture the screen
$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bmp = New-Object System.Drawing.Bitmap 1920, 1080
$graphics = [System.Drawing.Graphics]::FromImage($bmp)
$graphics.CopyFromScreen(0, 0, 0, 0, $bounds.Size)

# Save the screenshot
$bmp.Save($filepath, [System.Drawing.Imaging.ImageFormat]::Png)      #>
}
function Data-Get ([int]$time = 30){
    for ($i = 0; $i -lt $time; $i++){
        $remaining = $time - $i
        echo "Remaining: $remaining"
        #echo "Starting $i"
        press_key $l
        clear_notifications
        press_key x 
        sleep 10
        ss
        press_key $cancel
        sleep 10
        press_key $r 
        clear_notifications
        press_key x 
        sleep 10
        ss
        press_key $cancel
        
        #echo "Ending $i"
    }

}
function clear_notifications([int]$time = 30){
    for ($i = 0; $i -lt $time; $i++){
        $remaining = $time - $i
        press_key $confirm
        }
}
#move left,
#wait
#clear notifications
#open menu
#take ss
<#Here's a clicker script#>
function click_script (){
$cSource = @'
using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;
public class Clicker
{
//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646270(v=vs.85).aspx
[StructLayout(LayoutKind.Sequential)]
struct INPUT
{ 
    public int        type; // 0 = INPUT_MOUSE,
                            // 1 = INPUT_KEYBOARD
                            // 2 = INPUT_HARDWARE
    public MOUSEINPUT mi;
}

//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646273(v=vs.85).aspx
[StructLayout(LayoutKind.Sequential)]
struct MOUSEINPUT
{
    public int    dx ;
    public int    dy ;
    public int    mouseData ;
    public int    dwFlags;
    public int    time;
    public IntPtr dwExtraInfo;
}

//This covers most use cases although complex mice may have additional buttons
//There are additional constants you can use for those cases, see the msdn page
const int MOUSEEVENTF_MOVED      = 0x0001 ;
const int MOUSEEVENTF_LEFTDOWN   = 0x0002 ;
const int MOUSEEVENTF_LEFTUP     = 0x0004 ;
const int MOUSEEVENTF_RIGHTDOWN  = 0x0008 ;
const int MOUSEEVENTF_RIGHTUP    = 0x0010 ;
const int MOUSEEVENTF_MIDDLEDOWN = 0x0020 ;
const int MOUSEEVENTF_MIDDLEUP   = 0x0040 ;
const int MOUSEEVENTF_WHEEL      = 0x0080 ;
const int MOUSEEVENTF_XDOWN      = 0x0100 ;
const int MOUSEEVENTF_XUP        = 0x0200 ;
const int MOUSEEVENTF_ABSOLUTE   = 0x8000 ;

const int screen_length = 0x10000 ;

//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646310(v=vs.85).aspx
[System.Runtime.InteropServices.DllImport("user32.dll")]
extern static uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);

public static void LeftClickAtPoint(int x, int y)
{
    //Move the mouse
    INPUT[] input = new INPUT[3];
    input[0].mi.dx = x*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width);
    input[0].mi.dy = y*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height);
    input[0].mi.dwFlags = MOUSEEVENTF_MOVED | MOUSEEVENTF_ABSOLUTE;
    //Left mouse button down
    input[1].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
    //Left mouse button up
    input[2].mi.dwFlags = MOUSEEVENTF_LEFTUP;
    SendInput(3, input, Marshal.SizeOf(input[0]));
}

public static void RightClickAtPoint(int x, int y)
{
    //Move the mouse
    INPUT[] input = new INPUT[3];
    input[0].mi.dx = x*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width);
    input[0].mi.dy = y*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height);
    input[0].mi.dwFlags = MOUSEEVENTF_MOVED | MOUSEEVENTF_ABSOLUTE;
    //Left mouse button down
    input[1].mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;
    //Left mouse button up
    input[2].mi.dwFlags = MOUSEEVENTF_RIGHTUP;
    SendInput(3, input, Marshal.SizeOf(input[0]));
}

}
'@
Add-Type -TypeDefinition $cSource -ReferencedAssemblies System.Windows.Forms,System.Drawing

<#
Example of how it works:
while ($true) {
[Clicker]::RightClickAtPoint(300,300)
Start-Sleep -Seconds 1.5
[Clicker]::RightClickAtPoint(600,600)
Start-Sleep -Seconds 1.5
}
#>
}
