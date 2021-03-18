using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;
using System.Diagnostics;
using System.IO;
using VGAudio.Containers.Adx;
using VGAudio.Containers.Wave;
using VGAudio.Formats;

namespace SteamHelper
{
    public partial class Form_SteamHelper : Form
    {
		static TextWriter logger;
		static readonly string[] DATNames =
		{
			"CART_BANK01.dat",
			"CASINOPOLIS_BANK01.dat",
			"CASINOPOLIS_BANK05.dat",
			"CHAOS0_BANK01.dat",
			"CHAOS0_BANK05.dat",
			"CHAOS2_BANK01.dat",
			"CHAOS4_BANK01.dat",
			"CHAOS6_BANK01.dat",
			"CHAOS6_BANK05.dat",
			"CHAOS7A_BANK01.dat",
			"CHAOS7A_BANK05.dat",
			"CHAOS7B_BANK01.dat",
			"CHAOVOICE_BANK04.dat",
			"CHAOVOICE_BANK05.dat",
			"CHAO_EFX_BANK01.dat",
			"check_sheet_bank02.dat",
			"COMMON_BANK00.dat",
			"DRY_MOUNTAIN_BANK01.dat",
			"DRY_MOUNTAIN_BANK05.dat",
			"E101_BANK01.dat",
			"EGG_CARRIER_BANK01.dat",
			"EGG_CARRIER_BANK05.dat",
			"EMERALD_COAST_BANK01.dat",
			"EMERALD_COAST_BANK05.dat",
			"ENEMY_SET_BANK04.dat",
			"E_0001.dat",
			"E_0003.dat",
			"E_0007.dat",
			"E_0008.dat",
			"E_0009.dat",
			"E_000D.dat",
			"E_0012.dat",
			"E_0016.dat",
			"E_001B.dat",
			"E_001E.dat",
			"E_0022.dat",
			"E_0024.dat",
			"E_0029.dat",
			"E_0035.dat",
			"E_0042.dat",
			"E_0046.dat",
			"E_0047.dat",
			"E_004B.dat",
			"E_004D.dat",
			"E_004E.dat",
			"E_0060.dat",
			"E_0061.dat",
			"E_0064.dat",
			"E_0065.dat",
			"E_0068.dat",
			"E_0071.dat",
			"E_0080.dat",
			"E_0087.dat",
			"E_0091.dat",
			"E_0097.dat",
			"E_009D.dat",
			"E_00B0.dat",
			"E_00B7.dat",
			"E_00BA.dat",
			"E_00BB.dat",
			"E_00BF.dat",
			"E_00C5.dat",
			"E_00D0.dat",
			"E_00D4.dat",
			"E_00DE.dat",
			"E_00F3.dat",
			"E_00F4.dat",
			"E_00F5.dat",
			"E_00F7.dat",
			"E_00F8.dat",
			"E_00FA.dat",
			"E_00FD.dat",
			"E_00FE.dat",
			"E_00FF.dat",
			"E_0160.dat",
			"FINAL_EGG_BANK01.dat",
			"FINAL_EGG_BANK04.dat",
			"FINAL_EGG_BANK05.dat",
			"HIGHWAY_BANK01.dat",
			"HIGHWAY_BANK05.dat",
			"HOT_SHELTER_BANK01.dat",
			"HOT_SHELTER_BANK05.dat",
			"ICE_CAP_BANK01.dat",
			"ICE_CAP_BANK04.dat",
			"ICE_CAP_BANK05.dat",
			"LOST_WORLD_BANK01.dat",
			"LOST_WORLD_BANK05.dat",
			"MOBILE1_BANK01.dat",
			"MOBILE2_BANK01.dat",
			"MOBILE3_BANK01.dat",
			"MOBILE3_BANK04.dat",
			"MOBILE3_BANK05.dat",
			"MYSTIC_RUIN_BANK01.dat",
			"MYSTIC_RUIN_BANK05.dat",
			"P_AMY_BANK03.dat",
			"P_BIG_BANK03.dat",
			"P_E102_BANK03.dat",
			"P_KNUCKLES_BANK03.dat",
			"P_METALTAILS_BANK03.dat",
			"P_SONICTAILS_BANK03.dat",
			"SANDHILL_BANK01.dat",
			"SHOOTING_BANK01.dat",
			"SKY_DECK_BANK01.dat",
			"SKY_DECK_BANK04.dat",
			"SKY_DECK_BANK05.dat",
			"STATION_SQUARE_BANK01.dat",
			"STATION_SQUARE_BANK05.dat",
			"TWINKLE_PARK_BANK01.dat",
			"TWINKLE_PARK_BANK05.dat",
			"V_AMY_E_BANK06.dat",
			"V_AMY_J_BANK06.dat",
			"V_BIG_E_BANK06.dat",
			"V_BIG_J_BANK06.dat",
			"V_E102_E_BANK06.dat",
			"V_E102_J_BANK06.dat",
			"V_KNUCKLES_E_BANK06.dat",
			"V_KNUCKLES_J_BANK06.dat",
			"V_SONICTAILS_E_BANK06.dat",
			"V_SONICTAILS_J_BANK06.dat",
			"WINDY_VALLEY_BANK01.dat",
			"WINDY_VALLEY_BANK05.dat",
		};
		static bool is2010 = false;
		static List<FENTRY> files;
		static List<byte[]> saves;
		delegate void SetTextCallback(string text);
		delegate void SetTextCallbackFull(System.Windows.Forms.Label control, string text);
		delegate void SetValueCallback(int val);
		public Form_SteamHelper()
        {
            InitializeComponent();
			backgroundWorker1.RunWorkerAsync();
		}
		private void WriteLog(string str)
		{
			if (ProgressLabel.InvokeRequired)
			{
				SetTextCallback d = new SetTextCallback(WriteLog);
				this.Invoke(d, new object[] { str });
			}
			else
			{
				ProgressLabel.Text = str;
				logger.WriteLine(str);
				logger.Flush();
			}
		}
        private void ConvertSFD()
        {
            Process pProcess;
            string strOutput;
            if (!Directory.Exists(Path.Combine(Environment.CurrentDirectory, "system")))
            {
                WriteLog("Could not locate the system folder.");
                MessageBox.Show("Unable to locate SADX system folder at: " + Path.Combine(Environment.CurrentDirectory, "system") + ".\nVerify integrity of your SADX installation and run the installer again.", "Error: system folder not found", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
            }
            // Convert all SA* SFDs to MPG
            if (File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "SA1.SFD")))
            {
                pProcess = new System.Diagnostics.Process();
                pProcess.StartInfo.FileName = "sfd2mpg.exe";
                pProcess.StartInfo.Arguments = "-c \"..\\lame --silent\" sa1.sfd sa2.sfd sa3.sfd sa4.sfd sa5.sfd sa6.sfd sa7.sfd sa8.sfd";
                pProcess.StartInfo.UseShellExecute = false;
                pProcess.StartInfo.RedirectStandardOutput = true;
                pProcess.StartInfo.WorkingDirectory = Path.Combine(Environment.CurrentDirectory, "system");
                pProcess.StartInfo.CreateNoWindow = true;
                pProcess.Start();
                strOutput = pProcess.StandardOutput.ReadToEnd();
                WriteLog(strOutput);
                pProcess.WaitForExit();
                bool mpgcheck = false;
                progressBar1.Value += 40;
                // Convert SA* MPGs using FFMPEG
                for (int u = 1; u < 9; u++)
                {
                    progressBar1.Value += 20;
                    WriteLog("Converting SA" + u.ToString() + ".MPG...");
                    pProcess.StartInfo.FileName = "ffmpeg.exe";
                    pProcess.StartInfo.Arguments = "-y -hide_banner -loglevel error -f mpeg -r 29.97 -i sa" + u.ToString() + ".mpg -vcodec mpeg1video -s 640x480 -aspect 4/3 -acodec mp2 -b:v 3000000 SA" + u.ToString() + ".MPEG";
                    pProcess.StartInfo.UseShellExecute = false;
                    pProcess.StartInfo.RedirectStandardError = true;
                    pProcess.StartInfo.WorkingDirectory = Path.Combine(Environment.CurrentDirectory, "system");
                    pProcess.StartInfo.CreateNoWindow = true;
                    pProcess.Start();
                    strOutput = pProcess.StandardError.ReadToEnd();
                    WriteLog(strOutput);
                    pProcess.WaitForExit();
                    if (File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "SA" + u.ToString() + ".MPEG")))
                    {
                        if (File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "SA" + u.ToString() + ".MPG"))) File.Replace(Path.Combine(Environment.CurrentDirectory, "system", "SA" + u.ToString() + ".MPEG"), Path.Combine(Environment.CurrentDirectory, "system", "SA" + u.ToString() + ".MPG"), Path.Combine(Environment.CurrentDirectory, "system", "SA" + u.ToString() + "_bk.MPEG"));
                        File.Delete(Path.Combine(Environment.CurrentDirectory, "system", "SA" + u.ToString() + "_bk.MPEG"));
                        if (File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "SA" + u.ToString() + ".SFD"))) File.Delete(Path.Combine(Environment.CurrentDirectory, "system", "SA" + u.ToString() + ".SFD"));
                    }
                    else
                        WriteLog("Error converting file SA" + u.ToString() + ".MPG.");
                    if (File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "tmp.mp2"))) File.Delete(Path.Combine(Environment.CurrentDirectory, "system", "tmp.mp2"));
                    if (File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "tmp.wav"))) File.Delete(Path.Combine(Environment.CurrentDirectory, "system", "tmp.wav"));
                }
                for (int o = 1; o < 9; o++)
                {
                    if (!File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "SA" + o.ToString() + ".MPG")))
                    {
                        mpgcheck = true;
                    }
                }
                if (mpgcheck)
                    MessageBox.Show("sfd2mpg failed to convert some or all SADX videos to 2004 format. Verify integrity of your SADX installation and run the installer again.", "Error: FMV conversion failed", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
            }
            else
            {
                WriteLog("SA* SFD files not found, skipping conversion.");
                bool mpgcheck = false;
                for (int o = 1; o < 9; o++)
                {
                    if (!File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "SA" + o.ToString() + ".MPG")))
                    {
                        mpgcheck = true;
                    }
                }
                if (mpgcheck)
                    MessageBox.Show("sfd2mpg failed to convert some or all SADX videos to 2004 format. Verify integrity of your SADX installation and run the installer again.", "Error: FMV conversion failed", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
                else
                    WriteLog("SA* MPG files already exist.");
            }
            // Convert US intro using FFMPEG
            if (!File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "RE-US.MPG")))
            {
                if (!Directory.Exists(Path.Combine(Environment.CurrentDirectory, "DLC")))
                {
                    WriteLog("Could not locate the DLC folder.");
                    MessageBox.Show("Could not locate the DLC folder at " + Path.Combine(Environment.CurrentDirectory, "DLC") + ".\nVerify integrity of your SADX installation and run the installer again.", "Error: FMV conversion failed", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
                }
                else
                {
                    pProcess = new System.Diagnostics.Process();
                    WriteLog("Converting RE-US.MPG...");
                    pProcess.StartInfo.FileName = "ffmpeg.exe";
                    pProcess.StartInfo.Arguments = "-y -hide_banner -loglevel error -f mpeg -r 29.97 -i re-us2.sfd -vcodec mpeg1video -aspect 4/3 -acodec mp2 -b:v 5800000 RE-US.MPG";
                    pProcess.StartInfo.UseShellExecute = false;
                    pProcess.StartInfo.RedirectStandardError = true;
                    pProcess.StartInfo.WorkingDirectory = Path.Combine(Environment.CurrentDirectory, "DLC");
                    pProcess.StartInfo.CreateNoWindow = true;
                    pProcess.Start();
                    strOutput = pProcess.StandardError.ReadToEnd();
                    WriteLog(strOutput);
                    pProcess.WaitForExit();
                    if (File.Exists(Path.Combine(Environment.CurrentDirectory, "DLC", "RE-US.MPG"))) File.Move(Path.Combine(Environment.CurrentDirectory, "DLC", "RE-US.MPG"), Path.Combine(Environment.CurrentDirectory, "system", "RE-US.MPG"));
                    else
                        WriteLog("Error converting RE-US.MPG.");
                    if (!File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "RE-US.MPG")))
                        MessageBox.Show("Intro file conversion failed: " + Path.Combine(Environment.CurrentDirectory, "system", "RE-US.MPG") + ".\nVerify integrity of your SADX installation and run the installer again.", "Error: FMV conversion failed", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
                }
                // Convert JP intro using FFMPEG
                if (!File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "RE-JP.MPG")))
                {
                    pProcess = new System.Diagnostics.Process();
                    WriteLog("Converting RE-JP.MPG");
                    pProcess.StartInfo.FileName = "ffmpeg.exe";
                    pProcess.StartInfo.Arguments = "-y -hide_banner -loglevel error -f mpeg -r 29.97 -i re-jp2.sfd -vcodec mpeg1video -aspect 4/3 -acodec mp2 -b:v 5800000 RE-JP.MPG";
                    pProcess.StartInfo.UseShellExecute = false;
                    pProcess.StartInfo.RedirectStandardError = true;
                    pProcess.StartInfo.WorkingDirectory = Path.Combine(Environment.CurrentDirectory, "DLC");
                    pProcess.StartInfo.CreateNoWindow = true;
                    pProcess.Start();
                    strOutput = pProcess.StandardError.ReadToEnd();
                    WriteLog(strOutput);
                    pProcess.WaitForExit();
                    if (File.Exists(Path.Combine(Environment.CurrentDirectory, "DLC", "RE-JP.MPG"))) File.Move(Path.Combine(Environment.CurrentDirectory, "DLC", "RE-JP.MPG"), Path.Combine(Environment.CurrentDirectory, "system", "RE-JP.MPG"));
                    else
                        WriteLog("Error converting RE-JP.MPG.");
                    if (!File.Exists(Path.Combine(Environment.CurrentDirectory, "system", "RE-JP.MPG")))
                        MessageBox.Show("Intro file conversion failed: " + Path.Combine(Environment.CurrentDirectory, "system", "RE-JP.MPG") + ".\nVerify integrity of your SADX installation and run the installer again.", "Error: FMV conversion failed", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
                }
            }
            else
                WriteLog("File RE-JP.MPG already exists.");
        }
		private void ConvertDAT(string filename)
		{
			// Load file
			WriteLog("Opening file: " + filename);
			byte[] file = File.ReadAllBytes(filename);
			switch (System.Text.Encoding.ASCII.GetString(file, 0, 0x10))
			{
				case "archive  V2.2\0\0\0":
					is2010 = false;
					WriteLog("Bank " + Path.GetFileName(filename) + " is already in the 2004 format.");
					return;
				case "archive  V2.DMZ\0":
					is2010 = true;
					break;
				default:
					WriteLog("Bank " + Path.GetFileName(filename) + "error: Unknown archive version/type");
					return;
			}
			int count = BitConverter.ToInt32(file, 0x10);
			files = new List<FENTRY>(count);
			for (int i = 0; i < count; i++)
			{
				files.Add(new FENTRY(file, 0x14 + (i * 0xC)));
			}
			// Convert
			WriteLog("Converting soundbank " + Path.GetFileName(filename) + "...");
			List<FENTRY> list = new List<FENTRY>(files);
			foreach (FENTRY item in list)
			{
				byte[] waveFile = Compress.ProcessBuffer(item.file);
				if (is2010)
				{
					AudioData audio = new AdxReader().Read(waveFile);
					item.file = new WaveWriter().GetFile(audio);
				}
			}
			WriteLog("Saving DAT file: " + filename + "...");
			int fsize = 0x14;
			int hloc = fsize;
			fsize += files.Count * 0xC;
			int tloc = fsize;
			foreach (FENTRY item in files)
			{
				fsize += item.name.Length + 1;
			}
			int floc = fsize;
			foreach (FENTRY item in files)
			{
				fsize += item.file.Length;
			}
			byte[] datfile = new byte[fsize];
			System.Text.Encoding.ASCII.GetBytes("archive  V2.2").CopyTo(datfile, 0);
			BitConverter.GetBytes(files.Count).CopyTo(datfile, 0x10);
			foreach (FENTRY item in files)
			{
				BitConverter.GetBytes(tloc).CopyTo(datfile, hloc);
				hloc += 4;
				System.Text.Encoding.ASCII.GetBytes(item.name).CopyTo(datfile, tloc);
				tloc += item.name.Length + 1;
				BitConverter.GetBytes(floc).CopyTo(datfile, hloc);
				hloc += 4;
				item.file.CopyTo(datfile, floc);
				floc += item.file.Length;
				BitConverter.GetBytes(item.file.Length).CopyTo(datfile, hloc);
				hloc += 4;
			}
			File.WriteAllBytes(filename, datfile);
			progressBar1.Value += 1;
		}
		static ushort CalcSaveChecksum(byte[] a2)
		{
			ushort v1; // eax@1
			int v2; // ecx@1
			byte v3; // edi@2
			ushort v4; // eax@3
			ushort v6; // [sp+0h] [bp-4h]@2

			v1 = 65535;
			v2 = 4;
			do
			{
				v3 = a2[v2];
				v6 = (ushort)(v3 ^ v1);
				if (((v3 ^ (byte)v1) & 1) != 0)
				{
					v4 = (ushort)((v6 >> 1) ^ 0x8408);
					v6 = (ushort)((v6 >> 1) ^ 0x8408);
				}
				else
				{
					v4 = (ushort)(v6 >> 1);
					v6 = (ushort)(v6 >> 1);
				}
				v4 = (ushort)(v4 >> 1);
				if ((v6 & 1) != 0)
				{
					v4 ^= 0x8408;
					v6 = v4;
				}
				else
				{
					v6 = v4;
				}
				v4 = (ushort)(v4 >> 1);
				if ((v6 & 1) != 0)
				{
					v4 ^= 0x8408;
					v6 = v4;
				}
				else
				{
					v6 = v4;
				}
				v4 = (ushort)(v4 >> 1);
				if ((v6 & 1) != 0)
				{
					v4 ^= 0x8408;
					v6 = v4;
				}
				else
				{
					v6 = v4;
				}
				v4 = (ushort)(v4 >> 1);
				if ((v6 & 1) != 0)
				{
					v4 ^= 0x8408;
					v6 = v4;
				}
				else
				{
					v6 = v4;
				}
				v4 = (ushort)(v4 >> 1);
				if ((v6 & 1) != 0)
				{
					v4 ^= 0x8408;
					v6 = v4;
				}
				else
				{
					v6 = v4;
				}
				v4 = (ushort)(v4 >> 1);
				if ((v6 & 1) != 0)
				{
					v4 ^= 0x8408;
					v6 = v4;
				}
				else
				{
					v6 = v4;
				}
				v4 = (ushort)(v4 >> 1);
				if ((v6 & 1) != 0)
				{
					v1 = (ushort)(v4 ^ 0x8408);
				}
				else
				{
					v6 = v4;
					v1 = v6;
				}
				++v2;
			}
			while (v2 < 0x570);
			return (ushort)~v1;
		}
		static bool Compare(byte[] a1, byte[] a2)
		{
			if (a1.Length != a2.Length)
				return false;

			for (int i = 0; i < a1.Length; i++)
				if (a1[i] != a2[i])
					return false;

			return true;
		}
		private bool CheckSaveDuplicate(byte[] file)
		{
			foreach (var item in saves)
			{
				if (Compare(file, item))
				{
					WriteLog("Duplicate save data found, file not added");
					return true;
				}
			}
			return false;
		}
		private void AddSave(byte[] file)
		{
			if (!CheckSaveDuplicate(file))
				saves.Add(file);
		}
		private void ConvertSave()
		{
			saves = new List<byte[]>();
			string path_sadx2004 = Environment.CurrentDirectory;
			string path_steam = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.UserProfile), "Documents", "SEGA", "Sonic Adventure DX", "SAVEDATA");
			string path_dccol = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.UserProfile), "Documents", "SEGA", "Dreamcast Collection", "Sonic Adventure DX", "SAVEDATA");
			string path_savefolder = path_steam;
			bool dosaves = false;
			if (Directory.Exists(path_steam))
			{
				WriteLog("Found Steam saves at " + path_steam);
				dosaves = true;
			}
			else if (Directory.Exists(path_dccol))
			{
				WriteLog("Found Dreamcast Collection saves" + path_dccol);
				path_savefolder = path_dccol;
				dosaves = true;
			}
			if (!dosaves)
			{
				WriteLog("No save data found");
				return;
			}
			// Create 2004 savedata folder
			if (!Directory.Exists(Path.Combine(Environment.CurrentDirectory, "savedata"))) Directory.CreateDirectory(Path.Combine(Environment.CurrentDirectory, "savedata"));
			// Copy Chao Garden file
			if (File.Exists(Path.Combine(path_sadx2004, "savedata", "SONICADVENTURE_DX_CHAOGARDEN.snc")))
			{
				WriteLog("The Chao save file was not converted because your SADX 2004 savedata folder already contains a Chao save file.");
			}
			else if (File.Exists(Path.Combine(path_savefolder, "SonicAdventureChaoGarden.snc")))
			{
				WriteLog("Copying Chao Garden file...");
				WriteLog(Path.Combine(path_savefolder, "SonicAdventureChaoGarden.snc") + " > " + Path.Combine(Environment.CurrentDirectory, "savedata", "SONICADVENTURE_DX_CHAOGARDEN.snc"));
				File.Copy(Path.Combine(path_savefolder, "SonicAdventureChaoGarden.snc"), Path.Combine(Environment.CurrentDirectory, "savedata", "SONICADVENTURE_DX_CHAOGARDEN.snc"));
			}
			// Add regular saves from SADX2004 folder
			for (int u = 1; u < 100; u++)
			{
				string savefile = Path.Combine(path_sadx2004, "savedata", "SonicDX" + u.ToString("D2") + ".snc");
				if (File.Exists(savefile))
				{
					WriteLog("Adding save: " + savefile);
					AddSave(File.ReadAllBytes(savefile));
				}
			}
			// Add regular saves from Steam folder
			WriteLog("Converting regular saves...");
			for (int i = 1; i < 100; i++)
			{
				string path_save = Path.Combine(path_savefolder, "SonicAdventure" + i.ToString("D2") + ".snc");
				if (File.Exists(path_save))
				{
					byte[] newsave = new byte[1392];
					Array.Copy(File.ReadAllBytes(path_save), newsave, newsave.Length);
					BitConverter.GetBytes(CalcSaveChecksum(newsave)).CopyTo(newsave, 0);
					WriteLog("Checking/adding save: " + path_save);
					AddSave(newsave);
				}
			}
			// Write out the saves
			WriteLog("Writing out saves...");
			int s = 0;
			foreach (var item in saves)
			{
				File.WriteAllBytes(Path.Combine(path_sadx2004, "savedata", "SonicDX" + (s + 1).ToString("D2") + ".snc"), saves[s]);
				WriteLog("Converted save file:\n" + Path.Combine(path_sadx2004, "savedata", "SonicDX" + (s + 1).ToString("D2") + ".snc"));
				s++;
			}
		}
		private void SetProgress(int value)
		{
			if (progressBar1.InvokeRequired)
			{
				SetValueCallback d = new SetValueCallback(SetProgress);
				this.Invoke(d, new object[] { value });
			}
			else
				progressBar1.Value = value;
		}
		private void ActivateLabel(System.Windows.Forms.Label control, string text)
		{
			if (control.InvokeRequired)
			{
				SetTextCallbackFull d = new SetTextCallbackFull(ActivateLabel);
				this.Invoke(d, new object[] { control, text });
			}
			else
			{
				control.Font = new Font(DefaultFont, FontStyle.Bold);
				control.Text = text;
			}
		}
		private void DoneLabel(System.Windows.Forms.Label control, string text)
		{
			if (labelSaves.InvokeRequired)
			{
				SetTextCallbackFull d = new SetTextCallbackFull(DoneLabel);
				this.Invoke(d, new object[] { control, text });
			}
			else
			{
				control.Font = new Font(DefaultFont, FontStyle.Regular);
				control.Text = text;
			}
		}
		private void UpdateProgressLabel(string text)
		{
			if (ProgressLabel.InvokeRequired)
			{
				SetTextCallback d = new SetTextCallback(UpdateProgressLabel);
				this.Invoke(d, new object[] { text });
			}
			else
			{
				ProgressLabel.Text = text;
			}
		}
		private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
			bool done = false;
			while (!done)
			{
				try
				{
					UpdateProgressLabel("Creating log file...");
					logger = File.CreateText(Path.Combine(Environment.CurrentDirectory, "SADX Steam Conversion.log"));
                    UpdateProgressLabel("Registering URL handler...");
                    WriteLog("Registering URL handler...");
                    addURLHandler();
                    ActivateLabel(labelSaves, "  Converting save data...");
					ConvertSave();
					SetProgress(10);
					DoneLabel(labelSaves, "✓ Converting save data...");
					ActivateLabel(labelVideos, "  Converting videos...");
					ConvertSFD();
					SetProgress(210);
					DoneLabel(labelVideos, "✓ Converting videos...");
					ActivateLabel(labelSounds, "  Converting sounds...");
					if (Directory.Exists("SoundData"))
					{
						WriteLog("Moving the SoundData folder...");
						if (Directory.Exists(Path.Combine("system", "SoundData"))) Directory.Delete(Path.Combine("system", "SoundData"));
						Directory.Move("SoundData", Path.Combine("system", "SoundData"));
					}
					else if (Directory.Exists(Path.Combine("system", "SoundData"))) WriteLog("SoundData folder is already in system");
					else
					{
						WriteLog("Could not find the SoundData folder.");
						MessageBox.Show("Could not find the SoundData folder. Verify integrity of your SADX installation and run the installer again.", "Error: Soundbank conversion failed", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);

					}
					WriteLog("Converting soundbanks...");
					List<string> errornames = new List<string>();
					for (int u = 0; u < DATNames.Length; u++)
					{
						string fn = Path.Combine(Environment.CurrentDirectory, "system", "SoundData", "se", DATNames[u]);
						if (File.Exists(fn)) ConvertDAT(fn);
						if (!File.Exists(fn))
						{
							if (errornames.Count < 5) errornames.Add(fn);
						}
					}
					if (errornames.Count > 0)
					{
						string combinedString = string.Join("\n", errornames.ToArray());
						MessageBox.Show("The following soundbanks were not converted properly:\n" + combinedString + ".\n\nVerify integrity of your SADX installation and run the installer again.", "Error: Soundbank conversion failed", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
					}
					DoneLabel(labelSounds, "✓ Converting sounds...");
					SetProgress(330);
					WriteLog("Done!");
					logger.Close();
					System.Threading.Thread.Sleep(1000);
					done = true;
				}
				catch (Exception ex)
				{
					DialogResult result;
					result = MessageBox.Show("Error running Steam Conversion Helper: \n" + ex.Message.ToString() + "\n\nSome files in the game's folder may be blocked by another program, or your anti-virus is interfering. Close all programs accessing the game's folder and try again.\n\nIf you skip this step, the game won't have sound, music and videos.\n\nTry again?", "Error running Steam Conversion Helper", MessageBoxButtons.RetryCancel, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
					if (result == DialogResult.Cancel) System.Environment.Exit(0);
				}
			}
            System.Environment.Exit(0);
		}

        // Code from SADX Mod Loader
        private void addURLHandler()
        {
            try
            {
                using (var hkcr = Microsoft.Win32.Registry.ClassesRoot)
                using (var key = hkcr.CreateSubKey("sadxmm"))
                {
                    key.SetValue(null, "URL:SADX Mod Manager Protocol");
                    key.SetValue("URL Protocol", string.Empty);
                    using (var k2 = key.CreateSubKey("DefaultIcon"))
                        k2.SetValue(null, Path.Combine(Path.GetDirectoryName(Application.ExecutablePath), "SADXModManager.exe") + ",1");
                    using (var k3 = key.CreateSubKey("shell"))
                    using (var k4 = k3.CreateSubKey("open"))
                    using (var k5 = k4.CreateSubKey("command"))
                        k5.SetValue(null, $"\"{Path.Combine(Path.GetDirectoryName(Application.ExecutablePath), "SADXModManager.exe")}\" \"%1\"");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Unable to registed SADX Mod Manager URL handler:\n" + ex.Message.ToString());
            }
        }

        // Code from SA Tools
		internal class FENTRY
		{
			public string name;
			public byte[] file;

			public FENTRY()
			{
				name = string.Empty;
			}

			public FENTRY(string fileName)
			{
				name = Path.GetFileName(fileName);
				file = File.ReadAllBytes(fileName);
			}

			public FENTRY(byte[] file, int address)
			{
				name = GetCString(file, BitConverter.ToInt32(file, address));
				this.file = new byte[BitConverter.ToInt32(file, address + 8)];
				Array.Copy(file, BitConverter.ToInt32(file, address + 4), this.file, 0, this.file.Length);
			}

			private string GetCString(byte[] file, int address)
			{
				int textsize = 0;
				while (file[address + textsize] > 0)
					textsize += 1;
				return System.Text.Encoding.ASCII.GetString(file, address, textsize);
			}
		}
		internal static class Compress
		{
			const uint SLIDING_LEN = 0x1000;
			const uint SLIDING_MASK = 0xFFF;

			const byte NIBBLE_HIGH = 0xF0;
			const byte NIBBLE_LOW = 0x0F;

			struct OffsetLengthPair
			{
				public byte highByte, lowByte;
				public int Offset
				{
					get
					{
						return ((lowByte & NIBBLE_HIGH) << 4) | highByte;
					}
				}
				public int Length
				{
					get
					{
						return (lowByte & NIBBLE_LOW) + 3;
					}
				}
			}
			struct ChunkHeader
			{
				private byte flags;
				private byte mask;

				public bool ReadFlag(out bool flag)
				{
					bool endOfHeader = mask != 0x00;

					flag = (flags & mask) != 0;

					mask <<= 1;
					return endOfHeader;
				}

				public ChunkHeader(byte flags)
				{
					this.flags = flags;
					this.mask = 0x01;
				}
			}

			private static void DecompressBuffer(byte[] decompBuf, byte[] compBuf /*Starting at + 20*/)
			{
				OffsetLengthPair olPair = new OffsetLengthPair();

				int compBufPtr = 0;
				int decompBufPtr = 0;

				// Create sliding dictionary buffer and clear first 4078 bytes of dictionary buffer to 0
				byte[] slidingDict = new byte[SLIDING_LEN];

				// Set an offset to the dictionary insertion point
				uint dictInsertionOffset = SLIDING_LEN - 18;

				// Current chunk header
				ChunkHeader chunkHeader = new ChunkHeader();

				while (decompBufPtr < decompBuf.Length)
				{
					// At the start of each chunk...
					if (!chunkHeader.ReadFlag(out bool flag))
					{
						// Load the chunk header
						chunkHeader = new ChunkHeader(compBuf[compBufPtr++]);
						chunkHeader.ReadFlag(out flag);
					}

					// Each chunk header is a byte and is a collection of 8 flags

					// If the flag is set, load a character
					if (flag)
					{
						// Copy the character
						byte rawByte = compBuf[compBufPtr++];
						decompBuf[decompBufPtr++] = rawByte;

						// Add the character to the dictionary, and slide the dictionary
						slidingDict[dictInsertionOffset++] = rawByte;
						dictInsertionOffset &= SLIDING_MASK;

					}
					// If the flag is clear, load an offset/length pair
					else
					{
						// Load the offset/length pair
						olPair.highByte = compBuf[compBufPtr++];
						olPair.lowByte = compBuf[compBufPtr++];

						// Get the offset from the offset/length pair
						int offset = olPair.Offset;

						// Get the length from the offset/length pair
						int length = olPair.Length;

						for (int i = 0; i < length; i++)
						{
							byte rawByte = slidingDict[(offset + i) & SLIDING_MASK];
							decompBuf[decompBufPtr++] = rawByte;

							if (decompBufPtr >= decompBuf.Length) return;

							// Add the character to the dictionary, and slide the dictionary
							slidingDict[dictInsertionOffset++] = rawByte;
							dictInsertionOffset &= SLIDING_MASK;
						}
					}
				}
			}

			public static bool isFileCompressed(byte[] CompressedBuffer)
			{
				return System.Text.Encoding.ASCII.GetString(CompressedBuffer, 0, 13) == "compress v1.0";
			}

			public static byte[] ProcessBuffer(byte[] CompressedBuffer)
			{
				if (isFileCompressed(CompressedBuffer))
				{
					uint DecompressedSize = BitConverter.ToUInt32(CompressedBuffer, 16);
					byte[] DecompressedBuffer = new byte[DecompressedSize];
					// Xor Decrypt the whole buffer
					byte XorEncryptionValue = CompressedBuffer[15];

					byte[] CompBuf = new byte[CompressedBuffer.Length - 20];
					for (int i = 20; i < CompressedBuffer.Length; i++)
					{
						CompBuf[i - 20] = (byte)(CompressedBuffer[i] ^ XorEncryptionValue);
					}

					// Decompress the whole buffer
					DecompressBuffer(DecompressedBuffer, CompBuf);

					// Switch the buffers around so the decompressed one gets saved instead
					return DecompressedBuffer;
				}
				else
				{
					return CompressedBuffer;
				}
			}

		}
        private void Form_SteamHelper_FormClosing(object sender, FormClosingEventArgs e)
        {
			e.Cancel = true;
        }
    }
}
