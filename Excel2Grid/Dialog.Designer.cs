namespace Excel2Grid
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmDialog));
            this.btCancel = new System.Windows.Forms.Button();
            this.tbLink = new System.Windows.Forms.TextBox();
            this.btUpdate = new System.Windows.Forms.Button();
            this.btGetLink = new System.Windows.Forms.Button();
            this.lLink = new System.Windows.Forms.Label();
            this.lFrom = new System.Windows.Forms.Label();
            this.cbUseColWidth = new System.Windows.Forms.CheckBox();
            this.cbUseRowHeight = new System.Windows.Forms.CheckBox();
            this.cbMerge = new System.Windows.Forms.CheckBox();
            this.cbHorizontal = new System.Windows.Forms.CheckBox();
            this.cbVertical = new System.Windows.Forms.CheckBox();
            this.cbBorders = new System.Windows.Forms.CheckBox();
            this.lSizeCoef = new System.Windows.Forms.Label();
            this.nudCol = new System.Windows.Forms.NumericUpDown();
            this.nudRow = new System.Windows.Forms.NumericUpDown();
            this.nudSizeCoef = new System.Windows.Forms.NumericUpDown();
            this.cbUseExcelRangeSize = new System.Windows.Forms.CheckBox();
            this.lbLog = new System.Windows.Forms.ListBox();
            this.pbProgress = new System.Windows.Forms.ProgressBar();
            this.nudBetweenInJoined = new System.Windows.Forms.NumericUpDown();
            this.lBetweenInJoined = new System.Windows.Forms.Label();
            this.nudFitSize = new System.Windows.Forms.NumericUpDown();
            this.cbFitInSize = new System.Windows.Forms.CheckBox();
            this.cbUseRotate = new System.Windows.Forms.CheckBox();
            this.cbUseReplaceDoubleSpace = new System.Windows.Forms.CheckBox();
            this.cbUseReplaceMultiSpace = new System.Windows.Forms.CheckBox();
            ((System.ComponentModel.ISupportInitialize)(this.nudCol)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudRow)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudSizeCoef)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudBetweenInJoined)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudFitSize)).BeginInit();
            this.SuspendLayout();
            // 
            // btCancel
            // 
            resources.ApplyResources(this.btCancel, "btCancel");
            this.btCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btCancel.Name = "btCancel";
            this.btCancel.UseVisualStyleBackColor = true;
            //this.btCancel.Click += new System.EventHandler(this.btCancel_Click);
            // 
            // tbLink
            // 
            resources.ApplyResources(this.tbLink, "tbLink");
            this.tbLink.Name = "tbLink";
            // 
            // btUpdate
            // 
            resources.ApplyResources(this.btUpdate, "btUpdate");
            this.btUpdate.Name = "btUpdate";
            this.btUpdate.UseVisualStyleBackColor = true;
            this.btUpdate.Click += new System.EventHandler(this.btUpdate_Click);
            // 
            // btGetLink
            // 
            resources.ApplyResources(this.btGetLink, "btGetLink");
            this.btGetLink.Name = "btGetLink";
            this.btGetLink.UseVisualStyleBackColor = true;
            this.btGetLink.Click += new System.EventHandler(this.btGetLink_Click);
            // 
            // lLink
            // 
            resources.ApplyResources(this.lLink, "lLink");
            this.lLink.Name = "lLink";
            // 
            // lFrom
            // 
            resources.ApplyResources(this.lFrom, "lFrom");
            this.lFrom.Name = "lFrom";
            // 
            // cbUseColWidth
            // 
            resources.ApplyResources(this.cbUseColWidth, "cbUseColWidth");
            this.cbUseColWidth.Name = "cbUseColWidth";
            this.cbUseColWidth.UseVisualStyleBackColor = true;
            // 
            // cbUseRowHeight
            // 
            resources.ApplyResources(this.cbUseRowHeight, "cbUseRowHeight");
            this.cbUseRowHeight.Name = "cbUseRowHeight";
            this.cbUseRowHeight.UseVisualStyleBackColor = true;
            // 
            // cbMerge
            // 
            resources.ApplyResources(this.cbMerge, "cbMerge");
            this.cbMerge.Name = "cbMerge";
            this.cbMerge.UseVisualStyleBackColor = true;
            // 
            // cbHorizontal
            // 
            resources.ApplyResources(this.cbHorizontal, "cbHorizontal");
            this.cbHorizontal.Name = "cbHorizontal";
            this.cbHorizontal.UseVisualStyleBackColor = true;
            // 
            // cbVertical
            // 
            resources.ApplyResources(this.cbVertical, "cbVertical");
            this.cbVertical.Name = "cbVertical";
            this.cbVertical.UseVisualStyleBackColor = true;
            // 
            // cbBorders
            // 
            resources.ApplyResources(this.cbBorders, "cbBorders");
            this.cbBorders.Name = "cbBorders";
            this.cbBorders.UseVisualStyleBackColor = true;
            // 
            // lSizeCoef
            // 
            resources.ApplyResources(this.lSizeCoef, "lSizeCoef");
            this.lSizeCoef.Name = "lSizeCoef";
            // 
            // nudCol
            // 
            resources.ApplyResources(this.nudCol, "nudCol");
            this.nudCol.Maximum = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            this.nudCol.Name = "nudCol";
            // 
            // nudRow
            // 
            resources.ApplyResources(this.nudRow, "nudRow");
            this.nudRow.Maximum = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            this.nudRow.Name = "nudRow";
            // 
            // nudSizeCoef
            // 
            resources.ApplyResources(this.nudSizeCoef, "nudSizeCoef");
            this.nudSizeCoef.DecimalPlaces = 3;
            this.nudSizeCoef.Name = "nudSizeCoef";
            // 
            // cbUseExcelRangeSize
            // 
            resources.ApplyResources(this.cbUseExcelRangeSize, "cbUseExcelRangeSize");
            this.cbUseExcelRangeSize.Name = "cbUseExcelRangeSize";
            this.cbUseExcelRangeSize.UseVisualStyleBackColor = true;
            // 
            // lbLog
            // 
            resources.ApplyResources(this.lbLog, "lbLog");
            this.lbLog.FormattingEnabled = true;
            this.lbLog.Name = "lbLog";
            // 
            // pbProgress
            // 
            resources.ApplyResources(this.pbProgress, "pbProgress");
            this.pbProgress.Name = "pbProgress";
            // 
            // nudBetweenInJoined
            // 
            resources.ApplyResources(this.nudBetweenInJoined, "nudBetweenInJoined");
            this.nudBetweenInJoined.DecimalPlaces = 3;
            this.nudBetweenInJoined.Name = "nudBetweenInJoined";
            // 
            // lBetweenInJoined
            // 
            resources.ApplyResources(this.lBetweenInJoined, "lBetweenInJoined");
            this.lBetweenInJoined.Name = "lBetweenInJoined";
            // 
            // nudFitSize
            // 
            resources.ApplyResources(this.nudFitSize, "nudFitSize");
            this.nudFitSize.DecimalPlaces = 3;
            this.nudFitSize.Maximum = new decimal(new int[] {
            1000000,
            0,
            0,
            0});
            this.nudFitSize.Name = "nudFitSize";
            // 
            // cbFitInSize
            // 
            resources.ApplyResources(this.cbFitInSize, "cbFitInSize");
            this.cbFitInSize.Name = "cbFitInSize";
            this.cbFitInSize.UseVisualStyleBackColor = true;
            // 
            // cbUseRotate
            // 
            resources.ApplyResources(this.cbUseRotate, "cbUseRotate");
            this.cbUseRotate.Name = "cbUseRotate";
            this.cbUseRotate.UseVisualStyleBackColor = true;
            // 
            // cbUseReplaceDoubleSpace
            // 
            resources.ApplyResources(this.cbUseReplaceDoubleSpace, "cbUseReplaceDoubleSpace");
            this.cbUseReplaceDoubleSpace.Name = "cbUseReplaceDoubleSpace";
            this.cbUseReplaceDoubleSpace.UseVisualStyleBackColor = true;
            // 
            // cbUseReplaceMultiSpace
            // 
            resources.ApplyResources(this.cbUseReplaceMultiSpace, "cbUseReplaceMultiSpace");
            this.cbUseReplaceMultiSpace.Name = "cbUseReplaceMultiSpace";
            this.cbUseReplaceMultiSpace.UseVisualStyleBackColor = true;
            // 
            // frmDialog
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btCancel;
            this.Controls.Add(this.cbUseReplaceMultiSpace);
            this.Controls.Add(this.cbUseReplaceDoubleSpace);
            this.Controls.Add(this.cbUseRotate);
            this.Controls.Add(this.cbFitInSize);
            this.Controls.Add(this.nudFitSize);
            this.Controls.Add(this.lBetweenInJoined);
            this.Controls.Add(this.nudBetweenInJoined);
            this.Controls.Add(this.pbProgress);
            this.Controls.Add(this.lbLog);
            this.Controls.Add(this.cbUseExcelRangeSize);
            this.Controls.Add(this.nudSizeCoef);
            this.Controls.Add(this.nudRow);
            this.Controls.Add(this.nudCol);
            this.Controls.Add(this.lSizeCoef);
            this.Controls.Add(this.cbBorders);
            this.Controls.Add(this.cbVertical);
            this.Controls.Add(this.cbHorizontal);
            this.Controls.Add(this.cbMerge);
            this.Controls.Add(this.cbUseRowHeight);
            this.Controls.Add(this.cbUseColWidth);
            this.Controls.Add(this.lFrom);
            this.Controls.Add(this.btGetLink);
            this.Controls.Add(this.btUpdate);
            this.Controls.Add(this.tbLink);
            this.Controls.Add(this.btCancel);
            this.Controls.Add(this.lLink);
            this.Name = "frmDialog";
            this.ShowInTaskbar = false;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Dialog_FormClosing);
            this.Load += new System.EventHandler(this.Dialog_Load);
            this.SizeChanged += new System.EventHandler(this.Dialog_SizeChanged);
            ((System.ComponentModel.ISupportInitialize)(this.nudCol)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudRow)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudSizeCoef)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudBetweenInJoined)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudFitSize)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btCancel;
        private System.Windows.Forms.TextBox tbLink;
        private System.Windows.Forms.Button btUpdate;
        private System.Windows.Forms.Button btGetLink;
        private System.Windows.Forms.Label lLink;
        private System.Windows.Forms.Label lFrom;
        private System.Windows.Forms.CheckBox cbUseColWidth;
        private System.Windows.Forms.CheckBox cbUseRowHeight;
        private System.Windows.Forms.CheckBox cbMerge;
        private System.Windows.Forms.CheckBox cbHorizontal;
        private System.Windows.Forms.CheckBox cbVertical;
        private System.Windows.Forms.CheckBox cbBorders;
        private System.Windows.Forms.Label lSizeCoef;
        private System.Windows.Forms.NumericUpDown nudCol;
        private System.Windows.Forms.NumericUpDown nudRow;
        private System.Windows.Forms.NumericUpDown nudSizeCoef;
        private System.Windows.Forms.CheckBox cbUseExcelRangeSize;
        private System.Windows.Forms.ListBox lbLog;
        private System.Windows.Forms.ProgressBar pbProgress;
        private System.Windows.Forms.NumericUpDown nudBetweenInJoined;
        private System.Windows.Forms.Label lBetweenInJoined;
        private System.Windows.Forms.CheckBox cbFitInSize;
        private System.Windows.Forms.NumericUpDown nudFitSize;
        private System.Windows.Forms.CheckBox cbUseRotate;
        private System.Windows.Forms.CheckBox cbUseReplaceDoubleSpace;
        private System.Windows.Forms.CheckBox cbUseReplaceMultiSpace;
    }
}