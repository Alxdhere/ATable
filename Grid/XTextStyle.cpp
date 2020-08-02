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
//----- XTextStyle.cpp : Implementation of CXTextStyle
//-----------------------------------------------------------------------------
#include "StdAfx.h"
#include "XTextStyle.h"
#include "oarxExport.h"
#include "vclImport.h"
//----- CXTextStyle
STDMETHODIMP CXTextStyle::InterfaceSupportsErrorInfo(REFIID riid) {
	static const IID* arr [] ={
		&IID_IXTextStyle
	} ;

	for ( int i =0 ; i < sizeof (arr) / sizeof (arr [0]) ; i++ ) {
		if ( InlineIsEqualGUID (*arr [i], riid) )
			return (S_OK) ;
	}
	return (S_FALSE) ;
}

//----- IDynamicProperty
STDMETHODIMP CXTextStyle::GetGUID (GUID *pPropGUID) {
	if ( pPropGUID == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	memcpy (pPropGUID, &CLSID_XTextStyle, sizeof(GUID)) ;

	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::GetDisplayName (BSTR *pBstrName) {
	if ( pBstrName == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	ACHAR buf[1024];
	vclImport::vclOPMName(7, buf);
	buf[_tcslen(buf) - 4] = '\0';
	*pBstrName =::SysAllocString(buf);


	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::IsPropertyEnabled (IUnknown *pUnk, BOOL *pbEnabled) {
	if ( pUnk == NULL )
		return (E_INVALIDARG) ;
	if ( pbEnabled == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	AcDbObjectId objId = OPM_GetObjectId(pUnk);
	*pbEnabled = HasAlxdGridEntity(objId);

	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::IsPropertyReadOnly (BOOL *pbReadOnly) {
	if ( pbReadOnly == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	*pbReadOnly =FALSE ;

	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::GetDescription (BSTR *pBstrName) {
	if ( pBstrName == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	ACHAR buf[1024];
	vclImport::vclOPMDescription(7, buf);
	*pBstrName =::SysAllocString(buf);

	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::GetCurrentValueName (BSTR *pBstrName) {
	if ( pBstrName == NULL )
		return (E_POINTER) ;
	// TODO: add your code here

	//return (S_OK) ; //----- If you do anything in there
	return (E_NOTIMPL) ;
}

STDMETHODIMP CXTextStyle::GetCurrentValueType (VARTYPE *pVarType) {
	if ( pVarType == NULL )
		return (E_POINTER) ;
	//----- Enumerated property
	*pVarType = VT_USERDEFINED ;

	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::GetCurrentValueData (IUnknown *pUnk, VARIANT *pVarData) {
	if ( pUnk == NULL )
		return (E_INVALIDARG) ;
	if ( pVarData == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the 3 lines below)
	//::VariantInit (pVarData) ;
	//V_VT(pVarData) =VT_I4 ;
	//V_I4(pVarData) =0 ; //---- Always return 0
	OPM_GetTextStyleCurrentValueData(pUnk, pVarData);

	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::SetCurrentValueData (IUnknown *pUnk, const VARIANT varData) {
	if ( pUnk == NULL )
		return (E_INVALIDARG) ;
	// TODO: add your code here

	OPM_SetTextStyleCurrentValueData(pUnk, varData);
	//BSTR b = _bstr_t(varData);
	//AcString s;// = new AcString();
	//s = varData;
	//----- In case of an enum property, call the following to update the physical combobox
	//m_pNotify->OnChanged (this) ;
	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::Connect (IDynamicPropertyNotify2 *pSink) {
	if ( pSink == NULL )
		return (E_POINTER) ;
	m_pNotify =pSink ;
	m_pNotify->AddRef () ;
	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::Disconnect () {
	if ( m_pNotify ) {
		m_pNotify->Release () ;
		m_pNotify= NULL ;
	}
	return (S_OK) ;
}

//----- IDynamicEnumProperty
STDMETHODIMP CXTextStyle::GetNumPropertyValues (LONG *pNumValues) {
	if ( pNumValues == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	*pNumValues = OPM_GetTextStyleCount(); //----- Have 3 items in the drop down

	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::GetPropValueName (LONG index, BSTR *pBstrValueName) {
	if ( pBstrValueName == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the 2 lines below)
	OPM_GetTextStyleNameAt(index, pBstrValueName);
	//WCHAR buffer [5] ; //----- This should be enough
	//*pBstrValueName =::SysAllocString (_itow (index, buffer, 10)) ; //----- Show simply the numbers in the combo

	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::GetPropValueData (LONG index, VARIANT* pValue) {
	if ( pValue == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the 3 lines below)
	
	OPM_GetTextStyleHandleAt(index, pValue);
	//::VariantInit (pValue) ;
	//V_VT(pValue) =VT_I4 ;
	//V_I4(pValue) =index ; //----- The index IS the value in this case

	return (S_OK) ;
}


//----- ICategorizePropertes
STDMETHODIMP CXTextStyle::MapPropertyToCategory (DISPID dispid, PROPCAT *pPropCat) {
	if ( pPropCat == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	*pPropCat =0 ;

	return (S_OK) ;
}

STDMETHODIMP CXTextStyle::GetCategoryName (PROPCAT propcat, LCID lcid, BSTR *pBstrName) {
	if ( pBstrName == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the 3 lines below)
	if ( propcat != 0 )
		return (E_INVALIDARG) ;
	ACHAR buf[1024];
	vclImport::vclOPMName(1003, buf);
	*pBstrName =::SysAllocString(buf);


	return (S_OK) ;
}
