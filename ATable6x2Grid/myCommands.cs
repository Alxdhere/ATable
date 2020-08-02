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

// This line is not mandatory, but improves loading performances
[assembly: CommandClass(typeof(ATable6x2Grid.MyCommands))]

namespace ATable6x2Grid
{

    // This class is instantiated by AutoCAD for each document when
    // a command is called by the user the first time in the context
    // of a given document. In other words, non static data in this class
    // is implicitly per-document!
    public class MyCommands
    {
        //struct TItem
        //{
        //    int index;
        //    double size;
        //    string title;
        //    int halignment;
        //    int valignment;
        //    bool visible;
        //};

        const string masterXdata    = "ALXD_GRID_MASTER_DATA";
        const string columnXdata    = "ALXD_GRID_COL_DATA";
        const string rowXdata       = "ALXD_GRID_ROW_DATA";
        const string cellXdata      = "ALXD_GRID_CELL_DATA";
        const string fillXdata      = "ALXD_GRID_FILL_DATA";
        const string borderXdata    = "ALXD_GRID_BORDER_DATA";
        //const string vborderXdata   = "ALXD_GRID_VER_BORDER_DATA";
        // The CommandMethod attribute can be applied to any public  member 
        // function of any public class.
        // The function should take no arguments and return nothing.
        // If the method is an intance member then the enclosing class is 
        // intantiated for each document. If the member is a static member then
        // the enclosing class is NOT intantiated.
        //
        // NOTE: CommandMethod has overloads where you can provide helpid and
        // context menu.
        private bool IsATable6x(Document doc, ObjectId objId, ref ObjectId dicId)
        {
            bool ret = false;
            using (Transaction tr = doc.TransactionManager.StartTransaction())
            {
                Entity ent = (Entity)tr.GetObject(objId, OpenMode.ForRead);
                if (ent is BlockReference)
                {
                    BlockReference blkRef = (ent as BlockReference);
                    ObjectId blkDefId = blkRef.BlockTableRecord;

                    BlockTableRecord blkDef = (BlockTableRecord)tr.GetObject(blkDefId, OpenMode.ForRead);
                    dicId = blkDef.ExtensionDictionary;

                    if (dicId.IsNull == true)
                        return ret;

                    DBDictionary extDict = (DBDictionary)tr.GetObject(dicId, OpenMode.ForRead);
                    ret = extDict.Contains(masterXdata);
                }
                tr.Commit();
                return ret;
            }
            
        }

        private bool ReadMasterData(Document doc, ObjectId dicId, AlxdSpreadSheet sheet)
        {
            using (Transaction tr = doc.TransactionManager.StartTransaction())
            {
                DBDictionary extDict = (DBDictionary)tr.GetObject(dicId, OpenMode.ForRead);

                DBObject ent = tr.GetObject(extDict.GetAt(masterXdata), OpenMode.ForRead);
                if (ent is Xrecord)
                {
                    Xrecord xrec = (ent as Xrecord);
                    ResultBuffer rb = xrec.Data;
                    TypedValue[] tvs = rb.AsArray();

                    foreach (TypedValue tv in tvs)
                        switch (tv.TypeCode)
                        {
                            case 3:
                            case 4:
                            case 6:
                            case 7:
                            case 8:
                            case 9:
                                sheet.AlxdSpreadSheetStyle.set_PropertyByNum(tv.TypeCode, tv.Value.ToString());
                                break;
                            case 38:
                            case 40:
                            case 41:
                            case 42:
                            case 56:
                            case 57:
                            case 58:
                            case 59:
                                double d;
                                double.TryParse(tv.Value.ToString(), out d);
                                sheet.AlxdSpreadSheetStyle.set_PropertyByNum(tv.TypeCode, d);
                                break;
                            case 60:
                            case 61:
                            case 62:
                            case 64:
                            case 65:
                            case 66:
                            case 70:
                            case 71:
                            case 280:
                            case 281:
                            case 282:
                            case 283:
                            case 288:
                            case 289:
                                int i;
                                int.TryParse(tv.Value.ToString(), out i);
                                sheet.AlxdSpreadSheetStyle.set_PropertyByNum(tv.TypeCode, i);
                                break;
                            case 287:
                                int p;
                                int.TryParse(tv.Value.ToString(), out p);
                                if (p == 0) p = 1; else p = 0;
                                sheet.AlxdSpreadSheetStyle.set_PropertyByNum(tv.TypeCode, p);
                                break;
                       }
                }
                tr.Commit();
            }
            return true;
        }

        private bool ReadItemData(Document doc, ObjectId dicId, string entryName, AlxdSpreadSheet sheet)
        {
            using (Transaction tr = doc.TransactionManager.StartTransaction())
            {
                DBDictionary extDict = (DBDictionary)tr.GetObject(dicId, OpenMode.ForRead);

                DBObject ent = tr.GetObject(extDict.GetAt(entryName), OpenMode.ForRead);
                bool isCol = (entryName == columnXdata);
                if (ent is Xrecord)
                {
                    Xrecord xrec = (ent as Xrecord);
                    ResultBuffer rb = xrec.Data;
                    TypedValue[] tvs = rb.AsArray();
                    int index = -1;
                    foreach (TypedValue tv in tvs)
                        switch (tv.TypeCode)
                        {
                            case 1:
                                if (isCol)
                                    sheet.AlxdColumns.Items[index].set_PropertyByNum(tv.TypeCode, tv.Value.ToString());
                                else
                                    sheet.AlxdRows.Items[index].set_PropertyByNum(tv.TypeCode, tv.Value.ToString());
                                break;
                            case 40:
                                index++;
                                double d;
                                double.TryParse(tv.Value.ToString(), out d);
                                if (isCol)
                                    sheet.AlxdColumns.Items[index].set_PropertyByNum(tv.TypeCode, d);
                                else
                                    sheet.AlxdRows.Items[index].set_PropertyByNum(tv.TypeCode, d);
                                break;
                            case 72:
                            case 73:
                                int i;
                                int.TryParse(tv.Value.ToString(), out i);
                                if (isCol)
                                    sheet.AlxdColumns.Items[index].set_PropertyByNum(tv.TypeCode, i);
                                else
                                    sheet.AlxdRows.Items[index].set_PropertyByNum(tv.TypeCode, i);
                                break;
                            case 280:
                                int v;
                                int.TryParse(tv.Value.ToString(), out v);
                                if (v == 0) v = 1; else v = 0;
                                if (isCol)
                                    sheet.AlxdColumns.Items[index].set_PropertyByNum(tv.TypeCode, v);
                                else
                                    sheet.AlxdRows.Items[index].set_PropertyByNum(tv.TypeCode, v);
                                break;
                        }
                }
                tr.Commit();
            }
            return true;
        }

        private bool ReadCellData(Document doc, ObjectId dicId, AlxdSpreadSheet sheet)
        {
            using (Transaction tr = doc.TransactionManager.StartTransaction())
            {
                DBDictionary extDict = (DBDictionary)tr.GetObject(dicId, OpenMode.ForRead);

                DBObject ent = tr.GetObject(extDict.GetAt(cellXdata), OpenMode.ForRead);
                if (ent is Xrecord)
                {
                    Xrecord xrec = (ent as Xrecord);
                    ResultBuffer rb = xrec.Data;
                    TypedValue[] tvs = rb.AsArray();
                    int c = 0;
                    int r = 0;
                    foreach (TypedValue tv in tvs)
                        switch (tv.TypeCode)
                        {
                            case 1:
                            case 3:
                                sheet.AlxdCells.Items[c, r].set_PropertyByNum(tv.TypeCode, tv.Value.ToString());
                                break;
                            case 10:
                                Point3d pt = (Point3d)tv.Value;
                                c = (int)pt[0];
                                r = (int)pt[1];
                                break;
                            case 11:
                                Point3d j = (Point3d)tv.Value;
                                sheet.AlxdCells.Items[c, r].set_PropertyByNum(tv.TypeCode, j.ToArray());
                                break;
                            case 40:
                            case 41:
                            case 42:
                            case 43:
                            case 50:
                            case 140:
                            case 141:
                            case 142:
                            case 143:
                                double d;
                                double.TryParse(tv.Value.ToString(), out d);
                                sheet.AlxdCells.Items[c, r].set_PropertyByNum(tv.TypeCode, d);
                                break;
                            case 60:
                            case 65:
                            case 72:
                            case 73:
                            case 282:
                            case 283:
                                int i;
                                int.TryParse(tv.Value.ToString(), out i);
                                sheet.AlxdCells.Items[c, r].set_PropertyByNum(tv.TypeCode, i);
                                break;
                            case 90:
                                break;
                        }
                }
                tr.Commit();
            }
            return true;
        }

        private bool ReadFillData(Document doc, ObjectId dicId, AlxdSpreadSheet sheet)
        {
            using (Transaction tr = doc.TransactionManager.StartTransaction())
            {
                DBDictionary extDict = (DBDictionary)tr.GetObject(dicId, OpenMode.ForRead);

                DBObject ent = tr.GetObject(extDict.GetAt(fillXdata), OpenMode.ForRead);
                if (ent is Xrecord)
                {
                    Xrecord xrec = (ent as Xrecord);
                    ResultBuffer rb = xrec.Data;
                    TypedValue[] tvs = rb.AsArray();
                    int c = 0;
                    int r = 0;
                    foreach (TypedValue tv in tvs)
                        switch (tv.TypeCode)
                        {
                            case 10:
                                Point3d pt = (Point3d)tv.Value;
                                c = (int)pt[0];
                                r = (int)pt[1];
                                break;
                            case 281:
                                int i;
                                int.TryParse(tv.Value.ToString(), out i);
                                sheet.AlxdCells.Items[c, r].set_PropertyByNum(tv.TypeCode, i);
                                break;
                        }
                }
                tr.Commit();
            }
            return true;
        }

        private bool ReadBorderData(Document doc, ObjectId dicId, AlxdSpreadSheet sheet)
        {
            using (Transaction tr = doc.TransactionManager.StartTransaction())
            {
                DBDictionary extDict = (DBDictionary)tr.GetObject(dicId, OpenMode.ForRead);

                DBObject ent = tr.GetObject(extDict.GetAt(borderXdata), OpenMode.ForRead);
                if (ent is Xrecord)
                {
                    Xrecord xrec = (ent as Xrecord);
                    ResultBuffer rb = xrec.Data;
                    TypedValue[] tvs = rb.AsArray();
                    int c = 0;
                    int r = 0;
                    int v = 0;
                    foreach (TypedValue tv in tvs)
                        switch (tv.TypeCode)
                        {
                            case 10: //vertical
                                Point3d vb = (Point3d)tv.Value;
                                c = (int)vb[0];
                                r = (int)vb[1];
                                v = (int)vb[2];
                                if (v == 0) v = 1; else v = 0;
                                sheet.AlxdVerticalBorders.Items[c, r].set_PropertyByNum(10, v);
                                sheet.AlxdVerticalBorders.Items[c, r].set_PropertyByNum(60, -1);
                                sheet.AlxdVerticalBorders.Items[c, r].set_PropertyByNum(65, -4);
                                break;
                            case 11: //horizontal
                                Point3d hb = (Point3d)tv.Value;
                                c = (int)hb[0];
                                r = (int)hb[1];
                                v = (int)hb[2];
                                if (v == 0) v = 1; else v = 0;
                                sheet.AlxdHorizontalBorders.Items[c, r].set_PropertyByNum(10, v);
                                sheet.AlxdHorizontalBorders.Items[c, r].set_PropertyByNum(60, -1);
                                sheet.AlxdHorizontalBorders.Items[c, r].set_PropertyByNum(65, -4);
                                break;
                        }
                }
                tr.Commit();
            }
            return true;
        }

        [LispFunction("alxd:atInterfaceATable6x2Grid")]
        public void ExecFunction(ResultBuffer args) // This method can have any name
        {
            Document doc = Autodesk.AutoCAD.ApplicationServices.Application.DocumentManager.MdiActiveDocument;
            Editor ed = doc.Editor;

            TypedValue[] tvs = new TypedValue[] { new TypedValue((int)DxfCode.Start, "INSERT") };
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
                ed.WriteMessage("\nSelected " + ss.Count.ToString() + " entities.");
                foreach (SelectedObject so in ss)
                {
                    ObjectId dicId = ObjectId.Null;
                    if (IsATable6x(doc, so.ObjectId, ref dicId))
                    {
                        ed.WriteMessage("\nTable of ATable 6.x is founded.");
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

                            ed.WriteMessage("\nRead style data...");
                            ReadMasterData(doc, dicId, alxdSpreadsheet);
                            ed.WriteMessage("done.");

                            ed.WriteMessage("\nRead columns data...");
                            ReadItemData(doc, dicId, columnXdata, alxdSpreadsheet);
                            ed.WriteMessage("done.");

                            ed.WriteMessage("\nRead rows data...");
                            ReadItemData(doc, dicId, rowXdata, alxdSpreadsheet);
                            ed.WriteMessage("done.");

                            ed.WriteMessage("\nRead cells data...");
                            ReadCellData(doc, dicId, alxdSpreadsheet);
                            ed.WriteMessage("done.");

                            ed.WriteMessage("\nRead fills data...");
                            ReadFillData(doc, dicId, alxdSpreadsheet);
                            ed.WriteMessage("done.");

                            ed.WriteMessage("\nRead borders data...");
                            ReadBorderData(doc, dicId, alxdSpreadsheet);
                            ed.WriteMessage("done.");

                            alxdSpreadsheet.Recalculate();
                            alxdSpreadsheet.RedrawBlockDefinitionFull();
                            alxdSpreadsheet.WriteToDictionary();
                        }
                        catch (System.Exception e)
                        {
                            MessageBox.Show("Ошибка при чтении данных таблицы. [" + e.Message + "]");
                            return;
                        }
                    }//if
                }//foreach
            }//else
        }

        // LispFunction is similar to CommandMethod but it creates a lisp 
        // callable function. Many return types are supported not just string
        // or integer.
        [LispFunction("c:atExchangeATable6x2Grid", "c:atExchangeATable6x2Grid")]
        public ResultBuffer CallFunction(ResultBuffer args) // This method can have any name
        {
            ResultBuffer rb = new ResultBuffer(new TypedValue((int)LispDataType.Text, "Импорт из ATable 6.x..."), new TypedValue((int)LispDataType.Text, "Импорт таблицы ATable 6.x в текущую таблицу ATable"), new TypedValue((int)LispDataType.Text, "alxd:atInterfaceATable6x2Grid"));
            return rb;
        }

    }

}
