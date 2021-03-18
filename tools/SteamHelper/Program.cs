using System.Windows.Forms;

namespace SteamHelper
{
	static class Program
	{
		static void Main(string[] args)
		{
			Form_SteamHelper form;
			Application.EnableVisualStyles();
			Application.SetCompatibleTextRenderingDefault(false);
			form = new Form_SteamHelper();
			form.ShowDialog();
		}
	}
}