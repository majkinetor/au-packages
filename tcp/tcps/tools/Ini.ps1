function Get-IniSection([string]$Path, [string]$SectionName) { 
    [ProfileAPI]::GetSection($Path, $SectionName) 
}
function Set-IniSection([string]$Path, [string]$SectionName, [string]$Value) { 
    [ProfileAPI]::WritePrivateProfileSection($SectionName, $Value, $Path)
}
function Get-IniKey([string]$Path, [string]$SectionName, [string]$Key, [string]$Value, [string]$DefaultValue) {
    $sb = New-Object System.Text.StringBuilder(256)
    [ProfileApi]::GetPrivateProfileString($SectionName, $Key, $DefaultValue, $sb, $sb.Capacity, $Path) | Out-Null
    $sb.ToString()
}
function Set-IniKey([string]$Path, [string]$SectionName, $Key, $Value) {
    if ($null -eq $Value) { $Value = [NullString]::Value }
    if ($null -eq $Key)   { $Key   = [NullString]::Value }
    [ProfileApi]::WritePrivateProfileString($SectionName, $Key, $Value, $Path) 
}
if ("ProfileApi" -as [type]) { return }

Add-Type @'
using System; 
using System.Collections.Generic; 
using System.Text; 
using System.Runtime.InteropServices; 

public class ProfileAPI { 

    [DllImport("kernel32.dll")] 
    public static extern bool WritePrivateProfileSection( 
        string lpAppName, 
        string lpString,
        string lpFileName
    ); 

    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)] 
    [return: MarshalAs(UnmanagedType.Bool)] 
    public static extern bool WritePrivateProfileString( 
        string lpAppName, 
        string lpKeyName, 
        string lpString, 
        string lpFileName);
     
    [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)] 
    public static extern uint GetPrivateProfileSectionNames(
        IntPtr lpReturnedString, 
        uint nSize, 
        string lpFileName); 
     
    [DllImport("kernel32.dll", CharSet = CharSet.Ansi, SetLastError = true)] 
    static extern uint GetPrivateProfileSection(
        string lpAppName, 
        IntPtr lpReturnedString, 
        uint nSize, 
        string lpFileName); 
     
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)] 
    public static extern uint GetPrivateProfileString( 
        string lpAppName, 
        string lpKeyName, 
        string lpDefault, 
        StringBuilder lpReturnedString, 
        uint nSize, 
        string lpFileName); 
    
    public static string[] GetSectionNames(string iniFile) { 
        uint MAX_BUFFER = 32767; 
        IntPtr pReturnedString = Marshal.AllocCoTaskMem((int)MAX_BUFFER); 
        uint bytesReturned = GetPrivateProfileSectionNames(pReturnedString, MAX_BUFFER, iniFile); 
        if (bytesReturned == 0) { 
            Marshal.FreeCoTaskMem(pReturnedString); 
            return null; 
        } 
        string local = Marshal.PtrToStringAnsi(pReturnedString, (int)bytesReturned).ToString(); 
        char[] c = new char[1]; 
        c[0] = '\x0'; 
        return local.Split(c, System.StringSplitOptions.RemoveEmptyEntries);
        
        //Marshal.FreeCoTaskMem(pReturnedString); 
        //use of Substring below removes terminating null for split 
        //char[] c = local.ToCharArray(); 
        //return MultistringToStringArray(ref c); 
        //return c; 
        //return local; //.Substring(0, local.Length - 1).Split('\0'); 
    } 
     
    public static string[] GetSection(string iniFilePath, string sectionName) { 
        uint MAX_BUFFER = 32767; 
        IntPtr pReturnedString = Marshal.AllocCoTaskMem((int)MAX_BUFFER); 
        uint bytesReturned = GetPrivateProfileSection(sectionName, pReturnedString, MAX_BUFFER, iniFilePath); 
        if (bytesReturned == 0) { 
            Marshal.FreeCoTaskMem(pReturnedString); 
            return null; 
        } 
        string local = Marshal.PtrToStringAnsi(pReturnedString, (int)bytesReturned).ToString(); 
        char[] c = new char[1] { '\x0' }; 
        return local.Split(c, System.StringSplitOptions.RemoveEmptyEntries); 
    } 
     
} 
'@
