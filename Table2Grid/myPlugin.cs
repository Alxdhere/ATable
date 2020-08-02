// (C) Copyright 2012 by Microsoft 
//
using System;
using Autodesk.AutoCAD.Runtime;
using Autodesk.AutoCAD.ApplicationServices;
using Autodesk.AutoCAD.DatabaseServices;
using Autodesk.AutoCAD.Geometry;
using Autodesk.AutoCAD.EditorInput;

// This line is not mandatory, but improves loading performances
[assembly: ExtensionApplication(typeof(Table2Grid.MyPlugin))]

namespace Table2Grid
{

    // This class is instantiated by AutoCAD once and kept alive for the 
    // duration of the session. If you don't do any one time initialization 
    // then you should remove this class.
    public class MyPlugin : IExtensionApplication
    {

        void IExtensionApplication.Initialize()
        {
            Document doc = Application.DocumentManager.MdiActiveDocument;
            Editor ed = doc.Editor;
            ed.WriteMessage("\nATable Table2Grid 1.0 Copyright 2012 Alexander Shchetinin");
        }

        void IExtensionApplication.Terminate()
        {
            // Do plug-in application clean up here
        }

    }

}
