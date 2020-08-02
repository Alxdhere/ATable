// (C) Copyright 2012 by Microsoft 
//
using System;
using Autodesk.AutoCAD.Runtime;
using Autodesk.AutoCAD.ApplicationServices;
using Autodesk.AutoCAD.DatabaseServices;
using Autodesk.AutoCAD.Geometry;
using Autodesk.AutoCAD.EditorInput;
using TDMS;
using System.Collections.Generic;
// This line is not mandatory, but improves loading performances
[assembly: CommandClass(typeof(TDMS2Grid.MyCommands))]

namespace TDMS2Grid
{
    public struct QueryObject
    {
        public string Sysname;
        public string Description;
        public string Stylename;
    }

    public struct ATableTDMSData
    {
        public TDMSObject obj;
        //public string queryDesc;
        public List<QueryObject> queries;
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
        //public void MyCommand() // This method can have any name
        //{
        //    // Put your command code here
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

        // LispFunction is similar to CommandMethod but it creates a lisp 
        // callable function. Many return types are supported not just string
        // or integer.
        //[LispFunction("MyLispFunction", "MyLispFunctionLocal")]
        //public int MyLispFunction(ResultBuffer args) // This method can have any name
        //{
        //    // Put your command code here

        //    // Return a value to the AutoCAD Lisp Interpreter
        //    return 1;
        //}

        [LispFunction("alxd:atInterfaceTDMS2Grid")]
        public void ExecFunction(ResultBuffer args) // This method can have any name
        {
            frmDialog dlg = new frmDialog();
            Autodesk.AutoCAD.ApplicationServices.Application.ShowModalDialog(null, dlg);
        }

        // LispFunction is similar to CommandMethod but it creates a lisp 
        // callable function. Many return types are supported not just string
        // or integer.
        [LispFunction("c:atExchangeTDMS2Grid", "c:atExchangeTDMS2Grid")]
        public ResultBuffer CallFunction(ResultBuffer args) // This method can have any name
        {
            ResultBuffer rb = new ResultBuffer(new TypedValue((int)LispDataType.Text, "Импорт из TDMS..."), new TypedValue((int)LispDataType.Text, "Импорт типовых таблиц из TDMS в текущую таблицу ATable"), new TypedValue((int)LispDataType.Text, "alxd:atInterfaceTDMS2Grid"));
            return rb;
        }

    }

}
