

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 7.00.0500 */
/* at Wed May 23 10:58:47 2012
 */
/* Compiler settings for .\Grid.idl:
    Oicf, W1, Zp8, env=Win64 (32b run)
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#pragma warning( disable: 4049 )  /* more than 64k source lines */


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __Grid_h__
#define __Grid_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __IXColCount_FWD_DEFINED__
#define __IXColCount_FWD_DEFINED__
typedef interface IXColCount IXColCount;
#endif 	/* __IXColCount_FWD_DEFINED__ */


#ifndef __IXCellText_FWD_DEFINED__
#define __IXCellText_FWD_DEFINED__
typedef interface IXCellText IXCellText;
#endif 	/* __IXCellText_FWD_DEFINED__ */


#ifndef __IXRowCount_FWD_DEFINED__
#define __IXRowCount_FWD_DEFINED__
typedef interface IXRowCount IXRowCount;
#endif 	/* __IXRowCount_FWD_DEFINED__ */


#ifndef __IXDefaultSize_FWD_DEFINED__
#define __IXDefaultSize_FWD_DEFINED__
typedef interface IXDefaultSize IXDefaultSize;
#endif 	/* __IXDefaultSize_FWD_DEFINED__ */


#ifndef __IXTextHeight_FWD_DEFINED__
#define __IXTextHeight_FWD_DEFINED__
typedef interface IXTextHeight IXTextHeight;
#endif 	/* __IXTextHeight_FWD_DEFINED__ */


#ifndef __IXTextWidthFactor_FWD_DEFINED__
#define __IXTextWidthFactor_FWD_DEFINED__
typedef interface IXTextWidthFactor IXTextWidthFactor;
#endif 	/* __IXTextWidthFactor_FWD_DEFINED__ */


#ifndef __IXTextObliqueAngle_FWD_DEFINED__
#define __IXTextObliqueAngle_FWD_DEFINED__
typedef interface IXTextObliqueAngle IXTextObliqueAngle;
#endif 	/* __IXTextObliqueAngle_FWD_DEFINED__ */


#ifndef __IXTextMarginsLeft_FWD_DEFINED__
#define __IXTextMarginsLeft_FWD_DEFINED__
typedef interface IXTextMarginsLeft IXTextMarginsLeft;
#endif 	/* __IXTextMarginsLeft_FWD_DEFINED__ */


#ifndef __IXTextMarginsTop_FWD_DEFINED__
#define __IXTextMarginsTop_FWD_DEFINED__
typedef interface IXTextMarginsTop IXTextMarginsTop;
#endif 	/* __IXTextMarginsTop_FWD_DEFINED__ */


#ifndef __IXTextMarginsRight_FWD_DEFINED__
#define __IXTextMarginsRight_FWD_DEFINED__
typedef interface IXTextMarginsRight IXTextMarginsRight;
#endif 	/* __IXTextMarginsRight_FWD_DEFINED__ */


#ifndef __IXTextMarginsBottom_FWD_DEFINED__
#define __IXTextMarginsBottom_FWD_DEFINED__
typedef interface IXTextMarginsBottom IXTextMarginsBottom;
#endif 	/* __IXTextMarginsBottom_FWD_DEFINED__ */


#ifndef __IXTextStyle_FWD_DEFINED__
#define __IXTextStyle_FWD_DEFINED__
typedef interface IXTextStyle IXTextStyle;
#endif 	/* __IXTextStyle_FWD_DEFINED__ */


#ifndef __IXDrawBorder_FWD_DEFINED__
#define __IXDrawBorder_FWD_DEFINED__
typedef interface IXDrawBorder IXDrawBorder;
#endif 	/* __IXDrawBorder_FWD_DEFINED__ */


#ifndef __IXFillCell_FWD_DEFINED__
#define __IXFillCell_FWD_DEFINED__
typedef interface IXFillCell IXFillCell;
#endif 	/* __IXFillCell_FWD_DEFINED__ */


#ifndef __IXTextFit_FWD_DEFINED__
#define __IXTextFit_FWD_DEFINED__
typedef interface IXTextFit IXTextFit;
#endif 	/* __IXTextFit_FWD_DEFINED__ */


#ifndef __IXTextType_FWD_DEFINED__
#define __IXTextType_FWD_DEFINED__
typedef interface IXTextType IXTextType;
#endif 	/* __IXTextType_FWD_DEFINED__ */


#ifndef __IXStyleName_FWD_DEFINED__
#define __IXStyleName_FWD_DEFINED__
typedef interface IXStyleName IXStyleName;
#endif 	/* __IXStyleName_FWD_DEFINED__ */


#ifndef __IXJustify_FWD_DEFINED__
#define __IXJustify_FWD_DEFINED__
typedef interface IXJustify IXJustify;
#endif 	/* __IXJustify_FWD_DEFINED__ */


#ifndef __XColCount_FWD_DEFINED__
#define __XColCount_FWD_DEFINED__

#ifdef __cplusplus
typedef class XColCount XColCount;
#else
typedef struct XColCount XColCount;
#endif /* __cplusplus */

#endif 	/* __XColCount_FWD_DEFINED__ */


#ifndef __XCellText_FWD_DEFINED__
#define __XCellText_FWD_DEFINED__

#ifdef __cplusplus
typedef class XCellText XCellText;
#else
typedef struct XCellText XCellText;
#endif /* __cplusplus */

#endif 	/* __XCellText_FWD_DEFINED__ */


#ifndef __XRowCount_FWD_DEFINED__
#define __XRowCount_FWD_DEFINED__

#ifdef __cplusplus
typedef class XRowCount XRowCount;
#else
typedef struct XRowCount XRowCount;
#endif /* __cplusplus */

#endif 	/* __XRowCount_FWD_DEFINED__ */


#ifndef __XDefaultSize_FWD_DEFINED__
#define __XDefaultSize_FWD_DEFINED__

#ifdef __cplusplus
typedef class XDefaultSize XDefaultSize;
#else
typedef struct XDefaultSize XDefaultSize;
#endif /* __cplusplus */

#endif 	/* __XDefaultSize_FWD_DEFINED__ */


#ifndef __XTextHeight_FWD_DEFINED__
#define __XTextHeight_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextHeight XTextHeight;
#else
typedef struct XTextHeight XTextHeight;
#endif /* __cplusplus */

#endif 	/* __XTextHeight_FWD_DEFINED__ */


#ifndef __XTextWidthFactor_FWD_DEFINED__
#define __XTextWidthFactor_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextWidthFactor XTextWidthFactor;
#else
typedef struct XTextWidthFactor XTextWidthFactor;
#endif /* __cplusplus */

#endif 	/* __XTextWidthFactor_FWD_DEFINED__ */


#ifndef __XTextObliqueAngle_FWD_DEFINED__
#define __XTextObliqueAngle_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextObliqueAngle XTextObliqueAngle;
#else
typedef struct XTextObliqueAngle XTextObliqueAngle;
#endif /* __cplusplus */

#endif 	/* __XTextObliqueAngle_FWD_DEFINED__ */


#ifndef __XTextMarginsLeft_FWD_DEFINED__
#define __XTextMarginsLeft_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextMarginsLeft XTextMarginsLeft;
#else
typedef struct XTextMarginsLeft XTextMarginsLeft;
#endif /* __cplusplus */

#endif 	/* __XTextMarginsLeft_FWD_DEFINED__ */


#ifndef __XTextMarginsTop_FWD_DEFINED__
#define __XTextMarginsTop_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextMarginsTop XTextMarginsTop;
#else
typedef struct XTextMarginsTop XTextMarginsTop;
#endif /* __cplusplus */

#endif 	/* __XTextMarginsTop_FWD_DEFINED__ */


#ifndef __XTextMarginsRight_FWD_DEFINED__
#define __XTextMarginsRight_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextMarginsRight XTextMarginsRight;
#else
typedef struct XTextMarginsRight XTextMarginsRight;
#endif /* __cplusplus */

#endif 	/* __XTextMarginsRight_FWD_DEFINED__ */


#ifndef __XTextMarginsBottom_FWD_DEFINED__
#define __XTextMarginsBottom_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextMarginsBottom XTextMarginsBottom;
#else
typedef struct XTextMarginsBottom XTextMarginsBottom;
#endif /* __cplusplus */

#endif 	/* __XTextMarginsBottom_FWD_DEFINED__ */


#ifndef __XTextStyle_FWD_DEFINED__
#define __XTextStyle_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextStyle XTextStyle;
#else
typedef struct XTextStyle XTextStyle;
#endif /* __cplusplus */

#endif 	/* __XTextStyle_FWD_DEFINED__ */


#ifndef __XDrawBorder_FWD_DEFINED__
#define __XDrawBorder_FWD_DEFINED__

#ifdef __cplusplus
typedef class XDrawBorder XDrawBorder;
#else
typedef struct XDrawBorder XDrawBorder;
#endif /* __cplusplus */

#endif 	/* __XDrawBorder_FWD_DEFINED__ */


#ifndef __XFillCell_FWD_DEFINED__
#define __XFillCell_FWD_DEFINED__

#ifdef __cplusplus
typedef class XFillCell XFillCell;
#else
typedef struct XFillCell XFillCell;
#endif /* __cplusplus */

#endif 	/* __XFillCell_FWD_DEFINED__ */


#ifndef __XTextFit_FWD_DEFINED__
#define __XTextFit_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextFit XTextFit;
#else
typedef struct XTextFit XTextFit;
#endif /* __cplusplus */

#endif 	/* __XTextFit_FWD_DEFINED__ */


#ifndef __XTextType_FWD_DEFINED__
#define __XTextType_FWD_DEFINED__

#ifdef __cplusplus
typedef class XTextType XTextType;
#else
typedef struct XTextType XTextType;
#endif /* __cplusplus */

#endif 	/* __XTextType_FWD_DEFINED__ */


#ifndef __XStyleName_FWD_DEFINED__
#define __XStyleName_FWD_DEFINED__

#ifdef __cplusplus
typedef class XStyleName XStyleName;
#else
typedef struct XStyleName XStyleName;
#endif /* __cplusplus */

#endif 	/* __XStyleName_FWD_DEFINED__ */


#ifndef __XJustify_FWD_DEFINED__
#define __XJustify_FWD_DEFINED__

#ifdef __cplusplus
typedef class XJustify XJustify;
#else
typedef struct XJustify XJustify;
#endif /* __cplusplus */

#endif 	/* __XJustify_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IXColCount_INTERFACE_DEFINED__
#define __IXColCount_INTERFACE_DEFINED__

/* interface IXColCount */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXColCount;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("B0721B6A-0944-469B-9B2A-E3D56BFEEE2A")
    IXColCount : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXColCountVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXColCount * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXColCount * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXColCount * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXColCount * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXColCount * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXColCount * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXColCount * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXColCountVtbl;

    interface IXColCount
    {
        CONST_VTBL struct IXColCountVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXColCount_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXColCount_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXColCount_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXColCount_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXColCount_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXColCount_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXColCount_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXColCount_INTERFACE_DEFINED__ */


#ifndef __IXCellText_INTERFACE_DEFINED__
#define __IXCellText_INTERFACE_DEFINED__

/* interface IXCellText */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXCellText;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("A04F9621-73A0-4C15-88E8-203A5B56AF0E")
    IXCellText : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXCellTextVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXCellText * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXCellText * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXCellText * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXCellText * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXCellText * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXCellText * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXCellText * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXCellTextVtbl;

    interface IXCellText
    {
        CONST_VTBL struct IXCellTextVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXCellText_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXCellText_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXCellText_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXCellText_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXCellText_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXCellText_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXCellText_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXCellText_INTERFACE_DEFINED__ */


#ifndef __IXRowCount_INTERFACE_DEFINED__
#define __IXRowCount_INTERFACE_DEFINED__

/* interface IXRowCount */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXRowCount;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("66ADD026-8668-4249-828B-114D01BE3D39")
    IXRowCount : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXRowCountVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXRowCount * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXRowCount * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXRowCount * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXRowCount * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXRowCount * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXRowCount * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXRowCount * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXRowCountVtbl;

    interface IXRowCount
    {
        CONST_VTBL struct IXRowCountVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXRowCount_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXRowCount_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXRowCount_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXRowCount_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXRowCount_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXRowCount_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXRowCount_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXRowCount_INTERFACE_DEFINED__ */


#ifndef __IXDefaultSize_INTERFACE_DEFINED__
#define __IXDefaultSize_INTERFACE_DEFINED__

/* interface IXDefaultSize */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXDefaultSize;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("206DF71F-88AF-4076-A4F0-05BC8FF3B85C")
    IXDefaultSize : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXDefaultSizeVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXDefaultSize * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXDefaultSize * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXDefaultSize * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXDefaultSize * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXDefaultSize * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXDefaultSize * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXDefaultSize * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXDefaultSizeVtbl;

    interface IXDefaultSize
    {
        CONST_VTBL struct IXDefaultSizeVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXDefaultSize_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXDefaultSize_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXDefaultSize_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXDefaultSize_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXDefaultSize_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXDefaultSize_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXDefaultSize_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXDefaultSize_INTERFACE_DEFINED__ */


#ifndef __IXTextHeight_INTERFACE_DEFINED__
#define __IXTextHeight_INTERFACE_DEFINED__

/* interface IXTextHeight */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextHeight;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("6AD4A4D4-17D1-4E3A-AD43-B7C006D894EF")
    IXTextHeight : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextHeightVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextHeight * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextHeight * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextHeight * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextHeight * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextHeight * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextHeight * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextHeight * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextHeightVtbl;

    interface IXTextHeight
    {
        CONST_VTBL struct IXTextHeightVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextHeight_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextHeight_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextHeight_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextHeight_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextHeight_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextHeight_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextHeight_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextHeight_INTERFACE_DEFINED__ */


#ifndef __IXTextWidthFactor_INTERFACE_DEFINED__
#define __IXTextWidthFactor_INTERFACE_DEFINED__

/* interface IXTextWidthFactor */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextWidthFactor;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("3B84B819-094C-435C-A6BB-14D5FC342870")
    IXTextWidthFactor : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextWidthFactorVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextWidthFactor * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextWidthFactor * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextWidthFactor * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextWidthFactor * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextWidthFactor * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextWidthFactor * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextWidthFactor * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextWidthFactorVtbl;

    interface IXTextWidthFactor
    {
        CONST_VTBL struct IXTextWidthFactorVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextWidthFactor_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextWidthFactor_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextWidthFactor_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextWidthFactor_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextWidthFactor_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextWidthFactor_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextWidthFactor_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextWidthFactor_INTERFACE_DEFINED__ */


#ifndef __IXTextObliqueAngle_INTERFACE_DEFINED__
#define __IXTextObliqueAngle_INTERFACE_DEFINED__

/* interface IXTextObliqueAngle */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextObliqueAngle;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("A2029015-A9CE-4A24-B36C-4F7BEDD04F5C")
    IXTextObliqueAngle : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextObliqueAngleVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextObliqueAngle * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextObliqueAngle * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextObliqueAngle * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextObliqueAngle * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextObliqueAngle * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextObliqueAngle * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextObliqueAngle * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextObliqueAngleVtbl;

    interface IXTextObliqueAngle
    {
        CONST_VTBL struct IXTextObliqueAngleVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextObliqueAngle_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextObliqueAngle_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextObliqueAngle_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextObliqueAngle_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextObliqueAngle_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextObliqueAngle_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextObliqueAngle_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextObliqueAngle_INTERFACE_DEFINED__ */


#ifndef __IXTextMarginsLeft_INTERFACE_DEFINED__
#define __IXTextMarginsLeft_INTERFACE_DEFINED__

/* interface IXTextMarginsLeft */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextMarginsLeft;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("13BC4F19-73D5-4170-8FE9-A6C938BFB080")
    IXTextMarginsLeft : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextMarginsLeftVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextMarginsLeft * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextMarginsLeft * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextMarginsLeft * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextMarginsLeft * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextMarginsLeft * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextMarginsLeft * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextMarginsLeft * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextMarginsLeftVtbl;

    interface IXTextMarginsLeft
    {
        CONST_VTBL struct IXTextMarginsLeftVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextMarginsLeft_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextMarginsLeft_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextMarginsLeft_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextMarginsLeft_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextMarginsLeft_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextMarginsLeft_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextMarginsLeft_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextMarginsLeft_INTERFACE_DEFINED__ */


#ifndef __IXTextMarginsTop_INTERFACE_DEFINED__
#define __IXTextMarginsTop_INTERFACE_DEFINED__

/* interface IXTextMarginsTop */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextMarginsTop;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("783A4EF5-A004-4173-8577-1A4FA1CA9D85")
    IXTextMarginsTop : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextMarginsTopVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextMarginsTop * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextMarginsTop * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextMarginsTop * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextMarginsTop * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextMarginsTop * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextMarginsTop * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextMarginsTop * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextMarginsTopVtbl;

    interface IXTextMarginsTop
    {
        CONST_VTBL struct IXTextMarginsTopVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextMarginsTop_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextMarginsTop_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextMarginsTop_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextMarginsTop_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextMarginsTop_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextMarginsTop_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextMarginsTop_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextMarginsTop_INTERFACE_DEFINED__ */


#ifndef __IXTextMarginsRight_INTERFACE_DEFINED__
#define __IXTextMarginsRight_INTERFACE_DEFINED__

/* interface IXTextMarginsRight */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextMarginsRight;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("E859BDDB-6A9D-49BD-8AC3-ED07C877B17F")
    IXTextMarginsRight : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextMarginsRightVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextMarginsRight * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextMarginsRight * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextMarginsRight * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextMarginsRight * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextMarginsRight * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextMarginsRight * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextMarginsRight * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextMarginsRightVtbl;

    interface IXTextMarginsRight
    {
        CONST_VTBL struct IXTextMarginsRightVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextMarginsRight_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextMarginsRight_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextMarginsRight_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextMarginsRight_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextMarginsRight_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextMarginsRight_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextMarginsRight_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextMarginsRight_INTERFACE_DEFINED__ */


#ifndef __IXTextMarginsBottom_INTERFACE_DEFINED__
#define __IXTextMarginsBottom_INTERFACE_DEFINED__

/* interface IXTextMarginsBottom */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextMarginsBottom;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("2AE5A433-0395-4BD2-9FFC-7DF4F8A718E8")
    IXTextMarginsBottom : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextMarginsBottomVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextMarginsBottom * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextMarginsBottom * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextMarginsBottom * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextMarginsBottom * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextMarginsBottom * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextMarginsBottom * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextMarginsBottom * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextMarginsBottomVtbl;

    interface IXTextMarginsBottom
    {
        CONST_VTBL struct IXTextMarginsBottomVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextMarginsBottom_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextMarginsBottom_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextMarginsBottom_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextMarginsBottom_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextMarginsBottom_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextMarginsBottom_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextMarginsBottom_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextMarginsBottom_INTERFACE_DEFINED__ */


#ifndef __IXTextStyle_INTERFACE_DEFINED__
#define __IXTextStyle_INTERFACE_DEFINED__

/* interface IXTextStyle */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextStyle;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CBC5492F-A705-4E1C-8A00-6D09B18AD0A1")
    IXTextStyle : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextStyleVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextStyle * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextStyle * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextStyle * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextStyle * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextStyle * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextStyle * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextStyle * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextStyleVtbl;

    interface IXTextStyle
    {
        CONST_VTBL struct IXTextStyleVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextStyle_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextStyle_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextStyle_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextStyle_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextStyle_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextStyle_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextStyle_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextStyle_INTERFACE_DEFINED__ */


#ifndef __IXDrawBorder_INTERFACE_DEFINED__
#define __IXDrawBorder_INTERFACE_DEFINED__

/* interface IXDrawBorder */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXDrawBorder;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("88318CD8-9C62-4A58-B3BC-552E5A031D34")
    IXDrawBorder : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXDrawBorderVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXDrawBorder * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXDrawBorder * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXDrawBorder * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXDrawBorder * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXDrawBorder * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXDrawBorder * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXDrawBorder * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXDrawBorderVtbl;

    interface IXDrawBorder
    {
        CONST_VTBL struct IXDrawBorderVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXDrawBorder_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXDrawBorder_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXDrawBorder_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXDrawBorder_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXDrawBorder_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXDrawBorder_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXDrawBorder_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXDrawBorder_INTERFACE_DEFINED__ */


#ifndef __IXFillCell_INTERFACE_DEFINED__
#define __IXFillCell_INTERFACE_DEFINED__

/* interface IXFillCell */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXFillCell;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("9DAC1423-4EF6-455B-A654-1B71F040F3EB")
    IXFillCell : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXFillCellVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXFillCell * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXFillCell * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXFillCell * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXFillCell * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXFillCell * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXFillCell * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXFillCell * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXFillCellVtbl;

    interface IXFillCell
    {
        CONST_VTBL struct IXFillCellVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXFillCell_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXFillCell_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXFillCell_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXFillCell_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXFillCell_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXFillCell_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXFillCell_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXFillCell_INTERFACE_DEFINED__ */


#ifndef __IXTextFit_INTERFACE_DEFINED__
#define __IXTextFit_INTERFACE_DEFINED__

/* interface IXTextFit */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextFit;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("59A53735-45D6-4095-8C18-AC922B430FDE")
    IXTextFit : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextFitVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextFit * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextFit * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextFit * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextFit * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextFit * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextFit * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextFit * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextFitVtbl;

    interface IXTextFit
    {
        CONST_VTBL struct IXTextFitVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextFit_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextFit_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextFit_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextFit_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextFit_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextFit_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextFit_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextFit_INTERFACE_DEFINED__ */


#ifndef __IXTextType_INTERFACE_DEFINED__
#define __IXTextType_INTERFACE_DEFINED__

/* interface IXTextType */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXTextType;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("258BC0F4-A118-48CD-827D-2510FFCCA3EC")
    IXTextType : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXTextTypeVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXTextType * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXTextType * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXTextType * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXTextType * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXTextType * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXTextType * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXTextType * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXTextTypeVtbl;

    interface IXTextType
    {
        CONST_VTBL struct IXTextTypeVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXTextType_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXTextType_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXTextType_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXTextType_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXTextType_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXTextType_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXTextType_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXTextType_INTERFACE_DEFINED__ */


#ifndef __IXStyleName_INTERFACE_DEFINED__
#define __IXStyleName_INTERFACE_DEFINED__

/* interface IXStyleName */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXStyleName;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("42DF7F0D-1F91-4371-85FD-0025290A3F92")
    IXStyleName : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXStyleNameVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXStyleName * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXStyleName * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXStyleName * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXStyleName * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXStyleName * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXStyleName * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXStyleName * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXStyleNameVtbl;

    interface IXStyleName
    {
        CONST_VTBL struct IXStyleNameVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXStyleName_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXStyleName_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXStyleName_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXStyleName_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXStyleName_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXStyleName_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXStyleName_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXStyleName_INTERFACE_DEFINED__ */


#ifndef __IXJustify_INTERFACE_DEFINED__
#define __IXJustify_INTERFACE_DEFINED__

/* interface IXJustify */
/* [unique][helpstring][nonextensible][dual][uuid][object] */ 


EXTERN_C const IID IID_IXJustify;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("6FE44EEE-514F-44C5-B749-4B34325F4007")
    IXJustify : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct IXJustifyVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IXJustify * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IXJustify * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IXJustify * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IXJustify * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IXJustify * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IXJustify * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IXJustify * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        END_INTERFACE
    } IXJustifyVtbl;

    interface IXJustify
    {
        CONST_VTBL struct IXJustifyVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IXJustify_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IXJustify_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IXJustify_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IXJustify_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IXJustify_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IXJustify_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IXJustify_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IXJustify_INTERFACE_DEFINED__ */



#ifndef __AlxdGridLib_LIBRARY_DEFINED__
#define __AlxdGridLib_LIBRARY_DEFINED__

/* library AlxdGridLib */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_AlxdGridLib;

EXTERN_C const CLSID CLSID_XColCount;

#ifdef __cplusplus

class DECLSPEC_UUID("8D13AC9A-D15E-4F05-B680-DBD3AAB59FCA")
XColCount;
#endif

EXTERN_C const CLSID CLSID_XCellText;

#ifdef __cplusplus

class DECLSPEC_UUID("058EB710-D1A3-4BD0-8C24-B161375453DC")
XCellText;
#endif

EXTERN_C const CLSID CLSID_XRowCount;

#ifdef __cplusplus

class DECLSPEC_UUID("B83EEF7A-6D05-4F97-A38D-6C078EE7B7FC")
XRowCount;
#endif

EXTERN_C const CLSID CLSID_XDefaultSize;

#ifdef __cplusplus

class DECLSPEC_UUID("679D47B6-DC5D-4044-9F17-89D4B4ADAC69")
XDefaultSize;
#endif

EXTERN_C const CLSID CLSID_XTextHeight;

#ifdef __cplusplus

class DECLSPEC_UUID("1C4A69AA-B314-4681-A995-B6E3D2FB39E0")
XTextHeight;
#endif

EXTERN_C const CLSID CLSID_XTextWidthFactor;

#ifdef __cplusplus

class DECLSPEC_UUID("AEC36E14-30B6-4081-B16F-455BB518977E")
XTextWidthFactor;
#endif

EXTERN_C const CLSID CLSID_XTextObliqueAngle;

#ifdef __cplusplus

class DECLSPEC_UUID("3B2F3D36-88EF-4911-892B-B5E33726C4A5")
XTextObliqueAngle;
#endif

EXTERN_C const CLSID CLSID_XTextMarginsLeft;

#ifdef __cplusplus

class DECLSPEC_UUID("62BCA396-2FBD-42FE-AE75-ED96CB12FE14")
XTextMarginsLeft;
#endif

EXTERN_C const CLSID CLSID_XTextMarginsTop;

#ifdef __cplusplus

class DECLSPEC_UUID("59A0A23D-15CD-48C9-95E8-3A9C6132468E")
XTextMarginsTop;
#endif

EXTERN_C const CLSID CLSID_XTextMarginsRight;

#ifdef __cplusplus

class DECLSPEC_UUID("A07318B7-43CF-4792-9B97-0CD112D00310")
XTextMarginsRight;
#endif

EXTERN_C const CLSID CLSID_XTextMarginsBottom;

#ifdef __cplusplus

class DECLSPEC_UUID("9A57846C-3978-4917-A355-2CA336A13D06")
XTextMarginsBottom;
#endif

EXTERN_C const CLSID CLSID_XTextStyle;

#ifdef __cplusplus

class DECLSPEC_UUID("223F0517-9CA5-4A34-BEFB-377306FC7FF6")
XTextStyle;
#endif

EXTERN_C const CLSID CLSID_XDrawBorder;

#ifdef __cplusplus

class DECLSPEC_UUID("2F525FDD-F494-4972-9A42-5E93491B9D45")
XDrawBorder;
#endif

EXTERN_C const CLSID CLSID_XFillCell;

#ifdef __cplusplus

class DECLSPEC_UUID("1C2DEA26-3290-4847-8AC5-B2564E67753C")
XFillCell;
#endif

EXTERN_C const CLSID CLSID_XTextFit;

#ifdef __cplusplus

class DECLSPEC_UUID("EEEDE9C5-055E-4D42-8865-A0467267BEAF")
XTextFit;
#endif

EXTERN_C const CLSID CLSID_XTextType;

#ifdef __cplusplus

class DECLSPEC_UUID("18B6BAD4-C5F4-4C07-807D-E3F9469E86F3")
XTextType;
#endif

EXTERN_C const CLSID CLSID_XStyleName;

#ifdef __cplusplus

class DECLSPEC_UUID("D1AED31C-82B9-40D0-B16E-0F66689E9F2F")
XStyleName;
#endif

EXTERN_C const CLSID CLSID_XJustify;

#ifdef __cplusplus

class DECLSPEC_UUID("1456767D-50CB-4E70-824E-6C689D95F2EE")
XJustify;
#endif
#endif /* __AlxdGridLib_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


