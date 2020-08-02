// (C) Copyright 2002-2007 by Autodesk, Inc. 
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
//----- XStyleName.h : Declaration of the CXStyleName
//-----------------------------------------------------------------------------
#pragma once
#include "resource.h"

#include "Grid.h"



//----- CXStyleName
class ATL_NO_VTABLE CXStyleName : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CXStyleName, &CLSID_XStyleName>,
	public ISupportErrorInfo,
	public IDispatchImpl<IXStyleName, &IID_IXStyleName, &LIBID_AlxdGridLib, /*wMajor =*/ 1, /*wMinor =*/ 0>,
    public IDynamicDialogProperty,
    public ICategorizeProperties,
	public IDynamicProperty2
{
public:
	CXStyleName () {
	}

	DECLARE_REGISTRY_RESOURCEID(IDR_XSTYLENAME)

	BEGIN_COM_MAP(CXStyleName)
		COM_INTERFACE_ENTRY(IXStyleName)
		COM_INTERFACE_ENTRY(IDispatch)
		COM_INTERFACE_ENTRY(ISupportErrorInfo)
		COM_INTERFACE_ENTRY(IDynamicDialogProperty)
		COM_INTERFACE_ENTRY(ICategorizeProperties)
		COM_INTERFACE_ENTRY(IDynamicProperty2)
	END_COM_MAP()

	//----- ISupportsErrorInfo
	STDMETHOD(InterfaceSupportsErrorInfo)(REFIID riid);


	DECLARE_PROTECT_FINAL_CONSTRUCT()

	HRESULT FinalConstruct () {
		return (S_OK) ;
	}
	
	void FinalRelease () {
	}

	IDynamicPropertyNotify2 *m_pNotify ;

public:
	//IDynamicProperty2
	STDMETHOD(GetGUID)(GUID* propGUID) ;
	STDMETHOD(GetDisplayName)(BSTR* bstrName) ;
	STDMETHOD(IsPropertyEnabled)(IUnknown *pUnk, BOOL* pbEnabled) ;
	STDMETHOD(IsPropertyReadOnly)(BOOL* pbReadonly) ;
	STDMETHOD(GetDescription)(BSTR* bstrName) ;
	STDMETHOD(GetCurrentValueName)(BSTR* pbstrName) ;
	STDMETHOD(GetCurrentValueType)(VARTYPE* pVarType) ;
	STDMETHOD(GetCurrentValueData)(IUnknown *pUnk, VARIANT* pvarData) ;
	STDMETHOD(SetCurrentValueData)(IUnknown *pUnk, const VARIANT varData) ;
	STDMETHOD(Connect)(IDynamicPropertyNotify2* pSink) ;
	STDMETHOD(Disconnect)() ;
	//IDynamicDialogProperty
	STDMETHOD(GetCustomDialogProc)(OPMDIALOGPROC* pDialogProc) ;
	STDMETHOD(GetMacroName)(BSTR* bstrName) ;
	//ICategorizePropery
	STDMETHOD(MapPropertyToCategory)(DISPID dispid, PROPCAT* ppropcat) ;
	STDMETHOD(GetCategoryName)(PROPCAT propcat, LCID lcid, BSTR* pbstrName) ;
	//IXStyleName

} ;

OBJECT_ENTRY_AUTO(__uuidof(XStyleName), CXStyleName)
//OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXStyleName, AcDbBlockReference)
