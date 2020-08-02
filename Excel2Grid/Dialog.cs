using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;

using Excel = Microsoft.Office.Interop.Excel;
//using AutoCADInterop = Autodesk.AutoCAD.Interop.AcadApplication;
using System.Text.RegularExpressions;

using AlxdGrid;
using System.IO;
using System.Reflection;
using Microsoft.Win32;

namespace Excel2Grid
{
    public partial class frmDialog : Form
    {
        public frmDialog()
        {
            InitializeComponent();
        }

        public double GetBetweenFromSpreadsheet()
        {
            double ret = 0.0;
            AlxdApplication app = null;
            //MessageBox.Show("Here 1");
            try
            {
                app = (AlxdApplication)Marshal.GetActiveObject("AlxdGrid.AlxdApplication");
            }
            catch
            {
                return ret;
            }
            //MessageBox.Show("Here 2");
            int a = app.AlxdEditor.AlxdSpreadSheets.Active;
            AlxdSpreadSheet alxdSpreadsheet = app.AlxdEditor.AlxdSpreadSheets.Items[a];
            ret = alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(38);
            Marshal.ReleaseComObject(alxdSpreadsheet);
            //MessageBox.Show("Here 3: " + ret.ToString());
            return ret;
        }

        private void FormToVar(ref ATableExcelData data)
        {
            data.fromCol = (int)nudCol.Value;
            data.fromRow = (int)nudRow.Value;
            data.sizeCoef = (double)nudSizeCoef.Value;
            data.betweenInJoined = (double)nudBetweenInJoined.Value;
            data.useRowHeight = cbUseRowHeight.Checked;
            data.useColWidth = cbUseColWidth.Checked;
            data.useMerge = cbMerge.Checked;
            data.useHorizontal = cbHorizontal.Checked;
            data.useVertical = cbVertical.Checked;
            data.useBorders = cbBorders.Checked;
            data.link = tbLink.Text;
            data.useExcelRangeSize = cbUseExcelRangeSize.Checked;
            data.fitInSize = cbFitInSize.Checked;
            data.fitSize = (double)nudFitSize.Value;
            data.useRotate = cbUseRotate.Checked;
            data.useReplaceDoubleSpace = cbUseReplaceDoubleSpace.Checked;
            data.useReplaceMultiSpace = cbUseReplaceMultiSpace.Checked;
        }

        private void VarToForm(ATableExcelData data)
        {
            //MessageBox.Show(data.fromCol.ToString() + "x" + data.fromRow.ToString());
            //MessageBox.Show("min " + nudCol.Minimum.ToString());
            //MessageBox.Show("max " + nudCol.Maximum.ToString());
            nudCol.Maximum = 1000;
            nudCol.Value = (decimal)data.fromCol;
            //MessageBox.Show("1");
            nudRow.Maximum = 1000;
            nudRow.Value = (decimal)data.fromRow;
            //MessageBox.Show("2");
            nudSizeCoef.Value = (decimal)data.sizeCoef;
            //MessageBox.Show("3");
            nudBetweenInJoined.Value = (decimal)data.betweenInJoined;
            //MessageBox.Show("4");
            cbUseRowHeight.Checked = data.useRowHeight;
            cbUseColWidth.Checked = data.useColWidth;
            cbMerge.Checked = data.useMerge;
            cbHorizontal.Checked = data.useHorizontal;
            cbVertical.Checked = data.useVertical;
            cbBorders.Checked = data.useBorders;
            tbLink.Text = data.link;
            cbUseExcelRangeSize.Checked = data.useExcelRangeSize;
            cbFitInSize.Checked = data.fitInSize;
            nudFitSize.Value = (decimal)data.fitSize;
            cbUseRotate.Checked = data.useRotate;
            cbUseReplaceDoubleSpace.Checked = data.useReplaceDoubleSpace;
            cbUseReplaceMultiSpace.Checked = data.useReplaceMultiSpace;
            //MessageBox.Show("5");
        }

        public bool LoadConfig(ref ATableExcelData data)
        {
            try
            {
                RegistryKey root = Registry.CurrentUser.OpenSubKey("Software", false);
                RegistryKey ra = root.OpenSubKey("Alxd", false);
                using (RegistryKey rk = ra.OpenSubKey("Excel2Grid", false))
                {
                    data.fromCol = (int)rk.GetValue("fromCol", 0);
                    data.fromRow = (int)rk.GetValue("fromRow", 0);
                    
                    string tmp;
                    tmp = (string)rk.GetValue("sizeCoef", 1.93);
                    data.sizeCoef = double.Parse(tmp);
                    tmp = (string)rk.GetValue("betweenInJoined", 10);
                    data.betweenInJoined = double.Parse(tmp);
                    tmp = (string)rk.GetValue("fitSize", 180);
                    data.fitSize = double.Parse(tmp);

                    tmp = (string)rk.GetValue("useRowHeight", false);
                    data.useRowHeight = bool.Parse(tmp);
                    tmp = (string)rk.GetValue("useColWidth", false);
                    data.useColWidth = bool.Parse(tmp);
                    tmp = (string)rk.GetValue("useMerge", false);
                    data.useMerge = bool.Parse(tmp);
                    tmp = (string)rk.GetValue("useHorizontal", false);
                    data.useHorizontal = bool.Parse(tmp);
                    tmp = (string)rk.GetValue("useVertical", false);
                    data.useVertical = bool.Parse(tmp);
                    tmp = (string)rk.GetValue("useBorders", false);
                    data.useBorders = bool.Parse(tmp);
                    tmp = (string)rk.GetValue("useExcelRangeSize", false);
                    data.useExcelRangeSize = bool.Parse(tmp);
                    tmp = (string)rk.GetValue("fitInSize", false);
                    data.fitInSize = bool.Parse(tmp);
                    tmp = (string)rk.GetValue("useRotate", false);
                    data.useRotate = bool.Parse(tmp);

                    tmp = (string)rk.GetValue("useReplaceDoubleSpace", false);
                    data.useReplaceDoubleSpace = bool.Parse(tmp);
                    tmp = (string)rk.GetValue("useReplaceMultiSpace", false);
                    data.useReplaceMultiSpace = bool.Parse(tmp);

                    rk.Close();
                }
                ra.Close();
                root.Close();
                lbLog.Items.Add("Настройки загружены");
            }
            catch(Exception e)
            {
                lbLog.Items.Add("Настройки в реестре не найдены: " + e.Message);
                return false;
            }
            return true;
        }

        public bool SaveConfig(ATableExcelData data)
        {
            try
            {
                RegistryKey root = Registry.CurrentUser.OpenSubKey("Software", true);
                RegistryKey ra = root.CreateSubKey("Alxd");
                using (RegistryKey rk = ra.CreateSubKey("Excel2Grid"))
                {
                    rk.SetValue("fromCol", data.fromCol);
                    rk.SetValue("fromRow", data.fromRow);
                    rk.SetValue("sizeCoef", data.sizeCoef);
                    rk.SetValue("betweenInJoined", data.betweenInJoined);
                    rk.SetValue("fitSize", data.fitSize);
                    rk.SetValue("useRowHeight", data.useRowHeight);
                    rk.SetValue("useColWidth", data.useColWidth);
                    rk.SetValue("useMerge", data.useMerge);
                    rk.SetValue("useHorizontal", data.useHorizontal);
                    rk.SetValue("useVertical", data.useVertical);
                    rk.SetValue("useBorders", data.useBorders);
                    rk.SetValue("useExcelRangeSize", data.useExcelRangeSize);
                    rk.SetValue("fitInSize", data.fitInSize);
                    rk.SetValue("useRotate", data.useRotate);
                    rk.SetValue("useReplaceDoubleSpace", data.useReplaceDoubleSpace);
                    rk.SetValue("useReplaceMultiSpace", data.useReplaceMultiSpace);
                    rk.Close();
                }
                ra.Close();
                root.Close();
                lbLog.Items.Add("Настройки сохранены");
            }
            catch (Exception e)
            {
                lbLog.Items.Add("Настройки в реестре не сохранены: " + e.Message);
                return false;
            }
            return true;
        }

        public bool StringToData(string value, ref ATableExcelData data)
        {
            //MessageBox.Show("10");
            if (!String.IsNullOrEmpty(value))
            {
                //MessageBox.Show("11");
                //MessageBox.Show(value);
                string[] values = value.Split(';');
                //MessageBox.Show(values.Count().ToString());

                if (values.Count() > 0)
                    if (values[0] == "1.0")
                    {
                        //MessageBox.Show(values[0]);
                        int index = 0;
                        foreach (string v in values)
                        {
                            switch (index)
                            {
                                case 1:
                                    data.fromCol = int.Parse(v);
                                    break;
                                case 2:
                                    data.fromRow = int.Parse(v);
                                    break;
                                case 3:
                                    data.useColWidth = bool.Parse(v);
                                    break;
                                case 4:
                                    data.useRowHeight = bool.Parse(v);
                                    break;
                                case 5:
                                    data.useHorizontal = bool.Parse(v);
                                    break;
                                case 6:
                                    data.useVertical = bool.Parse(v);
                                    break;
                                case 7:
                                    data.useMerge = bool.Parse(v);
                                    break;
                                case 8:
                                    data.useBorders = bool.Parse(v);
                                    break;
                                case 9:
                                    data.sizeCoef = double.Parse(v);
                                    break;
                                case 10:
                                    data.betweenInJoined = double.Parse(v);
                                    break;
                                case 11:
                                    data.useExcelRangeSize = bool.Parse(v);
                                    break;
                                case 12:
                                    data.fitInSize = bool.Parse(v);
                                    break;
                                case 13:
                                    data.fitSize = double.Parse(v);
                                    break;
                                case 14:
                                    data.useRotate = bool.Parse(v);
                                    break;
                                case 15:
                                    data.useReplaceDoubleSpace = bool.Parse(v);
                                    break;
                                case 16:
                                    data.useReplaceMultiSpace = bool.Parse(v);
                                    break;
                            }
                            index++;
                        }
                        return true;
                    }
            }
            return false;
        }

        public bool DataToString(ATableExcelData data, ref string value)
        {
            value = "1.0;";//version
            value += data.fromCol.ToString() + ";";
            value += data.fromRow.ToString() + ";";
            value += data.useColWidth.ToString() + ";";
            value += data.useRowHeight.ToString() + ";";
            value += data.useHorizontal.ToString() + ";";
            value += data.useVertical.ToString() + ";";
            value += data.useMerge.ToString() + ";";
            value += data.useBorders.ToString() + ";";
            value += data.sizeCoef.ToString() + ";";
            value += data.betweenInJoined.ToString() + ";";
            value += data.useExcelRangeSize.ToString() + ";";
            value += data.fitInSize.ToString() + ";";
            value += data.fitSize.ToString() + ";";
            value += data.useRotate.ToString() + ";";
            value += data.useReplaceDoubleSpace.ToString() + ";";
            value += data.useReplaceMultiSpace.ToString() + ";";
            return true;
        }

        public bool LoadLinkFromTable(ref ATableExcelData data)
        {
            AlxdApplication app = null;

            try
            {
                app = (AlxdApplication)Marshal.GetActiveObject("AlxdGrid.AlxdApplication");
            }
            catch (Exception e)
            {
                MessageBox.Show("Невозможно найти открытый редактор таблиц. Попробуйте вызвать команду снова.[" + e.Message + "]");
                return false;
            }

            int a = app.AlxdEditor.AlxdSpreadSheets.Active;
            AlxdSpreadSheet alxdSpreadsheet = app.AlxdEditor.AlxdSpreadSheets.Items[a];
            AlxdSpreadSheetStyle alxdSpreadsheetstyle = alxdSpreadsheet.AlxdSpreadSheetStyle;

            nudCol.Maximum = alxdSpreadsheetstyle.ColCount - 1;
            nudRow.Maximum = alxdSpreadsheetstyle.RowCount - 1;

            //MessageBox.Show("1");
            ATableExcelData tmp_data = new ATableExcelData();
            //MessageBox.Show("2");
            string value = (string)alxdSpreadsheetstyle.get_PropertyByNum(301);
            //MessageBox.Show("3" + value);
            if (StringToData(value, ref tmp_data))
            {
                //MessageBox.Show("4");
                data = tmp_data;
            }
            //MessageBox.Show(alxdSpreadsheetstyle.get_PropertyByNum(300));
            data.link = (string)alxdSpreadsheetstyle.get_PropertyByNum(300);

            //MessageBox.Show(data.link);

            if (String.IsNullOrEmpty(data.link))
                return false;

            return (data.link.Length > 0);
        }

        public bool SaveLinkToTable(ATableExcelData data)
        {
            AlxdApplication app = null;

            try
            {
                app = (AlxdApplication)Marshal.GetActiveObject("AlxdGrid.AlxdApplication");
            }
            catch (Exception e)
            {
                MessageBox.Show("Невозможно найти открытый редактор таблиц. Попробуйте вызвать команду снова.[" + e.Message + "]");
                return false;
            }

            int a = app.AlxdEditor.AlxdSpreadSheets.Active;
            AlxdSpreadSheet alxdSpreadsheet = app.AlxdEditor.AlxdSpreadSheets.Items[a];
            AlxdSpreadSheetStyle alxdSpreadsheetstyle = alxdSpreadsheet.AlxdSpreadSheetStyle;

            //MessageBox.Show("Save: " + data.link);
            alxdSpreadsheet.AlxdSpreadSheetStyle.set_PropertyByNum(300, data.link);
            string value = "";
            if (DataToString(data, ref value))
            {
                //MessageBox.Show(value);
                alxdSpreadsheet.AlxdSpreadSheetStyle.set_PropertyByNum(301, value);
            }
            //MessageBox.Show("Saved");

            //string s = alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(300);
            //MessageBox.Show("Load: " + s);
            return true;
        }

        private bool GetLinkParts(string link, ref string path, ref string filename, ref string sheet, ref string address)
        {
            //MatchCollection matches = Regex.Matches(link, "'?(.+)\\\\\\[([\\w\\s\\[\\]]+.xls[xm]?)\\]([\\w\\s]+)'?!([a-zA-Z0-9:\\$]+)", RegexOptions.IgnoreCase);
            MatchCollection matches = Regex.Matches(link, "'?(.+?)\\\\\\[(.+?)\\](.+?)'?!([a-zA-Z0-9:\\$]+)", RegexOptions.IgnoreCase);
            //MessageBox.Show(matches.Count.ToString());

            if (matches.Count == 0)
                return false;

            if (matches[0].Groups.Count < 5)
                return false;

            path = matches[0].Groups[1].Value;
            filename = matches[0].Groups[2].Value;
            sheet = matches[0].Groups[3].Value;
            address = matches[0].Groups[4].Value;

            return true;
        }

        public bool UpdateTableByLink(ATableExcelData data, AlxdApplication app = null)
        {
            if (data.useColWidth || data.useRowHeight)
                if (data.sizeCoef <= 0)
                {
                    MessageBox.Show("Недопустимый коэффициент преобразования размера. Он должен быть больше 0!", "Excel2Grid", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return false;
                }

            string path = "";
            string filename = "";
            string sheet = "";
            string address = "";

            //check link
            //MessageBox.Show(data.link);
            if (!GetLinkParts(data.link, ref path, ref filename, ref sheet, ref address))
            {
                MessageBox.Show("Некорректная ссылка на данные в Microsoft Excel. Проверьте ссылку и попробуйте вызвать команду снова.", "Excel2Grid", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }

            lbLog.Items.Add("Ссылка распознана:");
            lbLog.Items.Add("Путь = " + path);
            lbLog.Items.Add("Файл = " + filename);
            lbLog.Items.Add("Лист = " + sheet);
            lbLog.Items.Add("Адрес = " + address);
            //MessageBox.Show(path + "\n" + filename + "\n" + sheet + "\n" + address);

            //check path and filename
            if (!Directory.Exists(path))
            {
                MessageBox.Show("Путь в ссылке некорректный. Проверьте путь и попробуйте вызвать команду снова.");
                return false;
            }

            if (!File.Exists(path + "\\" + filename))
            {
                MessageBox.Show("Имя файла в ссылке некорректно. Проверьте имя файла и попробуйте вызвать команду снова.");
                return false;
            }

            //check excel
            bool ExcelWasCreated = false;
            Excel.Application xlApp = null;

            try
            {
                xlApp = (Excel.Application)Marshal.GetActiveObject("Excel.Application");
                lbLog.Items.Add("Открытый Excel найден");
            }
            catch { }

            if (xlApp == null)
                try
                {
                    xlApp = new Excel.Application();
                    xlApp.Visible = true;
                    ExcelWasCreated = true;
                    lbLog.Items.Add("Открыт новый Excel");
                }
                catch
                {
                    MessageBox.Show("Невозможно открыть Microsoft Excel. Проверьте наличие Microsoft Excel на локальном компьютере и попробуйте вызвать команду снова.");
                    return false;
                }

            //find opened file
            bool WorkbookWasOpened = false;
            Excel.Workbooks xlWorkBooks = xlApp.Workbooks;
            Excel.Workbook xlWorkBook = null;

            foreach (Excel.Workbook xlTmp in xlWorkBooks)
                if (xlTmp.FullName.CompareTo(path + "\\" + filename) == 0)
                {
                    xlWorkBook = xlTmp;
                    lbLog.Items.Add("Файл [" + filename + "] найден открытым");
                    break;
                }

            //open workbook
            if (xlWorkBook == null)
                try
                {
                    xlWorkBook = xlApp.Workbooks._Open(path + "\\" + filename, false, true, Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value);
                    WorkbookWasOpened = true;
                    lbLog.Items.Add("Файл [" + filename + "] открыт");
                }
                catch
                {
                    MessageBox.Show("Невозможно открыть файл '" + filename + "' в Microsoft Excel. Проверьте файл и попробуйте вызвать команду снова.");
                    if (ExcelWasCreated)
                    {
                        xlApp.Quit();
                        Marshal.ReleaseComObject(xlApp);
                    }
                    return false;
                }

            //open sheet
            Excel.Worksheet xlWorkSheet = null;
            try
            {
                xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets[sheet];
                lbLog.Items.Add("Лист [" + sheet + "] найден");
            }
            catch
            {
                MessageBox.Show("Невозможно открыть лист '" + sheet + "' в Microsoft Excel. Проверьте наличие листа в файле и попробуйте вызвать команду снова.");
                return false;
            }

            //open range
            Excel.Range xlRange = null;
            try
            {
                xlRange = xlWorkSheet.get_Range(address, Missing.Value);
                lbLog.Items.Add("Диапазон [" + address + "] выбран");
            }
            catch
            {
                MessageBox.Show("Невозможно найти диапазон '" + address + "' в Microsoft Excel. Проверьте наличие данного диапазона в файле и попробуйте вызвать команду снова.");
                return false;
            }

            //AutoCADInterop ac = null;
            //try
            //{
            //    ac = (AutoCADInterop)Marshal.GetActiveObject("AutoCAD.Application");
            //    lbLog.Items.Add("Открытый AutoCAD найден");
            //}
            //catch (Exception e)
            //{
            //    MessageBox.Show("Невозможно найти открытый AutoCAD " + e.Message);
            //    return false;
            //}

            //AlxdApplication app = null;
            //AlxdApplication app = new AlxdApplication();
            
            if (app == null)
                try
                {
                    //app = (AlxdApplication)ac.GetInterfaceObject("AlxdGrid.AlxdApplication");
                    app = (AlxdApplication)Marshal.GetActiveObject("AlxdGrid.AlxdApplication");
                    lbLog.Items.Add("Открытый ATable найден");
                    //Marshal.get
                }
                catch(Exception e)
                {
                    MessageBox.Show("Невозможно найти открытый редактор таблиц. Попробуйте вызвать команду снова.[" + e.Message + "]");
                    return false;
                }

            int a = app.AlxdEditor.AlxdSpreadSheets.Active;
            AlxdSpreadSheet alxdSpreadsheet = app.AlxdEditor.AlxdSpreadSheets.Items[a];

            int RealColCount = xlRange.Columns.Count;
            int RealRowCount = xlRange.Rows.Count;

            lbLog.Items.Add("Размер диапазона выбранного в Excel:");
            lbLog.Items.Add("Колонок = " + RealColCount.ToString());
            lbLog.Items.Add("Рядов = " + RealRowCount.ToString());

            //MessageBox.Show("1. RealColCount " + RealColCount.ToString() + " RealRowCount " + RealRowCount.ToString());

            if (data.useExcelRangeSize)
            {
                DialogResult dr = System.Windows.Forms.DialogResult.Yes;
                //if ((RealColCount > 500) || (RealRowCount > 500))
                if (RealColCount * RealRowCount > 5000)
                    dr = MessageBox.Show("Размер импортируемой таблицы довольно большой. Вы уверены, что хотите импортировать таблицу " + RealColCount.ToString() + "x" + RealRowCount.ToString() + "?", "Excel2Grid", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

                if (dr != System.Windows.Forms.DialogResult.Yes)
                {
                    lbLog.Items.Add("Импорт таблицы прерван пользователем!");
                    return false;
                }
                 
                alxdSpreadsheet.AlxdSpreadSheetStyle.ColCount = data.fromCol + RealColCount;
                alxdSpreadsheet.AlxdSpreadSheetStyle.RowCount = data.fromRow + RealRowCount;
            }

            int fromCol = data.fromCol;
            int fromRow = data.fromRow;
            if ((RealColCount == 1) && (RealRowCount == 1))
            {
                RealColCount = alxdSpreadsheet.AlxdSpreadSheetStyle.ColCount;
                RealRowCount = alxdSpreadsheet.AlxdSpreadSheetStyle.RowCount;
            }
            else
            {
                //MessageBox.Show("in if");
                //MessageBox.Show(alxdSpreadsheet.AlxdSpreadSheetStyle.ColCount.ToString());
                //MessageBox.Show(alxdSpreadsheet.AlxdSpreadSheetStyle.RowCount.ToString());

                int t;
                t = alxdSpreadsheet.AlxdSpreadSheetStyle.ColCount - fromCol;
                if (RealColCount > t)
                    RealColCount = t;

                t = alxdSpreadsheet.AlxdSpreadSheetStyle.RowCount - fromRow;
                if (RealRowCount > t)
                    RealRowCount = t;
            }

            //MessageBox.Show("2. RealColCount " + RealColCount.ToString() + " RealRowCount " + RealRowCount.ToString());

            AlxdCells alxdCells = alxdSpreadsheet.AlxdCells;
            AlxdBorders alxdVerBorders = alxdSpreadsheet.AlxdVerticalBorders;
            AlxdBorders alxdHorBorders = alxdSpreadsheet.AlxdHorizontalBorders;
            AlxdCell alxdCell = null;
            AlxdBorder alxdBorder = null;

            alxdCells.UnjoinCellInRect(fromCol, fromRow, fromCol + RealColCount - 1, fromRow + RealRowCount - 1);
            lbLog.Items.Add("Размер диапазона в ATable:");
            lbLog.Items.Add("Колонок = " + RealColCount.ToString());
            lbLog.Items.Add("Рядов = " + RealRowCount.ToString());
            lbLog.TopIndex = lbLog.Items.Count - 1;

            int ai;
            int aj;

            int i;
            int j;
            bool skip;
            int all = RealColCount * RealRowCount;
            int cur = 0;

            //tsProgress.Visible = true;

            double fullSize = 0.0;
            if (data.fitInSize)
                data.sizeCoef = 1.0;

            i = 0;
            ai = 0;
            pbProgress.Maximum = all;
            pbProgress.Step = 1;

            while (i < RealColCount)
            {
                skip = false;
                Excel.Range col = ((Excel.Range)xlRange.Cells[1, i + 1]).EntireColumn;
                if ((bool)col.Hidden == true)
                {
                    ai++;
                    skip = true;
                }

                if (!skip)
                {
                    if (data.useColWidth)
                    {
                        double tmp = (double)col.ColumnWidth * data.sizeCoef;
                        AlxdItem ci = alxdSpreadsheet.AlxdColumns.Items[i + fromCol - ai];
                        ci.set_PropertyByNum(40, tmp);
                        //!ci.Size = tmp;
                        Marshal.ReleaseComObject(ci);

                        fullSize += tmp;
                    }

                    j = 0;
                    aj = 0;

                    while (j < RealRowCount)
                    {
                        skip = false;
                        Excel.Range row = ((Excel.Range)xlRange.Cells[j + 1, 1]).EntireRow;

                        if ((bool)row.Hidden == true)
                        {
                            aj++;
                            skip = true;
                        }

                        if (!skip)
                        {
                            if ((data.useRowHeight) && (i == 0))
                            {
                                double tmp = (double)row.RowHeight * data.sizeCoef;
                                AlxdItem ri = alxdSpreadsheet.AlxdRows.Items[j + fromRow - aj];
                                ri.set_PropertyByNum(40, tmp);
                                //!ri.Size = tmp;
                                Marshal.ReleaseComObject(ri);
                            }

                            Excel.Range cr = (Excel.Range)xlRange.Cells[j + 1, i + 1];
                            alxdCell = alxdCells.Items[i + fromCol - ai, j + fromRow - aj];

                            string contain = (string)cr.Text;
                            //lbLog.Items.Add(contain);
                            if (data.useReplaceMultiSpace)
                            {
                                contain = Regex.Replace(contain, "[ ]{3,}", "\r\n");//Environment.NewLine);
                                //lbLog.Items.Add(contain);
                            }

                            if (data.useReplaceDoubleSpace)
                            {
                                contain = Regex.Replace(contain, "[ ]{2}", " ");
                                //lbLog.Items.Add(contain);
                            }
                            alxdCell.Contain = contain;
                            //MessageBox.Show("Contain = " + cr.Text);
                            

                            if (data.useHorizontal)
                            {
                                Excel.XlHAlign ha = (Excel.XlHAlign)cr.HorizontalAlignment;
                                switch (ha)
                                {
                                    case Excel.XlHAlign.xlHAlignLeft:
                                        alxdCell.set_PropertyByNum(72, 1);
                                        //!alxdCell.HorizontalAlignment = 1;
                                        break;
                                    case Excel.XlHAlign.xlHAlignCenter:
                                        alxdCell.set_PropertyByNum(72, 2);
                                        //!alxdCell.HorizontalAlignment = 2;
                                        break;
                                    case Excel.XlHAlign.xlHAlignRight:
                                        alxdCell.set_PropertyByNum(72, 3);
                                        //!alxdCell.HorizontalAlignment = 3;
                                        break;
                                    default:
                                        alxdCell.set_PropertyByNum(72, 0);
                                        //!alxdCell.HorizontalAlignment = 0;
                                        break;
                                }
                            }

                            if (data.useVertical)
                            {
                                Excel.XlVAlign va = (Excel.XlVAlign)cr.VerticalAlignment;
                                switch (va)
                                {
                                    case Excel.XlVAlign.xlVAlignTop:
                                        alxdCell.set_PropertyByNum(73, 4);
                                        //!alxdCell.VerticalAlignment = 4;
                                        break;
                                    case Excel.XlVAlign.xlVAlignCenter:
                                        alxdCell.set_PropertyByNum(73, 3);
                                        //!alxdCell.VerticalAlignment = 3;
                                        break;
                                    case Excel.XlVAlign.xlVAlignBottom:
                                        alxdCell.set_PropertyByNum(73, 2);
                                        //!alxdCell.VerticalAlignment = 2;
                                        break;
                                    default:
                                        alxdCell.set_PropertyByNum(73, 0);
                                        //!alxdCell.VerticalAlignment = 0;
                                        break;
                                }
                            }

                            if (data.useRotate)
                            {
                                Excel.XlOrientation to = (Excel.XlOrientation)cr.Orientation;
                                switch (to)
                                {
                                    case Excel.XlOrientation.xlUpward:
                                        alxdCell.set_PropertyByNum(50, 90);
                                        break;
                                    default:
                                        alxdCell.set_PropertyByNum(50, 0);
                                        break;
                                }
                            }

                            if (data.useMerge)
                            {
                                Excel.Range ma = (Excel.Range)cr.MergeArea[1, 1];
                                string ma1 = cr.get_Address(Missing.Value, Missing.Value, Excel.XlReferenceStyle.xlA1, Missing.Value, Missing.Value);
                                string ma2 = ma.get_Address(Missing.Value, Missing.Value, Excel.XlReferenceStyle.xlA1, Missing.Value, Missing.Value);
                                if ((bool)cr.MergeCells && (ma1.CompareTo(ma2) == 0))
                                {
                                    int sr;
                                    int sb;
                                    sr = i - ai + ma.MergeArea.Columns.Count - 1 + fromCol;
                                    sb = j - aj + ma.MergeArea.Rows.Count - 1 + fromRow;

                                    sr = Math.Min(sr, alxdSpreadsheet.AlxdSpreadSheetStyle.ColCount-1);
                                    sb = Math.Min(sb, alxdSpreadsheet.AlxdSpreadSheetStyle.RowCount-1);

                                    alxdCells.JoinCellInRect(i + fromCol - ai, j + fromRow - aj, sr, sb, true);
                                    alxdCell.set_PropertyByNum(43, data.betweenInJoined);
                                    //!alxdCells.JoinCellInRect(i + fromCol - ai, j + fromRow - aj, sr, sb);
                                }
                                Marshal.ReleaseComObject(ma);
                            }
                            Marshal.ReleaseComObject(alxdCell);

                            if (data.useBorders)
                            {
                                //left border
                                lbLog.Items.Add("Левый бордюр[" + (i + fromCol - ai).ToString() + "," + (j + fromRow - aj).ToString() + "]");
                                lbLog.Items.Add("Состояние в Excel:" + (Excel.XlLineStyle)cr.Borders.get_Item(Excel.XlBordersIndex.xlEdgeLeft).LineStyle);

                                alxdBorder = alxdVerBorders.Items[i + fromCol - ai, j + fromRow - aj];
                                if ((Excel.XlLineStyle)cr.Borders.get_Item(Excel.XlBordersIndex.xlEdgeLeft).LineStyle != Excel.XlLineStyle.xlLineStyleNone)
                                    alxdBorder.set_PropertyByNum(10, 1);
                                    //!alxdBorder.State = 1;
                                else
                                    alxdBorder.set_PropertyByNum(10, 0);
                                    //!alxdBorder.State = 0;
                                Marshal.ReleaseComObject(alxdBorder);

                                //right border
                                if (i + 1 == RealColCount)
                                {
                                    alxdBorder = alxdVerBorders.Items[i + fromCol - ai + 1, j + fromRow - aj];
                                    if ((Excel.XlLineStyle)cr.Borders.get_Item(Excel.XlBordersIndex.xlEdgeRight).LineStyle != Excel.XlLineStyle.xlLineStyleNone)
                                        alxdBorder.set_PropertyByNum(10, 1);
                                        //!alxdBorder.State = 1;
                                    else
                                        alxdBorder.set_PropertyByNum(10, 0);
                                        //!alxdBorder.State = 0;
                                    Marshal.ReleaseComObject(alxdBorder);
                                }

                                //top border
                                alxdBorder = alxdVerBorders.Items[i + fromCol - ai, j + fromRow - aj];
                                if ((Excel.XlLineStyle)cr.Borders.get_Item(Excel.XlBordersIndex.xlEdgeTop).LineStyle != Excel.XlLineStyle.xlLineStyleNone)
                                    alxdBorder.set_PropertyByNum(10, 1);
                                //!    alxdBorder.State = 1;
                                else
                                    alxdBorder.set_PropertyByNum(10, 0);
                                //!    alxdBorder.State = 0;
                                Marshal.ReleaseComObject(alxdBorder);

                                //bottom border
                                if (j + 1 == RealRowCount)
                                {
                                    alxdBorder = alxdHorBorders.Items[i + fromCol - ai, j + fromRow - aj + 1];
                                    if ((Excel.XlLineStyle)cr.Borders.get_Item(Excel.XlBordersIndex.xlEdgeBottom).LineStyle != Excel.XlLineStyle.xlLineStyleNone)
                                        alxdBorder.set_PropertyByNum(10, 1);
                                    //    alxdBorder.State = 1;
                                    else
                                        alxdBorder.set_PropertyByNum(10, 0);
                                    //    alxdBorder.State = 0;
                                    Marshal.ReleaseComObject(alxdBorder);
                                }
                            }

                        }

                        j++;
                        cur++;
                        pbProgress.Value = cur;
                        
                        //Marshal.ReleaseComObject(row);
                    }//while row
                }

                i++;
                //Marshal.ReleaseComObject(col);
            }//while col

            if (data.fitInSize && data.fitSize > 0)
            {
                if (fullSize != data.fitSize)
                {
                    data.sizeCoef = data.fitSize / fullSize;
                    nudSizeCoef.Value = (decimal)data.sizeCoef;
                }
                lbLog.Items.Add("Подгонка размера " + fullSize.ToString() + "->" + data.fitSize.ToString());
                lbLog.TopIndex = lbLog.Items.Count - 1;

                i = 0;
                while (i < RealColCount)
                {
                    skip = false;
                    Excel.Range col = ((Excel.Range)xlRange.Cells[1, i + 1]).EntireColumn;
                    if ((bool)col.Hidden == true)
                    {
                        ai++;
                        skip = true;
                    }

                    if (!skip)
                    {
                        if (data.useColWidth)
                        {
                            double tmp = (double)col.ColumnWidth * data.sizeCoef;
                            AlxdItem ci = alxdSpreadsheet.AlxdColumns.Items[i + fromCol - ai];
                            ci.set_PropertyByNum(40, tmp);
                            Marshal.ReleaseComObject(ci);
                        }
                    }
                    i++;
                }
            }
            //!alxdSpreadsheet.AlxdSpreadSheetSelections.Update();
            Marshal.ReleaseComObject(alxdCells);
            Marshal.ReleaseComObject(alxdVerBorders);
            Marshal.ReleaseComObject(alxdHorBorders);

            
            //!alxdSpreadsheet.Recoordinate();
            alxdSpreadsheet.RedrawBlockDefinition();
            //!alxdSpreadsheet.RedrawBlockReference();
            alxdSpreadsheet.WriteToDictionary();
            Marshal.ReleaseComObject(alxdSpreadsheet);

            if (WorkbookWasOpened)
                xlWorkBook.Close(false, Missing.Value, Missing.Value);

            if (ExcelWasCreated)
            {
                xlApp.Quit();
                Marshal.ReleaseComObject(xlApp);
            }
            GC.GetTotalMemory(true);
            pbProgress.Value = 0;
            //tsProgress.Visible = false;
            return true;
        }

        private void btGetLink_Click(object sender, EventArgs e)
        {
            //check excel
            Excel.Application xlApp = null;

            try
            {
                xlApp = (Excel.Application)Marshal.GetActiveObject("Excel.Application");
                //xlApp.Visible = true;
                lbLog.Items.Add("Открытый Excel найден");
            }
            catch 
            {
                MessageBox.Show("Невозможно найти открытый Microsoft Excel. Проверьте наличие запущенного Microsoft Excel и попробуйте вызвать команду снова.");
                return;
            }

            string wbPath = "";
            try
            {
                wbPath = xlApp.ActiveWorkbook.Path;
                lbLog.Items.Add("Путь [" + wbPath + "] найден");
            }
            catch
            {
                MessageBox.Show("Невозможно найти открытый Microsoft Excel. Проверьте наличие запущенного Microsoft Excel и попробуйте вызвать команду снова.");
                return;
            }

            if (wbPath.Length == 0)
            {
                MessageBox.Show("Путь активного файла не определен. Возможно активный файл в Microsoft Excel не сохранен.");
                return;
            }

            string wbFileName = "";
            wbFileName = xlApp.ActiveWorkbook.FullName;
            wbFileName = wbFileName.Substring(wbPath.Length + 1);
            tbLink.Text = wbPath + "\\[" + wbFileName + "]" + xlApp.ActiveWorkbook.ActiveSheet.Name + "!" + xlApp.Selection.Address;
        }

        private void btUpdate_Click(object sender, EventArgs e)
        {
            ATableExcelData data = new ATableExcelData();
            FormToVar(ref data);

            UpdateTableByLink(data);
            SaveLinkToTable(data);
        }

        private void Dialog_Load(object sender, EventArgs e)
        {
            //tsProgress.Visible = false;

            ATableExcelData data = new ATableExcelData();
            if (!LoadConfig(ref data))
            {
                data.fromCol = 0;
                data.fromRow = 0;
                data.sizeCoef = 1.93;
                data.betweenInJoined = GetBetweenFromSpreadsheet();
            }

            if (LoadLinkFromTable(ref data))
            {
                lbLog.Items.Add("Путь [" + data.link + "] найден");
            }
            VarToForm(data);

            tbLink.Text = data.link;
            //Dialog_Update(sender);
        }

        private void Dialog_SizeChanged(object sender, EventArgs e)
        {
            //MessageBox.Show((sender as Form).Width.ToString());
            //pbProgress.Width = (sender as Form).Width - 34;
            //tsProgress.
            
            //sStrip.Update();
            //const int bw = 4;
            //int dist = (sender as Form).Width - nudCol.Left - 20; 
            //nudCol.Width = (dist - bw) / 2;
            //nudRow.Width = nudCol.Width;
            //nudRow.Left = nudCol.Left + nudCol.Width + bw;
        }

        private void Dialog_FormClosing(object sender, FormClosingEventArgs e)
        {
            ATableExcelData data = new ATableExcelData();
            FormToVar(ref data);
            SaveConfig(data);
        }
    }
}
