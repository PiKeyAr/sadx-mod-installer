
namespace SteamHelper
{
    partial class Form_SteamHelper
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.labelSaves = new System.Windows.Forms.Label();
            this.labelVideos = new System.Windows.Forms.Label();
            this.labelSounds = new System.Windows.Forms.Label();
            this.ProgressLabel = new System.Windows.Forms.Label();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.label4 = new System.Windows.Forms.Label();
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.SuspendLayout();
            // 
            // labelSaves
            // 
            this.labelSaves.AutoSize = true;
            this.labelSaves.ForeColor = System.Drawing.SystemColors.ControlText;
            this.labelSaves.Location = new System.Drawing.Point(49, 46);
            this.labelSaves.Name = "labelSaves";
            this.labelSaves.Size = new System.Drawing.Size(178, 20);
            this.labelSaves.TabIndex = 0;
            this.labelSaves.Text = "  Converting save data...";
            // 
            // labelVideos
            // 
            this.labelVideos.AutoSize = true;
            this.labelVideos.Location = new System.Drawing.Point(49, 80);
            this.labelVideos.Name = "labelVideos";
            this.labelVideos.Size = new System.Drawing.Size(154, 20);
            this.labelVideos.TabIndex = 1;
            this.labelVideos.Text = "  Converting videos...";
            // 
            // labelSounds
            // 
            this.labelSounds.AutoSize = true;
            this.labelSounds.Location = new System.Drawing.Point(49, 111);
            this.labelSounds.Name = "labelSounds";
            this.labelSounds.Size = new System.Drawing.Size(161, 20);
            this.labelSounds.TabIndex = 2;
            this.labelSounds.Text = "  Converting sounds...";
            // 
            // ProgressLabel
            // 
            this.ProgressLabel.Location = new System.Drawing.Point(12, 203);
            this.ProgressLabel.Name = "ProgressLabel";
            this.ProgressLabel.Size = new System.Drawing.Size(454, 135);
            this.ProgressLabel.TabIndex = 3;
            this.ProgressLabel.Text = "Current progress";
            // 
            // progressBar1
            // 
            this.progressBar1.Location = new System.Drawing.Point(16, 148);
            this.progressBar1.Maximum = 335;
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(450, 37);
            this.progressBar1.TabIndex = 4;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.ForeColor = System.Drawing.SystemColors.ControlText;
            this.label4.Location = new System.Drawing.Point(12, 9);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(303, 20);
            this.label4.TabIndex = 5;
            this.label4.Text = "Converting your SADX data, please wait...";
            // 
            // backgroundWorker1
            // 
            this.backgroundWorker1.WorkerReportsProgress = true;
            this.backgroundWorker1.DoWork += new System.ComponentModel.DoWorkEventHandler(this.backgroundWorker1_DoWork);
            // 
            // Form_SteamHelper
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(486, 357);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.progressBar1);
            this.Controls.Add(this.ProgressLabel);
            this.Controls.Add(this.labelSounds);
            this.Controls.Add(this.labelVideos);
            this.Controls.Add(this.labelSaves);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form_SteamHelper";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Steam Conversion Helper";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form_SteamHelper_FormClosing);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelSaves;
        private System.Windows.Forms.Label labelVideos;
        private System.Windows.Forms.Label labelSounds;
        private System.Windows.Forms.Label ProgressLabel;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.Label label4;
        private System.ComponentModel.BackgroundWorker backgroundWorker1;
    }
}