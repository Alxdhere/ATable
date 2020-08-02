// (C) Copyright 2002-2005 by Autodesk, Inc. 
//
// Permission to use, copy, modify, and distribute this software in
// object code form for any purpose and without fee is hereby granted, 
// provided that the above copyright notice appears in all copies and 
// that both that copyright notice and the limited warranty and
// restricted rights notice below appear in all supporting 
// documentation.
//
// AUTODESK PROVIDES THIS PROGRAM "AS IS" AND WITH ALL FAULTS. 
// AUTODESK SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTY OF
// MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.  AUTODESK, INC. 
// DOES NOT WARRANT THAT THE OPERATION OF THE PROGRAM WILL BE
// UNINTERRUPTED OR ERROR FREE.
//
// Use, duplication, or disclosure by the U.S. Government is subject to 
// restrictions set forth in FAR 52.227-19 (Commercial Computer
// Software - Restricted Rights) and DFAR 252.227-7013(c)(1)(ii)
// (Rights in Technical Data and Computer Software), as applicable.
//

//-----------------------------------------------------------------------------
//----- acrxEntryPoint.h
//-----------------------------------------------------------------------------
#include "StdAfx.h"
#include "resource.h"
#include "oarxExport.h"
#include "vclImport.h"
//#include "AcDbDoubleClickBlockReference.h"
#include "AlxdEditorReactor.h"

#include "XDefaultSize.h"
#include "XTextHeight.h"
#include "XTextWidthFactor.h"
#include "XTextObliqueAngle.h"
#include "XTextMarginsLeft.h"
#include "XTextMarginsTop.h"
#include "XTextMarginsRight.h"
#include "XTextMarginsBottom.h"
#include "XColCount.h"
#include "XRowCount.h"
#include "XCellText.h"
#include "XTextStyle.h"
#include "XDrawBorder.h"
#include "XFillCell.h"
#include "XTextFit.h"
#include "XTextType.h"
#include "XStyleName.h"
#include "XJustify.h"
//#import "C:/Users/Alxd/Documents/RAD Studio/Projects/AT8x/DLL/AlxdGrid.dll" no_namespace

AlxdEditorReactor *pAlxdEditorReactor = NULL;

//-----------------------------------------------------------------------------
#define szRDS _RXST("Alxd")

//1000 - Общее
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXStyleName, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXColCount, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXRowCount, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXDefaultSize, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXJustify, AcDbBlockReference)

//1003 - Текст
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXCellText, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextStyle, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextHeight, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextWidthFactor, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextObliqueAngle, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextMarginsLeft, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextMarginsBottom, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextMarginsRight, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextMarginsTop, AcDbBlockReference)

//1002 - Состояние
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXDrawBorder, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXFillCell, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextFit, AcDbBlockReference)
OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextType, AcDbBlockReference)

//-----------------------------------------------------------------------------
AcRx::AppRetCode RegisterArxApp()
{
	AcadApp::ErrorStatus res;

	//write app info
	AcadAppInfo appInfo;
	appInfo.setAppName(_T("ATable 8.x"));// AppName
	appInfo.setAppDesc(_T("ATable for AutoCAD 2010-2012"));// Description
	appInfo.setModuleName(acedGetAppName());// The physical location of the module
	appInfo.setLoadReason(AcadApp::LoadReasons(AcadApp::kOnAutoCADStartup));	
	
	try
	{
		res = appInfo.writeToRegistry(false, false);// Write the AppInfo to the registry, don't write to DBX registry section.

		res = appInfo.writeGroupNameToRegistry(_T("ALXDGRID"));// Write the group,
		res = appInfo.writeCommandNameToRegistry(_T("ALXDAT"), _T("ALXDAT")); // and the commands.
		res = appInfo.writeCommandNameToRegistry(_T("ALXDATS"), _T("ALXDATS"));
	}
	catch(...)
	{
		acutPrintf(_T("Can't register application info in registry."));
		return res == AcadApp::eOk ? AcRx::kRetOK : AcRx::kRetError;			
	}

	return AcRx::kRetOK;
}

AcRx::AppRetCode LoadDependencyLibrary()
{
	CString modulePathDLL = acedGetAppName();
	modulePathDLL.Truncate(modulePathDLL.GetLength() - 3);
	modulePathDLL += _T("dll");

#if defined(_DEBUG)
#if !defined(_WIN64) && !defined (_AC64)
	modulePathDLL = _T("C:/AT8x/AlxdGrid.dll");
#else
	modulePathDLL = _T("C:/Users/Alxd/Documents/RAD Studio/Projects/AT8x/DLL/x64/AlxdGrid.dll");
#endif
#endif

	vclInstance = LoadLibrary(modulePathDLL);
	if (vclInstance == NULL)
	{
		acutPrintf(_T("Can't load dependency library AlxdGrid.dll."));
		return AcRx::kRetError;
	}

	vclImport::vclGetLength			= (pvclGetLength)::GetProcAddress(vclInstance,"vclGetLength");
	vclImport::vclSetLength			= (pvclSetLength)::GetProcAddress(vclInstance,"vclSetLength");
	vclImport::vclSetAt				= (pvclSetAt)::GetProcAddress(vclInstance,"vclSetAt");
	vclImport::vclGetAt				= (pvclGetAt)::GetProcAddress(vclInstance,"vclGetAt");

	vclImport::vclUpdString			= (pvclUpdString)::GetProcAddress(vclInstance,"vclUpdString");
	vclImport::vclDelString			= (pvclDelString)::GetProcAddress(vclInstance,"vclDelString");

	vclImport::vclOPMName			= (pvclOpm)::GetProcAddress(vclInstance,"vclOPMName");
	vclImport::vclOPMDescription	= (pvclOpm)::GetProcAddress(vclInstance,"vclOPMDescription");
	vclImport::vclOPMMessages		= (pvclOpm)::GetProcAddress(vclInstance,"vclOPMMessages");

	return AcRx::kRetOK;
}

AcRx::AppRetCode UnloadDependencyLibrary()
{
	FreeLibrary(vclInstance);
	return AcRx::kRetOK;
}
//----- ObjectARX EntryPoint
class CGridApp : public AcRxArxApp {

public:
	CGridApp () : AcRxArxApp () {}

	virtual AcRx::AppRetCode On_kInitAppMsg (void *pkt) {
		// TODO: Load dependencies here

		// You *must* call On_kInitAppMsg here
		AcRx::AppRetCode retCode =AcRxArxApp::On_kInitAppMsg (pkt) ;
		
		// TODO: Add your initialization code here
		retCode = RegisterArxApp();			
		retCode = LoadDependencyLibrary();

		//acrxLoadModule(_T("AcRefEd.arx"), 0);
		acrxLoadModule(_T("AcAuthEnviron.arx"), false);
		acrxLoadModule(_T("AcEAttedit.arx"), false);

		acedRegisterFilterWinMsg(&FirstFilterWinMsg);
		pAlxdEditorReactor = new AlxdEditorReactor();

		
		/*
		if(!acrxDynamicLinker->loadModule(_T("AcDblClkEditPE.arx"), Adesk::kFalse))
		{
			acutPrintf(_T("Failed to load AcDblClkEditPE.arx"));
		}
		else
		{
			AcDbDoubleClickEdit::rxInit();
			AcDbDoubleClickBlockReference *pBlockReferenceEdit = new AcDbDoubleClickBlockReference;
			AcDbBlockReference::desc()->addX(AcDbDoubleClickEdit::desc(), pBlockReferenceEdit);
		}
		*/
		InitAcUiComboBoxs();
			
#ifdef _DEBUG
		acutPrintf(_T("\nAlxdGrid 8.0 [DEBUG] Copyright © 2001 - 2012 Alx Development"));
#else
		acutPrintf(_T("\nATable 8.0 Copyright © 2001 - 2012 Alx Development"));
#endif

		

		return (retCode) ;
	}

	virtual AcRx::AppRetCode On_kUnloadAppMsg (void *pkt) {
		// TODO: Add your code here

		// You *must* call On_kUnloadAppMsg here
		AcRx::AppRetCode retCode =AcRxArxApp::On_kUnloadAppMsg (pkt) ;

		// TODO: Unload dependencies here
		FreeAcUiComboBoxs();

		delete pAlxdEditorReactor;
		acedRemoveFilterWinMsg(&FirstFilterWinMsg);

		retCode = UnloadDependencyLibrary();
		//AcDbBlockReference::desc()->delX(AcDbDoubleClickEdit::desc());

		return (retCode) ;
	}

	virtual void RegisterServerComponents () {
		//----- Self-register COM server upon loading.
		if ( FAILED(::DllRegisterServer ()) )
			acutPrintf (_RXST("Failed to register COM server.\n")) ;
	}

public:

	// - AlxdGrid._AlxdAt command (do not rename)
	static void AlxdGrid_AlxdAt(void)
	{
		// Add your code for command AlxdGrid._AlxdAt here
		//INT_AlxdGrid_At(false);
	}
public:

	// - AlxdGrid._AlxdAts command (do not rename)
	static void AlxdGrid_AlxdAts(void)
	{
		// Add your code for command AlxdGrid._AlxdAts here
		//INT_AlxdGrid_Ats();
	}
public:

	// ----- ads_alxdat symbol (do not rename)
	static int ads_alxdat(void)
	{
		//----- Remove the following line if you do not expect any argument for this ADS function
		struct resbuf *pArgs =acedGetArgs () ;

		// TODO: add your code here

		// TODO: Replace the following line by your returned value if any
		//acedRetVoid () ;
		//return INT_AlxdGrid_ads_alxdat(pArgs);

		return (RSRSLT) ;
	}

	// - AlxdGrid._AlxdAtc command (do not rename)
	static void AlxdGrid_AlxdAtc(void)
	{
		// Add your code for command AlxdGrid._AlxdAtc here
		//INT_AlxdGrid_Atc();
	}
} ;

//-----------------------------------------------------------------------------
IMPLEMENT_ARX_ENTRYPOINT(CGridApp)

//ACED_ARXCOMMAND_ENTRY_AUTO(CGridApp, AlxdGrid, _AlxdAt, AlxdAt, ACRX_CMD_MODAL | ACRX_CMD_REDRAW | ACRX_CMD_NOPERSPECTIVE, NULL)
//ACED_ARXCOMMAND_ENTRY_AUTO(CGridApp, AlxdGrid, _AlxdAts, AlxdAts, ACRX_CMD_MODAL | ACRX_CMD_REDRAW, NULL)
//ACED_ADSSYMBOL_ENTRY_AUTO(CGridApp, alxdat, true)
//ACED_ARXCOMMAND_ENTRY_AUTO(CGridApp, AlxdGrid, _AlxdAtc, AlxdAtc, ACRX_CMD_MODAL | ACRX_CMD_USEPICKSET | ACRX_CMD_REDRAW | ACRX_CMD_NOPERSPECTIVE, NULL)
