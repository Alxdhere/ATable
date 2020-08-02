// (C) Copyright 2011 by Microsoft 
//
using System;
using Autodesk.AutoCAD.Runtime;
using Autodesk.AutoCAD.ApplicationServices;
using Autodesk.AutoCAD.DatabaseServices;
using Autodesk.AutoCAD.Geometry;
using Autodesk.AutoCAD.EditorInput;
using System.Windows;
using AlxdGrid;
using System.Runtime.InteropServices;

// This line is not mandatory, but improves loading performances
[assembly: CommandClass(typeof(Excel2Grid.MyCommands))]

namespace Excel2Grid
{
    public struct ATableExcelData
    {
        public string link;
        public int fromCol;
        public int fromRow;
        public bool useColWidth;
        public bool useRowHeight;
        public bool useHorizontal;
        public bool useVertical;
        public bool useMerge;
        public bool useBorders;
        public double sizeCoef;
        public double betweenInJoined;
        public bool useExcelRangeSize;
        public bool fitInSize;
        public double fitSize;
        public bool useRotate;
        public bool useReplaceDoubleSpace;
        public bool useReplaceMultiSpace;
    }


    // This class is instantiated by AutoCAD for each document when
    // a command is called by the user the first time in the context
    // of a given document. In other words, non static data in this class
    // is implicitly per-document!
    public class MyCommands
    {
        // The CommandMethod attribute can be applied to any public  member 
        // function of any public class.
        // The function should take no arguments and return nothing.
        // If the method is an intance member then the enclosing class is 
        // intantiated for each document. If the member is a static member then
        // the enclosing class is NOT intantiated.
        //
        // NOTE: CommandMethod has overloads where you can provide helpid and
        // context menu.

        // Modal Command with localized name
        //[CommandMethod("MyGroup", "MyCommand", "MyCommandLocal", CommandFlags.Modal)]
        //[CommandMethod("c:atExchangeExcel2Grid", CommandFlags.Modal)]
        //public ResultBuffer MyCommand() // This method can have any name
        //{
        //    // Put your command code here
        //    const short RTSTR = 5005;
        //    ResultBuffer rb = new ResultBuffer(new TypedValue(RTSTR, "Command"), new TypedValue(RTSTR, "Command hint"), new TypedValue(RTSTR, "alxd:interfaceExcel2Grid"));
        //    return rb;
        //}

        //[CommandMethod("alxd:atInterfaceExcel2Grid", CommandFlags.Modal)]
        //public void MyCommand(ResultBuffer args) // This method can have any name
        //{
        //    MessageBox.Show("test");
            
        //    // Put your command code here
        //    //const short RTSTR = 5005;
        //    //ResultBuffer rb = new ResultBuffer(new TypedValue(RTSTR, "Command"), new TypedValue(RTSTR, "Command hint"), new TypedValue(RTSTR, "alxd:interfaceExcel2Grid"));
        //    //return rb;
        //}

        // Modal Command with pickfirst selection
        //[CommandMethod("MyGroup", "MyPickFirst", "MyPickFirstLocal", CommandFlags.Modal | CommandFlags.UsePickSet)]
        //public void MyPickFirst() // This method can have any name
        //{
        //    PromptSelectionResult result = Application.DocumentManager.MdiActiveDocument.Editor.GetSelection();
        //    if (result.Status == PromptStatus.OK)
        //    {
        //        // There are selected entities
        //        // Put your command using pickfirst set code here
        //    }
        //    else
        //    {
        //        // There are no selected entities
        //        // Put your command code here
        //    }
        //}

        // Application Session Command with localized name
        //[CommandMethod("MyGroup", "MySessionCmd", "MySessionCmdLocal", CommandFlags.Modal | CommandFlags.Session)]
        //public void MySessionCmd() // This method can have any name
        //{
        //    // Put your command code here
        //}


        [LispFunction("alxd:atInterfaceExcel2Grid")]
        public void ExecFunction(ResultBuffer args) // This method can have any name
        {
            frmDialog dlg = new frmDialog();
            Autodesk.AutoCAD.ApplicationServices.Application.ShowModalDialog(null, dlg);
        }

        // LispFunction is similar to CommandMethod but it creates a lisp 
        // callable function. Many return types are supported not just string
        // or integer.
        [LispFunction("c:atExchangeExcel2Grid", "c:atExchangeExcel2Grid")]
        public ResultBuffer CallFunction(ResultBuffer args) // This method can have any name
        {
            ResultBuffer rb = new ResultBuffer(new TypedValue((int)LispDataType.Text, "Импорт из Excel..."), new TypedValue((int)LispDataType.Text, "Импорт выбранного диапазона из Excel в текущую таблицу ATable"), new TypedValue((int)LispDataType.Text, "alxd:atInterfaceExcel2Grid"));
            return rb;
        }

        [LispFunction("c:atUpdateExcel2Grid", "c:atUpdateExcel2Grid")]
        public void UpdateSelectedATables(ResultBuffer args) // This method can have any name
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
                Transaction tr = doc.TransactionManager.StartTransaction();
                try
                {
                    AlxdApplication app = new AlxdApplication();

                    SelectionSet ss = res.Value;
                    foreach (SelectedObject so in ss)
                    {
                        Entity ent = (Entity)tr.GetObject(so.ObjectId, OpenMode.ForRead);
                        if (ent is BlockReference)
                        {
                            bool isATable = false;
                            if (System.Environment.Is64BitOperatingSystem)
                                isATable = (app.IsATableBlockReference(ent.ObjectId.OldIdPtr.ToInt64()));
                            else
                                isATable = (app.IsATableBlockReference(ent.ObjectId.OldIdPtr.ToInt32()));
                            
                            if (isATable)
                            {
                                AlxdSpreadSheets alxdSpreadSheets = app.AlxdEditor.AlxdSpreadSheets;
                                int a = alxdSpreadSheets.Add();
                                AlxdSpreadSheet alxdSpreadSheet = alxdSpreadSheets.Items[a];
                                if (System.Environment.Is64BitOperatingSystem)
                                    alxdSpreadSheet.BlockReferenceID = ent.ObjectId.OldIdPtr.ToInt64();
                                else
                                    alxdSpreadSheet.BlockReferenceID32 = ent.ObjectId.OldIdPtr.ToInt32();
                                alxdSpreadSheet.ReadFromDictionary();
                                alxdSpreadSheet.RedrawBlockDefinition();
                                alxdSpreadSheets.Active = a;
                                Marshal.FinalReleaseComObject(alxdSpreadSheet);
                                Marshal.FinalReleaseComObject(alxdSpreadSheets);

                                using (frmDialog dlg = new frmDialog())
                                {
                                    ATableExcelData data = new ATableExcelData();
                                    if (!dlg.LoadConfig(ref data))
                                    {
                                        data.fromCol = 0;
                                        data.fromRow = 0;
                                        data.sizeCoef = 1.93;
                                        data.betweenInJoined = dlg.GetBetweenFromSpreadsheet();
                                        ed.WriteMessage("\nНе удалось загрузить параметры из реестра.");
                                    }

                                    if (!dlg.LoadLinkFromTable(ref data))
                                        ed.WriteMessage("\nНе удалось загрузить параметры из таблицы.");
                                    else
                                    {
                                        ed.WriteMessage("\nОбновление таблицы...");
                                        ed.WriteMessage("\nИмя: " + (ent as BlockReference).Name);
                                        ed.WriteMessage("\nПуть: " + data.link);
                                        ObjectId[] objs = new ObjectId[1];
                                        objs[0] = ent.ObjectId;
                                        ed.SetImpliedSelection(objs);
                                    }

                                    if (!dlg.UpdateTableByLink(data, app))
                                        ed.WriteMessage("\nОшибка при обновлении таблицы.");
                                    else
                                        ed.WriteMessage("\n...завершено!");
                                }

                            }//if (isATable)
                        }//if (ent is BlockReference)
                        ent.Dispose();
                    }
                    app.Quit();
                    Marshal.FinalReleaseComObject(app);
                    tr.Commit();
                }
                catch (System.Exception e)
                {
                    tr.Abort();
                    ed.WriteMessage("\nUpdate is failed with error: [" + e.Message + "]");
                }
            }//res.Status
        }//public void UpdateSelectedATables

        [LispFunction("c:atUpdateAllExcel2Grid", "c:atUpdateAllExcel2Grid")]
        public void UpdateAllATables(ResultBuffer args) // This method can have any name
        {
            Document doc = Autodesk.AutoCAD.ApplicationServices.Application.DocumentManager.MdiActiveDocument;
            Editor ed = doc.Editor;

            TypedValue[] tvs = new TypedValue[] { new TypedValue((int)DxfCode.Start, "INSERT") };
            SelectionFilter filter = new SelectionFilter(tvs);

            PromptSelectionResult res = ed.SelectAll(filter);

            if (res.Status != PromptStatus.OK)
            {
                ed.WriteMessage("\nNothing update.");
            }
            else
            {
                Transaction tr = doc.TransactionManager.StartTransaction();
                try
                {
                    AlxdApplication app = new AlxdApplication();

                    SelectionSet ss = res.Value;
                    foreach (SelectedObject so in ss)
                    {
                        Entity ent = (Entity)tr.GetObject(so.ObjectId, OpenMode.ForRead);
                        if (ent is BlockReference)
                        {
                            bool isATable = false;
                            if (System.Environment.Is64BitOperatingSystem)
                                isATable = (app.IsATableBlockReference(ent.ObjectId.OldIdPtr.ToInt64()));
                            else
                                isATable = (app.IsATableBlockReference(ent.ObjectId.OldIdPtr.ToInt32()));

                            if (isATable)
                            {
                                AlxdSpreadSheets alxdSpreadSheets = app.AlxdEditor.AlxdSpreadSheets;
                                int a = alxdSpreadSheets.Add();
                                AlxdSpreadSheet alxdSpreadSheet = alxdSpreadSheets.Items[a];
                                if (System.Environment.Is64BitOperatingSystem)
                                    alxdSpreadSheet.BlockReferenceID = ent.ObjectId.OldIdPtr.ToInt64();
                                else
                                    alxdSpreadSheet.BlockReferenceID32 = ent.ObjectId.OldIdPtr.ToInt32();
                                alxdSpreadSheet.ReadFromDictionary();
                                alxdSpreadSheet.RedrawBlockDefinition();
                                alxdSpreadSheets.Active = a;

                                using (frmDialog dlg = new frmDialog())
                                {
                                    ATableExcelData data = new ATableExcelData();
                                    if (!dlg.LoadConfig(ref data))
                                    {
                                        data.fromCol = 0;
                                        data.fromRow = 0;
                                        data.sizeCoef = 1.93;
                                        data.betweenInJoined = dlg.GetBetweenFromSpreadsheet();
                                        ed.WriteMessage("\nНе удалось загрузить параметры из реестра.");
                                    }

                                    if (!dlg.LoadLinkFromTable(ref data))
                                    {
                                        ed.WriteMessage("\nНе удалось загрузить параметры из таблицы.");
                                    }
                                    else
                                    {
                                        ed.WriteMessage("\nОбновление таблицы...");
                                        ed.WriteMessage("\nИмя: " + (ent as BlockReference).Name);
                                        ed.WriteMessage("\nПуть: " + data.link);
                                        ObjectId[] objs = new ObjectId[1];
                                        objs[0] = ent.ObjectId;
                                        ed.SetImpliedSelection(objs);
                                    }

                                    if (!dlg.UpdateTableByLink(data, app))
                                    {
                                        ed.WriteMessage("\nОшибка при обновлении таблицы.");
                                    }
                                    else
                                    {
                                        ed.WriteMessage("\n...завершено!");
                                    }
                                }

                                alxdSpreadSheets.Delete(a);
                                Marshal.FinalReleaseComObject(alxdSpreadSheet);
                                Marshal.FinalReleaseComObject(alxdSpreadSheets);

                            }//if (isATable)
                        }//if (ent is BlockReference)
                        ent.Dispose();
                    }
                    ed.SetImpliedSelection(new ObjectId[0]);

                    app.Quit();
                    Marshal.FinalReleaseComObject(app);
                    tr.Commit();
                }
                catch (System.Exception e)
                {
                    tr.Abort();
                    ed.WriteMessage("\nUpdate is failed with error: [" + e.Message + "]");
                }
            }//res.Status
        }//public void UpdateSelectedATables

    }
}
