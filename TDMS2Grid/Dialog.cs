using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using TDMS;
using System.Runtime.InteropServices;
using Autodesk.AutoCAD.ApplicationServices;
using System.Text.RegularExpressions;
using AlxdGrid;
using System.IO;

namespace TDMS2Grid
{
    public partial class frmDialog : Form
    {
        ATableTDMSData data;
            
        //check TDMS
        private bool ThereAreTDMS()
        {
            try
            {
                TDMSApplication app = (TDMSApplication)Marshal.GetActiveObject("TDMS.Application");
                Marshal.ReleaseComObject(app);
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка при обращении к TDMS: " + e.Message, "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                return false;
            }

            return true;
        }

        private bool UpdateDataObject()
        {
            try
            {
                TDMSApplication app = (TDMSApplication)Marshal.GetActiveObject("TDMS.Application");

                if (app.Shell.SelObjects.Count > 0)
                {
                    data.obj = app.Shell.SelObjects[0];
                    //TDMSObject o = app.Shell.SelObjects[0];
                    //tbObject.Text = o.Description;
                }
                Marshal.ReleaseComObject(app);
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка при получении выбранного объекта из TDMS: " + e.Message, "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                return false;
            }

            return true;
        }

        private bool UpdateDataObjectFromDrawing()
        {
            string guid;
            //MessageBox.Show("here");
            try
            {
                Document doc = Autodesk.AutoCAD.ApplicationServices.Application.DocumentManager.MdiActiveDocument;
                string fn = doc.Database.Filename;
                //MessageBox.Show(fn);

                MatchCollection matches = Regex.Matches(fn, "^(.+?)\\\\(\\{[a-zA-Z0-9-]{36}\\})\\\\(.+)$", RegexOptions.IgnoreCase);
                //MessageBox.Show(matches.Count.ToString());
                if (matches.Count == 0)
                    return false;

                //MessageBox.Show(matches[0].Groups.Count.ToString());
                if (matches[0].Groups.Count < 4)
                    return false;

                guid = matches[0].Groups[2].Value;
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка при получении имени файла из AutoCAD: " + e.Message, "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }

            //MessageBox.Show(guid);

            try
            {
                TDMSApplication app = (TDMSApplication)Marshal.GetActiveObject("TDMS.Application");
                data.obj = app.GetObjectByGUID(guid);
                Marshal.ReleaseComObject(app);
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка при получении объекта для открытого документа из TDMS: " + e.Message, "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                return false;
            }

            return true;
        }

        private bool UpdateDataQueries()
        {
            const string PREFIX = "ATable:";
            string sysname = "";
            try
            {
                TDMSApplication app = (TDMSApplication)Marshal.GetActiveObject("TDMS.Application");

                //lbQueries.Items.Clear();
                int c = app.Queries.Count;
                pbProgress.Minimum = 0;
                pbProgress.Maximum = c;
                pbProgress.Step = 1;
                UpdateProgressLabel("Поиск типов таблиц в TDMS:");
                for (int i = 0; i < c; i++)
                {
                    //MessageBox.Show("Here 1");
                    TDMSQuery q = app.Queries[i];
                    sysname = q.SysName;
                    //MessageBox.Show("Here 2" + sysname);
                    if (sysname.Length > PREFIX.Length)
                        if (string.Compare(sysname.Substring(0, PREFIX.Length), PREFIX, true) == 0)
                        {
                            //MessageBox.Show("Here 3" + sysname);
                            QueryObject qo = new QueryObject();
                            //MessageBox.Show("Here 3.1" + sysname);
                            qo.Sysname = q.SysName;
                            //MessageBox.Show("Here 3.2" + qo.Sysname);
                            qo.Description = q.Description;
                            //MessageBox.Show("Here 3.3" + qo.Description);
                            if (q.Comments.Count > 0)
                                qo.Stylename = q.Comments[0].Text;
                            //MessageBox.Show("Here 4" + qo.Sysname + " - " + qo.Description + " - " + qo.Stylename);
                            data.queries.Add(qo);
                            //lbQueries.Items.Add(q.Description);
                            //MessageBox.Show("Here 5");
                        }
                    pbProgress.Value = i;
                    Marshal.ReleaseComObject(q);
                    //MessageBox.Show("Here 6");
                }
                pbProgress.Value = 0;
                //pbProgress.Value = pbProgress.Maximum;

                UpdateProgressLabel("Готово");
                Marshal.ReleaseComObject(app);
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка при обновлении списка выборок [" + sysname + "] из TDMS: " + e.Message, "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                return false;
            }
            
            return true;
        }

        private void UpdateDialog()
        {
            tbObject.Text = "";
            if (data.obj != null)
            {
                tbObject.Text = data.obj.Description;
            }

            int tmp = lbQueries.SelectedIndex;
            lbQueries.Items.Clear();
            if (data.queries != null)
            {
                foreach (QueryObject qo in data.queries)
                    lbQueries.Items.Add(qo.Description);
            }
            if (tmp > -1)
                lbQueries.SelectedIndex = tmp;
        }

        private bool UpdateSpreadSheet(TDMSSheet sheet, string stylename)
        {
            //check stylename exist?
            DialogResult dr;
            bool st_exist = true;
            if (stylename.Length > 0)
                if (!File.Exists(stylename))
                {
                    st_exist = false;
                    dr = MessageBox.Show("Стиль таблицы [" + stylename + "] не найден. Продолжить импорт данных из TDMS?", "TDMS2Grid", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (dr == System.Windows.Forms.DialogResult.No)
                        return false;
                }

            try
            {
                AlxdApplication app = null;
                app = (AlxdApplication)Marshal.GetActiveObject("AlxdGrid.AlxdApplication");
                int a = app.AlxdEditor.AlxdSpreadSheets.Active;
                AlxdSpreadSheet alxdSpreadsheet = app.AlxdEditor.AlxdSpreadSheets.Items[a];

                if (st_exist)
                    if (stylename.Length > 0)
                    {
                        AlxdSpreadSheetStyle tempStyle = app.CreateAlxdSpreadSheetStyle();
                        if (!tempStyle.LoadFrom(stylename))
                        {
                            dr = MessageBox.Show("Ошибка при загрузке стиля таблицы [" + stylename + "]. Продолжить импорт данных из TDMS?", "TDMS2Grid", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                            if (dr == System.Windows.Forms.DialogResult.No)
                            {
                                Marshal.FinalReleaseComObject(alxdSpreadsheet);
                                Marshal.FinalReleaseComObject(tempStyle);
                                return false;
                            }
                        }
                        alxdSpreadsheet.AlxdSpreadSheetStyle.CopyFrom(tempStyle);
                        alxdSpreadsheet.RedrawBlockDefinitionFull();
                        Marshal.FinalReleaseComObject(tempStyle);
                    }

                int cc = sheet.ColumnsCount;
                int rc = sheet.RowsCount;
                int p = 0;

                alxdSpreadsheet.AlxdSpreadSheetStyle.ColCount = cc;
                alxdSpreadsheet.AlxdSpreadSheetStyle.RowCount = rc;

                pbProgress.Minimum = 0;
                pbProgress.Maximum = cc * rc;
                pbProgress.Step = 1;
                UpdateProgressLabel("Импорт таблицы из TDMS:");
                for (int c = 0; c < cc; c++)
                    for (int r = 0; r < rc; r++)
                    {
                        dynamic tmp = sheet;
                        string contain = Convert.ToString(tmp[r, c]);
                        alxdSpreadsheet.AlxdCells.Items[c, r].Contain = contain;

                        pbProgress.Value = p;
                        //pbProgress.Update();
                        p++;
                    }
                pbProgress.Value = 0;
                alxdSpreadsheet.RedrawBlockDefinition();
                UpdateProgressLabel("Готово");
                Marshal.FinalReleaseComObject(alxdSpreadsheet);
                
            }
            catch (Exception e)
            {
                MessageBox.Show("Невозможно найти открытый редактор таблиц. Попробуйте вызвать команду снова.[" + e.Message + "]");
                return false;
            }

            return true;
        }

        private void UpdateProgressLabel(string value)
        {
            //lbProgress.Visible = true;
            lbProgress.Text = value;
            //lbProgress.Top = pbProgress.Top + (pbProgress.Height - lbProgress.Height) / 2;
            //lbProgress.Left = pbProgress.Left + (pbProgress.Width - lbProgress.Width) / 2;
        }

        private void btBrowse_Click(object sender, EventArgs e)
        {
            try
            {
                TDMSApplication app = (TDMSApplication)Marshal.GetActiveObject("TDMS.Application");

                TDMSSelectObjectDlg d = app.Dialogs.SelectObjectDlg;
                d.Prompt = "Выбор объекта в TDMS";
                d.ParentWindow = (int)ActiveForm.Handle;
                if (d.Show())
                {
                    if (d.Objects.Count > 0)
                    {
                        data.obj = d.Objects[0];
                        //tbObject.Text = data.obj.Description;
                        UpdateDialog();
                    }
                }

                Marshal.ReleaseComObject(app);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при получении выбранного объекта из TDMS: " + ex.Message, "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void bUpdate_Click(object sender, EventArgs e)
        {
            if (lbQueries.SelectedIndex < 0)
            {
                MessageBox.Show("Не выбран тип таблицы в списке. Выберите тип таблицы в списке и повторите команду.", "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                TDMSApplication app = (TDMSApplication)Marshal.GetActiveObject("TDMS.Application");

                TDMSQuery q = app.Queries[data.queries[lbQueries.SelectedIndex].Sysname];
                q.set_Parameter("object", data.obj);
                TDMSSheet sheet = q.Sheet;

                if (sheet == null)
                    MessageBox.Show("При выполнении выборки таблица не сформирована!", "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                else
                if ((sheet.ColumnsCount <= 0) || (sheet.RowsCount <= 0))
                    MessageBox.Show("При выполнении выборки сформирована таблица с количеством колонок или рядов = 0 [" + sheet.ColumnsCount.ToString() + "x" + sheet.RowsCount.ToString() + "]!", "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                else
                    UpdateSpreadSheet(sheet, data.queries[lbQueries.SelectedIndex].Stylename);

                Marshal.ReleaseComObject(sheet);
                Marshal.ReleaseComObject(q);
                Marshal.ReleaseComObject(app);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при выполнении запроса в TDMS: " + ex.Message, "TDMS2Grid", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        public frmDialog()
        {
            InitializeComponent();
        }

        private void frmDialog_Shown(object sender, EventArgs e)
        {
            data = new ATableTDMSData();
            data.queries = new List<QueryObject>();

            if (!ThereAreTDMS())
            {
                (sender as Form).Close();
                return;
            }

            if (!UpdateDataQueries())
            {
                (sender as Form).Close();
                return;
            }

            if (!UpdateDataObject())
            {
                (sender as Form).Close();
                return;
            }

            UpdateDataObjectFromDrawing();

            UpdateDialog();

            if (lbQueries.Items.Count > 0)
                lbQueries.SelectedIndex = 0;

            lbProgress.BackColor = Color.Transparent;
        }
    }
}
