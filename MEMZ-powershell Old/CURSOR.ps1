$source= @"
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows;
using System.Runtime.InteropServices;
using System.IO;
using System.Diagnostics;
using System.Media;
using System.Reflection;
using System.Threading;

　public static class Win32
{
[DllImport("USER32.dll", CallingConvention = CallingConvention.StdCall)]
static extern void SetCursorPos(int X, int Y);

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

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool SetProcessDPIAware();
 [DllImport("user32.dll", SetLastError = true)]
        public static extern bool DrawIcon(IntPtr hdc, int xLeft, int yTop, IntPtr hIcon);

        [DllImport("user32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool GetCursorPos(out POINT lpPoint);
        [DllImport("user32.dll")]
        public static extern bool GetCursorInfo(ref CURSORINFO pci);

        public const Int32 CURSOR_SHOWING = 0x00000001;
        public const Int32 CURSOR_SUPPRESSED = 0x00000002;
        [StructLayout(LayoutKind.Sequential)]
        public struct POINT
        {
            public Int32 x;
            public Int32 y;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct CURSORINFO
        {
            public Int32 cbSize;        // Specifies the size, in bytes, of the structure.
                                        // The caller must set this to Marshal.SizeOf(typeof(CURSORINFO)).
            public Int32 flags;         // Specifies the cursor state. This parameter can be one of the following values:
                                        //    0             The cursor is hidden.
                                        //    CURSOR_SHOWING    The cursor is showing.
                                        //    CURSOR_SUPPRESSED    (Windows 8 and above.) The cursor is suppressed. This flag indicates that the system is not drawing the cursor because the user is providing input through touch or pen instead of the mouse.
            public IntPtr hCursor;          // Handle to the cursor.
            public POINT ptScreenPos;       // A POINT structure that receives the screen coordinates of the cursor.
        }

[DllImport("user32.dll")]
static extern IntPtr LoadIcon(IntPtr hInstance, SystemIcons lpIconName);
public enum SystemIcons
{
    IDI_APPLICATION = 32512,
    IDI_HAND = 32513,
    IDI_QUESTION = 32514,
    IDI_EXCLAMATION = 32515,
    IDI_ASTERISK = 32516,
    IDI_WINLOGO = 32517,
    IDI_WARNING = IDI_EXCLAMATION,
    IDI_ERROR = IDI_HAND,
    IDI_INFORMATION = IDI_ASTERISK,
}

public static void move()
{
SetProcessDPIAware();
while(true)
            {
                POINT point;
                GetCursorPos(out point);
                Random random = new Random();
      Thread.Sleep(10);
                SetCursorPos(point.x + (random.Next() % 3 - 1), point.y + (random.Next() % 3 - 1));
            }
}
}
"@
 Add-Type -TypeDefinition $source -Language CSharp
 [Win32]::move()