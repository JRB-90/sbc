using System;
using System.IO;

namespace BinToMif
{
    class Program
    {
        static void Main(string[] args)
        {
            string binPath = Environment.CurrentDirectory + "\\" + args[0];
            string mifPath = Environment.CurrentDirectory + "\\" + args[1];

            byte[] bytes = File.ReadAllBytes(binPath);

            string fileString = "WIDTH=8;\nDEPTH = " + bytes.Length + ";\n\nADDRESS_RADIX=UNS;\nDATA_RADIX = UNS;\n\n";
            fileString += "CONTENT BEGIN\n";

            for (int i = 0; i < bytes.Length; i++)
            {
                fileString += $"\t{i} : {bytes[i]};\n";
            }

            fileString += "END;\n";

            File.WriteAllText(mifPath, fileString);
            Console.WriteLine("Successfully converted to mif");
        }
    }
}
