# Initialization
## Define constants for script
$TITLE = "FINAL FANTASY"
$DELAY = 0.6
### Key Mappings
$confirm = "V"
$cancel = "C"
$menu = "X"
$u = "{UP}"
$d = "{DOWN}"
$l = "{LEFT}"
$r = "{RIGHT}"
## Position Variables
$itemActualPosition=138,121 # position on game position on ss = [131, 91](-0,-30)
$tmp_x = $itemActualPosition[0]
$tmp_y = $itemActualPosition[1] - 30
$itemRelativePosition = $tmp_x, $tmp_y
$tmp_x = $itemRelativePosition[0] + 823
$tmp_y = $itemRelativePosition[1] + 389
$bbhair = 966, 513 
## Initialization Function

# Functions
## Main
function start_game(){
    <#
        Requires no arguments. Launches game to main spalsh screen.
        !!!{NOTE} Game will not launch if steam is not connected to 
        the internet.
    #>
    ii "C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY PR\FINAL FANTASY.exe"
    Sleep 60;
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.AppActivate($TITLE);
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}");
}

## Image Processing Functions

function press_key ([string]$key) {   
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.AppActivate($TITLE)
    Sleep $DELAY
    #$wshell.SendKeys('~')
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait($key);
}
#grind 20 # takes about 30 minutes 0012 02152026 solo bb
function grind ([int]$time = 30){
    $start = Get-Date
    echo $start
    for ($i = 0; $i -lt $time; $i++){
        $remaining = $time - $i
        echo "Remaining: $remaining"
        echo "Starting ${inBattleSoloMonk}"
        while (-not (inBattleSoloMonk)){
            press_key $l
            sleep $DELAY
            press_key $r 
            sleep $DELAY
        }
        while (inBattleSoloMonk){
            sleep -s 5;
            echo "Confirm sent: $remaining"
            press_key $confirm
        }
        #echo "Ending $i"
    }
    echo "Start Time: `n$start`nEnd Time: ";
    Get-Date;
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
Add-Type -AssemblyName System.Drawing
#-730 860 -485 892;; -641 874
<#
X: -958, Y: 517 | RGB: (172, 144, 82) | Hex: #AC9052
bb brown hair on overworld
Positions change with each instance? Get initial position to base eveything else from. Menu?
"Item" in same position, but either selected or not.>
#>
# Screen shot, 1912 x 1049 I has three pixels... Top is Indigo[0130, 0089](071, 074, 205), next is light blue[0130, 0090](164, 167, 243), then the next is Periwinkle[0130, 0091](224, 225, 244) (to the right of periwinkle is light gray, 240 240240
# 954 480 pixels in 6x6 to make chunk all same color Very close to edge
#I positionLight gray - bb hair = adjustment
#[0131, 0091] - [0954, 0480] = [-823, -389] 138 132
function foo (){
    <#
    Given position and dimensions of Fighter, Can I calculate and return bb pixel? any pixel??
    #>
    #actual top left of montior (0,0) 3840 0
    #top-left pixel of fighter
    $TL = 3856, 7
    #bottom-right pixel of fighter
    $BR = 3871, 22
    $width = $BR[0] - $TL[0];
    $height = $BR[1] - $TL[1];
    $atmp = $TL[0] - 8;
    $btmp = $BR[1] + 9;
    $tlMapPixel = $atmp, $btmp
    #4808 511
    $x = $atmp + 960 - 3840
    $y = $btmp + 480
    return $x, $y

}
function Get-PixelColor {
    param (
        [int]$x = 0,
        [int]$y = 0
    )

    # Create a 1x1 bitmap to store the pixel data
    $bitmap = New-Object System.Drawing.Bitmap(1, 1)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    
    # Copy the specific pixel from the screen into our bitmap
    $graphics.CopyFromScreen($x, $y, 0, 0, $bitmap.Size)
    
    # Get the color of that pixel
    $color = $bitmap.GetPixel(0, 0)
    
    # Clean up resources
    $graphics.Dispose()
    $bitmap.Dispose()
    
    return $color
}
function check_condition($input) {
    <#
    Given color at position, returns false if the pixel matches specific value
    #>
    if ($input){
        foreach( $a in $input){
            echo "This element is: $a";
        }
    }
    if ($input -match "oneInHundredsPlace"){
        $foo = -677, 338, 240, 240, 240
    }

    
    $condition = $true
    $x = $foo[0]
    $y = $foo[1]
    $R = (Get-PixelColor -x $x -y $y).R
    $G = (Get-PixelColor -x $x -y $y).G
    $B = (Get-PixelColor -x $x -y $y).B
    if ($R -eq $foo[2] -and $G -eq $foo[3] -and $B -eq $foo[4] -and $x -eq $foo[0] -and $y -eq $foo[1]){
        $condition =$false    
    }
    return $condition
}
#How to get relative positon of pixel within a know screen size?
function inBattleSoloMonk([int]$R,[int]$G ,[int]$B ,[int]$x ,[int]$y) {
    <#
    Given color at position, returns false if the pixel matches specific value
    #>
    $overworldMonkHairInvisible = $true
    $x = $bbhair[0]
    #echo "x is $x";
    $y = $bbhair[1]
    $R = (Get-PixelColor -x $x -y $y).R
    $G = (Get-PixelColor -x $x -y $y).G
    $B = (Get-PixelColor -x $x -y $y).B
    if ($R -eq 172 -and $G -eq 144 -and $B -eq 82){
        $overworldMonkHairInvisible =$false    
    }
    return $overworldMonkHairInvisible
}
##X: -677, Y: 338 | RGB: (240, 240, 240) | Hex: #F0F0F0    
function one_in_hundreds_place([int]$R,[int]$G ,[int]$B ,[int]$x ,[int]$y) {
    <#
    Given color at position, returns false if the pixel matches specific value
    #>
    $greaterThanOneHundred = $false
    $x = -677
    $y = 338
    $R = (Get-PixelColor -x $x -y $y).R
    $G = (Get-PixelColor -x $x -y $y).G
    $B = (Get-PixelColor -x $x -y $y).B
    if ($R -eq 240 -and $G -eq 240 -and $B -eq 240 -and $x -eq -677 -and $y -eq 338){
        $greaterThanOneHundred = $true
    }
    return $greaterThanOneHundred
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