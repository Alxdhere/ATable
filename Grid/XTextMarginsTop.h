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
//----- XTextMarginsTop.h : Declaration of the CXTextMarginsTop
//-----------------------------------------------------------------------------
#pragma once
#include "resource.h"

#include "Grid.h"



//----- CXTextMarginsTop
class ATL_NO_VTABLE CXTextMarginsTop : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CXTextMarginsTop, &CLSID_XTextMarginsTop>,
	public ISupportErrorInfo,
	public IDispatchImpl<IXTextMarginsTop, &IID_IXTextMarginsTop, &LIBID_AlxdGridLib, /*wMajor =*/ 1, /*wMinor =*/ 0>,
    public ICategorizeProperties,
	public IDynamicProperty2
{
public:
	CXTextMarginsTop () {
	}

	DECLARE_REGISTRY_RESOURCEID(IDR_XTEXTMARGINSTOP)

	BEGIN_COM_MAP(CXTextMarginsTop)
		COM_INTERFACE_ENTRY(IXTextMarginsTop)
		COM_INTERFACE_ENTRY(IDispatch)
		COM_INTERFACE_ENTRY(ISupportErrorInfo)
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
	//ICategorizePropery
	STDMETHOD(MapPropertyToCategory)(DISPID dispid, PROPCAT* ppropcat) ;
	STDMETHOD(GetCategoryName)(PROPCAT propcat, LCID lcid, BSTR* pbstrName) ;
	//IXTextMarginsTop

} ;

OBJECT_ENTRY_AUTO(__uuidof(XTextMarginsTop), CXTextMarginsTop)
//OPM_DYNPROP_OBJECT_ENTRY_AUTO(CXTextMarginsTop, AcDbBlockReference)
