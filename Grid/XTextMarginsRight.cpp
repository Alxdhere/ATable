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
//----- XTextMarginsRight.cpp : Implementation of CXTextMarginsRight
//-----------------------------------------------------------------------------
#include "StdAfx.h"
#include "XTextMarginsRight.h"
#include "oarxExport.h"
#include "vclImport.h"
//----- CXTextMarginsRight
STDMETHODIMP CXTextMarginsRight::InterfaceSupportsErrorInfo(REFIID riid) {
	static const IID* arr [] ={
		&IID_IXTextMarginsRight
	} ;

	for ( int i =0 ; i < sizeof (arr) / sizeof (arr [0]) ; i++ ) {
		if ( InlineIsEqualGUID (*arr [i], riid) )
			return (S_OK) ;
	}
	return (S_FALSE) ;
}

//----- IDynamicProperty
STDMETHODIMP CXTextMarginsRight::GetGUID (GUID *pPropGUID) {
	if ( pPropGUID == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	memcpy (pPropGUID, &CLSID_XTextMarginsRight, sizeof(GUID)) ;

	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::GetDisplayName (BSTR *pBstrName) {
	if ( pBstrName == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	ACHAR buf[1024];
	vclImport::vclOPMName(58, buf);
	buf[_tcslen(buf) - 4] = '\0';
	*pBstrName =::SysAllocString(buf);

	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::IsPropertyEnabled (IUnknown *pUnk, BOOL *pbEnabled) {
	if ( pUnk == NULL )
		return (E_INVALIDARG) ;
	if ( pbEnabled == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	AcDbObjectId objId = OPM_GetObjectId(pUnk);
	*pbEnabled = HasAlxdGridEntity(objId);

	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::IsPropertyReadOnly (BOOL *pbReadOnly) {
	if ( pbReadOnly == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	*pbReadOnly =FALSE ;

	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::GetDescription (BSTR *pBstrName) {
	if ( pBstrName == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	ACHAR buf[1024];
	vclImport::vclOPMDescription(58, buf);
	*pBstrName =::SysAllocString(buf);

	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::GetCurrentValueName (BSTR *pBstrName) {
	if ( pBstrName == NULL )
		return (E_POINTER) ;
	// TODO: add your code here

	//return (S_OK) ; //----- If you do anything in there
	return (E_NOTIMPL) ;
}

STDMETHODIMP CXTextMarginsRight::GetCurrentValueType (VARTYPE *pVarType) {
	if ( pVarType == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	*pVarType =VT_R8 ; //----- An integer

	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::GetCurrentValueData (IUnknown *pUnk, VARIANT *pVarData) {
	if ( pUnk == NULL )
		return (E_INVALIDARG) ;
	if ( pVarData == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the 3 lines below)
	AcDbObjectId objId = OPM_GetObjectId(pUnk);
	if (OPM_GetNumData(objId, 58, pVarData) != RTNORM)
		return E_FAIL;

	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::SetCurrentValueData (IUnknown *pUnk, const VARIANT varData) {
	if ( pUnk == NULL )
		return (E_INVALIDARG) ;
	// TODO: add your code here
	AcDbObjectId objId = OPM_GetObjectId(pUnk);
	if (OPM_SetNumData(objId, 58, varData) != RTNORM)
		return E_FAIL;
	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::Connect (IDynamicPropertyNotify2 *pSink) {
	if ( pSink == NULL )
		return (E_POINTER) ;
	m_pNotify =pSink ;
	m_pNotify->AddRef () ;
	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::Disconnect () {
	if ( m_pNotify ) {
		m_pNotify->Release () ;
		m_pNotify= NULL ;
	}
	return (S_OK) ;
}



//----- ICategorizePropertes
STDMETHODIMP CXTextMarginsRight::MapPropertyToCategory (DISPID dispid, PROPCAT *pPropCat) {
	if ( pPropCat == NULL )
		return (E_POINTER) ;
	// TODO: add your code here (and comment the line below)
	*pPropCat =0 ;

	return (S_OK) ;
}

STDMETHODIMP CXTextMarginsRight::GetCategoryName (PROPCAT propcat, LCID lcid, BSTR *pBstrName) {
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
