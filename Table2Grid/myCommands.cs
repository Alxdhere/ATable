// (C) Copyright 2012 by Microsoft 
//
using System;
using Autodesk.AutoCAD.Runtime;
using Autodesk.AutoCAD.ApplicationServices;
using Autodesk.AutoCAD.DatabaseServices;
using Autodesk.AutoCAD.Geometry;
using Autodesk.AutoCAD.EditorInput;
using AlxdGrid;
using System.Runtime.InteropServices;
using System.Windows;
using Autodesk.AutoCAD.Colors;

// This line is not mandatory, but improves loading performances
[assembly: CommandClass(typeof(Table2Grid.MyCommands))]

namespace Table2Grid
{

    // This class is instantiated by AutoCAD for each document when
    // a command is called by the user the first time in the context
    // of a given document. In other words, non static data in this class
    // is implicitly per-document!
    public class MyCommands
    {
        [LispFunction("alxd:atInterfaceTable2Grid")]
        public void ExecFunction(ResultBuffer args) // This method can have any name
        {
            Document doc = Autodesk.AutoCAD.ApplicationServices.Application.DocumentManager.MdiActiveDocument;
            Editor ed = doc.Editor;

            TypedValue[] tvs = new TypedValue[] { new TypedValue((int)DxfCode.Start, "ACAD_TABLE") };
            SelectionFilter filter = new SelectionFilter(tvs);
            PromptSelectionResult res;

            do
            {
                res = ed.GetSelection(filter);
            }
            while ((res.Status != PromptStatus.OK) && (res.Status != PromptStatus.Cancel));

            if (res.Status != PromptStatus.OK)
            {
                ed.WriteMessage("\nNothing selected.");
            }
            else
            {
                int index = 0;
                SelectionSet ss = res.Value;
                foreach (SelectedObject so in ss)
                {
                    using (Transaction tr = doc.TransactionManager.StartTransaction())
                    {
                        Table tb = (Table)tr.GetObject(so.ObjectId, OpenMode.ForRead);

                        try
                        {
                            AlxdApplication app = null;
                            app = (AlxdApplication)Marshal.GetActiveObject("AlxdGrid.AlxdApplication");

                            int a;
                            if (index == 0)
                                a = app.AlxdEditor.AlxdSpreadSheets.Active;
                            else
                                a = app.AlxdEditor.AlxdSpreadSheets.Add();
                            AlxdSpreadSheet alxdSpreadsheet = app.AlxdEditor.AlxdSpreadSheets.Items[a];

                            int cc = tb.Columns.Count;
                            int rc = tb.Rows.Count;

                            alxdSpreadsheet.AlxdSpreadSheetStyle.ColCount = cc;
                            alxdSpreadsheet.AlxdSpreadSheetStyle.RowCount = rc;

                            string styleTextStyleName = alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(7);
                            ObjectId styleTextStyleId;
                            using (TextStyleTable tst = (TextStyleTable)tr.GetObject(doc.Database.TextStyleTableId, OpenMode.ForRead))
                            {
                                styleTextStyleId = tst[styleTextStyleName];
                            }
                            //MessageBox.Show(styleTextStyleId.ToString());

                            double styleTextHeight = (double)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(40);
                            int styleTextType = (int)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(283);
                            bool styleTextTypeIsMText = (styleTextType == 0); //is MText

                            double styleTextMarginLeft = (double)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(56); 
                            double styleTextMarginBottom = (double)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(57); 
                            double styleTextMarginRight = (double)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(58); 
                            double styleTextMarginTop = (double)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(59);

                            Color styleTextColor = Color.FromColorIndex(ColorMethod.ByAci, (short)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(60));
                            Color styleVerBorderColor = Color.FromColorIndex(ColorMethod.ByAci, (short)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(61));
                            Color styleHorBorderColor = Color.FromColorIndex(ColorMethod.ByAci, (short)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(62));
                            LineWeight styleVerBorderWeight = (LineWeight)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(65);
                            LineWeight styleHorBorderWeight = (LineWeight)alxdSpreadsheet.AlxdSpreadSheetStyle.get_PropertyByNum(66); 

                            

                            //unjoin all in spreadsheet
                            alxdSpreadsheet.AlxdCells.UnjoinCellInRect(0, 0, cc-1, rc-1);
                            for (int c = 0; c < cc; c++)
                            {
                                //column width
                                alxdSpreadsheet.AlxdColumns.Items[c].set_PropertyByNum(40,tb.Columns[c].Width);
                                for (int r = 0; r < rc; r++)
                                {
                                    //row height
                                    if (c == 0)
                                        alxdSpreadsheet.AlxdRows.Items[r].set_PropertyByNum(40, tb.Rows[r].Height);

                                    //join cell
                                    bool isMerged = tb.Cells[r, c].IsMerged.Value;
                                    bool isRanged = (tb.Cells[r, c].GetMergeRange() != null);
                                    //MessageBox.Show(isMerged.ToString() + " - " + isRanged.ToString());
                                    if (isMerged && isRanged)
                                    {
                                        //MessageBox.Show("joining cell " + c.ToString() + "," + r.ToString());
                                        CellRange cr = tb.Cells[r, c].GetMergeRange();
                                        alxdSpreadsheet.AlxdCells.JoinCellInRect(c, r, c + cr.RightColumn - cr.LeftColumn, r + cr.BottomRow - cr.TopRow, true);
                                    }

                                    if (!isMerged && isRanged)
                                        continue;

                                    alxdSpreadsheet.AlxdCells.Items[c, r].Contain = tb.Cells[r, c].TextString;
                                    //    MessageBox.Show("TopRow = " + cr.TopRow.ToString() +
                                    //        " LeftColumn = " + cr.LeftColumn.ToString() +
                                    //        " BottomRow = " + cr.BottomRow.ToString() +
                                    //        " RightColumn = " + cr.RightColumn.ToString());
                                    //MessageBox.Show("[" + r.ToString() + "," + c.ToString() + "].IsMerged = " + tb.Cells[r, c].IsMerged.ToString());

                                    //type
                                    if (styleTextTypeIsMText)
                                        alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(282, 0);
                                    else
                                        alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(282, 1);

                                    //height
                                    double textHeight = tb.Cells[r, c].TextHeight.Value;
                                    if (textHeight >= 0)
                                        if (textHeight != styleTextHeight)
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(40, textHeight);
                                        else
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(40, 0);

                                    //between
                                    double textBetween = tb.Cells[r, c].TextHeight.Value * 5 / 3;
                                    alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(43, textBetween);

                                    //style
                                    ObjectId textStyleId = tb.Cells[r, c].TextStyleId.Value;
                                    if (textStyleId != styleTextStyleId)
                                    {
                                        if (System.Environment.Is64BitOperatingSystem)
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(90, textStyleId.OldIdPtr.ToInt64());
                                        else
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(90, textStyleId.OldIdPtr.ToInt32());
                                    }
                                    else
                                        alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(90, 0);

                                    //color
                                    Color textColor = tb.Cells[r, c].ContentColor;
                                    if (textColor != styleTextColor)
                                        alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(60, textColor.ColorIndex);
                                    else
                                        alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(60, -1);

                                    //horizontal alignment
                                    if (tb.Cells[r, c].Alignment != null)
                                    {
                                        int textHAlignment = (int)tb.Cells[r, c].Alignment.Value;
                                        //MessageBox.Show(textAlignment.ToString() + " = " + (5 - Math.Ceiling(textAlignment / 3.0)).ToString());
                                        alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(72, textHAlignment - (Math.Ceiling(textHAlignment / 3.0) - 1) * 3);
                                    }

                                    //vertical alignment
                                    if (tb.Cells[r, c].Alignment != null)
                                    {
                                        int textVAlignment = (int)tb.Cells[r, c].Alignment.Value;
                                        //MessageBox.Show(textAlignment.ToString() + " = " + (5 - Math.Ceiling(textAlignment / 3.0)).ToString());
                                        alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(73, 5 - Math.Ceiling(textVAlignment / 3.0));
                                    }

                                    //MessageBox.Show("[" + r.ToString() + "," + c.ToString() + "] " +
                                    //    tb.Cells[r, c].Borders.Left.Margin.Value + " x " +
                                    //    tb.Cells[r, c].Borders.Bottom.Margin.Value + " x " +
                                    //    tb.Cells[r, c].Borders.Right.Margin.Value + " x " + //4.5
                                    //    tb.Cells[r, c].Borders.Top.Margin.Value + " x " +
                                    //    tb.Cells[r, c].Borders.Horizontal.Margin.Value + " x " +
                                    //    tb.Cells[r, c].Borders.Vertical.Margin.Value); //4.5

                                    //left margin                                    
                                    double leftMargin = tb.Cells[r, c].Borders.Horizontal.Margin.Value;//Left.Margin.Value;
                                    if (leftMargin >= 0)
                                        if (leftMargin != styleTextMarginLeft)
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(140, leftMargin);
                                        else
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(140, -1);

                                    //bottom margin
                                    double bottomMargin = tb.Cells[r, c].Borders.Bottom.Margin.Value;
                                    if (bottomMargin >= 0)
                                        if (bottomMargin != styleTextMarginBottom)
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(141, bottomMargin);
                                        else
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(141, -1);

                                    //right margin
                                    double rightMargin = tb.Cells[r, c].Borders.Horizontal.Margin.Value;//Right.Margin.Value; - этот вариант дает неверный результат в 2012
                                    if (rightMargin >= 0)
                                        if (rightMargin != styleTextMarginRight)
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(142, rightMargin);
                                        else
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(142, -1);

                                    //top margin
                                    double topMargin = tb.Cells[r, c].Borders.Top.Margin.Value;
                                    if (topMargin >= 0)
                                        if (topMargin != styleTextMarginTop)
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(143, topMargin);
                                        else
                                            alxdSpreadsheet.AlxdCells.Items[c, r].set_PropertyByNum(143, -1);

                                    
                                    
                                    
                                }
                            }

                            //borders
                            for (int c = 0; c < cc; c++)
                            {
                                for (int r = 0; r < rc; r++)
                                {
                                    bool isMerged = tb.Cells[r, c].IsMerged.Value;
                                    bool isRanged = (tb.Cells[r, c].GetMergeRange() != null);

                                    //horizontal
                                    LineWeight topWeight;
                                    Color topColor;
                                    if (!isMerged && isRanged)
                                    {
                                        //joined cell
                                        CellRange cr = tb.Cells[r, c].GetMergeRange();
                                        topWeight = tb.Cells[cr.TopRow, cr.LeftColumn].Borders.Top.LineWeight.Value;
                                        topColor = tb.Cells[cr.TopRow, cr.LeftColumn].Borders.Top.Color;
                                    }
                                    else
                                    {
                                        //simple or joining cell
                                        topWeight = tb.Cells[r, c].Borders.Top.LineWeight.Value;
                                        topColor = tb.Cells[r, c].Borders.Top.Color;
                                    }
                                    //weight
                                    if (topWeight != styleHorBorderWeight)
                                        alxdSpreadsheet.AlxdHorizontalBorders.Items[c, r].set_PropertyByNum(65, topWeight);
                                    else
                                        alxdSpreadsheet.AlxdHorizontalBorders.Items[c, r].set_PropertyByNum(65, -4);
                                    //color
                                    if (topColor != styleHorBorderColor)
                                        alxdSpreadsheet.AlxdHorizontalBorders.Items[c, r].set_PropertyByNum(60, topColor.ColorIndex);
                                    else
                                        alxdSpreadsheet.AlxdHorizontalBorders.Items[c, r].set_PropertyByNum(60, 0);

                                    //last row
                                    if (r == rc - 1)
                                    {
                                        if (!isMerged && isRanged)
                                        {
                                            //joined cell
                                            CellRange cr = tb.Cells[r, c].GetMergeRange();
                                            topWeight = tb.Cells[cr.TopRow, cr.LeftColumn].Borders.Bottom.LineWeight.Value;
                                            topColor = tb.Cells[cr.TopRow, cr.LeftColumn].Borders.Bottom.Color;
                                        }
                                        else
                                        {
                                            topWeight = tb.Cells[r, c].Borders.Bottom.LineWeight.Value;
                                            topColor = tb.Cells[r, c].Borders.Bottom.Color;
                                        }
                                        //weight
                                        if (topWeight != styleHorBorderWeight)
                                            alxdSpreadsheet.AlxdHorizontalBorders.Items[c, r + 1].set_PropertyByNum(65, topWeight);
                                        else
                                            alxdSpreadsheet.AlxdHorizontalBorders.Items[c, r + 1].set_PropertyByNum(65, -4);
                                        //color
                                        if (topColor != styleHorBorderColor)
                                            alxdSpreadsheet.AlxdHorizontalBorders.Items[c, r + 1].set_PropertyByNum(60, topColor.ColorIndex);
                                        else
                                            alxdSpreadsheet.AlxdHorizontalBorders.Items[c, r + 1].set_PropertyByNum(60, 0);
                                    }

                                    //vertical
                                    LineWeight leftWeight;
                                    Color leftColor;
                                    if (!isMerged && isRanged)
                                    {
                                        //joined cell
                                        CellRange cr = tb.Cells[r, c].GetMergeRange();
                                        leftWeight = tb.Cells[cr.TopRow, cr.LeftColumn].Borders.Left.LineWeight.Value;
                                        leftColor = tb.Cells[cr.TopRow, cr.LeftColumn].Borders.Left.Color;
                                    }
                                    else
                                    {
                                        //simple or joining cell
                                        leftWeight = tb.Cells[r, c].Borders.Left.LineWeight.Value;
                                        leftColor = tb.Cells[r, c].Borders.Left.Color;
                                    }
                                    //weight
                                    if (leftWeight != styleVerBorderWeight)
                                        alxdSpreadsheet.AlxdVerticalBorders.Items[c, r].set_PropertyByNum(65, leftWeight);
                                    else
                                        alxdSpreadsheet.AlxdVerticalBorders.Items[c, r].set_PropertyByNum(65, -4);
                                    //color
                                    if (leftColor != styleVerBorderColor)
                                        alxdSpreadsheet.AlxdVerticalBorders.Items[c, r].set_PropertyByNum(60, leftColor.ColorIndex);
                                    else
                                        alxdSpreadsheet.AlxdVerticalBorders.Items[c, r].set_PropertyByNum(60, 0);

                                    //last column
                                    if (c == cc - 1)
                                    {
                                        if (!isMerged && isRanged)
                                        {
                                            //joined cell
                                            CellRange cr = tb.Cells[r, c].GetMergeRange();
                                            leftWeight = tb.Cells[cr.TopRow, cr.LeftColumn].Borders.Right.LineWeight.Value;
                                            leftColor = tb.Cells[cr.TopRow, cr.LeftColumn].Borders.Right.Color;
                                        }
                                        else
                                        {
                                            leftWeight = tb.Cells[r, c].Borders.Right.LineWeight.Value;
                                            leftColor = tb.Cells[r, c].Borders.Right.Color;
                                        }

                                        //weight
                                        if (leftWeight != styleVerBorderWeight)
                                            alxdSpreadsheet.AlxdVerticalBorders.Items[c + 1, r].set_PropertyByNum(65, leftWeight);
                                        else
                                            alxdSpreadsheet.AlxdVerticalBorders.Items[c + 1, r].set_PropertyByNum(65, -4);
                                        //color
                                        if (leftColor != styleVerBorderColor)
                                            alxdSpreadsheet.AlxdVerticalBorders.Items[c + 1, r].set_PropertyByNum(60, leftColor.ColorIndex);
                                        else
                                            alxdSpreadsheet.AlxdVerticalBorders.Items[c + 1, r].set_PropertyByNum(60, 0);
                                    }

                                    
                                    
                                }
                            }

                            alxdSpreadsheet.RedrawBlockDefinition();
                            Marshal.FinalReleaseComObject(alxdSpreadsheet);
                        }
                        catch (System.Exception e)
                        {
                            MessageBox.Show("Невозможно найти открытый редактор таблиц. Попробуйте вызвать команду снова.[" + e.Message + "]");
                            return;
                        }

                        tb.Dispose();
                        tr.Commit();
                    }

                    index++;
                }

                
            }

        }

        // LispFunction is similar to CommandMethod but it creates a lisp 
        // callable function. Many return types are supported not just string
        // or integer.
        [LispFunction("c:atExchangeTable2Grid", "c:atExchangeTable2Grid")]
        public ResultBuffer CallFunction(ResultBuffer args) // This method can have any name
        {
            ResultBuffer rb = new ResultBuffer(new TypedValue((int)LispDataType.Text, "Импорт из таблицы AutoCAD..."), new TypedValue((int)LispDataType.Text, "Импорт таблицы AutoCAD в текущую таблицу ATable"), new TypedValue((int)LispDataType.Text, "alxd:atInterfaceTable2Grid"));
            return rb;
        }

    }

}
