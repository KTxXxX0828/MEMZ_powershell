$source= @"
using System;
using System.Runtime.InteropServices;
using System.Threading;

public static class Win32
{
 [DllImport("user32.dll")]
    static extern int GetSystemMetrics(SystemMetric smIndex);
    public enum SystemMetric : int
    {
      SM_CXSCREEN = 0,
      SM_CYSCREEN = 1,
      SM_CYVSCROLL = 2,
      SM_CXVSCROLL = 3,
      SM_CYCAPTION = 4,
      SM_CXBORDER = 5,
      SM_CYBORDER = 6,
      SM_CXDLGFRAME = 7,
      SM_CYDLGFRAME = 8,
      SM_CYVTHUMB = 9,
      SM_CXHTHUMB = 10,
      SM_CXICON = 11,
      SM_CYICON = 12,
      SM_CXCURSOR = 13,
      SM_CYCURSOR = 14,
      SM_CYMENU = 15,
      SM_CXFULLSCREEN = 16,
      SM_CYFULLSCREEN = 17,
      SM_CYKANJIWINDOW = 18,
      SM_MOUSEWHEELPRESENT = 75,
      SM_CYHSCROLL = 20,
      SM_CXHSCROLL = 21,
      SM_DEBUG = 22,
      SM_SWAPBUTTON = 23,
      SM_RESERVED1 = 24,
      SM_RESERVED2 = 25,
      SM_RESERVED3 = 26,
      SM_RESERVED4 = 27,
      SM_CXMIN = 28,
      SM_CYMIN = 29,
      SM_CXSIZE = 30,
      SM_CYSIZE = 31,
      SM_CXFRAME = 32,
      SM_CYFRAME = 33,
      SM_CXMINTRACK = 34,
      SM_CYMINTRACK = 35,
      SM_CXDOUBLECLK = 36,
      SM_CYDOUBLECLK = 37,
      SM_CXICONSPACING = 38,
      SM_CYICONSPACING = 39,
      SM_MENUDROPALIGNMENT = 40,
      SM_PENWINDOWS = 41,
      SM_DBCSENABLED = 42,
      SM_CMOUSEBUTTONS = 43,
      SM_CXFIXEDFRAME = SM_CXDLGFRAME,
      SM_CYFIXEDFRAME = SM_CYDLGFRAME,
      SM_CXSIZEFRAME = SM_CXFRAME,
      SM_CYSIZEFRAME = SM_CYFRAME,
      SM_SECURE = 44,
      SM_CXEDGE = 45,
      SM_CYEDGE = 46,
      SM_CXMINSPACING = 47,
      SM_CYMINSPACING = 48,
      SM_CXSMICON = 49,
      SM_CYSMICON = 50,
      SM_CYSMCAPTION = 51,
      SM_CXSMSIZE = 52,
      SM_CYSMSIZE = 53,
      SM_CXMENUSIZE = 54,
      SM_CYMENUSIZE = 55,
      SM_ARRANGE = 56,
      SM_CXMINIMIZED = 57,
      SM_CYMINIMIZED = 58,
      SM_CXMAXTRACK = 59,
      SM_CYMAXTRACK = 60,
      SM_CXMAXIMIZED = 61,
      SM_CYMAXIMIZED = 62,
      SM_NETWORK = 63,
      SM_CLEANBOOT = 67,
      SM_CXDRAG = 68,
      SM_CYDRAG = 69,
      SM_SHOWSOUNDS = 70,
      SM_CXMENUCHECK = 71,
      SM_CYMENUCHECK = 72,
      SM_SLOWMACHINE = 73,
      SM_MIDEASTENABLED = 74,
      SM_MOUSEPRESENT = 19,
      SM_XVIRTUALSCREEN = 76,
      SM_YVIRTUALSCREEN = 77,
      SM_CXVIRTUALSCREEN = 78,
      SM_CYVIRTUALSCREEN = 79,
      SM_CMONITORS = 80,
      SM_SAMEDISPLAYFORMAT = 81,
      SM_IMMENABLED = 82,
      SM_CXFOCUSBORDER = 83,
      SM_CYFOCUSBORDER = 84,
      SM_TABLETPC = 86,
      SM_MEDIACENTER = 87,
      SM_CMETRICS_OTHER = 76,
      SM_CMETRICS_2000 = 83,
      SM_CMETRICS_NT = 88,
      SM_REMOTESESSION = 0x1000,
      SM_SHUTTINGDOWN = 0x2000,
      SM_REMOTECONTROL = 0x2001,
    }
  [DllImport("user32.dll")]
        static extern IntPtr GetWindowDC(IntPtr hWnd);

        [DllImport("user32.dll")]
        static extern IntPtr GetDesktopWindow();

        [DllImport("gdi32.dll")]
        static extern bool StretchBlt(IntPtr hdcDest, int nXOriginDest, int nYOriginDest, int nWidthDest,
       int nHeightDest, IntPtr hdcSrc, int nXOriginSrc, int nYOriginSrc, int nWidthSrc, int nHeightSrc,
       TernaryRasterOperations dwRop);

        [DllImport("gdi32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool BitBlt(IntPtr hdc, int nXDest, int nYDest, int nWidth, int nHeight,
      IntPtr hdcSrc, int nXSrc, int nYSrc, TernaryRasterOperations dwRop);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool SetProcessDPIAware();

        public enum TernaryRasterOperations
        {
            SRCCOPY = 0x00CC0020,
            SRCPAINT = 0x00EE0086,
            SRCAND = 0x008800C6,
            SRCINVERT = 0x00660046,
            SRCERASE = 0x00440328,
            NOTSRCCOPY = 0x00330008,
            NOTSRCERASE = 0x001100A6,
            MERGECOPY = 0x00C000CA,
            MERGEPAINT = 0x00BB0226,
            PATCOPY = 0x00F00021,
            PATPAINT = 0x00FB0A09,
            PATINVERT = 0x005A0049,
            DSTINVERT = 0x00550009,
            BLACKNESS = 0x00000042,
            WHITENESS = 0x00FF0062,
            CAPTUREBLT = 0x40000000
        }

public static void flash()
{
SetProcessDPIAware();
while(true)
            {
                Thread.Sleep(1000);
                IntPtr hwnd = GetDesktopWindow();
                IntPtr hdc = GetWindowDC(hwnd);
                int x = GetSystemMetrics(SystemMetric.SM_CXSCREEN);
                int y = GetSystemMetrics(SystemMetric.SM_CYSCREEN);
                StretchBlt(hdc, 0, 0, x, y, hdc, 0, 0, x, y, TernaryRasterOperations.NOTSRCCOPY);
            }
}
}
"@
 Add-Type -TypeDefinition $source -Language CSharp
 [Win32]::flash()