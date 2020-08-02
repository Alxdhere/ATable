namespace TDMS2Grid
{
    partial class frmDialog
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
            this.lbQueries = new System.Windows.Forms.ListBox();
            this.lObject = new System.Windows.Forms.Label();
            this.tbObject = new System.Windows.Forms.TextBox();
            this.btBrowse = new System.Windows.Forms.Button();
            this.lQueries = new System.Windows.Forms.Label();
            this.btClose = new System.Windows.Forms.Button();
            this.btUpdate = new System.Windows.Forms.Button();
            this.pbProgress = new System.Windows.Forms.ProgressBar();
            this.lbProgress = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lbQueries
            // 
            this.lbQueries.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbQueries.FormattingEnabled = true;
            this.lbQueries.Location = new System.Drawing.Point(16, 65);
            this.lbQueries.Name = "lbQueries";
            this.lbQueries.Size = new System.Drawing.Size(464, 147);
            this.lbQueries.TabIndex = 2;
            // 
            // lObject
            // 
            this.lObject.AutoSize = true;
            this.lObject.Location = new System.Drawing.Point(13, 13);
            this.lObject.Name = "lObject";
            this.lObject.Size = new System.Drawing.Size(108, 13);
            this.lObject.TabIndex = 1;
            this.lObject.Text = "Выбранный объект:";
            // 
            // tbObject
            // 
            this.tbObject.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbObject.Location = new System.Drawing.Point(127, 10);
            this.tbObject.Name = "tbObject";
            this.tbObject.ReadOnly = true;
            this.tbObject.Size = new System.Drawing.Size(330, 20);
            this.tbObject.TabIndex = 2;
            this.tbObject.TabStop = false;
            // 
            // btBrowse
            // 
            this.btBrowse.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btBrowse.Location = new System.Drawing.Point(456, 10);
            this.btBrowse.Name = "btBrowse";
            this.btBrowse.Size = new System.Drawing.Size(24, 20);
            this.btBrowse.TabIndex = 1;
            this.btBrowse.Text = "...";
            this.btBrowse.UseVisualStyleBackColor = true;
            this.btBrowse.Click += new System.EventHandler(this.btBrowse_Click);
            // 
            // lQueries
            // 
            this.lQueries.AutoSize = true;
            this.lQueries.Location = new System.Drawing.Point(13, 44);
            this.lQueries.Name = "lQueries";
            this.lQueries.Size = new System.Drawing.Size(133, 13);
            this.lQueries.TabIndex = 4;
            this.lQueries.Text = "Доступные типы таблиц:";
            // 
            // btClose
            // 
            this.btClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btClose.Location = new System.Drawing.Point(405, 238);
            this.btClose.Name = "btClose";
            this.btClose.Size = new System.Drawing.Size(75, 23);
            this.btClose.TabIndex = 0;
            this.btClose.Text = "Закрыть";
            this.btClose.UseVisualStyleBackColor = true;
            // 
            // btUpdate
            // 
            this.btUpdate.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btUpdate.Location = new System.Drawing.Point(324, 238);
            this.btUpdate.Name = "btUpdate";
            this.btUpdate.Size = new System.Drawing.Size(75, 23);
            this.btUpdate.TabIndex = 3;
            this.btUpdate.Text = "Обновить";
            this.btUpdate.UseVisualStyleBackColor = true;
            this.btUpdate.Click += new System.EventHandler(this.bUpdate_Click);
            // 
            // pbProgress
            // 
            this.pbProgress.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pbProgress.Location = new System.Drawing.Point(16, 238);
            this.pbProgress.Name = "pbProgress";
            this.pbProgress.Size = new System.Drawing.Size(302, 23);
            this.pbProgress.TabIndex = 5;
            this.pbProgress.Value = 50;
            // 
            // lbProgress
            // 
            this.lbProgress.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.lbProgress.AutoSize = true;
            this.lbProgress.BackColor = System.Drawing.SystemColors.Control;
            this.lbProgress.ForeColor = System.Drawing.SystemColors.ControlText;
            this.lbProgress.Location = new System.Drawing.Point(13, 220);
            this.lbProgress.Name = "lbProgress";
            this.lbProgress.Size = new System.Drawing.Size(73, 13);
            this.lbProgress.TabIndex = 6;
            this.lbProgress.Text = "Выполнение:";
            this.lbProgress.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // frmDialog
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btClose;
            this.ClientSize = new System.Drawing.Size(492, 273);
            this.Controls.Add(this.lbProgress);
            this.Controls.Add(this.pbProgress);
            this.Controls.Add(this.btUpdate);
            this.Controls.Add(this.btClose);
            this.Controls.Add(this.lQueries);
            this.Controls.Add(this.btBrowse);
            this.Controls.Add(this.tbObject);
            this.Controls.Add(this.lObject);
            this.Controls.Add(this.lbQueries);
            this.MinimumSize = new System.Drawing.Size(500, 300);
            this.Name = "frmDialog";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Импорт таблиц из TDMS";
            this.Shown += new System.EventHandler(this.frmDialog_Shown);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListBox lbQueries;
        private System.Windows.Forms.Label lObject;
        private System.Windows.Forms.TextBox tbObject;
        private System.Windows.Forms.Button btBrowse;
        private System.Windows.Forms.Label lQueries;
        private System.Windows.Forms.Button btClose;
        private System.Windows.Forms.Button btUpdate;
        private System.Windows.Forms.ProgressBar pbProgress;
        private System.Windows.Forms.Label lbProgress;
    }
}