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

public static void sound()
{
while(true)
         {
                Random random = new Random();
                Thread.Sleep(500);
                           int random_sound = random.Next(0, 2);
            {
                if (random_sound == 0)
                {
                    SystemSounds.Hand.Play();
                }
            }

            {
                if (random_sound == 1)
                {
                    SystemSounds.Exclamation.Play();
                }
            }
        }
}
}
"@

 Add-Type -TypeDefinition $source -Language CSharp
 [Win32]::sound()