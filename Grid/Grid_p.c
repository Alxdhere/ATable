

/* this ALWAYS GENERATED file contains the proxy stub code */


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

#if defined(_M_AMD64)


#pragma warning( disable: 4049 )  /* more than 64k source lines */
#if _MSC_VER >= 1200
#pragma warning(push)
#endif

#pragma warning( disable: 4211 )  /* redefine extern to static */
#pragma warning( disable: 4232 )  /* dllimport identity*/
#pragma warning( disable: 4024 )  /* array to pointer mapping*/
#pragma warning( disable: 4152 )  /* function/data pointer conversion in expression */

#define USE_STUBLESS_PROXY


/* verify that the <rpcproxy.h> version is high enough to compile this file*/
#ifndef __REDQ_RPCPROXY_H_VERSION__
#define __REQUIRED_RPCPROXY_H_VERSION__ 475
#endif


#include "rpcproxy.h"
#ifndef __RPCPROXY_H_VERSION__
#error this stub requires an updated version of <rpcproxy.h>
#endif // __RPCPROXY_H_VERSION__


#include "Grid.h"

#define TYPE_FORMAT_STRING_SIZE   3                                 
#define PROC_FORMAT_STRING_SIZE   1                                 
#define EXPR_FORMAT_STRING_SIZE   1                                 
#define TRANSMIT_AS_TABLE_SIZE    0            
#define WIRE_MARSHAL_TABLE_SIZE   0            

typedef struct _Grid_MIDL_TYPE_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ TYPE_FORMAT_STRING_SIZE ];
    } Grid_MIDL_TYPE_FORMAT_STRING;

typedef struct _Grid_MIDL_PROC_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ PROC_FORMAT_STRING_SIZE ];
    } Grid_MIDL_PROC_FORMAT_STRING;

typedef struct _Grid_MIDL_EXPR_FORMAT_STRING
    {
    long          Pad;
    unsigned char  Format[ EXPR_FORMAT_STRING_SIZE ];
    } Grid_MIDL_EXPR_FORMAT_STRING;


static RPC_SYNTAX_IDENTIFIER  _RpcTransferSyntax = 
{{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}};


extern const Grid_MIDL_TYPE_FORMAT_STRING Grid__MIDL_TypeFormatString;
extern const Grid_MIDL_PROC_FORMAT_STRING Grid__MIDL_ProcFormatString;
extern const Grid_MIDL_EXPR_FORMAT_STRING Grid__MIDL_ExprFormatString;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXColCount_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXColCount_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXCellText_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXCellText_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXRowCount_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXRowCount_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXDefaultSize_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXDefaultSize_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextHeight_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextHeight_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextWidthFactor_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextWidthFactor_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextObliqueAngle_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextObliqueAngle_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextMarginsLeft_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextMarginsLeft_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextMarginsTop_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextMarginsTop_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextMarginsRight_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextMarginsRight_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextMarginsBottom_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextMarginsBottom_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextStyle_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextStyle_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXDrawBorder_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXDrawBorder_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXFillCell_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXFillCell_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextFit_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextFit_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXTextType_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXTextType_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXStyleName_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXStyleName_ProxyInfo;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO IXJustify_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IXJustify_ProxyInfo;



#if !defined(__RPC_WIN64__)
#error  Invalid build platform for this stub.
#endif

static const Grid_MIDL_PROC_FORMAT_STRING Grid__MIDL_ProcFormatString =
    {
        0,
        {

			0x0
        }
    };

static const Grid_MIDL_TYPE_FORMAT_STRING Grid__MIDL_TypeFormatString =
    {
        0,
        {
			NdrFcShort( 0x0 ),	/* 0 */

			0x0
        }
    };


/* Object interface: IUnknown, ver. 0.0,
   GUID={0x00000000,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: IDispatch, ver. 0.0,
   GUID={0x00020400,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: IXColCount, ver. 0.0,
   GUID={0xB0721B6A,0x0944,0x469B,{0x9B,0x2A,0xE3,0xD5,0x6B,0xFE,0xEE,0x2A}} */

#pragma code_seg(".orpc")
static const unsigned short IXColCount_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXColCount_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXColCount_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXColCount_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXColCount_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXColCountProxyVtbl = 
{
    0,
    &IID_IXColCount,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXColCount_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXColCountStubVtbl =
{
    &IID_IXColCount,
    &IXColCount_ServerInfo,
    7,
    &IXColCount_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXCellText, ver. 0.0,
   GUID={0xA04F9621,0x73A0,0x4C15,{0x88,0xE8,0x20,0x3A,0x5B,0x56,0xAF,0x0E}} */

#pragma code_seg(".orpc")
static const unsigned short IXCellText_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXCellText_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXCellText_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXCellText_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXCellText_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXCellTextProxyVtbl = 
{
    0,
    &IID_IXCellText,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXCellText_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXCellTextStubVtbl =
{
    &IID_IXCellText,
    &IXCellText_ServerInfo,
    7,
    &IXCellText_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXRowCount, ver. 0.0,
   GUID={0x66ADD026,0x8668,0x4249,{0x82,0x8B,0x11,0x4D,0x01,0xBE,0x3D,0x39}} */

#pragma code_seg(".orpc")
static const unsigned short IXRowCount_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXRowCount_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXRowCount_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXRowCount_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXRowCount_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXRowCountProxyVtbl = 
{
    0,
    &IID_IXRowCount,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXRowCount_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXRowCountStubVtbl =
{
    &IID_IXRowCount,
    &IXRowCount_ServerInfo,
    7,
    &IXRowCount_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXDefaultSize, ver. 0.0,
   GUID={0x206DF71F,0x88AF,0x4076,{0xA4,0xF0,0x05,0xBC,0x8F,0xF3,0xB8,0x5C}} */

#pragma code_seg(".orpc")
static const unsigned short IXDefaultSize_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXDefaultSize_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXDefaultSize_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXDefaultSize_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXDefaultSize_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXDefaultSizeProxyVtbl = 
{
    0,
    &IID_IXDefaultSize,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXDefaultSize_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXDefaultSizeStubVtbl =
{
    &IID_IXDefaultSize,
    &IXDefaultSize_ServerInfo,
    7,
    &IXDefaultSize_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextHeight, ver. 0.0,
   GUID={0x6AD4A4D4,0x17D1,0x4E3A,{0xAD,0x43,0xB7,0xC0,0x06,0xD8,0x94,0xEF}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextHeight_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextHeight_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextHeight_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextHeight_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextHeight_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextHeightProxyVtbl = 
{
    0,
    &IID_IXTextHeight,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextHeight_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextHeightStubVtbl =
{
    &IID_IXTextHeight,
    &IXTextHeight_ServerInfo,
    7,
    &IXTextHeight_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextWidthFactor, ver. 0.0,
   GUID={0x3B84B819,0x094C,0x435C,{0xA6,0xBB,0x14,0xD5,0xFC,0x34,0x28,0x70}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextWidthFactor_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextWidthFactor_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextWidthFactor_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextWidthFactor_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextWidthFactor_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextWidthFactorProxyVtbl = 
{
    0,
    &IID_IXTextWidthFactor,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextWidthFactor_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextWidthFactorStubVtbl =
{
    &IID_IXTextWidthFactor,
    &IXTextWidthFactor_ServerInfo,
    7,
    &IXTextWidthFactor_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextObliqueAngle, ver. 0.0,
   GUID={0xA2029015,0xA9CE,0x4A24,{0xB3,0x6C,0x4F,0x7B,0xED,0xD0,0x4F,0x5C}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextObliqueAngle_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextObliqueAngle_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextObliqueAngle_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextObliqueAngle_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextObliqueAngle_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextObliqueAngleProxyVtbl = 
{
    0,
    &IID_IXTextObliqueAngle,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextObliqueAngle_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextObliqueAngleStubVtbl =
{
    &IID_IXTextObliqueAngle,
    &IXTextObliqueAngle_ServerInfo,
    7,
    &IXTextObliqueAngle_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextMarginsLeft, ver. 0.0,
   GUID={0x13BC4F19,0x73D5,0x4170,{0x8F,0xE9,0xA6,0xC9,0x38,0xBF,0xB0,0x80}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextMarginsLeft_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextMarginsLeft_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextMarginsLeft_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextMarginsLeft_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextMarginsLeft_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextMarginsLeftProxyVtbl = 
{
    0,
    &IID_IXTextMarginsLeft,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextMarginsLeft_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextMarginsLeftStubVtbl =
{
    &IID_IXTextMarginsLeft,
    &IXTextMarginsLeft_ServerInfo,
    7,
    &IXTextMarginsLeft_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextMarginsTop, ver. 0.0,
   GUID={0x783A4EF5,0xA004,0x4173,{0x85,0x77,0x1A,0x4F,0xA1,0xCA,0x9D,0x85}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextMarginsTop_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextMarginsTop_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextMarginsTop_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextMarginsTop_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextMarginsTop_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextMarginsTopProxyVtbl = 
{
    0,
    &IID_IXTextMarginsTop,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextMarginsTop_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextMarginsTopStubVtbl =
{
    &IID_IXTextMarginsTop,
    &IXTextMarginsTop_ServerInfo,
    7,
    &IXTextMarginsTop_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextMarginsRight, ver. 0.0,
   GUID={0xE859BDDB,0x6A9D,0x49BD,{0x8A,0xC3,0xED,0x07,0xC8,0x77,0xB1,0x7F}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextMarginsRight_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextMarginsRight_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextMarginsRight_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextMarginsRight_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextMarginsRight_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextMarginsRightProxyVtbl = 
{
    0,
    &IID_IXTextMarginsRight,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextMarginsRight_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextMarginsRightStubVtbl =
{
    &IID_IXTextMarginsRight,
    &IXTextMarginsRight_ServerInfo,
    7,
    &IXTextMarginsRight_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextMarginsBottom, ver. 0.0,
   GUID={0x2AE5A433,0x0395,0x4BD2,{0x9F,0xFC,0x7D,0xF4,0xF8,0xA7,0x18,0xE8}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextMarginsBottom_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextMarginsBottom_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextMarginsBottom_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextMarginsBottom_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextMarginsBottom_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextMarginsBottomProxyVtbl = 
{
    0,
    &IID_IXTextMarginsBottom,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextMarginsBottom_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextMarginsBottomStubVtbl =
{
    &IID_IXTextMarginsBottom,
    &IXTextMarginsBottom_ServerInfo,
    7,
    &IXTextMarginsBottom_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextStyle, ver. 0.0,
   GUID={0xCBC5492F,0xA705,0x4E1C,{0x8A,0x00,0x6D,0x09,0xB1,0x8A,0xD0,0xA1}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextStyle_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextStyle_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextStyle_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextStyle_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextStyle_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextStyleProxyVtbl = 
{
    0,
    &IID_IXTextStyle,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextStyle_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextStyleStubVtbl =
{
    &IID_IXTextStyle,
    &IXTextStyle_ServerInfo,
    7,
    &IXTextStyle_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXDrawBorder, ver. 0.0,
   GUID={0x88318CD8,0x9C62,0x4A58,{0xB3,0xBC,0x55,0x2E,0x5A,0x03,0x1D,0x34}} */

#pragma code_seg(".orpc")
static const unsigned short IXDrawBorder_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXDrawBorder_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXDrawBorder_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXDrawBorder_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXDrawBorder_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXDrawBorderProxyVtbl = 
{
    0,
    &IID_IXDrawBorder,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXDrawBorder_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXDrawBorderStubVtbl =
{
    &IID_IXDrawBorder,
    &IXDrawBorder_ServerInfo,
    7,
    &IXDrawBorder_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXFillCell, ver. 0.0,
   GUID={0x9DAC1423,0x4EF6,0x455B,{0xA6,0x54,0x1B,0x71,0xF0,0x40,0xF3,0xEB}} */

#pragma code_seg(".orpc")
static const unsigned short IXFillCell_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXFillCell_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXFillCell_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXFillCell_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXFillCell_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXFillCellProxyVtbl = 
{
    0,
    &IID_IXFillCell,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXFillCell_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXFillCellStubVtbl =
{
    &IID_IXFillCell,
    &IXFillCell_ServerInfo,
    7,
    &IXFillCell_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextFit, ver. 0.0,
   GUID={0x59A53735,0x45D6,0x4095,{0x8C,0x18,0xAC,0x92,0x2B,0x43,0x0F,0xDE}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextFit_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextFit_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextFit_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextFit_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextFit_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextFitProxyVtbl = 
{
    0,
    &IID_IXTextFit,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextFit_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextFitStubVtbl =
{
    &IID_IXTextFit,
    &IXTextFit_ServerInfo,
    7,
    &IXTextFit_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXTextType, ver. 0.0,
   GUID={0x258BC0F4,0xA118,0x48CD,{0x82,0x7D,0x25,0x10,0xFF,0xCC,0xA3,0xEC}} */

#pragma code_seg(".orpc")
static const unsigned short IXTextType_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXTextType_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextType_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXTextType_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXTextType_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXTextTypeProxyVtbl = 
{
    0,
    &IID_IXTextType,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXTextType_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXTextTypeStubVtbl =
{
    &IID_IXTextType,
    &IXTextType_ServerInfo,
    7,
    &IXTextType_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXStyleName, ver. 0.0,
   GUID={0x42DF7F0D,0x1F91,0x4371,{0x85,0xFD,0x00,0x25,0x29,0x0A,0x3F,0x92}} */

#pragma code_seg(".orpc")
static const unsigned short IXStyleName_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXStyleName_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXStyleName_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXStyleName_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXStyleName_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXStyleNameProxyVtbl = 
{
    0,
    &IID_IXStyleName,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXStyleName_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXStyleNameStubVtbl =
{
    &IID_IXStyleName,
    &IXStyleName_ServerInfo,
    7,
    &IXStyleName_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IXJustify, ver. 0.0,
   GUID={0x6FE44EEE,0x514F,0x44C5,{0xB7,0x49,0x4B,0x34,0x32,0x5F,0x40,0x07}} */

#pragma code_seg(".orpc")
static const unsigned short IXJustify_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0
    };

static const MIDL_STUBLESS_PROXY_INFO IXJustify_ProxyInfo =
    {
    &Object_StubDesc,
    Grid__MIDL_ProcFormatString.Format,
    &IXJustify_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO IXJustify_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    Grid__MIDL_ProcFormatString.Format,
    &IXJustify_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(7) _IXJustifyProxyVtbl = 
{
    0,
    &IID_IXJustify,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfoCount */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetTypeInfo */ ,
    0 /* (void *) (INT_PTR) -1 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */
};


static const PRPC_STUB_FUNCTION IXJustify_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION
};

CInterfaceStubVtbl _IXJustifyStubVtbl =
{
    &IID_IXJustify,
    &IXJustify_ServerInfo,
    7,
    &IXJustify_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};

static const MIDL_STUB_DESC Object_StubDesc = 
    {
    0,
    NdrOleAllocate,
    NdrOleFree,
    0,
    0,
    0,
    0,
    0,
    Grid__MIDL_TypeFormatString.Format,
    1, /* -error bounds_check flag */
    0x50002, /* Ndr library version */
    0,
    0x70001f4, /* MIDL Version 7.0.500 */
    0,
    0,
    0,  /* notify & notify_flag routine table */
    0x1, /* MIDL flag */
    0, /* cs routines */
    0,   /* proxy/server info */
    0
    };

const CInterfaceProxyVtbl * _Grid_ProxyVtblList[] = 
{
    ( CInterfaceProxyVtbl *) &_IXStyleNameProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextObliqueAngleProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextMarginsLeftProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextWidthFactorProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXDefaultSizeProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXCellTextProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXFillCellProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXRowCountProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextStyleProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextMarginsBottomProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextFitProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXColCountProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextHeightProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXDrawBorderProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextMarginsRightProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXJustifyProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextTypeProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IXTextMarginsTopProxyVtbl,
    0
};

const CInterfaceStubVtbl * _Grid_StubVtblList[] = 
{
    ( CInterfaceStubVtbl *) &_IXStyleNameStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextObliqueAngleStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextMarginsLeftStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextWidthFactorStubVtbl,
    ( CInterfaceStubVtbl *) &_IXDefaultSizeStubVtbl,
    ( CInterfaceStubVtbl *) &_IXCellTextStubVtbl,
    ( CInterfaceStubVtbl *) &_IXFillCellStubVtbl,
    ( CInterfaceStubVtbl *) &_IXRowCountStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextStyleStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextMarginsBottomStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextFitStubVtbl,
    ( CInterfaceStubVtbl *) &_IXColCountStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextHeightStubVtbl,
    ( CInterfaceStubVtbl *) &_IXDrawBorderStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextMarginsRightStubVtbl,
    ( CInterfaceStubVtbl *) &_IXJustifyStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextTypeStubVtbl,
    ( CInterfaceStubVtbl *) &_IXTextMarginsTopStubVtbl,
    0
};

PCInterfaceName const _Grid_InterfaceNamesList[] = 
{
    "IXStyleName",
    "IXTextObliqueAngle",
    "IXTextMarginsLeft",
    "IXTextWidthFactor",
    "IXDefaultSize",
    "IXCellText",
    "IXFillCell",
    "IXRowCount",
    "IXTextStyle",
    "IXTextMarginsBottom",
    "IXTextFit",
    "IXColCount",
    "IXTextHeight",
    "IXDrawBorder",
    "IXTextMarginsRight",
    "IXJustify",
    "IXTextType",
    "IXTextMarginsTop",
    0
};

const IID *  _Grid_BaseIIDList[] = 
{
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    0
};


#define _Grid_CHECK_IID(n)	IID_GENERIC_CHECK_IID( _Grid, pIID, n)

int __stdcall _Grid_IID_Lookup( const IID * pIID, int * pIndex )
{
    IID_BS_LOOKUP_SETUP

    IID_BS_LOOKUP_INITIAL_TEST( _Grid, 18, 16 )
    IID_BS_LOOKUP_NEXT_TEST( _Grid, 8 )
    IID_BS_LOOKUP_NEXT_TEST( _Grid, 4 )
    IID_BS_LOOKUP_NEXT_TEST( _Grid, 2 )
    IID_BS_LOOKUP_NEXT_TEST( _Grid, 1 )
    IID_BS_LOOKUP_RETURN_RESULT( _Grid, 18, *pIndex )
    
}

const ExtendedProxyFileInfo Grid_ProxyFileInfo = 
{
    (PCInterfaceProxyVtblList *) & _Grid_ProxyVtblList,
    (PCInterfaceStubVtblList *) & _Grid_StubVtblList,
    (const PCInterfaceName * ) & _Grid_InterfaceNamesList,
    (const IID ** ) & _Grid_BaseIIDList,
    & _Grid_IID_Lookup, 
    18,
    2,
    0, /* table of [async_uuid] interfaces */
    0, /* Filler1 */
    0, /* Filler2 */
    0  /* Filler3 */
};
#if _MSC_VER >= 1200
#pragma warning(pop)
#endif


#endif /* defined(_M_AMD64)*/

