$source= @"
using System;
using System.Runtime.InteropServices;
using System.Threading;

public static class Win32
{
 [DllImport("user32.dll")]
 static extern int GetSystemMetrics(int smIndex);

 [DllImport("user32.dll")]
 static extern IntPtr GetDC(IntPtr hWnd);

 [DllImport("gdi32.dll")]
 static extern bool StretchBlt(IntPtr hdcDest, int nXOriginDest, int nYOriginDest, int nWidthDest,int nHeightDest, IntPtr hdcSrc, int nXOriginSrc, int nYOriginSrc, int nWidthSrc, int nHeightSrc, int dwRop);

 [DllImport("user32.dll", SetLastError = true)]
 static extern bool SetProcessDPIAware();

public static void PIP()
{
SetProcessDPIAware();
int cx = GetSystemMetrics(0);
int cy = GetSystemMetrics(1);

            while(true)
            {
                Thread.Sleep(800);
                IntPtr hdc = GetDC(IntPtr.Zero);

                StretchBlt(hdc, 50, 50, cx - 100, cy - 100, hdc, 0, 0, cx, cy, 0x00CC0020);
            }
}
}
"@
 Add-Type -TypeDefinition $source -Language CSharp
 [Win32]::PIP()