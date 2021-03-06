#include "stdafx.h"
#include "vclImport.h"
#include "oarxExport.h"
#include "AlxdJig.h"
//#include "..\..\Greta\syntax2.h"
//#include "..\..\Greta\regexpr2.h"
//#include "regexpr2.h"
//#include "atlrx.h"
//namespace System;//.Text.RegularExpressions;
//using System;
//using System.Globalization;
//using System.Text.RegularExpressions;
//using namespace std;
//using namespace regex;

#include "regexpr2.h"

#ifdef _UNICODE
        #define tstring wstring
        #define tcout   wcout
#else
        #define tstring string
        #define tcout   cout
#endif

using namespace std;
using namespace regex;

const double DIVCONST = 0.017453292519943295769236907684886;
const ACHAR* gridXdata = _T("ALXD_GRID_DATA");
const ACHAR* columnXdata = _T("ALXD_GRID_COLUMN_DATA");
const ACHAR* rowXdata = _T("ALXD_GRID_ROW_DATA");
const ACHAR* cellXdata = _T("ALXD_GRID_CELL_DATA");
const ACHAR* fillXdata = _T("ALXD_GRID_FILL_DATA");
const ACHAR* verBorderXdata = _T("ALXD_GRID_VER_BORDER_DATA");
const ACHAR* horBorderXdata = _T("ALXD_GRID_HOR_BORDER_DATA");
const int CN_BASE = 0xBC00;

HWND hEditor;
AcDbBlockTableRecord* pBlockDef = NULL;
AlxdJigAttDefInfoArray attInfo;

//#ifdef _DEBUG
//#import "G:/Александр/Borland Studio Projects/AlxdGrid9/AlxdGrid.dll" no_namespace
#if !defined(_WIN64) && !defined (_AC64)
#import "C:/Users/Alxd/Documents/RAD Studio/Projects/AT8x/DLL/Win32/AlxdGrid.dll" no_namespace
//#import "C:/AT8x/AlxdGrid.dll" no_namespace
#else
#import "C:/Users/Alxd/Documents/RAD Studio/Projects/AT8x/DLL/x64/AlxdGrid.dll" no_namespace
#endif
//extern IAlxdApplicationPtr intalxdapp;
//static IAlxdApplicationPtr alxdapp(L"AlxdGrid.AlxdApplication");
//#import "AlxdGrid.dll" no_namespace
//#endif

#import "acax18enu.tlb" //namespace

int __cdecl acedEvaluateLisp(ACHAR const *, struct resbuf * &);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Common 2 common functions :)
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CALLBACK TimerProc(HWND hWnd, UINT nMsg, UINT_PTR nIDEvent, DWORD dwTime)
{
	//acutPrintf(_T("\nscreen update need"));
	SendMessage(hEditor, WM_USER + 0x7D0B, 0, 0);//WM_ALXD_SELECTIONREDRAW
	acedGetAcadFrame()->KillTimer(1000);
}

BOOL FirstFilterWinMsg(MSG* pMsg)
{
	if (pMsg->message == WM_LBUTTONDBLCLK)
	{
		DocVars.docData().thereAreDblClick = true;
	}
	return FALSE;
}

BOOL FilterWinMsg(MSG* pMsg)
{
	/*
	if (pMsg->message == WM_ENTERIDLE)
	{
		acutPrintf(_T("here"));
	}
	*/
	if (pMsg->message == WM_MOUSEWHEEL || pMsg->message == WM_VSCROLL || pMsg->message == WM_HSCROLL)
	{
		acedGetAcadFrame()->KillTimer(1000);
		acedGetAcadFrame()->SetTimer(1000, 100, TimerProc);
		return FALSE;
	}	

	if ((pMsg->message >= WM_KEYFIRST) && (pMsg->message <= WM_KEYLAST))
	{
		if (hEditor == ::GetActiveWindow())
		{			
			if (pMsg->message == WM_KEYDOWN)
			{
				//ESC				
				if (pMsg->wParam == 27)
				{					
					int r;
					r = SendMessage(hEditor, WM_USER + 0x7D06, 0, 0);//WM_ALXD_CLOSE
					if (r)
						SendMessage(hEditor, WM_CLOSE, 0, 0);
				}
			
				//Ctrl+Tab pressed
				if ((pMsg->wParam == 9) && (GetKeyState(VK_CONTROL) < 0))
				{					
					SendMessage(hEditor, WM_USER + 0x7D07, !(GetKeyState(VK_SHIFT) < 0), 0);//WM_ALXD_SWITCH_TAB
					return TRUE;
				}
			
			}
			

			HWND Wnd = GetCapture();
			
			if (!Wnd)
				Wnd = pMsg->hwnd;

			return SendMessage(Wnd, CN_BASE + pMsg->message, pMsg->wParam, pMsg->lParam);
		}
	}

	return FALSE;
}

void OnIdleWinMsg()
{
	SendMessage(hEditor, WM_USER + 0x7D05, 0, 0);//WM_ALXD_IDLE
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Common functions
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern "C" __declspec(dllexport) int oarxScreenToOCS(int pixel_x, int pixel_y, Adesk::IntDbId blkRefId, double* x, double* y)
{
	CPoint pt = CPoint(pixel_x, pixel_y);
	AcGePoint3d wcs_pt;
	acedCoordFromPixelToWorld(0, pt, asDblArray(wcs_pt));
	//acutPrintf(_T("\nWCS x: %f y: %f"), wcs_pt.x, wcs_pt.y);

	//CPoint invpt;
	//acedCoordFromWorldToPixel(0, asDblArray(wcs_pt), invpt);
	//acutPrintf(_T("\nINVPT x: %d y: %d"), invpt.x, invpt.y);

	AcDbObjectId refId;
	refId.setFromOldId(blkRefId);

	//open block reference
	AcDbBlockReference *pBlockRef = NULL;
	if (acdbOpenObject(pBlockRef, refId, AcDb::kForRead) != Acad::eOk)
	{
		if (pBlockRef)
			pBlockRef->close();
		return FALSE;
	}

	AcGeMatrix3d trns = pBlockRef->blockTransform();
	pBlockRef->close();

	trns.invert();
	AcGePoint3d ocs_pt = wcs_pt;
	ocs_pt.transformBy(trns);
	*x = ocs_pt.x;
	*y = ocs_pt.y;
	return TRUE;
}

extern "C" __declspec(dllexport) int oarxAcEdEvaluateLisp(const ACHAR* Text, VARIANT* pVarData, int* pResType)
{
	//acutPrintf(Text);
	//acutPrintf(_T("\nText=%p"), Text);
	int r;
	ACHAR *buf = NULL;
	acutUpdString(Text, buf);

	//acutPrintf(_T("\nText=%p"), Text);
	//acutPrintf(_T("\nbuf=%p"), buf);

	resbuf *rb = NULL;
	r = acedEvaluateLisp(buf, rb);
	*pResType = int(rb->restype);
	switch (rb->restype)
	{
	case RTREAL:	//5001
		::VariantCopy(pVarData, &_variant_t(rb->resval.rreal));
		break;
	case RTSHORT:	//5003
		::VariantCopy(pVarData, &_variant_t(rb->resval.rint));
		break;
	case RTSTR:		//5005
		::VariantCopy(pVarData, &_variant_t(rb->resval.rstring));
		break;
	default:
		::VariantCopy(pVarData, &_variant_t(""));
	}
	return r;
}

extern "C" __declspec(dllexport) int oarxAcEdGetFileNavDialog(const ACHAR * title, const ACHAR * def, const ACHAR * ext, const ACHAR * dlgname, int flags, ACHAR*& res)
{
	struct resbuf* result = NULL;//acutNewRb(RTSTR); no!!!
	int r = acedGetFileNavDialog(title, def, ext, dlgname, flags, &result);
	if (r == RTNORM)
	{
		vclImport::vclUpdString(result->resval.rstring, res);
		//resstr = strcpy(resstr, result->resval.rstring); 
		acutRelRb(result);
		//return status;
	}
	return r;
}

extern "C" __declspec(dllexport) int oarxAcDbRToS(double Value, ACHAR*& Text)
{
	int r;
	ACHAR buf[255];
	r = acdbRToS(Value, -1, -1, buf);
	vclImport::vclUpdString(buf, Text);
	return r;
}

extern "C" __declspec(dllexport) int oarxAcDbAngToS(double Value, ACHAR*& Text)
{
	int r;
	ACHAR buf[255];
	r = acdbAngToS(Value * DIVCONST, -1, -1, buf);
	vclImport::vclUpdString(buf, Text);
	return r;
}

extern "C" __declspec(dllexport) int oarxAcDbDisToF(const ACHAR* Text, double* Value)
{
	return acdbDisToF(Text, -1, Value);
}

extern "C" __declspec(dllexport) int oarxAcEdGetDist(const ACHAR* Prompt, double* Value)
{
	return acedGetDist(NULL, Prompt, Value);
}

extern "C" __declspec(dllexport) int oarxAcUtPrintf(const ACHAR* Prompt)
{
	return acutPrintf(Prompt);
}
extern "C" __declspec(dllexport) bool oarxValidLayerName(ACHAR*& pLayerName)
{	
	if (acdbSNValid(pLayerName, 0) != RTNORM)
	{
		vclImport::vclUpdString(_T("0"), pLayerName);
		return false;
	}

	AcDbLayerTable *pLayerTable = NULL;
	if (acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pLayerTable, AcDb::kForWrite) != Acad::eOk)
		return false;
	
	if (!pLayerTable->has(pLayerName))
	{
		AcDbLayerTableRecord *pRecord = new AcDbLayerTableRecord();
		pRecord->setName(pLayerName);
		pLayerTable->add(pRecord);
		pRecord->close();
		//delete pRecord;
	}

	pLayerTable->close();
	
	return true;
}

extern "C" __declspec(dllexport) bool oarxValidTextStyleName(ACHAR*& pStyleName, ACHAR*& pFontName, ACHAR*& pBigFontName, Adesk::IntDbId& id)
{
	//bool replaced = false;
	if (acdbSNValid(pStyleName, 0) != RTNORM)
	{
		MessageBox(0, _T("Text style name is not valid and replaced to 'Standard'!"), NULL, MB_ICONINFORMATION + MB_OK);
		vclImport::vclUpdString(_T("Standard"), pStyleName);
		//replaced = true;
	}

	AcDbTextStyleTable *pStyleTable = NULL;
	Acad::ErrorStatus ret;
	ret = acDocManager->lockDocument(acDocManager->curDocument(), AcAp::kAutoWrite); //good
	if (ret != Acad::eOk)
		return false;

	ret = acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pStyleTable, AcDb::kForRead/*AcDb::kForWrite*/);
	if (ret != Acad::eOk)
		return false;

	/*
	if (ret != Acad::eOk)
	{
		if (pStyleTable)
			pStyleTable->close();
		//return false;
		//replaced = true;

		ret = acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pStyleTable, AcDb::kForRead);
		if (ret != Acad::eOk)
		{
			if (pStyleTable)
				pStyleTable->close();
			return false;
		}
	}
	else
		replaced = true;
		*/

	AcDbObjectId objId;
	if (!pStyleTable->has(pStyleName))
	{
		pStyleTable->upgradeOpen();

		AcDbTextStyleTableRecord *pStyleTableRecord = new AcDbTextStyleTableRecord;
		pStyleTableRecord->setName(pStyleName);
		if (pFontName == NULL)
			vclImport::vclUpdString(_T("txt.shx"), pFontName);
		pStyleTableRecord->setFileName(pFontName);
		pStyleTableRecord->setBigFontFileName(pBigFontName);
		pStyleTable->add(objId, pStyleTableRecord);
		pStyleTableRecord->close();

		pStyleTable->downgradeOpen();
		//delete pStyleTableRecord;
	}
	else
	{
		AcDbTextStyleTableRecord *pStyleTableRecord;
		pStyleTable->getAt(pStyleName, pStyleTableRecord, /*replaced ?*/ /*AcDb::kForWrite*/ AcDb::kForRead);

		ACHAR* name;
		pStyleTableRecord->fileName(name);
		//if (name && pFontName && (_tcsicmp(name, pFontName) != 0))
			/*&& !replaced /*&&
			::MessageBox(0, _T("Text style font file name is differ from grid style value. Replace value in text style?"), NULL, MB_ICONQUESTION + MB_YESNO) == IDYES*/
		//	pStyleTableRecord->setFileName(pFontName);
		//else
		vclImport::vclUpdString(name, pFontName);

		pStyleTableRecord->bigFontFileName(name);
		//if (name && pBigFontName && (_tcsicmp(name, pBigFontName) != 0))
			/*&& !replaced &&
			::MessageBox(0, _T("Text style big font file name is differ from grid style value. Replace value in text style?"), NULL, MB_ICONQUESTION + MB_YESNO) == IDYES*/
		//	pStyleTableRecord->setBigFontFileName(pBigFontName);
		//else
		vclImport::vclUpdString(name, pBigFontName);

		objId = pStyleTableRecord->objectId();

		pStyleTableRecord->close();
	}
	id = objId.asOldId();

	pStyleTable->close();

	return true;
}

extern "C" __declspec(dllexport) bool oarxSaveLayersLock(PAlxdSpreadSheetStyleExchange value, PWasLocked locked)
{
	AcDbLayerTable* pLayerTable = NULL;
	if (acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pLayerTable, AcDb::kForRead) != Acad::eOk)
		return false;

	AcDbLayerTableRecord *pRecord = NULL;

	if (value->TextLayer)
	{
		//Acad::ErrorStatus r;
		//r = pLayerTable->getAt(value->TextLayer, pRecord, AcDb::kForWrite);
		if (pLayerTable->getAt(value->TextLayer, pRecord, AcDb::kForWrite) != Acad::eOk)
		//if (r != Acad::eOk)
		{
			pLayerTable->close();
			return false;
		}

		locked->TextLayer = pRecord->isLocked();
		if (locked->TextLayer)
			pRecord->setIsLocked(false);
		pRecord->close();
	}

	if (value->VerBorderLayer)
	{
		if (pLayerTable->getAt(value->VerBorderLayer, pRecord, AcDb::kForWrite) != Acad::eOk)
		{
			pLayerTable->close();
			return false;
		}

		locked->VerBorderLayer = pRecord->isLocked();
		if (locked->VerBorderLayer)
			pRecord->setIsLocked(false);
		pRecord->close();
	}

	if (value->HorBorderLayer)
	{
		if (pLayerTable->getAt(value->HorBorderLayer, pRecord, AcDb::kForWrite) != Acad::eOk)
		{
			pLayerTable->close();
			return false;
		}

		locked->HorBorderLayer = pRecord->isLocked();
		if (locked->HorBorderLayer)
			pRecord->setIsLocked(false);
		pRecord->close();
	}

	pLayerTable->close();

	return true;
}

extern "C" __declspec(dllexport) bool oarxLoadLayersLock(PAlxdSpreadSheetStyleExchange value, PWasLocked locked)
{
	AcDbLayerTable* pLayerTable = NULL;
	if (acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pLayerTable, AcDb::kForRead) != Acad::eOk)
		return false;

	AcDbLayerTableRecord *pRecord = NULL;

	if (locked->TextLayer)
		if (pLayerTable->getAt(value->TextLayer, pRecord, AcDb::kForWrite) == Acad::eOk)
		{
			pRecord->setIsLocked(true);
			pRecord->close();
		}

	if (locked->VerBorderLayer)
		if (pLayerTable->getAt(value->VerBorderLayer, pRecord, AcDb::kForWrite) == Acad::eOk)
		{
			pRecord->setIsLocked(true);
			pRecord->close();
		}

	if (locked->HorBorderLayer)
		if (pLayerTable->getAt(value->HorBorderLayer, pRecord, AcDb::kForWrite) == Acad::eOk)
		{
			pRecord->setIsLocked(true);
			pRecord->close();
		}

	pLayerTable->close();

	return true;
}

extern "C" __declspec(dllexport) bool oarxId2Handle(Adesk::IntDbId id, ACHAR*& Text)
{
	AcDbObjectId objId;
	objId.setFromOldId(id);
	bool r = objId.isValid();

	if (r)
	{
		ACHAR buf[255];
		objId.handle().getIntoAsciiBuffer(buf);
		vclImport::vclUpdString(buf, Text);
	}
	return r;
}

bool funclist(ACHAR* cmdPrefix, AcString* value)
//int srv_LookUpSupportedFunc(AcArray<const char*> & functionKWord)
{
	ACHAR docgroupname[40];
	//*DOC(0x000000002484f960)
	//*DOC(0x0a675060)

#if !defined(_WIN64) && !defined (_AC64)
	_stprintf(docgroupname, _T("*DOC(0x%.8x)"), (long)acDocManager->curDocument());
#else
	_stprintf(docgroupname, _T("*DOC(0x%.16x)"), (long)acDocManager->curDocument());
#endif

#ifdef _DEBUG
	acutPrintf(docgroupname);
#endif

	AcEdCommandStack* pCommandStack = acedRegCmds;
	AcEdCommandIterator* pCommandIterator = pCommandStack->iterator();
	if (!pCommandIterator)
		return false;

	while (!pCommandIterator->done())
	{
		const ACHAR* groupname = pCommandIterator->commandGroup();
		if (acutWcMatchEx(docgroupname, groupname, true))
		{
			const ACHAR* funcname = pCommandIterator->command()->globalName();
			//acutPrintf(funcname);
			//const ACHAR* funcname2 = pCommandIterator->command()->localName();

			if (acutWcMatchEx(funcname, cmdPrefix, true))
			{
				//ACHAR *buf;
				//acutUpdString(funcname, buf);

				resbuf *rb = NULL;
				//int r = acedEvaluateLisp(buf, rb);
				//int r = acedEvaluateLisp(_T("(c:atimportat6)"), rb);
				//int r = acedEvaluateLisp(funcname, rb);
				ACHAR buf[250];
				_stprintf(buf, _T("(%s)"), funcname);
				int r = acedEvaluateLisp(buf, rb);

				//SAFEARRAYBOUND rgsaBound;
				//rgsaBound.lLbound = 0L;
				//rgsaBound.cElements = 3;
				//SAFEARRAY* pValues = NULL;
				//pValues = SafeArrayCreate(VT_BSTR, 1, &rgsaBound);

				//long i;
				//ACHAR docgroupname[1024] = "%s;%s%;s";
				//AcString v = *value;
				if (rb->restype == RTSTR)
				{
					*value += "(";
					*value += rb->resval.rstring;
					rb = rb->rbnext;
				}
				else
					continue;

				if (rb->restype == RTSTR)
				{
					*value += ";";
					*value += rb->resval.rstring;
					rb = rb->rbnext;
				}
				else
					continue;

				if (rb->restype == RTSTR)
				{
					*value += _T(";");
					*value += rb->resval.rstring;
					*value += _T(")");
					rb = rb->rbnext;
				}
				else
					continue;

				
				//::VariantCopy(pValue, &_variant_t(v.kACharPtr()));
			}
		}

		pCommandIterator->next();
	}

	delete pCommandIterator;
	
	return true;
	/*int sumlen = 0;
	char docgroupname[40];
	sprintf(docgroupname, "*DOC(0x%.8x)", (long)acDocManager->curDocument());

    AcEdCommandStack* pCommandStack = acedRegCmds;

	AcEdCommandIterator* pCommandIterator = pCommandStack->iterator();
	if (pCommandIterator)
	{
		while (!pCommandIterator->done())
		{
			if (acutWcMatchEx(docgroupname, pCommandIterator->commandGroup(), true))
			{
				const char* funcname = pCommandIterator->command()->globalName();

				if (acutWcMatchEx(funcname, COMMAND_PREFIX, true))
				{
					functionKWord.append(funcname + strlen(COMMAND_PREFIX) - 1);
					sumlen += acutXStrLength(functionKWord.last());
				}
			}
			pCommandIterator->next();
		}

		delete pCommandIterator;
	}

	//sort AcArray
	bool sorted=false;
    while (!sorted)
	{
		sorted=true;
		for (int i = 1; i < functionKWord.length(); i++)
		{
			const char* t1 = functionKWord.at(i-1);
			const char* t2 = functionKWord.at(i);

			if (strcmp(t1, t2) > 0)
			{
				functionKWord.swap(i-1, i);
				sorted=false;
			}
		}
	}

	//delete pCommandStack;//no!!!
	return sumlen;
	*/
	return true;
}

extern "C" __declspec(dllexport) bool oarxImportFuncList(ACHAR*& value)
{
	bool ret;
	AcString v;
	ret = funclist(_T("c:atExchange*"), &v);
	vclImport::vclUpdString(v.kACharPtr(), value);

	return ret;
}


////////////////////////////////////////////////////////////////////
//
// Combo Box list utility functions
//
////////////////////////////////////////////////////////////////////

extern "C" __declspec(dllexport) void oarxGetTextStyles(HWND handle)
{
	AcDbTextStyleTable *pTextStyleTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pTextStyleTable, AcDb::kForRead);

	AcDbTextStyleTableIterator *pItr;
	if (pTextStyleTable->newIterator(pItr) == Acad::eOk) 
	{
		AcDbTextStyleTableRecord *pRecord = NULL;

		while (!pItr->done())
		{
			if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
			{
				const ACHAR *pName;
				pRecord->getName(pName);
				::SendMessage(handle, CB_ADDSTRING, 0, (long)pName);
				pRecord->close();
			}	 
			pItr->step();
		}
	}//if 
	delete pItr;
	pTextStyleTable->close();
}

extern "C" __declspec(dllexport) void oarxGetLayers(HWND handle)
{
	AcDbLayerTable *pLayerTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pLayerTable, AcDb::kForRead);

	AcDbLayerTableIterator *pItr;
	if (pLayerTable->newIterator(pItr) == Acad::eOk) 
	{
		AcDbLayerTableRecord *pRecord = NULL;

		while (!pItr->done())
		{
			if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
			{
				const ACHAR *pName;
				pRecord->getName(pName);
				::SendMessage(handle, CB_ADDSTRING, 0, (long)pName);
				pRecord->close();
			}	 
			pItr->step();
		}
	}//if 
	delete pItr;
	pLayerTable->close();
}

extern "C" __declspec(dllexport) void oarxGetLinetypes(HWND handle)
{
	AcDbLinetypeTable *pLinetypeTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pLinetypeTable, AcDb::kForRead);

	AcDbLinetypeTableIterator *pItr;
	if (pLinetypeTable->newIterator(pItr) == Acad::eOk) 
	{
		AcDbLinetypeTableRecord *pRecord = NULL;

		while (!pItr->done())
		{
			if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
			{
				const ACHAR *pName;
				pRecord->getName(pName);
				::SendMessage(handle, CB_ADDSTRING, 0, (long)pName);
				pRecord->close();
			}	 
			pItr->step();
		}
	}//if 
	delete pItr;
	pLinetypeTable->close();
}

extern "C" __declspec(dllexport) void oarxGetBlocks(HWND handle)
{
	AcDbBlockTable *pBlockTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pBlockTable, AcDb::kForRead);

	AcDbBlockTableIterator *pItr;
	if (pBlockTable->newIterator(pItr) == Acad::eOk) 
	{
		AcDbBlockTableRecord *pRecord = NULL;

		while (!pItr->done())
		{
			if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
			{
				if (!(pRecord->isLayout() ||
					  pRecord->isAnonymous() ||
					  pRecord->isFromOverlayReference() ||
					  pRecord->isFromExternalReference()))
				{
					const ACHAR *pName;
					pRecord->getName(pName);
					::SendMessage(handle, CB_ADDSTRING, 0, (long)pName);
				}
				pRecord->close();
			}	 
			pItr->step();
		}
		delete pItr;
	}//if 
	pBlockTable->close();
}


extern "C" __declspec(dllexport) Adesk::IntDbId oarxGetTextStyleId(ACHAR* pStyleName)
{
	AcDbTextStyleTable *pTextStyleTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pTextStyleTable, AcDb::kForRead);

	if (!pTextStyleTable->has(pStyleName))
	{
		pTextStyleTable->close();
		return 0;
	}

	AcDbTextStyleTableRecord *pTextStyleTableRecord;
	if (pTextStyleTable->getAt(pStyleName, pTextStyleTableRecord, AcDb::kForRead) != Acad::eOk)
	{
		if (pTextStyleTableRecord)
			pTextStyleTableRecord->close();

		pTextStyleTable->close();

		return 0;
	}

	AcDbObjectId objId;
	objId = pTextStyleTableRecord->objectId();

	pTextStyleTableRecord->close();
	pTextStyleTable->close();

	return objId.asOldId();
}

extern "C" __declspec(dllexport) void oarxGetTextStyleName(Adesk::IntDbId oldId, ACHAR*& pTextStyleName)
{
	AcDbObjectId objId;
	objId.setFromOldId(oldId);

	if (!objId.isValid())
	{
		vclImport::vclUpdString(_T("Not valid"), pTextStyleName);
		return;// false;
	}

	AcDbTextStyleTableRecord *pTextStyleTableRecord;
	if (acdbOpenObject(pTextStyleTableRecord, objId, AcDb::kForRead) == Acad::eOk)
	{
		const ACHAR* name;
		pTextStyleTableRecord->getName(name);
		vclImport::vclUpdString(name, pTextStyleName);
		
		pTextStyleTableRecord->close();	
	}

	//return true;
}

extern "C" __declspec(dllexport) void oarxGetTextStyleProperties(Adesk::IntDbId oldId, double& dHeight, double& dWidthFactor, double& dOblique, bool& v)
{
	AcDbObjectId objId;
	objId.setFromOldId(oldId);

	if (!objId.isValid())
		return;

	AcDbTextStyleTableRecord *pTextStyleTableRecord;
	if (acdbOpenObject(pTextStyleTableRecord, objId, AcDb::kForRead) == Acad::eOk)
	{
		dHeight = pTextStyleTableRecord->textSize();
		dWidthFactor = pTextStyleTableRecord->xScale();
		dOblique = pTextStyleTableRecord->obliquingAngle();
		v = (pTextStyleTableRecord->isVertical() == Adesk::kTrue);

		pTextStyleTableRecord->close();	
	}
}

extern "C" __declspec(dllexport) void oarxRegisterOnIdleWinMsg()
{
	acedRegisterOnIdleWinMsg(&OnIdleWinMsg);
}
extern "C" __declspec(dllexport) void oarxRemoveOnIdleWinMsg()
{
	acedRemoveOnIdleWinMsg(&OnIdleWinMsg);
}
extern "C" __declspec(dllexport) void oarxRegisterWinMsg(HWND h)
{
	hEditor = h;
	acedRemoveFilterWinMsg(&FirstFilterWinMsg);
	acedRegisterFilterWinMsg(&FilterWinMsg);
}

extern "C" __declspec(dllexport) void oarxRemoveWinMsg()
{
	acedRemoveFilterWinMsg(&FilterWinMsg);
	acedRegisterFilterWinMsg(&FirstFilterWinMsg);
	hEditor = 0;
}

extern "C" __declspec(dllexport) void oarxDisableDocumentActivation()
{
	acDocManager->disableDocumentActivation();
}

extern "C" __declspec(dllexport) void oarxEnableDocumentActivation()
{
	acDocManager->enableDocumentActivation();
	acedRedraw(NULL, 1);
}


extern "C" __declspec(dllexport) void oarxSendStringToExecute(const ACHAR* pszExecute, bool bActivate, bool bWrapUpInactiveDoc, bool bEchoString)
{
	acDocManager->sendStringToExecute(acDocManager->curDocument(), pszExecute, bActivate, bWrapUpInactiveDoc, bEchoString);
}

////////////////////////////////////////////////////////////////////
//
// Color Combo Box functions
//
////////////////////////////////////////////////////////////////////

class  CAlxdAcUiColorComboBox : public CAcUiColorComboBox {
public:
	BOOL OnDropDown()	{	return CAcUiColorComboBox::OnDropDown(); }
	BOOL OnCloseUp()	{	return CAcUiColorComboBox::OnCloseUp();	}
	BOOL OnSelectOther(BOOL isOther2, int curSel, int& newSel)
	{
		return CAcUiColorComboBox::OnSelectOther(isOther2, isOther2, newSel); 
	}
};
CAlxdAcUiColorComboBox *dummyColorCombo;

extern "C" __declspec(dllexport) int oarxAttachColorCombo(HWND hWnd)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpAttachColorCombo"));
#endif
	if (dummyColorCombo->GetSafeHwnd() == NULL)
	{
		dummyColorCombo->SubclassWindow(hWnd);
		dummyColorCombo->UpdateData(FALSE); 
	}
	return 0;
}

extern "C" __declspec(dllexport) int oarxAddColorToColorCombo(int colorIndex)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpAddColorToColorCombo"));
#endif
	return dummyColorCombo->AddColorToMRU(colorIndex);
}

extern "C" __declspec(dllexport) int oarxInsertColorItemInList(int index, ACHAR* name, int cargo)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpInsertColorItemInList"));
#endif
	//ACHAR* nameInt = NULL;
	//acutUpdString(name, nameInt);
	//return dummyColorCombo->InsertItemInList(index, (LPCTSTR)nameInt, cargo);
	return dummyColorCombo->InsertItemInList(index, (LPCTSTR)name, cargo);
}

extern "C" __declspec(dllexport) int oarxOnColorComboDrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpOnColorComboDrawItem"));
#endif
	dummyColorCombo->DrawItem(lpDrawItemStruct);
	return 0;
}

extern "C" __declspec(dllexport) int oarxOnColorComboDropDown()
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpOnColorComboDropDown"));
#endif
	dummyColorCombo->OnDropDown();
	return 0;
}

extern "C" __declspec(dllexport) int oarxOnColorComboCloseUp()
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpOnColorComboCloseUp"));
#endif
	dummyColorCombo->OnCloseUp();
	return 0;
}

extern "C" __declspec(dllexport) int oarxOnColorComboSelectOther(BOOL isOther2, int curSel, int& newSel)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpOnColorComboSelectOther"));
#endif
	return dummyColorCombo->OnSelectOther(isOther2, curSel, newSel);
}

extern "C" __declspec(dllexport) void oarxSetUseByBlock(BOOL use)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpSetUseByBlock"));
#endif
	dummyColorCombo->SetUseByBlock(use);
}

extern "C" __declspec(dllexport) void oarxSetUseByLayer(BOOL use)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpSetUseByLayer"));
#endif
	dummyColorCombo->SetUseByLayer(use);
}

extern "C" __declspec(dllexport) int oarxDetachColorCombo()
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpDetachColorCombo"));
#endif
	if (dummyColorCombo->GetSafeHwnd() != NULL)
		dummyColorCombo->UnsubclassWindow();
	return 0;
}

////////////////////////////////////////////////////////////////////
//
// Lineweight Combo Box functions
//
////////////////////////////////////////////////////////////////////

class  CAlxdAcUiLineWeightComboBox : public CAcUiLineWeightComboBox {
public:
	BOOL OnDropDown()	{	return CAcUiLineWeightComboBox::OnDropDown(); }
};
CAlxdAcUiLineWeightComboBox *dummyLineWeightCombo;

extern "C" __declspec(dllexport) int oarxAttachLineWeightCombo(HWND hWnd)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpAttachLineWeightCombo"));
#endif
	if (dummyLineWeightCombo->GetSafeHwnd() == NULL)
	{
		dummyLineWeightCombo->SubclassWindow(hWnd);
		dummyLineWeightCombo->UpdateData(FALSE); 
	}
	return 0;
}

extern "C" __declspec(dllexport) int oarxInsertLineWeightItemInList(int index, ACHAR* name, int cargo)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpInsertLineWeightItemInList"));
#endif
	return dummyLineWeightCombo->InsertItemInList(index, (LPCTSTR)name, cargo);
}

extern "C" __declspec(dllexport) int oarxFindItemByLineWeight(int LineWeightIndex)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpFindItemByLineWeight"));
#endif
	int ret = dummyLineWeightCombo->FindItemByLineWeight(LineWeightIndex);
	return ret;
}

extern "C" __declspec(dllexport) int oarxGetCurrentItemLineWeight()
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpGetCurrentItemLineWeight"));
#endif
	int ret = dummyLineWeightCombo->GetCurrentItemLineWeight();
	return ret;
}

extern "C" __declspec(dllexport) int oarxGetItemLineWeight(int item)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpGetItemLineWeight"));
#endif
	int ret = dummyLineWeightCombo->GetItemLineWeight(item);
	return ret;
}

extern "C" __declspec(dllexport) int oarxOnLineWeightComboDrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct)
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpOnLineWeightComboDrawItem"));
#endif
	dummyLineWeightCombo->DrawItem(lpDrawItemStruct);
	return 0;
}

extern "C" __declspec(dllexport) int oarxOnLineWeightComboDropDown()
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpOnLineWeightComboDropDown"));
#endif
	dummyLineWeightCombo->OnDropDown();
	return 0;
}

extern "C" __declspec(dllexport) int oarxDetachLineWeightCombo()
{
#ifdef _DEBUG
	OutputDebugString(_T("\nexpDetachLineWeightCombo"));
#endif
	if (dummyLineWeightCombo->GetSafeHwnd() != NULL)
		dummyLineWeightCombo->UnsubclassWindow();
	return 0;
}

//common
void InitAcUiComboBoxs()
//extern "C" __declspec(dllexport) void expInitAcUiComboBoxs()
{
	dummyColorCombo = new CAlxdAcUiColorComboBox();
	dummyColorCombo->SetUseByBlock(true);
	dummyColorCombo->SetUseByLayer(true);
	//dummyColorCombo->SetUseOther1(true);

	dummyLineWeightCombo = new CAlxdAcUiLineWeightComboBox();
	//dummyLineWeightCombo->SetUseDefault(true);
//	dummyLineWeightCombo
}

void FreeAcUiComboBoxs()
//extern "C" __declspec(dllexport) void expFreeAcUiComboBoxs()
{
	delete dummyLineWeightCombo;
	delete dummyColorCombo;
}

////////////////////////////////////////////////////////////////////
//
// Dialog functions
//
////////////////////////////////////////////////////////////////////

extern "C" __declspec(dllexport) bool oarxAcEdSetColorDialog(int& nColor, bool bAllowMetaColor, int nCurLayerColor)
{	 
	return acedSetColorDialog(nColor, bAllowMetaColor, nCurLayerColor) == 0 ? false : true;
}

extern "C" __declspec(dllexport) int oarxAcEdGetRGB(int nColor)
{
	return acedGetRGB(nColor);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Block Utilities
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int EraseAttDef(AcDbBlockTableRecord* pBlockDef)
{
	//delete all AttributeDefinition in pBlockDef
	//pBlockDef must be opened for write
	AcDbEntity *pEnt = NULL;
	AcDbBlockTableRecordIterator *pIterator = NULL;

	pBlockDef->newIterator(pIterator);
	if (pIterator == NULL)
		return RTERROR;

	for (pIterator->start(); !pIterator->done(); pIterator->step())
	{
		if (pIterator->getEntity(pEnt, AcDb::kForWrite) == Acad::eOk)
		{
			if (pEnt->isKindOf(AcDbAttributeDefinition::desc()))
				pEnt->erase();
			pEnt->close();
		}
	}

	delete pIterator;

	return RTNORM;
}

int EraseAttRef(AcDbBlockReference *pBlockRef)
{
	//delete all AttributeReference in BlockReference (refId)
	//pBlockRef mut be opened for write
	/*
	AcDbObjectId refId;
	refId.setFromOldId(id);

	AcDbBlockReference *pBlockRef = NULL;

	if (acdbOpenObject(pBlockRef, refId, AcDb::kForWrite) != Acad::eOk)
		return RTERROR;
	*/
	AcDbObjectId objId;
	AcDbObjectIterator *pObjectIterator = NULL;

	pObjectIterator = pBlockRef->attributeIterator();
	if (pObjectIterator == NULL)
		return RTERROR;
	
	AcDbEntity *pEnt = NULL;
	while (!pObjectIterator->done())
	{
		objId = pObjectIterator->objectId();
		if (acdbOpenAcDbEntity(pEnt, objId, AcDb::kForWrite) == Acad::eOk)
		{
			pEnt->erase();
			pEnt->close();
		}
		pObjectIterator->step();
	}

	delete pObjectIterator;

	//pBlockRef->close();

	return RTNORM;
}

int DrawBlock(ACHAR* BlockName, const AcGePoint3d pt, const AcGePoint3d scale, double rotation, AcDbObjectId& objId)
{
	if (pBlockDef == NULL)
		return RTERROR;

	bool founded = false;
	ACHAR tmpBlockName[512];

	//check block name in database
	AcDbBlockTable *pBlockTable = NULL;
	if (acdbHostApplicationServices()->workingDatabase()->getBlockTable(pBlockTable, AcDb::kForRead) != Acad::eOk)
		return RTERROR;

	if (pBlockTable->has(BlockName))
	{
		_tcscpy(tmpBlockName, BlockName);
		founded = true;
	}
	pBlockTable->close();

	//check block name in disk
	if (!founded)
	{	    
		if (acedFindFile(BlockName, tmpBlockName) == RTNORM)
			founded = true;
	}

	if (founded)
	{
		AcDbObjectId defId = pBlockDef->id();
		pBlockDef->close();

		AutoCAD::IAcadApplicationPtr acadapp(acedGetAcadWinApp()->GetIDispatch(true));
		AutoCAD::IAcadDocumentPtr adoc = acadapp->ActiveDocument;
		AutoCAD::IAcadBlocksPtr ablocks = adoc->Blocks;
		AutoCAD::IAcadBlockPtr ablock = adoc->ObjectIdToObject(defId.asOldId());

		AcAxPoint3d vpt = pt;
		AutoCAD::IAcadBlockReferencePtr ablockref = ablock->InsertBlock(vpt.asVariantPtr(), tmpBlockName, scale[0], scale[1], scale[2], rotation);
		objId.setFromOldId(ablockref->ObjectID);

		if (acdbOpenObject(pBlockDef, defId, AcDb::kForWrite) != Acad::eOk)
			return RTERROR;
	}
	else
		return RTERROR;

	return RTNORM;
}

int DrawBlockAttDef(AcDbBlockTableRecord* pBlockDef, AcDbObjectId intBlockDefId)
{
	AcDbBlockTableRecord *pIntBlockDef = NULL;

	if (acdbOpenObject(pIntBlockDef, intBlockDefId, AcDb::kForRead) != Acad::eOk)
	{
		if (pIntBlockDef)
			pIntBlockDef->close();
		return RTERROR;
	}

	AcGePoint3d basePoint;
	AcDbEntity *pEnt;
	AcDbAttributeDefinition *pAttDef;
	AcDbBlockTableRecordIterator *pIterator;

	pIntBlockDef->newIterator(pIterator);
	pIntBlockDef->close();

	for (pIterator->start(); !pIterator->done(); pIterator->step())
	{
		pIterator->getEntity(pEnt, AcDb::kForRead);

		pAttDef = AcDbAttributeDefinition::cast(pEnt);
		if (pAttDef != NULL && !pAttDef->isConstant())
		{
			AcDbAttributeDefinition *pNewAttDef = AcDbAttributeDefinition::cast(pAttDef->clone());
			pAttDef->close();

			pBlockDef->appendAcDbEntity(pNewAttDef);
			pNewAttDef->close();
		}
	}
	delete pIterator;

	return RTNORM;
}

int DrawBlockAttRef(AcDbBlockTableRecord* pBlockDef, AcDbBlockReference *pBlockRef)
{
	AcGePoint3d basePoint;
	AcDbEntity *pEnt;
	AcDbAttributeDefinition *pAttDef;
	AcDbBlockTableRecordIterator *pIterator;
	Acad::ErrorStatus res;

	AlxdJigAttDefInfo ai;
	attInfo.removeAll();

	pBlockDef->newIterator(pIterator);

	for (pIterator->start(); !pIterator->done(); pIterator->step())
	{
		pIterator->getEntity(pEnt, AcDb::kForRead);

		pAttDef = AcDbAttributeDefinition::cast(pEnt);
		if (pAttDef != NULL && !pAttDef->isConstant())
		{
			AcDbAttribute *pAtt = new AcDbAttribute();
			pAtt->setPropertiesFrom(pAttDef);
			//pAtt->setInvisible(pAttDef->isInvisible());
			pAtt->setAttributeFromBlock(pAttDef, pBlockRef->blockTransform());
			
			basePoint = pAtt->position();
			basePoint -= pBlockDef->origin().asVector();
			pAtt->setPosition(basePoint);

			basePoint = pAtt->alignmentPoint();
			basePoint -= pBlockDef->origin().asVector();
			pAtt->setAlignmentPoint(basePoint);

			res = pBlockRef->appendAttribute(pAtt);
			//res = actrTransactionManager->addNewlyCreatedDBRObject(pAtt, true);

			//acutUpdString(pAttDef->tag(), ai.tag);
			ai.tag = pAttDef->tagConst();
			ai.pos = pAttDef->position();
			ai.aln = pAttDef->alignmentPoint();
			attInfo.append(ai);

			pAtt->close();
		}
		pEnt->close();
	}
	delete pIterator;

	return RTNORM;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Borders Exports & internal functions
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool ParseBordersList(struct resbuf * value, long obj, TAlxdBorderExchangeFunc func, int AColCount, int ARowCount, char AType)
{
	struct resbuf* pTemp = value;
	PAlxdBorderExchange AlxdBorderExchange = NULL;
	int i;
	int j;
	bool canparse;

	while (pTemp != NULL)
	{
		if (pTemp->restype == 10)
		{
			i = (int)pTemp->resval.rpoint[0];
			j = (int)pTemp->resval.rpoint[1];

			if ((i < 0) || (i > AColCount))
				return false;

			if ((j < 0) || (j > ARowCount))
				return false;

			canparse = false;
			if (AType == 0)//ver borders
				if (j < ARowCount)
				{
					AlxdBorderExchange = func(obj, i, j);
					canparse = true;
				};

			if (AType == 1)//hor borders
				if (i < AColCount)
				{
					AlxdBorderExchange = func(obj, i, j);
					canparse = true;
				};
		}

		if (canparse)
		{
			switch (pTemp->restype)
			{
			case 10:
				AlxdBorderExchange->State = (int)pTemp->resval.rpoint[2];
				break;
			case 60:
				AlxdBorderExchange->Color = pTemp->resval.rint;
				break;
			case 65:
				AlxdBorderExchange->Weight = pTemp->resval.rint;
				break;

			case 6:
				vclImport::vclUpdString(pTemp->resval.rstring, AlxdBorderExchange->Layer);
				break;
			}//switch
		}//if

		pTemp = pTemp->rbnext;
	}//while

	return true;
}

bool BuildBordersList(struct resbuf ** value, long obj, TAlxdBorderExchangeFunc func, int AColCount, int ARowCount, char AType)
{
	struct resbuf* pLast = NULL;
	PAlxdBorderExchange AlxdBorderExchange = NULL;
		//= func(obj, 0, 0);
	//p->Color
	bool canbuild;
	for (int i = 0; i <= AColCount; i++)
		for (int j = 0; j <= ARowCount; j++)
		{
			canbuild = false;
			if (AType == 0)//ver borders
				if (j < ARowCount)
				{
					AlxdBorderExchange = func(obj, i, j);
					canbuild = true;
				};

			if (AType == 1)//hor borders
				if (i < AColCount)
				{
					AlxdBorderExchange = func(obj, i, j);
					canbuild = true;
				};

			if (canbuild)
			{
				if (!i && !j)
				{
					*value = acutNewRb(10);
					pLast = *value;
				}
				else
				{
					pLast->rbnext = acutNewRb(10);
					pLast = pLast->rbnext;
				}

				pLast->resval.rpoint[0] = i;
				pLast->resval.rpoint[1] = j;
				pLast->resval.rpoint[2] = AlxdBorderExchange->State;

				//(60 . Border.Color)
				pLast->rbnext = acutNewRb(60);
				pLast = pLast->rbnext;
				pLast->resval.rint = AlxdBorderExchange->Color;

				//(65 . Border.Weight)
				pLast->rbnext = acutNewRb(65);
				pLast = pLast->rbnext;
				pLast->resval.rint = AlxdBorderExchange->Weight;

				//(6 . TextProperty.Layer)
				if (AlxdBorderExchange->Layer)
				{
					pLast->rbnext = acutNewRb(6);
					pLast = pLast->rbnext;
					acutUpdString(AlxdBorderExchange->Layer, pLast->resval.rstring);
					//alxdUpdString(CellProperty->TextProperty.Formula, pLast->resval.rstring);
				}

			}
		}//fors

	return true;
}

extern "C" __declspec(dllexport) bool oarxReadBordersList(long obj, TAlxdBorderExchangeFunc func, Adesk::IntDbId dict, int AColCount, int ARowCount, char AType)
{
	AcDbObjectId dictId;
	dictId.setFromOldId(dict);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForRead);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;

	if (pDict->getAt(AType == 0 ? verBorderXdata : horBorderXdata, xrecObjId) != Acad::eOk)
		return false;

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForRead);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* value;
	pX->rbChain(&value);

	ParseBordersList(value, obj, func, AColCount, ARowCount, AType);

	acutRelRb(value);

	return true;
}

extern "C" __declspec(dllexport) bool oarxWriteBordersList(long obj, TAlxdBorderExchangeFunc func, Adesk::IntDbId dict, int AColCount, int ARowCount, char AType)
{
	AcDbObjectId dictId;
	dictId.setFromOldId(dict);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForWrite);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;
	
	if (pDict->getAt(AType == 0 ? verBorderXdata : horBorderXdata, xrecObjId) != Acad::eOk)
	{
		AcDbObjectPointer<AcDbXrecord> pX;
		pX.create();
		if (pX.object()==NULL)
			return false;

	    if (pDict->setAt(AType == 0 ? verBorderXdata : horBorderXdata, pX.object(), xrecObjId) != Acad::eOk)
			return false;
	}

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForWrite);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* value = NULL;
	BuildBordersList(&value, obj, func, AColCount, ARowCount, AType);

    if (pX->setFromRbChain(*value) != Acad::eOk)
	{
        acutRelRb(value);
        return false;
    }

	acutRelRb(value);

	return true;
}

extern "C" __declspec(dllexport) bool oarxEraseBorder(PAlxdBorderExchange value)
{
	if (value->ObjectId != 0)
	{
		AcDbObjectId objId;
		objId.setFromOldId(value->ObjectId);

		AcDbObject *pObject = NULL;
		Acad::ErrorStatus res;

		res = acDocManager->lockDocument(acDocManager->document(objId.database()), AcAp::kAutoWrite); //good
		if (res != Acad::eOk)
			return false;

		res = acdbOpenObject(pObject, objId, AcDb::kForWrite);
		if (res != Acad::eOk)
		{
			if (pObject)
				pObject->close();
			return false;
		}

		pObject->erase();
		pObject->close();

		value->ObjectId = 0;
	}

	return true;
}

extern "C" __declspec(dllexport) bool oarxRedrawBorder(PDrawingPair stCoord, PDrawingPair endCoord, PAlxdBorderExchange value)
{
	if (pBlockDef == NULL)
		return false;

	if (value->State != 0)
	{
		AcDbObjectId objId;
		AcDbLine *pLine;
		AcGePoint3d startPt;
		AcGePoint3d endPt;

		startPt.set(stCoord->x, stCoord->y, 0);
		endPt.set(endCoord->x, endCoord->y, 0);

		if (!value->ObjectId)
		{//create new line
			pLine = new AcDbLine(startPt, endPt);
			pBlockDef->appendAcDbEntity(objId, pLine);
			value->ObjectId = objId.asOldId();
		}
		else
		{//modify exist line
			objId.setFromOldId(value->ObjectId);

			Acad::ErrorStatus ret;
			ret = acdbOpenObject(pLine, objId, AcDb::kForWrite);
			if (ret != Acad::eOk)
			{
				if (pLine)
					pLine->close();
				return false;
			}

			pLine->setStartPoint(startPt);
			pLine->setEndPoint(endPt);
		}

		AcCmColor Color;
		Color.setColorIndex(value->Color);
		pLine->setColor(Color);
		pLine->setLayer(value->Layer);
		pLine->setLineWeight((AcDb::LineWeight)value->Weight);
		pLine->close();
		return true;		
	}

	if (!oarxEraseBorder(value))
		return false;

	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Fills Exports & internal functions
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool ParseFillsList(struct resbuf * value, long obj, TAlxdFillExchangeFunc func, int AColCount, int ARowCount)
{
	struct resbuf* pTemp = value;
	PAlxdFillExchange AlxdFillExchange = NULL;
	int i;
	int j;
	bool canparse;

	while (pTemp != NULL)
	{
		if (pTemp->restype == 10)
		{
			i = (int)pTemp->resval.rpoint[0];
			j = (int)pTemp->resval.rpoint[1];

			if ((i < 0) || (i > AColCount))
				return false;

			if ((j < 0) || (j > ARowCount))
				return false;

			AlxdFillExchange = func(obj, i, j);
		}

		switch (pTemp->restype)
		{
		case 281:
			AlxdFillExchange->FillType = (byte)pTemp->resval.rint;
			break;
		}//switch

		pTemp = pTemp->rbnext;
	}//while

	return true;
}

bool BuildFillsList(struct resbuf ** value, long obj, TAlxdFillExchangeFunc func, int AColCount, int ARowCount)
{
	struct resbuf* pLast = NULL;
	PAlxdFillExchange AlxdFillExchange = NULL;

	for (int i = 0; i < AColCount; i++)
		for (int j = 0; j < ARowCount; j++)
		{
			AlxdFillExchange = func(obj, i, j);

			if (!i && !j)
			{
				*value = acutNewRb(10);
				pLast = *value;
			}
			else
			{
				pLast->rbnext = acutNewRb(10);
				pLast = pLast->rbnext;
			}

			pLast->resval.rpoint[0] = i;
			pLast->resval.rpoint[1] = j;
			pLast->resval.rpoint[2] = 0;

			//(281 . FillProperty.FillType)
			pLast->rbnext = acutNewRb(281);
			pLast = pLast->rbnext;
			pLast->resval.rint = AlxdFillExchange->FillType;

		}//fors

	return true;
}

extern "C" __declspec(dllexport) bool oarxReadFillsList(long obj, TAlxdFillExchangeFunc func, Adesk::IntDbId dict, int AColCount, int ARowCount)
{
	AcDbObjectId dictId;
	dictId.setFromOldId(dict);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForRead);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;

	if (pDict->getAt(fillXdata, xrecObjId) != Acad::eOk)
		return false;

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForRead);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* value;
	pX->rbChain(&value);

	ParseFillsList(value, obj, func, AColCount, ARowCount);

	acutRelRb(value);

	return true;
}

extern "C" __declspec(dllexport) bool oarxWriteFillsList(Adesk::IntDbId obj, TAlxdFillExchangeFunc func, Adesk::IntDbId dict, int AColCount, int ARowCount)
{
	AcDbObjectId dictId;
	dictId.setFromOldId(dict);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForWrite);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;
	
	if (pDict->getAt(fillXdata, xrecObjId) != Acad::eOk)
	{
		AcDbObjectPointer<AcDbXrecord> pX;
		pX.create();
		if (pX.object()==NULL)
			return false;

	    if (pDict->setAt(fillXdata, pX.object(), xrecObjId) != Acad::eOk)
			return false;
	}

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForWrite);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* value = NULL;
	BuildFillsList(&value, obj, func, AColCount, ARowCount);

    if (pX->setFromRbChain(*value) != Acad::eOk)
	{
        acutRelRb(value);
        return false;
    }

	acutRelRb(value);

	return true;
}

extern "C" __declspec(dllexport) bool oarxEraseFill(PAlxdFillExchange value, int keptLines)
{
	if (value == NULL)
		return false;

	if (value->HatchType == 0)
	{
		AcDbObjectId hatchId;
		hatchId.setFromOldId(value->HatchId);

		if (!hatchId.isNull())
		{
			AcDbHatch* pHatch = NULL;

			Acad::ErrorStatus res;
			res = acDocManager->lockDocument(acDocManager->document(hatchId.database()), AcAp::kAutoWrite); //good
			if (res != Acad::eOk)
				return false;

			res = acdbOpenObject(pHatch, hatchId, AcDb::kForWrite);
			if (res != Acad::eOk)
			//if (acdbOpenObject(pHatch, hatchId, AcDb::kForWrite) != Acad::eOk)
			{
				if (pHatch)
					pHatch->close();
				return false;
			}
			pHatch->erase();
			pHatch->close();
		}
	}

	if (vclImport::vclGetLength(value->ObjectIds) > keptLines)
	{//delete trash lines in cell
		AcDbObjectId objId;

		for (int i = keptLines; i < vclImport::vclGetLength(value->ObjectIds); i++)
		{
			//objId.setFromOldId(pCellProperty->ObjectIds[i]);
			objId.setFromOldId(vclImport::vclGetAt(value->ObjectIds, i));

			Acad::ErrorStatus res;
			res = acDocManager->lockDocument(acDocManager->document(objId.database()), AcAp::kAutoWrite); //good
			if (res != Acad::eOk)
				return false;

			AcDbObject *pObject;
			res = acdbOpenObject(pObject, objId, AcDb::kForWrite);
			if (res != Acad::eOk)
			{
				if (pObject)
					pObject->close();
				return false;
			}

			pObject->erase();
			pObject->close();
		}
		vclImport::vclSetLength(value->ObjectIds, keptLines);
	}//if (CellProperty->LineCount > CurrentLine)

	return true;
}



extern "C" __declspec(dllexport) bool oarxRedrawFill(PAlxdFillExchange value)
{
	if (pBlockDef == NULL)
		return false;
	
	int iCurrentLine = 0;

	AcGePoint3d startPt;
	AcGePoint3d endPt;
	double	ds;

	//hatch
	if (value->HatchType > 0)
	{
		AcDbObjectId hatchId;
		hatchId.setFromOldId(value->HatchId);

		AcDbHatch* pHatch = NULL;

		if (hatchId.isNull())
		{
			pHatch = new AcDbHatch();
			pBlockDef->appendAcDbEntity(hatchId, pHatch);
		}
		else
		{
			if (acdbOpenObject(pHatch, hatchId, AcDb::kForWrite) != Acad::eOk)
			{
				if (pHatch)
					pHatch->close();
				return false;
			}

			//int n = pHatch->numLoops();

			while (pHatch->numLoops() > 0)
			//for (int i=0; i < n; i++)
			{
				pHatch->removeLoopAt(0);
			}
		}

		//pHatch->setColor(
		AcGeVector3d normal(0.0, 0.0, 1.0);
		pHatch->setNormal(normal);
		pHatch->setElevation(0.0);

		pHatch->setAssociative(Adesk::kFalse);
		pHatch->setPattern(AcDbHatch::kPreDefined, _T("SOLID")/*value->HatchName*/);
		pHatch->setHatchStyle(AcDbHatch::kNormal);

		AcGePoint2dArray vertexPts;
		vertexPts.setPhysicalLength(0).setLogicalLength(5);
		vertexPts[0].set(value->Coord.x, value->Coord.y);
		vertexPts[1].set(value->Coord.x + value->Size.x, value->Coord.y);
		vertexPts[2].set(value->Coord.x + value->Size.x, value->Coord.y - value->Size.y);
		vertexPts[3].set(value->Coord.x, value->Coord.y - value->Size.y);
		vertexPts[4].set(value->Coord.x, value->Coord.y);

		AcGeDoubleArray vertexBulges;
		vertexBulges.setPhysicalLength(0).setLogicalLength(5);
		for (int i = 0; i < 5; i++)
			vertexBulges[i] = 0.0;

		pHatch->appendLoop(AcDbHatch::kOutermost, vertexPts, vertexBulges); 
		pHatch->evaluateHatch();
		pHatch->close();

		value->HatchId = hatchId.asOldId();
	}

	for (iCurrentLine = 1; iCurrentLine < value->LineCount; iCurrentLine++)
	{
		if (value->IsRotatedCell)
		{
			ds = value->Coord.x + iCurrentLine * value->DefaultSize;
			startPt.set(ds, value->Coord.y, 0);
			endPt.set(ds, value->Coord.y - value->Size.y, 0);  
		}
		else
		{
			ds = value->Coord.y - iCurrentLine * value->DefaultSize;
			startPt.set(value->Coord.x, ds, 0);
			endPt.set(value->Coord.x + value->Size.x, ds, 0);  
		}

		AcDbLine *pLine = NULL;
		AcDbObjectId objId;

		if (iCurrentLine > vclImport::vclGetLength(value->ObjectIds))
		{//add line object
			pLine = new AcDbLine(startPt, endPt);
			pBlockDef->appendAcDbEntity(objId, pLine);
			vclImport::vclSetLength(value->ObjectIds, iCurrentLine);
			vclImport::vclSetAt(value->ObjectIds, iCurrentLine - 1, objId.asOldId());
		}
		else
		{//modify line object
			objId.setFromOldId(vclImport::vclGetAt(value->ObjectIds, iCurrentLine - 1));
			if (acdbOpenObject(pLine, objId, AcDb::kForWrite) != Acad::eOk)
			{
				if (pLine)
				{
					pLine->close();
					return false;
				}
			}
			pLine->setStartPoint(startPt);
			pLine->setEndPoint(endPt);
		}

		pLine->close();
	}

	if (!oarxEraseFill(value, iCurrentLine - 1))
		return false;

	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Cells Exports & internal functions
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool HasFieldCode(ACHAR* sText)
{
	match_results results;
	tstring str(sText);
	rpattern pat( _T("%<.+>%"), GLOBAL);
	match_results::backref_type br = pat.match( str, results );

	return br.matched;
}

bool ParseCellsList(struct resbuf * value, long obj, TAlxdCellExchangeFunc func, int AColCount, int ARowCount)
{
	AcDbObjectId styleId;
	struct resbuf* pTemp = value;
	PAlxdCellExchange AlxdCellExchange = NULL;
	int i;
	int j;
	bool canparse;

	while (pTemp != NULL)
	{
		if (pTemp->restype == 10)
		{
			i = (int)pTemp->resval.rpoint[0];
			j = (int)pTemp->resval.rpoint[1];

			if ((i < 0) || (i > AColCount))
				return false;

			if ((j < 0) || (j > ARowCount))
				return false;

			AlxdCellExchange = func(obj, i, j);
		}

		switch (pTemp->restype)
		{
		case 11:
			AlxdCellExchange->Joined.Cols = (int)pTemp->resval.rpoint[0];
			AlxdCellExchange->Joined.Rows = (int)pTemp->resval.rpoint[1];
			break;
		case 72:
			AlxdCellExchange->HorizontalAlignment = pTemp->resval.rint;
			break;
		case 73:
			AlxdCellExchange->VerticalAlignment = pTemp->resval.rint;
			break;
		case 40:
			AlxdCellExchange->Height = pTemp->resval.rreal;
			break;
		case 41:
			AlxdCellExchange->WidthFactor = pTemp->resval.rreal;
			break;
		case 42:
			AlxdCellExchange->ObliqueAngle = pTemp->resval.rreal;
			break;
		case 43:
			AlxdCellExchange->Between = pTemp->resval.rreal;
			break;
		case 50:
			AlxdCellExchange->Rotation = pTemp->resval.rreal;
			break;
		case 60:
			AlxdCellExchange->Color = pTemp->resval.rint;
			break;
		case 65:
			AlxdCellExchange->Weight = pTemp->resval.rint;
			break;	
		case 330:
			acdbGetObjectId(styleId, pTemp->resval.rlname);
			AlxdCellExchange->TextStyleObjectId = styleId.asOldId();
			break;
		case 140:
			AlxdCellExchange->Margins.Left = pTemp->resval.rreal;
			break;
		case 141:
			AlxdCellExchange->Margins.Bottom = pTemp->resval.rreal;
			break;
		case 142:
			AlxdCellExchange->Margins.Right = pTemp->resval.rreal;
			break;
		case 143:
			AlxdCellExchange->Margins.Top = pTemp->resval.rreal;
			break;
		case 282:
			AlxdCellExchange->TextType = (byte)pTemp->resval.rint;
			break;
		case 283:
			AlxdCellExchange->TextFit = (byte)pTemp->resval.rint;
			break;

		case 6:
			vclImport::vclUpdString(pTemp->resval.rstring, AlxdCellExchange->Layer);
			break;
		case 3:
			vclImport::vclUpdString(pTemp->resval.rstring, AlxdCellExchange->Formula);
			break;
		case 1:
			vclImport::vclUpdString(pTemp->resval.rstring, AlxdCellExchange->Text);
			break;

		}//switch

		pTemp = pTemp->rbnext;
	}//while

	return true;
}

bool BuildCellsList(struct resbuf ** value, long obj, TAlxdCellExchangeFunc func, int AColCount, int ARowCount)
{
	AcDbObjectId styleId;
	struct resbuf* pLast = NULL;
	PAlxdCellExchange AlxdCellExchange = NULL;

	for (int i = 0; i < AColCount; i++)
		for (int j = 0; j < ARowCount; j++)
		{
			AlxdCellExchange = func(obj, i, j);

			if (!i && !j)
			{
				*value = acutNewRb(10);
				pLast = *value;
			}
			else
			{
				pLast->rbnext = acutNewRb(10);
				pLast = pLast->rbnext;
			}

			pLast->resval.rpoint[0] = i;
			pLast->resval.rpoint[1] = j;
			pLast->resval.rpoint[2] = 0;

			//(11 joinedcol joinedrow 0)
			pLast->rbnext = acutNewRb(11);
			pLast = pLast->rbnext;
			pLast->resval.rpoint[0] = AlxdCellExchange->Joined.Cols;
			pLast->resval.rpoint[1] = AlxdCellExchange->Joined.Rows;
			pLast->resval.rpoint[2] = 0;

			//(72 . TextProperty.HorizontalAlignment)
			pLast->rbnext = acutNewRb(72);
			pLast = pLast->rbnext;
			pLast->resval.rint = AlxdCellExchange->HorizontalAlignment;

			//(73 . TextProperty.VerticalAlignment)
			pLast->rbnext = acutNewRb(73);
			pLast = pLast->rbnext;
			pLast->resval.rint = AlxdCellExchange->VerticalAlignment;

			//(40 . TextProperty.Height)
			pLast->rbnext = acutNewRb(40);
			pLast = pLast->rbnext;
			pLast->resval.rreal = AlxdCellExchange->Height;

			//(41 . TextProperty.WidthFactor)
			pLast->rbnext = acutNewRb(41);
			pLast = pLast->rbnext;
			pLast->resval.rreal = AlxdCellExchange->WidthFactor;

			//(42 . TextProperty.ObliqueAngle)
			pLast->rbnext = acutNewRb(42);
			pLast = pLast->rbnext;
			pLast->resval.rreal = AlxdCellExchange->ObliqueAngle;

			//(43 . TextProperty.Between)
			pLast->rbnext = acutNewRb(43);
			pLast = pLast->rbnext;
			pLast->resval.rreal = AlxdCellExchange->Between;

			//(50 . TextProperty.Rotation)
			pLast->rbnext = acutNewRb(50);
			pLast = pLast->rbnext;
			pLast->resval.rreal = AlxdCellExchange->Rotation;

			//(60 . TextProperty.Color)
			pLast->rbnext = acutNewRb(60);
			pLast = pLast->rbnext;
			pLast->resval.rint = AlxdCellExchange->Color;

			//(65 . TextProperty.LineWeight)
			pLast->rbnext = acutNewRb(65);
			pLast = pLast->rbnext;
			pLast->resval.rint = AlxdCellExchange->Weight;

			//(140 . TextProperty.Margins.MarginLeft)
			pLast->rbnext = acutNewRb(140);
			pLast = pLast->rbnext;
			pLast->resval.rreal = AlxdCellExchange->Margins.Left;

			//(141 . TextProperty.Margins.MarginBottom)
			pLast->rbnext = acutNewRb(141);
			pLast = pLast->rbnext;
			pLast->resval.rreal = AlxdCellExchange->Margins.Bottom;

			//(142 . TextProperty.Margins.MarginBottom)
			pLast->rbnext = acutNewRb(142);
			pLast = pLast->rbnext;
			pLast->resval.rreal = AlxdCellExchange->Margins.Right;

			//(143 . TextProperty.Margins.MarginBottom)
			pLast->rbnext = acutNewRb(143);
			pLast = pLast->rbnext;
			pLast->resval.rreal = AlxdCellExchange->Margins.Top;

			//(282 . TextProperty.TextType)
			pLast->rbnext = acutNewRb(282);
			pLast = pLast->rbnext;
			pLast->resval.rint = AlxdCellExchange->TextType;
			
			//(283 . TextProperty.TextFit)
			pLast->rbnext = acutNewRb(283);
			pLast = pLast->rbnext;
			pLast->resval.rint = AlxdCellExchange->TextFit;

			//(90 . TextProperty.TextStyleId)
			if (AlxdCellExchange->TextStyleObjectId)
			{
				pLast->rbnext = acutNewRb(330);//(90);
				pLast = pLast->rbnext;
				styleId.setFromOldId(AlxdCellExchange->TextStyleObjectId);
				acdbGetAdsName(pLast->resval.rlname, styleId);
			}
			//pLast->resval.rlname[0] = ;
			//#if !defined(_WIN64) && !defined (_AC64)
			//	//pLast->resval.rlong = AlxdCellExchange->TextStyleObjectId;
			//#else
			//	pLast->resval.rlname[0] = AlxdCellExchange->TextStyleObjectId;
			//#endif

			//(6 . TextProperty.Layer)
			if (AlxdCellExchange->Layer)
			{
				pLast->rbnext = acutNewRb(6);
				pLast = pLast->rbnext;
				acutUpdString(AlxdCellExchange->Layer, pLast->resval.rstring);
				//alxdUpdString(CellProperty->TextProperty.Formula, pLast->resval.rstring);
			}
			
			//(3 . TextProperty.Formula)
			if (AlxdCellExchange->Formula)
			{
				pLast->rbnext = acutNewRb(3);
				pLast = pLast->rbnext;
				acutUpdString(AlxdCellExchange->Formula, pLast->resval.rstring);
				//alxdUpdString(CellProperty->TextProperty.Formula, pLast->resval.rstring);
			}
			else
			//(1 . TextProperty.Text)
			if (AlxdCellExchange->Text)
			{
				pLast->rbnext = acutNewRb(1);
				pLast = pLast->rbnext;
				acutUpdString(AlxdCellExchange->Text, pLast->resval.rstring);
				//alxdUpdString(CellProperty->TextProperty.Text, pLast->resval.rstring);
				//acutUpdString("0________10________20________30________40________50________60________70________80________90_______100_______110_______120_______130_______140_______150_______160_______170_______180_______190_______200_______210_______220_______230_______240_______250___255_260_______270_______280", pLast->resval.rstring);
			}
		}//fors

	return true;
}

extern "C" __declspec(dllexport) bool oarxReadCellsList(Adesk::IntDbId obj, TAlxdCellExchangeFunc func, Adesk::IntDbId dict, int AColCount, int ARowCount)
{
	AcDbObjectId dictId;
	dictId.setFromOldId(dict);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForRead);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;

	if (pDict->getAt(cellXdata, xrecObjId) != Acad::eOk)
		return false;

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForRead);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* value;
	pX->rbChain(&value);

	ParseCellsList(value, obj, func, AColCount, ARowCount);

	acutRelRb(value);

	return true;
}

extern "C" __declspec(dllexport) bool oarxWriteCellsList(Adesk::IntDbId obj, TAlxdCellExchangeFunc func, Adesk::IntDbId dict, int AColCount, int ARowCount)
{
	AcDbObjectId dictId;
	dictId.setFromOldId(dict);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForWrite);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;
	
	if (pDict->getAt(cellXdata, xrecObjId) != Acad::eOk)
	{
		AcDbObjectPointer<AcDbXrecord> pX;
		pX.create();
		if (pX.object()==NULL)
			return false;

	    if (pDict->setAt(cellXdata, pX.object(), xrecObjId) != Acad::eOk)
			return false;
	}

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForWrite);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* value = NULL;
	BuildCellsList(&value, obj, func, AColCount, ARowCount);

	//Acad::ErrorStatus e = pX->setFromRbChain(*value);
    if (pX->setFromRbChain(*value) != Acad::eOk)
	{
        acutRelRb(value);
        return false;
    }

	acutRelRb(value);

	return true;
}

int ParseDText(ACHAR* sNextText, PDrawingPair size, PAlxdCellExchange value, double& dXScale)
{
	dXScale = value->WidthFactor;

	double dMaxSize = 0;
	dMaxSize = value->Rotation == 0 ? size->x : size->y;

	const ACHAR*	sRightText = NULL;
	ACHAR*	sLeftText = NULL;
	size_t	iLeftLength = 0;
	acutUpdString(sNextText, sLeftText);
	//int splittedlength = -1;
	if (acutSplitString(iLeftLength, sRightText, sNextText, '\r'))
	{
		sLeftText[iLeftLength] = _T('\0');
		//splittedlength = iLeftLength;
	}
	iLeftLength = _tcslen(sLeftText);

	AcDbObjectId objId;
	objId.setFromOldId(value->TextStyleObjectId);

	Acad::ErrorStatus res;
	AcGiTextStyle pTextStyle;// = new AcGiTextStyle();

	int lsr = 0;
	res = fromAcDbTextStyle(pTextStyle, objId);
	//pTextStyle->setFileName(pTextStyle->fileName());
	//pTextStyle.setBigFontFileName(pTextStyle.bigFontFileName());
	lsr = pTextStyle.loadStyleRec();

	pTextStyle.setTextSize(value->Height);
	pTextStyle.setObliquingAngle(value->ObliqueAngle * DIVCONST);
	pTextStyle.setXScale(value->WidthFactor);
	lsr = pTextStyle.loadStyleRec();

	AcGePoint2d ext;// = AcGePoint2d(0.0, 0.0);
	//ext = pTextStyle.extents(sLeftText, Adesk::kFalse, -1, Adesk::kFalse, NULL);
	ext = pTextStyle.extents(sLeftText, Adesk::kTrue, _tcslen(sLeftText), Adesk::kFalse);
	
	//AcGePoint2d extmin;
	//AcGePoint2d extmax;
	//res = pTextStyle->extentsBox(sLeftText, Adesk::kFalse, _tcslen(sLeftText), Adesk::kFalse, extmin, extmax);

	//ext = AcGePoint2d(extmax.x - extmin.x, extmax.y - extmin.y);

	if (value->TextFit == 4)	//fitted always
	{
		dXScale = (dMaxSize * value->WidthFactor) / ext.x;
		dXScale = min(value->WidthFactor, dXScale);
		//if (dXScale > value->WidthFactor)
		//	dXScale = value->WidthFactor;
		acutDelString(sLeftText);
		return iLeftLength;
	}

	if (value->TextFit == 3)	//unbreaked always
	{
		acutDelString(sLeftText);
		return iLeftLength;
	}

	//здесь сначала проверить необходимость парсинга ВООБЩЕ! может строка и так входит в заданный размер?!
	//if (ext.x < dMaxSize) ...

	//парсинг регулярными выражениями
	match_results results;

	//tstring str( _T("worÜÖÄd1, 而退哦破瑞， и было слово, 30%%dC: date:%<\\AcVar CreateDate \\f \"yyyy/MM/dd\">%%%p50 - %%135symbol 28.02.2007 \"\"unicode\\U+00C4\\U+00C4\"\" word2") );
	tstring str(sLeftText);
	rpattern pat( _T("([^ ]+%<.+>%[^ ]+ {0,})|([^ ]+%<.+>% {0,})|(%<.+>%[^ ]+ {0,})|(%<.+>% {0,})|([^ ]+ {0,})"), GLOBAL | FIRSTBACKREFS);

	match_results::backref_type br = pat.match( str, results );
	match_results::backref_vector vec = results.all_backrefs();
	match_results::backref_vector::iterator iter;

	AcDbObjectId fldId;
	//ACHAR*	sCurrentText = NULL;
	ACHAR*	sCurrentWord = NULL;
	AcString	acPrevText;
	AcString	acCurrentText;
	//AcString	acCurrentWord;
	AcDbField* pTextField = NULL;
	int c = 0;

	pTextField = new AcDbField();
	res = acdbHostApplicationServices()->workingDatabase()->addAcDbObject(fldId, pTextField);

	for ( iter = vec.begin(); iter != vec.end(); iter++ )
	{
		const wchar_t* sFirstCharOfWord = &(*iter->begin());
		int iLengthOfWord = iter->end()-iter->begin();

		//sCurrentText = AcString(sFirstCharOfWord, iLengthOfWord);
		acutNewString(sCurrentWord, iLengthOfWord+1);			
		_tcsncpy(sCurrentWord, sFirstCharOfWord, iLengthOfWord);
		sCurrentWord[iLengthOfWord] = '\0';
		acCurrentText = acPrevText + sCurrentWord;
		acutDelString(sCurrentWord);

		//measure code here
		//dMaxSize

		res = pTextField->setFieldCode(acCurrentText, AcDbField::FieldCodeFlag(AcDbField::kTextField | AcDbField::kPreserveFields));
		res = pTextField->setEvaluationOption(AcDbField::kAutomatic);
		res = pTextField->evaluate(AcDbField::kAutomatic, NULL, NULL, NULL);

		ext = pTextStyle.extents(pTextField->getValue(), Adesk::kTrue, -1, Adesk::kFalse, NULL);
		//AcString temp = pTextField->getValue();

		if (ext.x >= dMaxSize)
		{
			if (value->TextFit == 2)	//break
			{
				if (c == 0)
				{
					//перебор по буковкам, но не меньше одной
					//%<...>% - это поле - целиком, иначе оно не вычислится
					//%%u и %%o опускаем - это не символы, а команды
					//%%d, %%c, %%p - один символ

					tstring str_chars(acCurrentText);
					rpattern pat_chars( _T("(%%[uUoO])?(%<.+>%|%%[dDpPcC]|%%\\d{3}|.)[ ]?"), GLOBAL | FIRSTBACKREFS);

					match_results results_chars;
					match_results::backref_type br = pat_chars.match( str_chars, results_chars );

					match_results::backref_vector vec_chars = results_chars.all_backrefs();
					match_results::backref_vector::iterator iter_chars;

					for ( iter_chars = vec_chars.begin( ) ; iter_chars != vec_chars.end( ) ; iter_chars++ )
					{
						sFirstCharOfWord = &(*iter_chars->begin());
						iLengthOfWord = iter_chars->end()-iter_chars->begin();

						acutNewString(sCurrentWord, iLengthOfWord+1);			
						_tcsncpy(sCurrentWord, sFirstCharOfWord, iLengthOfWord);
						sCurrentWord[iLengthOfWord] = '\0';
						acCurrentText = acPrevText + sCurrentWord;
						acutDelString(sCurrentWord);

						res = pTextField->setFieldCode(acCurrentText, AcDbField::FieldCodeFlag(AcDbField::kTextField | AcDbField::kPreserveFields));
						res = pTextField->setEvaluationOption(AcDbField::kAutomatic);
						res = pTextField->evaluate(AcDbField::kAutomatic, NULL, NULL, NULL);

						ext = pTextStyle.extents(pTextField->getValue(), Adesk::kTrue, -1, Adesk::kFalse, NULL);

						if (ext.x >= dMaxSize)
						{
							pTextField->close();
							acutDelString(sLeftText);
							int ret = acPrevText.length();

							if (ret == 0)
								return acCurrentText.length();

							return ret;
						}

						acPrevText = acCurrentText;
					}		
				}
				else
				{
					//откат на слово назад
					pTextField->close();
					acutDelString(sLeftText);
					return acPrevText.length();
				}
			}
			else
			if (value->TextFit == 1)	//fit
			{
				//все. можно вписывать текст.
				pTextField->close();
				dXScale = dMaxSize * value->WidthFactor / ext.x;
				acutDelString(sLeftText);
				return acCurrentText.length();
			}
		}

		acPrevText = acCurrentText;
		c++;
	}
	
	pTextField->close();
	acutDelString(sLeftText);

	//delete pTextStyle;
	//if (splitted) && (iLeftLength + 1 == iLeftLength
	//if (iLeftLength < 1) iLeftLength = 1;
	//if (splittedlength == iLeftLength) iLeftLength++;
	return iLeftLength;
}

int RedrawDText(PDrawingPair coord, PDrawingPair size, PAlxdCellExchange value, int& iDrewLines)
{
	ACHAR*	sText = NULL;
	acutUpdString(value->Text, sText);	

	ACHAR*	sNextText = NULL;
	int iCurrentLine = 0;
	int	iSummDec = 0;

	AcDbObjectId objId;
	AcDbText* pText = NULL;
	AcGePoint3d position = AcGePoint3d(0, 0, 0);

	Acad::ErrorStatus stat;

	while (sText[iSummDec] != 0)
	{
		acutUpdString(sText + iSummDec, sNextText);
		iCurrentLine++;

		double	dXScale = 0.0;
		int		iNextTextLength = 0;
		iNextTextLength = ParseDText(sNextText, size, value, dXScale);
		sNextText[iNextTextLength] = '\0';

		//remove last space
		int iStrLen = _tcslen(sNextText) - 1;
		while (sNextText[iStrLen] == _T(' '))
		{
			sNextText[iStrLen] = '\0';
			iStrLen--;
		}

		iSummDec += iNextTextLength;
		if (sText[iSummDec] == 13)
			iSummDec = iSummDec + 2;

		if (iCurrentLine > vclImport::vclGetLength(value->ObjectIds))
		{//add text object
			pText = new AcDbText(position, sNextText, NULL, value->Height, value->Rotation * DIVCONST);
			pBlockDef->appendAcDbEntity(objId, pText);
			vclImport::vclSetLength(value->ObjectIds, iCurrentLine);
			vclImport::vclSetAt(value->ObjectIds, iCurrentLine - 1, objId.asOldId());
		}
		else
		{//change text object
			objId.setFromOldId(vclImport::vclGetAt(value->ObjectIds, iCurrentLine - 1));

			AcDbObject *pObj = NULL;
			if (acdbOpenObject(pObj, objId, AcDb::kForWrite) == Acad::eOk)
			{
				pText = AcDbText::cast(pObj);
				if (!pText)
				{
					pObj->erase();
					pObj->close();

					pText = new AcDbText(position, sNextText, NULL, value->Height, value->Rotation * DIVCONST);
					pBlockDef->appendAcDbEntity(objId, pText);
					vclImport::vclSetAt(value->ObjectIds, iCurrentLine - 1, objId.asOldId());
				}
				else
				{
					pText->setPosition(position);
					pText->setTextString(sNextText);
					pText->setHeight(value->Height);
					pText->setRotation(value->Rotation * DIVCONST);
				}
			}//if (acdbOpenObject
		}//if (iCurrentLine

		if (HasFieldCode(sNextText))
		{
			AcDbObjectId fldId;
			AcDbField* pTextField = NULL;

			pTextField = new AcDbField();
			pTextField->setFieldCode(sNextText, AcDbField::FieldCodeFlag(AcDbField::kTextField | AcDbField::kPreserveFields));
			pTextField->setEvaluationOption(AcDbField::kAutomatic);
			pTextField->evaluate(AcDbField::kAutomatic, NULL, NULL, NULL);

			pText->setField(_T("TEXT"), pTextField, fldId);

			pTextField->close();
		}

		acutDelString(sNextText);

		//objId.setFromOldId(value->TextStyleObjectId);
		//pText->setTextStyle(objId);
		AcDbObjectId styleId;
		styleId.setFromOldId(value->TextStyleObjectId);
		pText->setTextStyle(styleId);

		pText->setOblique(value->ObliqueAngle * DIVCONST);
		pText->setWidthFactor(dXScale);			

		AcCmColor Color;
		Color.setColorIndex(value->Color);
		pText->setColor(Color);
		pText->setLayer(value->Layer);
		pText->setLineWeight((AcDb::LineWeight)value->Weight);
		//pText->setLayer(value->FTextLayer);

		if (pText)
			pText->close();
	}
	acutDelString(sText);

	for (int i = 0; i < iCurrentLine; i++)
	{
		objId.setFromOldId(vclImport::vclGetAt(value->ObjectIds, i));

		if (value->Rotation == 0)
		{
			//horizontal
			if (value->HorizontalAlignment == 1) //left
				position[0] = coord->x + value->Margins.Left;
			else
			if (value->HorizontalAlignment == 2)//center
				position[0] = coord->x + (size->x + value->Margins.Left + value->Margins.Right) / 2;
			else
			if (value->HorizontalAlignment == 3)//right
				position[0] = coord->x + size->x + value->Margins.Left;// - value->Margins.Right;

			//vertical			
			if (value->VerticalAlignment <= 2)//baseline or bottom
				if (value->IsJoiningCell || !value->IsResetedCell)
					//position[1] = coord->y - size->y + value->Between * (iCurrentLine - i - 1) + value->Margins.Bottom;
					position[1] = coord->y - size->y + value->Between * (iCurrentLine - i - 1) - value->Margins.Top;
				else
					position[1] = coord->y - value->Between * (i + 1) + value->Margins.Bottom;
			else
			if (value->VerticalAlignment == 3)//middle
				if (value->IsJoiningCell || !value->IsResetedCell)
					//position[1] = coord->y - value->Between * i - (size->y - value->Between * (iCurrentLine - 1)) / 2;
					position[1] = coord->y - value->Between * i - (size->y + value->Margins.Top + value->Margins.Bottom - value->Between * (iCurrentLine - 1)) / 2;
				else
					position[1] = coord->y - value->Between * i - value->Between / 2;
				//- CellHeight / 2 + tCellCurrent.Between * CurrentLine / 2 - tCellCurrent.Between * (i+1) / 2 ;
			else
			if (value->VerticalAlignment == 4)//top
//						if (joining || !reseted)
					position[1] = coord->y - value->Between * i - value->Margins.Top;
//						else
//							Position[1] = RowProperty->Coord - tCellCurrent.Between * i - tCellCurrent.Margins.MarginTop;
			
			//set/change
			stat = acdbOpenObject(pText, objId, AcDb::kForWrite);
			if (stat == Acad::eOk)
			{
				pText->setHorizontalMode(AcDb::TextHorzMode(value->HorizontalAlignment - 1));
				pText->setVerticalMode(AcDb::TextVertMode(value->VerticalAlignment - 1));
				pText->setAlignmentPoint(position);
				pText->setPosition(position);
				pText->close();
			}
		}
		else
		{
			//horizontal
			if (value->HorizontalAlignment == 1)//left
				position[0] = coord->x + value->Between * i + value->Margins.Left;
			else
			if (value->HorizontalAlignment == 2)//center
				if (value->IsJoiningCell || !value->IsResetedCell)
					position[0] = coord->x + value->Between * i + (size->x - value->Between * (iCurrentLine - 1)) / 2 + value->Height / 2;
				else
					position[0] = coord->x + value->Between * i + value->Between / 2 + value->Height / 2;
			else
			if (value->HorizontalAlignment == 3)//right
				if (value->IsJoiningCell || !value->IsResetedCell)
					position[0] = coord->x + size->x - value->Between * (iCurrentLine - i - 1) + value->Margins.Left;
				else
					position[0] = coord->x + value->Between * (i + 1) + value->Margins.Left;

			//vertical
			if (value->VerticalAlignment < 2) value->VerticalAlignment = 2;

			if (value->VerticalAlignment == 2) //baseline or bottom
				position[1] = coord->y - size->y - value->Margins.Top;
			else
			if (value->VerticalAlignment == 3)//middle
				position[1] = coord->y - (size->y + value->Margins.Top + value->Margins.Bottom) / 2;
			else
			if (value->VerticalAlignment == 4)//top
				position[1] = coord->y - value->Margins.Top;

			//set/change
			if (acdbOpenObject(pText, objId, AcDb::kForWrite) == Acad::eOk)
			{
				pText->setHorizontalMode(AcDb::TextHorzMode(value->VerticalAlignment - 2));
				pText->setVerticalMode(AcDb::TextVertMode(value->HorizontalAlignment == 3 ? 0 : 4 - value->HorizontalAlignment));
				pText->setAlignmentPoint(position);
				pText->setPosition(position);
				pText->close();
			}
		}

	}//for (i = 0; i < CellProperty->LineCount; i++)

	if (!value->IsJoiningCell && value->IsResetedCell)
		iDrewLines = (int) ceil( iCurrentLine * value->Between / value->DefaultSize );
	else
		iDrewLines = iCurrentLine;

	return iCurrentLine;
}

int RedrawMText(PDrawingPair coord, PDrawingPair size, PAlxdCellExchange value, int& iDrewLines)
{
	ACHAR*	sText = NULL;
	acutUpdString(value->Text, sText);

	int iCurrentLine = 1;

	AcDbObjectId objId;
	AcDbMText *pText = NULL;

	if (iCurrentLine > vclImport::vclGetLength(value->ObjectIds))
	{
		pText = new AcDbMText();
		pBlockDef->appendAcDbEntity(objId, pText);
		vclImport::vclSetLength(value->ObjectIds, iCurrentLine);
		vclImport::vclSetAt(value->ObjectIds, iCurrentLine - 1, objId.asOldId());
	}
	else
	{
		objId.setFromOldId(vclImport::vclGetAt(value->ObjectIds, iCurrentLine - 1));

		AcDbObject *pObj = NULL;
		if (acdbOpenObject(pObj, objId, AcDb::kForWrite) == Acad::eOk)
		{
			pText = AcDbMText::cast(pObj);
			if (!pText)
			{
				pObj->erase();
				pObj->close();

				pText = new AcDbMText();
				pBlockDef->appendAcDbEntity(objId, pText);
				vclImport::vclSetAt(value->ObjectIds, iCurrentLine - 1, objId.asOldId());
			}
		}
	}

	pText->setContents(sText);

	if (HasFieldCode(sText))
	{
		AcDbObjectId fldId;
		AcDbField* pTextField = NULL;

		pTextField = new AcDbField();
		pTextField->setFieldCode(sText, AcDbField::FieldCodeFlag(AcDbField::kTextField | AcDbField::kPreserveFields));
		pTextField->setEvaluationOption(AcDbField::kAutomatic);
		pTextField->evaluate(AcDbField::kAutomatic, NULL, NULL, NULL);

		pText->setField(_T("TEXT"), pTextField, fldId);

		pTextField->close();
	}

	acutDelString(sText);

	pText->setRotation(value->Rotation * DIVCONST);

	if (value->Rotation == 0)
		pText->setWidth(size->x);// - value->Margins.Left - value->Margins.Right);
	else
		pText->setWidth(size->y);

	//objId.setFromOldId(tCellCurrent.TextStyleId);
	//pText->setTextStyle(objId);
	AcDbObjectId styleId;
	styleId.setFromOldId(value->TextStyleObjectId);
	pText->setTextStyle(styleId);

	pText->setTextHeight(value->Height);					


	double dls = value->Between /(value->Height * 5/3);
	if (dls > 4.0)
		dls = 4.0;
	else
		if (dls < 0.25)
			dls = 0.25;
	pText->setLineSpacingFactor(dls);

	AcGePoint3d Position;
	if (value->Rotation == 0)
	{
		//horizontal
		if (value->HorizontalAlignment == 1) //left
			Position[0] = coord->x + value->Margins.Left;
		else
		if (value->HorizontalAlignment == 2)//center
			Position[0] = coord->x + (size->x + value->Margins.Left + value->Margins.Right) / 2;
		else
		if (value->HorizontalAlignment == 3)//right
			Position[0] = coord->x + size->x + value->Margins.Left;

		//vertical
		if (value->VerticalAlignment <= 2)//baseline or bottom
			Position[1] = coord->y - size->y - value->Margins.Top;
		else
		if (value->VerticalAlignment == 3)//middle
			Position[1] = coord->y - (size->y + value->Margins.Top + value->Margins.Bottom) / 2;
		else
		if (value->VerticalAlignment == 4)//top
			Position[1] = coord->y - value->Margins.Top;

		pText->setAttachment(AcDbMText::AttachmentPoint((value->HorizontalAlignment - 1) + (4 - value->VerticalAlignment) * 3 + 1));
	}
	else
	{
		//horizontal
		if (value->HorizontalAlignment == 1) //left
			Position[0] = coord->x + value->Margins.Left;
		else
		if (value->HorizontalAlignment == 2)//center
			Position[0] = coord->x + (size->x + value->Margins.Left + value->Margins.Right) / 2;
		else
		if (value->HorizontalAlignment == 3)//right
			Position[0] = coord->x + size->x + value->Margins.Left;

		//vertical
		if (value->VerticalAlignment == 2)//baseline or bottom
			Position[1] = coord->y - size->y - value->Margins.Top;
		else
		if (value->VerticalAlignment == 3)//middle
			Position[1] = coord->y - (size->y + value->Margins.Top + value->Margins.Bottom) / 2;
		else
		if (value->VerticalAlignment == 4)//top
			Position[1] = coord->y - value->Margins.Top;

		pText->setAttachment(AcDbMText::AttachmentPoint((value->VerticalAlignment - 1) + (value->HorizontalAlignment - 1) * 3));
	}

	pText->setLocation(Position);

	AcCmColor Color;
	Color.setColorIndex(value->Color);
	pText->setColor(Color);
	pText->setLayer(value->Layer);
	pText->setLineWeight((AcDb::LineWeight)value->Weight);

	if (!value->IsJoiningCell)
		iDrewLines = (int) ceil (pText->actualHeight() / value->Between);

	if (pText)
		pText->close();

	return iCurrentLine;
}

int RedrawBText(PDrawingPair coord, PDrawingPair size, PAlxdCellExchange value, int& iDrewLines)
{
	ACHAR*	sText = NULL;
	acutUpdString(value->Text, sText);

	int iCurrentLine = 0;

	AcDbObjectId refId;
	AcGePoint3d position = AcGePoint3d(0, 0, 0);
	if (DrawBlock(sText, position, AcGePoint3d(1, 1, 1), 0, refId) != RTNORM)
		return iCurrentLine;

	iCurrentLine = 1;

	if (iCurrentLine > vclImport::vclGetLength(value->ObjectIds))
	{
		//pText = new AcDbMText();
		//pBlockDef->appendAcDbEntity(objId, pText);
		//objId.setNull();
		
		vclImport::vclSetLength(value->ObjectIds, iCurrentLine);
		vclImport::vclSetAt(value->ObjectIds, iCurrentLine - 1, refId.asOldId());
	}
	else
	{
		AcDbObjectId objId;
		objId.setFromOldId(vclImport::vclGetAt(value->ObjectIds, iCurrentLine - 1));

		AcDbObject *pObj = NULL;
		if (acdbOpenObject(pObj, objId, AcDb::kForWrite) == Acad::eOk)
		{
			pObj->erase();
			pObj->close();
		}

		//objId.setNull();
		//InsertBlockFull(sText, AcGePoint3d(0, 0, 0), AcGePoint3d(1, 1, 1), 0, objId);
		vclImport::vclSetAt(value->ObjectIds, iCurrentLine - 1, refId.asOldId());
	}
	acutDelString(sText);

	AcDbBlockReference *pBlockRef = NULL;
	if (acdbOpenObject(pBlockRef, refId, AcDb::kForWrite) == Acad::eOk)
	{
		AcDbExtents BlockDefExt = AcDbExtents();
		AcGeVector3d vec = AcGeVector3d(0, 0, 0);

		AcDbBlockTableRecord *pBlockDef = NULL;
		if (acdbOpenObject(pBlockDef, pBlockRef->blockTableRecord(), AcDb::kForRead) == Acad::eOk)
		{	
			BlockDefExt.addBlockExt(pBlockDef);
			vec = pBlockDef->origin() - BlockDefExt.minPoint();
			pBlockDef->close();
		}

		vec = vec.rotateBy(value->Rotation * DIVCONST, AcGeVector3d::kZAxis);

		if (value->Rotation == 0)
		{
			//horizontal
			if (value->HorizontalAlignment == 1) //left
				position[0] = coord->x + value->Margins.Left;
			else
			if (value->HorizontalAlignment == 2)//center
			{
				position[0] = coord->x + (size->x + value->Margins.Left + value->Margins.Right) / 2;
				vec[0] -= (BlockDefExt.maxPoint()[0] - BlockDefExt.minPoint()[0]) / 2;
			}
			else
			if (value->HorizontalAlignment == 3)//right
			{
				position[0] = coord->x + size->x + value->Margins.Left;// - value->Margins.Right;
				vec[0] -= BlockDefExt.maxPoint()[0] - BlockDefExt.minPoint()[0];
			}

			//vertical
			if (value->VerticalAlignment <= 2)//baseline or bottom
				position[1] = coord->y - size->y - value->Margins.Top;
			else
			if (value->VerticalAlignment == 3)//middle
			{
				position[1] = coord->y - (size->y + value->Margins.Top + value->Margins.Bottom)/ 2;
				vec[1] -= (BlockDefExt.maxPoint()[1] - BlockDefExt.minPoint()[1]) / 2;
			}
			else
			if (value->VerticalAlignment == 4)//top
			{
				//position[1] = coord->y - value->Margins.Top;
				position[1] = coord->y - value->Margins.Top;
				vec[1] -= BlockDefExt.maxPoint()[1] - BlockDefExt.minPoint()[1];
			}

		}
		else
		{
			//horizontal
			if (value->HorizontalAlignment == 1) //left
			{
				position[0] = coord->x + value->Margins.Left;
				vec[0] += BlockDefExt.maxPoint()[1] - BlockDefExt.minPoint()[1];
			}
			else
			if (value->HorizontalAlignment == 2)//center
			{
				position[0] = coord->x + (size->x + value->Margins.Left + value->Margins.Right) / 2;
				vec[0] += (BlockDefExt.maxPoint()[1] - BlockDefExt.minPoint()[1]) / 2;
			}
			else
			if (value->HorizontalAlignment == 3)//right
				position[0] = coord->x + size->x + value->Margins.Left;

			//vertical
			if (value->VerticalAlignment <= 2)//baseline or bottom
				position[1] = coord->y - size->y - value->Margins.Top;
			else
			if (value->VerticalAlignment == 3)//middle
			{
				position[1] = coord->y - (size->y + value->Margins.Top + value->Margins.Bottom) / 2;
				vec[1] -= (BlockDefExt.maxPoint()[0] - BlockDefExt.minPoint()[0]) / 2;
			}
			else
			if (value->VerticalAlignment == 4)//top
			{
				position[1] = coord->y - value->Margins.Top;
				vec[1] -= BlockDefExt.maxPoint()[0] - BlockDefExt.minPoint()[0];				
			}
		}

		position += vec;
		pBlockRef->setPosition(position);
		pBlockRef->setRotation(value->Rotation * DIVCONST);

		AcCmColor Color;
		Color.setColorIndex(value->Color);
		pBlockRef->setColor(Color);
		pBlockRef->setLayer(value->Layer);
		pBlockRef->setLineWeight((AcDb::LineWeight)value->Weight);

		pBlockRef->close();

		if (!value->IsJoiningCell)
			iDrewLines = (int) ceil ((BlockDefExt.maxPoint()[1] - BlockDefExt.minPoint()[1]) / value->Between);
	}

	return iCurrentLine;
}

extern "C" __declspec(dllexport) bool oarxEraseCell(PAlxdCellExchange value, int keptLines)
{
	if (value == NULL)
		return false;

	if (vclImport::vclGetLength(value->ObjectIds) > keptLines)
	{//delete trash lines in cell
		AcDbObjectId objId;

		for (int i = keptLines; i < vclImport::vclGetLength(value->ObjectIds); i++)
		{
			//objId.setFromOldId(pCellProperty->ObjectIds[i]);
			objId.setFromOldId(vclImport::vclGetAt(value->ObjectIds, i));

			Acad::ErrorStatus res;
			res = acDocManager->lockDocument(acDocManager->document(objId.database()), AcAp::kAutoWrite); //good
			if (res != Acad::eOk)
				return false;

			AcDbObject *pObject;
			res = acdbOpenObject(pObject, objId, AcDb::kForWrite);
			if (res != Acad::eOk)
			{
				if (pObject)
					pObject->close();
				return false;
			}

			pObject->erase();
			pObject->close();
		}
		vclImport::vclSetLength(value->ObjectIds, keptLines);
	}//if (CellProperty->LineCount > CurrentLine)

	return true;
}



extern "C" __declspec(dllexport) bool oarxRedrawCell(PDrawingPair coord, PDrawingPair size, PAlxdCellExchange value, int& iActualLinesInCell)
{
//	int i = 0;
//	i = sizeof(*value);
	if (pBlockDef == NULL)
		return false;
	
	int iObjects = 0;

	int iTextLength = 0;
	if (value->IsVisibleCell)
		if (value->Text)
			iTextLength = _tcslen(value->Text);
	//TAlxdCellTextType textType = TAlxdCellTextType[value->TextType];

	if (iTextLength > 0)
	{
		if (value->TextType == 1)//MText
		{
			iObjects = RedrawMText(coord, size, value, iActualLinesInCell);
		}
		else
		if (value->TextType == 2)//DText
		{
			iObjects = RedrawDText(coord, size, value, iActualLinesInCell);
		}
		else
		if (value->TextType == 3)//BText
		{
			iObjects = RedrawBText(coord, size, value, iActualLinesInCell);
		}
	}
	else
		iActualLinesInCell = 1;

	if (!oarxEraseCell(value, iObjects))
		return false;

	return true;
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Selections Exports & internal functions
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern "C" __declspec(dllexport) bool oarxRedrawSelection(PDrawingPair coord, PDrawingPair size, Adesk::IntDbId blkRefId)
{
	AcDbObjectId refId;
	refId.setFromOldId(blkRefId);

	//open block reference
	AcDbBlockReference *pBlockRef = NULL;
	if (acdbOpenObject(pBlockRef, refId, AcDb::kForRead) != Acad::eOk)
	{
		if (pBlockRef)
			pBlockRef->close();
		return FALSE;
	}

	AcGeMatrix3d trns = pBlockRef->blockTransform();
	pBlockRef->close();

	AcGePoint3d pt1 = AcGePoint3d(coord->x, coord->y, 0);
	AcGePoint3d pt4 = AcGePoint3d(coord->x + size->x, coord->y - size->y, pt1.z);
	AcGePoint3d pt2 = AcGePoint3d(pt4.x, pt1.y, pt1.z);
	AcGePoint3d pt3 = AcGePoint3d(pt1.x, pt4.y, pt1.z);

	pt1.transformBy(trns);
	pt2.transformBy(trns);
	pt3.transformBy(trns);
	pt4.transformBy(trns);

	acdbWcs2Ucs(asDblArray(pt1), asDblArray(pt1), false);
	acdbWcs2Ucs(asDblArray(pt2), asDblArray(pt2), false);
	acdbWcs2Ucs(asDblArray(pt3), asDblArray(pt3), false);
	acdbWcs2Ucs(asDblArray(pt4), asDblArray(pt4), false);

	acedGrDraw(asDblArray(pt1), asDblArray(pt2), 1, 0);
	acedGrDraw(asDblArray(pt2), asDblArray(pt4), 1, 0);
	acedGrDraw(asDblArray(pt1), asDblArray(pt3), 1, 0);
	acedGrDraw(asDblArray(pt3), asDblArray(pt4), 1, 0);
	return TRUE;
}

extern "C" __declspec(dllexport) int oarxAcEdRedraw()
{
	return acedRedraw(NULL, 1);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Items Exports & internal functions
//
//	логика такая, что при записи, записываются ВСЕ значения,
//	окромя строк и других указателей, т.к. они могут быть равны NULL'у
//	но при чтении значения могут отсутствовать, если вдруг юзверь-программер
//	их не указал в списке. главное, что каждый список предваряет номер или пара номеров
//	определяющих местоположение элемента
//
//	Alxd 12.03.2007 22:48
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool ParseItemsList(struct resbuf * value, Adesk::IntDbId obj, TAlxdItemExchangeFunc func, int ACount, char AType)
{
	struct resbuf* pTemp = value;
	PAlxdItemExchange AlxdItemExchange = NULL;
	int i;
	bool canparse;

	while (pTemp != NULL)
	{
		if (pTemp->restype == 10)
		{
			canparse = false;
			i = pTemp->resval.rpoint[0];

			if ((i < 0) || (i > ACount))
				return false;

			AlxdItemExchange = func(obj, i);
			canparse = true;
		}
		
		if (canparse)
		{
			switch (pTemp->restype)
			{
			case 40:
				AlxdItemExchange->Size = pTemp->resval.rreal;
				break;
			case 72:
				AlxdItemExchange->HorizontalAlignment = (byte)pTemp->resval.rint;
				break;
			case 73:
				AlxdItemExchange->VerticalAlignment = (byte)pTemp->resval.rint;
				break;
			case 280:
				AlxdItemExchange->Visible = pTemp->resval.rint == 0 ? false : true;
				break;
			case 1:
				vclImport::vclUpdString(pTemp->resval.rstring, AlxdItemExchange->Title);
				break;
			}//switch
		}
		pTemp = pTemp->rbnext;
	}

	return true;
}

bool BuildItemsList(struct resbuf ** value, Adesk::IntDbId obj, TAlxdItemExchangeFunc func, int ACount, char AType)
{
	struct resbuf* pLast = NULL;
	PAlxdItemExchange AlxdItemExchange = NULL;
	for (int i = 0; i < ACount; i++)
	{
		AlxdItemExchange = func(obj, i);

		if (!i)
		{
			*value = acutNewRb(10);
			pLast = *value;
		}
		else
		{
			pLast->rbnext = acutNewRb(10);
			pLast = pLast->rbnext;
		}
		pLast->resval.rpoint[0] = i;
		pLast->resval.rpoint[1] = 0; //zero
		pLast->resval.rpoint[2] = 0; //zero

		pLast->rbnext = acutNewRb(40);
		pLast = pLast->rbnext;
		pLast->resval.rreal = AlxdItemExchange->Size;

		pLast->rbnext = acutNewRb(72);
		pLast = pLast->rbnext;
		pLast->resval.rint = AlxdItemExchange->HorizontalAlignment;

		pLast->rbnext = acutNewRb(73);
		pLast = pLast->rbnext;
		pLast->resval.rint = AlxdItemExchange->VerticalAlignment;

		pLast->rbnext = acutNewRb(280);
		pLast = pLast->rbnext;
		pLast->resval.rint = (byte)AlxdItemExchange->Visible;

		if (AlxdItemExchange->Title)
		{
			pLast->rbnext = acutNewRb(1);
			pLast = pLast->rbnext;
			acutUpdString(AlxdItemExchange->Title, pLast->resval.rstring);
			//alxdUpdString(Item->Title, pLast->resval.rstring);
		}
	}

	return true;
}

extern "C" __declspec(dllexport) bool oarxReadItemsList(Adesk::IntDbId obj, TAlxdItemExchangeFunc func, Adesk::IntDbId dict, int ACount, char AType)
{
	AcDbObjectId dictId;
	dictId.setFromOldId(dict);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForRead);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;

	if (pDict->getAt(AType == 0 ? columnXdata : rowXdata, xrecObjId) != Acad::eOk)
		return false;

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForRead);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* items;
	pX->rbChain(&items);

	ParseItemsList(items, obj, func, ACount, AType);

	acutRelRb(items);

	return true;
}

extern "C" __declspec(dllexport) bool oarxWriteItemsList(Adesk::IntDbId obj, TAlxdItemExchangeFunc func, Adesk::IntDbId dict, int ACount, char AType)
{
#ifdef _DEBUG
	OutputDebugString(_T("\noarxWriteItemsList\n"));
	CString str;
	#if !defined(_WIN64) && !defined (_AC64)
		str.Format(_T("%d"), obj);
	#else
		str.Format(_T("%I64d"), obj);
	#endif
	OutputDebugString(str);

	#if !defined(_WIN64) && !defined (_AC64)
		str.Format(_T("%d"), func);
	#else
		str.Format(_T("%I64d"), func);
	#endif
	OutputDebugString(str);
#endif

	AcDbObjectId dictId;
	dictId.setFromOldId(dict);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForWrite);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;

	if (pDict->getAt(AType == 0 ? columnXdata : rowXdata, xrecObjId) != Acad::eOk)
	{
		AcDbObjectPointer<AcDbXrecord> pX;
		pX.create();
		if (pX.object()==NULL)
			return false;

	    if (pDict->setAt(AType == 0 ? columnXdata : rowXdata, pX.object(), xrecObjId) != Acad::eOk)
			return false;
	}

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForWrite);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* items = NULL;
	BuildItemsList(&items, obj, func, ACount, AType);

    if (pX->setFromRbChain(*items) != Acad::eOk)
	{
        acutRelRb(items);
        return false;
    }

	acutRelRb(items);

	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Header Exports
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//only erase header and attributes
extern "C" __declspec(dllexport) bool oarxEraseHeader(PAlxdSpreadSheetExchange value)
{
	if (pBlockDef == NULL)
		return false;

	if (value->HeaderRefId != 0)
	{
		//erase AttributeDef in block
		if (EraseAttDef(pBlockDef) != RTNORM)
			return false;

		//erase AttributeRef in block
		AcDbObjectId objId;
		AcDbBlockReference *pBlockRef = NULL;

		objId.setFromOldId(value->BlockRefId);
		if (acdbOpenObject(pBlockRef, objId, AcDb::kForWrite, true) != Acad::eOk)
		{
			if (pBlockRef)
				pBlockRef->close();
			return false;
		}

		if (EraseAttRef(pBlockRef) != RTNORM)
			return false;

		pBlockRef->close();
	
		//erase header in block
		objId.setFromOldId(value->HeaderRefId);
		if (acdbOpenObject(pBlockRef, objId, AcDb::kForWrite) != Acad::eOk)
		{
			if (pBlockRef)
				pBlockRef->close();
			return false;
		}

		pBlockRef->erase();
		pBlockRef->close();
	}
	
	return true;
}

//only insert header in block and clone attributes
extern "C" __declspec(dllexport) bool oarxRedrawHeader(PAlxdSpreadSheetStyleExchange style, PAlxdSpreadSheetExchange value)
{
	if (pBlockDef == NULL)
		return false;

	//try insert from file name, then from block name
	ACHAR *sText = NULL;
	acutUpdString(style->HeaderFileName, sText);

	int ret;
	AcDbObjectId objId;
	AcGePoint3d position = AcGePoint3d(0, 0, 0);

	ret = DrawBlock(sText, position, AcGePoint3d(1, 1, 1), 0, objId);

	if (ret != RTNORM)
	{
		acutUpdString(style->HeaderBlockName, sText);
		ret = DrawBlock(sText, position, AcGePoint3d(1, 1, 1), 0, objId);
	}

	acutDelString(sText);

	if (ret != RTNORM)
		return false;

	value->HeaderRefId = objId.asOldId();

	//edit header reference
	AcDbBlockReference *pBlockRef = NULL;

	if (acdbOpenObject(pBlockRef, objId, AcDb::kForWrite) != Acad::eOk)
	{
		if (pBlockRef)
			pBlockRef->close();
		return false;
	}

	pBlockRef->setColorIndex(0);
	pBlockRef->setLineWeight(AcDb::kLnWtByBlock);
	pBlockRef->setLayer(_T("0"));

	AcDbObjectId defId;
	defId = pBlockRef->blockTableRecord();

	if (EraseAttRef(pBlockRef) != RTNORM)
		return false;

	pBlockRef->close();

	//clone attribute definition from header to block
	DrawBlockAttDef(pBlockDef, defId);
	
	return true;
}

//only insert attribute reference
extern "C" __declspec(dllexport) bool oarxRedrawAttributeRef(PAlxdSpreadSheetExchange value)
{
	if (pBlockDef == NULL)
		return false;

	Acad::ErrorStatus ret;
	AcDbBlockReference *pBlockRef = NULL;

	if (value->BlockRefPtrJig == 0)
	{
		AcDbObjectId objId;
		objId.setFromOldId(value->BlockRefId);
		ret = acdbOpenObject(pBlockRef, objId, AcDb::kForWrite, true);
		if ((ret != Acad::eOk) && (ret != Acad::eWasOpenForWrite))
		{
			if (pBlockRef)
				pBlockRef->close();
			return false;
		}
	}
	else
		pBlockRef = (AcDbBlockReference*)value->BlockRefPtrJig;

	DrawBlockAttRef(pBlockDef, pBlockRef);

	if (value->BlockRefPtrJig == 0)
		pBlockRef->close();

	return true;
}

//only insert attribute reference
extern "C" __declspec(dllexport) bool oarxRepositionAttributeRef(PAlxdSpreadSheetExchange value, ads_point oldPt)
{
	//if (pBlockDef == NULL)
	//	return false;
	//if (value->BlockRefPtrJig != 0) return true;

	AcGeVector3d vec = AcGePoint3d(value->BlockDefInsPt[0], value->BlockDefInsPt[1], value->BlockDefInsPt[2]) - AcGePoint3d(oldPt[0], oldPt[1], oldPt[2]);
	if (vec.isZeroLength())
		return true;

	AcDbObjectId objId;
	AcDbBlockReference *pBlockRef = NULL;

	if (value->BlockRefPtrJig == 0)
	{
		objId.setFromOldId(value->BlockRefId);
		if (acdbOpenObject(pBlockRef, objId, AcDb::kForWrite) != Acad::eOk)
		{
			if (pBlockRef)
				pBlockRef->close();
			return false;
		}
	}
	else
		pBlockRef = (AcDbBlockReference*)value->BlockRefPtrJig;

	
	AcGePoint3d basePoint;

	AcDbObjectIterator *pObjectIterator = NULL;
	pObjectIterator = pBlockRef->attributeIterator();

	if (pObjectIterator == NULL)
	{
		if (pBlockRef)
			pBlockRef->close();
		return false;
	}
	
	//AcDbEntity *pEnt;
	AcDbAttribute *pAtt = NULL;
	AcDbObjectId attId;
	while (!pObjectIterator->done())
	{
		attId = pObjectIterator->objectId();

		//pEnt = NULL;
		//pEnt = pObjectIterator->entity();

		//if (pEnt)
		//{
		//	pAtt = AcDbAttribute::cast(pEnt);
		if (acdbOpenObject(pAtt, attId, AcDb::kForWrite) == Acad::eOk)
		{
			basePoint = pAtt->position() - vec;
			pAtt->setPosition(basePoint);

			basePoint = pAtt->alignmentPoint() - vec;
			pAtt->setAlignmentPoint(basePoint);

			pAtt->close();
			//pEnt->close();
		//}
		}
		pObjectIterator->step();
	}

	delete pObjectIterator;

	if (value->BlockRefPtrJig == 0)
		pBlockRef->close();

	return true;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Style Exports & internal functions
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool ParseStyleList(struct resbuf * value, PAlxdSpreadSheetStyleExchange style, PAlxdSpreadSheetExchange defs)
{
	struct resbuf* pTemp = value;

	while (pTemp != NULL)
	{
		switch (pTemp->restype)
		{
		//case 50:Version = pTemp->resval.rreal;
		//		break;

		case 2:	vclImport::vclUpdString(pTemp->resval.rstring, style->StyleName);
				break;
		case 3:	vclImport::vclUpdString(pTemp->resval.rstring, style->HeaderFileName);
				break;
		case 4:	vclImport::vclUpdString(pTemp->resval.rstring, style->HeaderBlockName);
				break;

		case 6:	vclImport::vclUpdString(pTemp->resval.rstring, style->TextLayer);
				break;
		case 7:	vclImport::vclUpdString(pTemp->resval.rstring, style->TextStyleName);
				vclImport::vclDelString(style->TextStyleFontName);
				vclImport::vclDelString(style->TextStyleBigFontName);
				break;
		case 8:	vclImport::vclUpdString(pTemp->resval.rstring, style->VerBorderLayer);
				break;
		case 9:	vclImport::vclUpdString(pTemp->resval.rstring, style->HorBorderLayer);
				break;
		//case 10:memcpy(defs->BlockDefInsPt, pTemp->resval.rpoint, 24);
		//		break;

		case 38:style->DefaultSize = pTemp->resval.rreal;
				break;
		case 40:style->TextHeight = pTemp->resval.rreal;
				break;
		case 41:style->TextWidthFactor = pTemp->resval.rreal;
				break;
		case 42:style->TextObliqueAngle = pTemp->resval.rreal;
				break;

		case 56:style->TextMargins.Left = pTemp->resval.rreal;
				break;
		case 57:style->TextMargins.Bottom = pTemp->resval.rreal;
				break;
		case 58:style->TextMargins.Right = pTemp->resval.rreal;
				break;
		case 59:style->TextMargins.Top = pTemp->resval.rreal;
				break;
		case 60:style->TextColor = pTemp->resval.rint;
				break;
		case 61:style->VerBorderColor = pTemp->resval.rint;
				break;
		case 62:style->HorBorderColor = pTemp->resval.rint;
				break;
		case 64:style->TextWeight = pTemp->resval.rint;
				break;
		case 65:style->VerBorderWeight = pTemp->resval.rint;
				break;
		case 66:style->HorBorderWeight = pTemp->resval.rint;
				break;

		case 70:style->ColCount = pTemp->resval.rint;
				break;
		case 71:style->RowCount = pTemp->resval.rint;
				break;

		case 280:style->DrawBorder = pTemp->resval.rint;
				break;
		case 281:style->FillCell = pTemp->resval.rint;
				break;
		case 282:style->TextFit = pTemp->resval.rint;
				break;
		case 283:style->TextType = pTemp->resval.rint;
				break;
		case 287:style->Primary = pTemp->resval.rint;
				break;
		case 288:style->Justify = (byte)pTemp->resval.rint;
				break;
		case 289:style->Lock = pTemp->resval.rint == 0?false:true;
				break;
		case 300:vclImport::vclUpdString(pTemp->resval.rstring, style->Note);
				break;
		case 301:vclImport::vclUpdString(pTemp->resval.rstring, style->Data);
				break;
			//alxdUpdString(pTemp->resval.rstring, pGridProperty->FLink);
		case 330:
				AcDbObjectId headerId;
				acdbGetObjectId(headerId, pTemp->resval.rlname);
				defs->HeaderRefId = headerId.asOldId();
				break;
		}//switch

		pTemp = pTemp->rbnext;
	}

	return true;
}

bool BuildStyleList(struct resbuf ** value, PAlxdSpreadSheetStyleExchange style, PAlxdSpreadSheetExchange defs)
{
	*value = acutBuildList(
		50, 8.0,

		//10, defs->BlockDefInsPt,

		38,	style->DefaultSize,				//x
		40,	style->TextHeight,					//x
		41,	style->TextWidthFactor,			//x
		42,	style->TextObliqueAngle,			//x

		56,	style->TextMargins.Left,			//x
		57,	style->TextMargins.Bottom,		//x
		58,	style->TextMargins.Right,		//x
		59,	style->TextMargins.Top,			//x

		60,	style->TextColor,					//x
		61,	style->VerBorderColor,				//x
		62,	style->HorBorderColor,				//x

		64,	style->TextWeight,					//x
		65,	style->VerBorderWeight,			//x
		66,	style->HorBorderWeight,			//x

		70,	style->ColCount,					//x
		71,	style->RowCount,					//x

		280,	style->DrawBorder,				//x
		281,	style->FillCell,				//x
		282,	style->TextFit,				//x
		283,	style->TextType,				//x
		
		287,	style->Primary,
		288,	style->Justify,			//x
		289,	style->Lock,				//x

		0);

	//goto to end of list
	resbuf *pLast = NULL;
	for (pLast = *value; pLast->rbnext != NULL; pLast = pLast->rbnext) {;}

	if (defs->HeaderRefId != 0)
	{
		AcDbObjectId headerId;
		headerId.setFromOldId(defs->HeaderRefId);

		//ads_name ent;
		//acdbGetAdsName(ent, headerId);

		pLast->rbnext = acutNewRb(330);
		pLast = pLast->rbnext;
		acdbGetAdsName(pLast->resval.rlname, headerId);
		//memcpy(pLast->resval.rlname, ent, sizeof(ads_name));
	}

	if (style->StyleName)
	{
		pLast->rbnext = acutNewRb(2);
		pLast = pLast->rbnext;
		acutUpdString(style->StyleName, pLast->resval.rstring);
	}

	if (style->HeaderFileName)
	{
		pLast->rbnext = acutNewRb(3);
		//pLast->rbnext = alxdNewRb(3);
		pLast = pLast->rbnext;
		acutUpdString(style->HeaderFileName, pLast->resval.rstring);
		//alxdUpdString(pGridProperty->FHeaderFileName, pLast->resval.rstring);
	}

	if (style->HeaderBlockName)
	{
		pLast->rbnext = acutNewRb(4);
		pLast = pLast->rbnext;
		acutUpdString(style->HeaderBlockName, pLast->resval.rstring);
	}

	if (style->TextLayer)
	{
		pLast->rbnext = acutNewRb(6);
		pLast = pLast->rbnext;
		acutUpdString(style->TextLayer, pLast->resval.rstring);
	}

	if (style->TextStyleName)
	{
		pLast->rbnext = acutNewRb(7);
		pLast = pLast->rbnext;
		acutUpdString(style->TextStyleName, pLast->resval.rstring);
	}

	if (style->VerBorderLayer)
	{
		pLast->rbnext = acutNewRb(8);
		pLast = pLast->rbnext;
		acutUpdString(style->VerBorderLayer, pLast->resval.rstring);
	}

	if (style->HorBorderLayer)
	{
		pLast->rbnext = acutNewRb(9);
		pLast = pLast->rbnext;
		acutUpdString(style->HorBorderLayer, pLast->resval.rstring);
	}

	if (style->Note)
	{
		pLast->rbnext = acutNewRb(300);
		pLast = pLast->rbnext;
		acutUpdString(style->Note, pLast->resval.rstring);
	}

	if (style->Data)
	{
		pLast->rbnext = acutNewRb(301);
		pLast = pLast->rbnext;
		acutUpdString(style->Data, pLast->resval.rstring);
	}

/*
	int		ColCount;+
    int		RowCount;+
    double	DefaultSize;+
    char	Primary;+
    char	Justify;+

    char	DrawBorder;+
    char	FillCell;+
    char	TextFit;+
    char	TextType;+

    ACHAR*	StyleName;+
    ACHAR*	TextStyleName;+
    ACHAR*	TextStyleFontName;
    ACHAR*	TextStyleBigFontName;

    double	TextHeight;+
    double	TextWidthFactor;+
    double	TextObliqueAngle;+
    TAlxdMargins TextMargins;+

    int		TextColor;+
    ACHAR*	TextLayer;+
    int		TextWeight;+

    int		VerBorderColor;+
    ACHAR*	VerBorderLayer;+
    int		VerBorderWeight;+

    int		HorBorderColor;+
    ACHAR*	HorBorderLayer;+
    int		HorBorderWeight;+

    ACHAR*	HeaderFileName;+
    ACHAR*	HeaderBlockName;+

    bool	Lock;+

    ACHAR*	Note;
	ACHAR*	Data;
*/
	return true;
}

extern "C" __declspec(dllexport) bool oarxReadStyleList(PAlxdSpreadSheetStyleExchange style, PAlxdSpreadSheetExchange value)
{
	AcDbObjectId dictId;
	dictId.setFromOldId(value->DictionaryId);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForRead);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;
	if (pDict->getAt(gridXdata, xrecObjId) != Acad::eOk)
		return false;

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForRead);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* head = NULL;
	pX->rbChain(&head);

	if (!ParseStyleList(head, style, value))
	{
		if (head)			
			acutRelRb(head);
		return false;
	}

	acutRelRb(head);

	return true;
}

extern "C" __declspec(dllexport) bool oarxWriteStyleList(PAlxdSpreadSheetStyleExchange style, PAlxdSpreadSheetExchange value)
{
	AcDbObjectId dictId;
	dictId.setFromOldId(value->DictionaryId);

	AcDbDictionaryPointer pDict(dictId, AcDb::kForWrite);
	if (pDict.openStatus() != Acad::eOk)
		return false;

	AcDbObjectId xrecObjId;

	if (pDict->getAt(gridXdata, xrecObjId) != Acad::eOk)
	{
		AcDbObjectPointer<AcDbXrecord> pX;
		pX.create();
		if (pX.object() == NULL)
			return false;

	    if (pDict->setAt(gridXdata, pX.object(), xrecObjId)!=Acad::eOk)
			return false;
	}

	AcDbObjectPointer<AcDbXrecord> pX(xrecObjId, AcDb::kForWrite);
	if (pX.openStatus() != Acad::eOk)
		return false;

	struct resbuf* head = NULL;
	if (!BuildStyleList(&head, style, value))
	{
		if (head)
			acutRelRb(head);
        return false;
	}

//	Acad::ErrorStatus rrr = pX->setFromRbChain(*head);
//	if (rrr != Acad::eOk)
    if (pX->setFromRbChain(*head) != Acad::eOk)
	{
        acutRelRb(head);
        return false;
    }

	acutRelRb(head);

	return true;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Grid Exports
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern "C" __declspec(dllexport) bool oarxIsUniqueGrid(PAlxdSpreadSheetExchange value)
{
	AcDbObjectId objId;
	objId.setFromOldId(value->BlockDefId);

	//open block definition
	AcDbBlockTableRecord* pBlockDef = NULL;
	if (acdbOpenObject(pBlockDef, objId, AcDb::kForWrite) != Acad::eOk)
	{
		if (pBlockDef)
			pBlockDef->close();
		return false;
	}

	AcDbObjectIdArray ids;
	pBlockDef->getBlockReferenceIds(ids);
	pBlockDef->close();

	if (ids.length() == 1)
		return true;

	return false;
}


extern "C" __declspec(dllexport) bool oarxEraseGrid(PAlxdSpreadSheetExchange value)
{
	AcDbObjectId objId;
	objId.setFromOldId(value->BlockDefId);

	//open block definition
	AcDbBlockTableRecord* pBlkDef = NULL;
	if (acdbOpenObject(pBlkDef, objId, AcDb::kForWrite) != Acad::eOk)
	{
		if (pBlkDef)
			pBlkDef->close();
		return false;
	}

	AcDbBlockTableRecordIterator *pIterator = NULL;
	if (pBlkDef->newIterator(pIterator) != Acad::eOk)
	{
		if (pIterator)
			delete pIterator;

		pBlkDef->close();
		return false;
	}

	Acad::ErrorStatus res;
	AcDbEntity *pEnt = NULL;
	for (pIterator->start(); !pIterator->done(); pIterator->step())
	{
		res = pIterator->getEntity(pEnt, AcDb::kForWrite);
		if (res == Acad::eOk)
		{
			if (pEnt->id().asOldId() != value->HeaderRefId)
				pEnt->erase();
			pEnt->close();
		}
	}
	delete pIterator;
	
	pBlkDef->close();

	return true;
}

extern "C" __declspec(dllexport) bool oarxOpenGrid(PAlxdSpreadSheetExchange value)
{
	if (pBlockDef != NULL)
		return false;

	Acad::ErrorStatus res;

	//get objid of block definition
	AcDbObjectId objId;
	objId.setFromOldId(value->BlockDefId);

	//actrTransactionManager->startTransaction();

	//Lock document
	//AcAp::DocLockMode lm = acDocManager->document(objId.database())->lockMode();
	res = acDocManager->lockDocument(acDocManager->document(objId.database()), AcAp::kAutoWrite); //good
	if (res != Acad::eOk)
		return false;
	//lm = acDocManager->document(objId.database())->lockMode();

	//Open block definition for writing
	res = acdbOpenObject(pBlockDef, objId, AcDb::kForWrite);
	if (res != Acad::eOk)
	{
		if (pBlockDef)
			pBlockDef->close();
		pBlockDef = NULL;
		return false;
	}

	return true;
}

extern "C" __declspec(dllexport) bool oarxCloseGrid(PAlxdSpreadSheetExchange value)
{
	if (pBlockDef == NULL)
		return false;
	
	//Justify
	AcGePoint3d origin = asPnt3d(value->BlockDefInsPt);
	pBlockDef->setOrigin(origin);

	//Close block definition
	pBlockDef->close();
	pBlockDef = NULL;

	//actrTransactionManager->endTransaction();
/*
	if (RedrawObj(value->BlockRefId) != RTNORM)
		return false;

	if (RedrawScreen() != RTNORM)
		return false;
*/
	return true;
}

extern "C" __declspec(dllexport) bool oarxApplyBlockRef(PAlxdSpreadSheetExchange value)
{
	Acad::ErrorStatus err;

	//open block reference
	AcDbObjectId objId;
	objId.setFromOldId(value->BlockRefId);

	AcDbBlockReference *pBlockRef = NULL;
	if (acdbOpenObject(pBlockRef, objId, AcDb::kForRead) != Acad::eOk)
	{
		if (pBlockRef)
			pBlockRef->close();
		return false;
	}

	memcpy(value->BlockRefInsPt, asDblArray(pBlockRef->position()), 24 /* sizeof(double)*3 */);
	AcGeScale3d scl_ft = pBlockRef->scaleFactors();
	value->BlockRefSclFt[0] = scl_ft[0];
	value->BlockRefSclFt[1] = scl_ft[1];
	value->BlockRefSclFt[2] = scl_ft[2];
	value->BlockDefId = pBlockRef->blockTableRecord().asOldId();
	pBlockRef->close();

	//open block definition
	objId.setFromOldId(value->BlockDefId);

	AcDbBlockTableRecord* pBlockDef = NULL;
	if (acdbOpenObject(pBlockDef, objId, AcDb::kForRead) != Acad::eOk)
	{
		if (pBlockDef)
			pBlockDef->close();
		return false;
	}

	memcpy(value->BlockDefInsPt, asDblArray(pBlockDef->origin()), 24 /* sizeof(double)*3 */);
	value->DictionaryId = pBlockDef->extensionDictionary().asOldId();
	pBlockDef->close();

	return true;
}

extern "C" __declspec(dllexport) bool oarxCreateBlockDef(PAlxdSpreadSheetExchange value)
{
	//Lock document
	//Acad::ErrorStatus err;
	//err = acDocManager->lockDocument(acDocManager->curDocument(), AcAp::kAutoWrite); //good
	//if (err != Acad::eOk)
	//	return false;
//	acDocManager->lockDocument(acDocManager->document(BlockDefId.database()), AcAp::kAutoWrite); //good
//	acDocManager->lockDocument(acDocManager->curDocument(), AcAp::kAutoWrite); //good

	int res;
	struct resbuf *pMain;
	ads_point pt = { 0.0, 0.0, 0.0 };

	pMain = acutBuildList(RTDXF0, _T("BLOCK"), 2, _T("*U"), 70, 1, 10, pt, 0);
	res = acdbEntMake(pMain);
	acutRelRb(pMain);

	if (res != RTNORM)
	{
		acutPrintf(_T("\nUnable to start anonymous block."));
		return false;
	}

	pMain = acutBuildList(RTDXF0, _T("ENDBLK"), 0 );
	res = acdbEntMake(pMain);
	acutRelRb(pMain);

	if (res != RTKWORD)
	{
		acutPrintf(_T("\nUnable to close anonymous block."));
		return false;
	}

	ACHAR blockname[20];
	res = acedGetInput(blockname); 

	if (res != RTNORM)
	{ 
	    acutPrintf(_T("\nAnonymous block not created."));
	    return false; 
	} 

	AcDbBlockTable *pBlockTable = NULL;
	if (acdbHostApplicationServices()->workingDatabase()->getBlockTable(pBlockTable, AcDb::kForRead) != Acad::eOk)
		return false;

	AcDbObjectId BlockDefId;
	if (pBlockTable->getAt(blockname, BlockDefId) != Acad::eOk)
	{
		pBlockTable->close();
		return false;
	}

	pBlockTable->close();

	AcDbBlockTableRecord* pBlockDef = NULL;
	if (acdbOpenObject(pBlockDef, BlockDefId, AcDb::kForWrite) != Acad::eOk)
		return false;

	pBlockDef->createExtensionDictionary();
	pBlockDef->setOrigin(AcGePoint3d(value->BlockDefInsPt[0], value->BlockDefInsPt[1], value->BlockDefInsPt[2]));
	value->DictionaryId = pBlockDef->extensionDictionary().asOldId();
	value->BlockDefId = pBlockDef->id().asOldId();
	//memcpy(value->BlockDefInsPt, asDblArray(pBlockDef->origin()), 24 /* sizeof(double)*3 */);	
	pBlockDef->close();

	if (value->BlockRefId != 0)
	{
		//open block reference
		AcDbObjectId objId;
		objId.setFromOldId(value->BlockRefId);

		AcDbBlockReference *pBlockRef = NULL;
		if (acdbOpenObject(pBlockRef, objId, AcDb::kForWrite) != Acad::eOk)
		{
			if (pBlockRef)
				pBlockRef->close();
			return false;
		}

		pBlockRef->setBlockTableRecord(BlockDefId);
		pBlockRef->close();

		value->HeaderRefId = 0;
	}

//	HeaderBlockRefId.setNull();
//	FHeaderInvalidate = true;
//	FInvalidate = true;

	return true;
}

extern "C" __declspec(dllexport) bool oarxBoundaryBlockDef(PAlxdSpreadSheetExchange value, VARIANT* pminPt, VARIANT* pmaxPt)
{
	if (pBlockDef == NULL)
		return false;
	
	pBlockDef->setOrigin(AcGePoint3d(value->BlockDefInsPt[0], value->BlockDefInsPt[1], value->BlockDefInsPt[2]));

	AcDbExtents BlockDefExt = AcDbExtents();
	BlockDefExt.addBlockExt(pBlockDef);
	::VariantCopy(pmaxPt, AcAxPoint3d(BlockDefExt.maxPoint()).asVariantPtr());
	::VariantCopy(pminPt, AcAxPoint3d(BlockDefExt.minPoint()).asVariantPtr());

	return true;
}

extern "C" __declspec(dllexport) bool oarxLockDocument(Adesk::IntDbId refId)
{
	if (refId == 0)
		return false;

	AcDbObjectId objId;
	objId.setFromOldId(refId);

	Acad::ErrorStatus res;
	res = acDocManager->lockDocument(acDocManager->document(objId.database()), AcAp::kAutoWrite); //good
	if (res != Acad::eOk)
		return false;
	if (acDocManager->lockDocument(acDocManager->document(objId.database()), AcAp::kAutoWrite) != Acad::eOk)
		return false;

	return true;
}

extern "C" __declspec(dllexport) bool oarxRedrawScreen(Adesk::IntDbId refId)
{
	//recordGraphicsModified
	AcDbObjectId objId;
	objId.setFromOldId(refId);

	if (objId.isNull())
		return false;

	AcDbBlockReference *pBlockRef = NULL;
	if (acdbOpenObject(pBlockRef, objId, AcDb::kForWrite) != Acad::eOk)
		return false;
	pBlockRef->recordGraphicsModified();
	pBlockRef->close();

	ads_name ent;
	acdbGetAdsName(ent, objId);
	acdbEntUpd(ent);

	actrTransactionManager->queueForGraphicsFlush();
	actrTransactionManager->flushGraphics();
	acedUpdateDisplay();

	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	OPM Functions
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

BOOL OPM_GetSelectionPoint(AcGePoint3d& sel_ecs_pt)
{
	//определение имени примитива
	//определение точки его выбора
	int res;
	ads_name ss;
	res = acedSSGet(_T("_I"), NULL, NULL, NULL, ss);

	struct resbuf *rbpp = NULL;
	res = acedSSNameX(&rbpp, ss, 0);
	res = acedSSFree(ss);

	if (!rbpp)
		return FALSE;

	AcDbObjectId refId;
	AcGePoint3d sel_pt;
	bool selPtFlag = false;

	struct resbuf* pTemp = rbpp;
	while (pTemp->rbnext != NULL)
	{
		//acutPrintf(_T("restype: %d"), pTemp->restype);
		switch (pTemp->restype)
		{
		case RTENAME:
			acdbGetObjectId(refId, pTemp->resval.rlname);
			break;
		case RT3DPOINT:
			sel_pt = asPnt3d(pTemp->resval.rpoint);
			selPtFlag = true;
			break;
		}
		pTemp=pTemp->rbnext;
	}
	res = acutRelRb(rbpp);

	if (refId.isNull())
	{
		acutPrintf(_T("\nThere are not entity name in list."));
		return FALSE;
	}

	if (!selPtFlag)
	{
		acutPrintf(_T("\nThere are not selection point in list."));
		return FALSE;
	}

	AcDbObjectId defId;
	//AcGePoint3d ref_pt;
	AcGePoint3d def_pt;
	//AcGeScale3d scl_ft;
	AcGeMatrix3d ref_mx;
	//double rot_an;

	//определение геометрических параметров BlockReference
	AcDbBlockReference *pBlockRef = NULL;
	if (acdbOpenObject(pBlockRef, refId, AcDb::kForRead) != Acad::eOk)
	{
		if (pBlockRef)
			pBlockRef->close();
		return FALSE;
	}

	defId = pBlockRef->blockTableRecord();
	ref_mx = pBlockRef->blockTransform();
	//ref_pt = pBlockRef->position();
	//scl_ft = pBlockRef->scaleFactors();
	//rot_an = pBlockRef->rotation();
	pBlockRef->close();

	//определение геометрических параметров BlockTableRecord
	AcDbBlockTableRecord* pBlockDef = NULL;
	if (acdbOpenObject(pBlockDef, defId, AcDb::kForRead) != Acad::eOk)
	{
		if (pBlockDef)
			pBlockDef->close();
		return FALSE;
	}

	def_pt = pBlockDef->origin();
	pBlockDef->close();

	//вычисление точки внутри блока (ECS)
	sel_ecs_pt = sel_pt;
	//ref_mx.invert
	sel_ecs_pt = sel_ecs_pt.transformBy(ref_mx.invert());
	//sel_ecs_pt -= ref_pt.asVector();
	//sel_ecs_pt[0] /= scl_ft[0];
	//sel_ecs_pt[1] /= scl_ft[1];
	//sel_ecs_pt[2] /= scl_ft[2];
	sel_ecs_pt += def_pt.asVector();

	return TRUE;
}

AcDbObjectId OPM_GetObjectId(IUnknown *pUnk)
{
	IAcadBaseObject* pBase = NULL;
	if (FAILED(pUnk->QueryInterface(__uuidof(IAcadBaseObject), reinterpret_cast<LPVOID*>(&pBase))))
		return 0;

	AcDbObjectId objId = NULL;
	if (FAILED(pBase->GetObjectId(&objId)))
	{
		pBase->Release();
		return 0;
	}

	return objId;
}

BOOL HasAlxdGridData(AcDbObjectId dicId, AcDbObjectId& xrecId)
{
	AcDbDictionaryPointer pDict(dicId, AcDb::kForRead);
	if (pDict.openStatus() != Acad::eOk)
		return FALSE;

	if (pDict->getAt(gridXdata, xrecId) != Acad::eOk)
		return FALSE;

	return TRUE;
}

BOOL HasAlxdGridData(AcDbObjectId dicId)
{
	AcDbObjectId xrecId;
	return HasAlxdGridData(dicId, xrecId);
}

BOOL HasAlxdGridEntity(AcDbObjectId refId, AcDbObjectId& xrecId)
{
	//is this block reference?
	AcDbObject *pObject = NULL;
	if (acdbOpenObject(pObject, refId, AcDb::kForRead) != Acad::eOk)
	{
		if (pObject)
			pObject->close();
		return FALSE;
	}

	if (!pObject->isKindOf(AcDbBlockReference::desc()))
	{
		pObject->close();
		return FALSE;
	}

	AcDbBlockReference* pBlockRef = NULL;
	pBlockRef = AcDbBlockReference::cast(pObject);

	AcDbObjectId defId;
	defId = pBlockRef->blockTableRecord();

	pBlockRef->close();

	//it has a dictionary?
	AcDbBlockTableRecord* pBlockDef = NULL;
	if (acdbOpenObject(pBlockDef, defId, AcDb::kForRead) != Acad::eOk)
	{
		if (pBlockDef)
			pBlockDef->close();
		return FALSE;
	}

	AcDbObjectId dicId;
	dicId = pBlockDef->extensionDictionary();

	pBlockDef->close();

	if (dicId.isNull())
		return FALSE;

	//has alxdgrid xrecord?	
	return HasAlxdGridData(dicId, xrecId);
}

BOOL HasAlxdGridEntity(AcDbObjectId refId)
{
	AcDbObjectId xrecId;
	return HasAlxdGridEntity(refId, xrecId);
}

extern "C" __declspec(dllexport) bool oarxIsATableBlockReference(Adesk::IntDbId obj)
{
	AcDbObjectId refId;
	AcDbObjectId xrecId;
	refId.setFromOldId(obj);
	return HasAlxdGridEntity(refId, xrecId) == 1 ? true : false;
}

//
//  индивидуальная процедура для чтения значений стиля таблицы
//  индивидуально только потому, что надо было сделать ее быстрой,
//  иначе надо было бы ее делать через IAlxdApplication (COM)
//
int OPM_GetNumData(AcDbObjectId objId, long index, VARIANT* pVarData)
{
	AcDbObjectId xrecId;
	if (HasAlxdGridEntity(objId, xrecId) != TRUE)
		return RTERROR;

	AcDbObjectPointer<AcDbXrecord> pX(xrecId, AcDb::kForRead);
	if (pX.openStatus() != Acad::eOk)
		return RTERROR;

	struct resbuf* rb = NULL;
	
	if (pX->rbChain(&rb) != Acad::eOk)
		return RTERROR;

	if (rb == NULL)
		return RTERROR;

	//поиск resbuf с нужным индексом
	struct resbuf* pTemp = rb;
	while ((pTemp->restype != index) && (pTemp->rbnext != NULL))
		pTemp=pTemp->rbnext;

	//если не найден индекс, то вернуть пустую строку, где надо
	if (pTemp->restype != index)
		switch (index)
		{
		case 2:		//Style name
		case 3:		//Header file name
		case 300:	//Link
			::VariantCopy(pVarData, &_variant_t(""));
			acutRelRb(rb);
			return RTNORM;
		default:
			acutRelRb(rb);
			return RTERROR;
		}
			
	switch (pTemp->restype)
	{
	case 2:		//Style name
	case 3:		//Header file name
	case 6:		//Text Layer
	case 7:		//Text style
	case 8:		//Vertical Borders Layer
	case 9:		//Horizontal Borders Layer
	case 300:	//Link
		::VariantCopy(pVarData, &_variant_t(pTemp->resval.rstring));
		break;
	case 38: //Item Default Size
	case 40: //Text Height
	case 41: //Text Width Factor
	case 42: //Text Oblique Angle
	case 56: //Text Margin Left
	case 57: //Text Margin Bottom
	case 58: //Text Margin Right
	case 59: //Text Margin Top
		::VariantCopy(pVarData, &_variant_t(pTemp->resval.rreal));
		break;
	case 60: //Text Color
	case 61: //Vertical Borders Color
	case 62: //Horizontal Borders Color
	case 70: //Col Count
	case 71: //Row Count
		::VariantCopy(pVarData, &_variant_t(pTemp->resval.rlong));
		break;
	case 64: //Text Lineweight
	case 65: //Vertical Borders Lineweight
	case 66: //Horizontal Borders Lineweight
	case 280: //Draw Border
	case 281: //Fill Cell
	case 282: //Text Fit
	case 283: //Text Type
//		case 285:
//		case 286:
	case 288: //Justify
		::VariantCopy(pVarData, &_variant_t((long)pTemp->resval.rint));
		break;
	}
	acutRelRb(rb);

	return RTNORM;
}

int OPM_SetNumData(AcDbObjectId objId, long index, const VARIANT varData)
{
	IAlxdApplicationPtr alxdapp(L"AlxdGrid.AlxdApplication"); 
	IAlxdEditorPtr alxdeditor = alxdapp->AlxdEditor;
	IAlxdSpreadSheetsPtr alxdspreadsheets = alxdeditor->AlxdSpreadSheets;
	int i = alxdspreadsheets->Add();

	IAlxdSpreadSheetPtr alxdspreadsheet = alxdspreadsheets->Items[i];
	//alxdspreadsheet->BlockReferenceID = objId.asOldId();

	#if !defined(_WIN64) && !defined (_AC64)
		alxdspreadsheet->put_BlockReferenceID32(objId.asOldId());
	#else
		alxdspreadsheet->put_BlockReferenceID(objId.asOldId());
	#endif
	
	alxdspreadsheet->ReadFromDictionary();
	//при перерисовке затираются все примитивы блока и он отрисовывается заново
	//и, самое главное, пересчитываются координаты колонок и рядов и их размеры
	alxdspreadsheet->RedrawBlockDefinition();

	IAlxdSpreadSheetStylePtr alxdspreadsheetstyle = alxdspreadsheet->AlxdSpreadSheetStyle;
	alxdspreadsheetstyle->PropertyByNum[index] = varData;

	alxdspreadsheet->RedrawBlockDefinition();

	alxdapp->Quit();

	return RTNORM;
}

int OPM_GetCellTextData(AcDbObjectId objId, VARIANT* pVarData)
{
	AcGePoint3d sel_ecs_pt;
	if (OPM_GetSelectionPoint(sel_ecs_pt) == FALSE)
		return RTERROR;

	IAlxdApplicationPtr alxdapp(L"AlxdGrid.AlxdApplication"); 
	IAlxdEditorPtr alxdeditor = alxdapp->AlxdEditor;
	IAlxdSpreadSheetsPtr alxdspreadsheets = alxdeditor->AlxdSpreadSheets;
	int i = alxdspreadsheets->Add();

	IAlxdSpreadSheetPtr alxdspreadsheet = alxdspreadsheets->Items[i];
	//alxdspreadsheet->BlockReferenceID = objId.asOldId();
	#if !defined(_WIN64) && !defined (_AC64)
		alxdspreadsheet->put_BlockReferenceID32(objId.asOldId());
	#else
		alxdspreadsheet->put_BlockReferenceID(objId.asOldId());
	#endif
	
	alxdspreadsheet->ReadFromDictionary();
	alxdspreadsheet->Recalculate();												
	alxdspreadsheet->RedrawBlockDefinition();

	//IAlxdItemsPtr cols = alxdspreadsheet->AlxdColumns;
	int acol = alxdspreadsheet->AlxdColumns->Index[sel_ecs_pt.x];
	int arow = alxdspreadsheet->AlxdRows->Index[sel_ecs_pt.y];

	if ((acol < 0) || (arow < 0))
	{
		alxdapp->Quit();
		return RTERROR;
	}

	//IAlxdSpreadSheetSelectionPtr selection = alxdspreadsheet->AlxdSpreadSheetSelections->Items[0];
	//selection->SetSelectionRect(acol, arow, acol, arow);
	//alxdspreadsheet->AlxdSpreadSheetSelections->Redraw();

	IAlxdCellPtr cell = alxdspreadsheet->AlxdCells->Items[acol, arow];
	::VariantCopy(pVarData, &_variant_t(cell->Contain));

	alxdapp->Quit();

	return RTNORM;
}

int OPM_SetCellTextData(AcDbObjectId objId, const VARIANT varData)
{
	AcGePoint3d sel_ecs_pt;
	if (OPM_GetSelectionPoint(sel_ecs_pt) == FALSE)
		return RTERROR;

	IAlxdApplicationPtr alxdapp(L"AlxdGrid.AlxdApplication"); 
	IAlxdEditorPtr alxdeditor = alxdapp->AlxdEditor;
	IAlxdSpreadSheetsPtr alxdspreadsheets = alxdeditor->AlxdSpreadSheets;
	int i = alxdspreadsheets->Add();

	IAlxdSpreadSheetPtr alxdspreadsheet = alxdspreadsheets->Items[i];
	//alxdspreadsheet->BlockReferenceID = objId.asOldId();
	//alxdspreadsheet->put_BlockReferenceID(objId.asOldId());
	#if !defined(_WIN64) && !defined (_AC64)
		alxdspreadsheet->put_BlockReferenceID32(objId.asOldId());
	#else
		alxdspreadsheet->put_BlockReferenceID(objId.asOldId());
	#endif
	alxdspreadsheet->ReadFromDictionary();
	alxdspreadsheet->RedrawBlockDefinition();

	int acol = alxdspreadsheet->AlxdColumns->Index[sel_ecs_pt.x];
	int arow = alxdspreadsheet->AlxdRows->Index[sel_ecs_pt.y];
	if ((acol < 0) || (arow < 0))
	{
		alxdapp->Quit();
		return RTERROR;
	}

	//IAlxdSpreadSheetSelectionPtr selection = alxdspreadsheet->AlxdSpreadSheetSelections->Items[0];
	//selection->SetSelectionRect(acol, arow, acol, arow);
	//alxdspreadsheet->AlxdSpreadSheetSelections->Redraw();

	IAlxdCellPtr cell = alxdspreadsheet->AlxdCells->Items[acol, arow];
	cell->Contain = _bstr_t(varData);

	alxdspreadsheet->RedrawBlockDefinition();
	alxdapp->Quit();
	return RTNORM;
}

int OPM_GetTextStyleCount()
{
	int ret = 0;
	AcDbTextStyleTable *pTextStyleTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pTextStyleTable, AcDb::kForRead);

	AcDbTextStyleTableIterator *pItr;
	if (pTextStyleTable->newIterator(pItr) == Acad::eOk) 
	{
		AcDbTextStyleTableRecord *pRecord = NULL;

		while (!pItr->done())
		{
			pItr->step();
			ret++;
		}
	}//if 
	delete pItr;
	pTextStyleTable->close();
	return ret;	
}

int OPM_GetTextStyleNameAt(int index, BSTR *pBstrValueName)
{
	//AcString ret = new AcString();
	int c = 0;
	AcDbTextStyleTable *pTextStyleTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pTextStyleTable, AcDb::kForRead);

	AcDbTextStyleTableIterator *pItr;
	if (pTextStyleTable->newIterator(pItr) == Acad::eOk) 
	{
		AcDbTextStyleTableRecord *pRecord = NULL;

		while (!pItr->done())
		{
			if (c == index)
				if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
				{
					const ACHAR *pName;
					pRecord->getName(pName);
					*pBstrValueName =::SysAllocString (pName) ;
					pRecord->close();
					break;
				}	 
			pItr->step();
			c++;
		}
	}//if 
	delete pItr;
	pTextStyleTable->close();
	return 0;	
}

int OPM_GetTextStyleHandleAt(int index, VARIANT* pValue)
{
	//AcString ret = new AcString();
	int c = 0;
	AcDbTextStyleTable *pTextStyleTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pTextStyleTable, AcDb::kForRead);

	AcDbTextStyleTableIterator *pItr;
	if (pTextStyleTable->newIterator(pItr) == Acad::eOk) 
	{
		AcDbTextStyleTableRecord *pRecord = NULL;

		while (!pItr->done())
		{
			if (c == index)
				if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
				{
					AcDbHandle h;
					pRecord->getAcDbHandle(h);

					ACHAR pName[1024];
					h.getIntoAsciiBuffer(pName);

					::VariantCopy(pValue, &_variant_t(pName));
					pRecord->close();
					break;
				}	 
			pItr->step();
			c++;
		}
	}//if 
	delete pItr;
	pTextStyleTable->close();
	return 0;	
}

int OPM_GetTextStyleCurrentValueData(IUnknown *pUnk, VARIANT *pVarData)
{
	AcDbObjectId objId = OPM_GetObjectId(pUnk);
	if (OPM_GetNumData(objId, 7, pVarData) == RTERROR)
		return 1;
	
	AcString s = pVarData->bstrVal;
	AcDbTextStyleTable *pTextStyleTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pTextStyleTable, AcDb::kForRead);

	AcDbTextStyleTableRecord *pRecord = NULL;
	if (pTextStyleTable->getAt(s, pRecord, AcDb::kForRead) == Acad::eOk)
	{
		AcDbHandle h;
		pRecord->getAcDbHandle(h);

		ACHAR pName[1024];
		h.getIntoAsciiBuffer(pName);

		::VariantCopy(pVarData, &_variant_t(pName));
		pRecord->close();
	}
	pTextStyleTable->close();
	return 0;
}

int OPM_SetTextStyleCurrentValueData(IUnknown *pUnk, const VARIANT varData)
{
	//AcString s = _variant_t(varData).bstrVal;//. .bstrVal;
	AcString s = varData.bstrVal;
	AcDbTextStyleTable *pTextStyleTable;
	acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pTextStyleTable, AcDb::kForRead);

	const ACHAR *pName;
	bool f = false;
	AcDbTextStyleTableIterator *pItr;
	if (pTextStyleTable->newIterator(pItr) == Acad::eOk) 
	{
		AcDbTextStyleTableRecord *pRecord = NULL;

		while (!pItr->done())
		{
			if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
			{
				AcDbHandle h;
				pRecord->getAcDbHandle(h);

				ACHAR pHandle[1024];
				h.getIntoAsciiBuffer(pHandle);

				if (s == pHandle)
				{
					pRecord->getName(pName);
					pRecord->close();
					f = true;
					break;
				}
				pRecord->close();
			}	 
			pItr->step();
		}
	}//if 
	delete pItr;
	pTextStyleTable->close();

	//assign here
	if (f)
	{
		AcDbObjectId objId = OPM_GetObjectId(pUnk);
		OPM_SetNumData(objId, 7, _variant_t(pName));
	}

	return 0;
}


int OPM_GetValueByIndex(int index, ACHAR *pValue, BSTR *pBstrValueName)
{
	AcString buf  = pValue;
	int p = 0;
	int s = 0;
	int c = 0;

	do
	{
		p = buf.findOneOf(_T(","));
		if (c == index)
		{
			if (p < 0)
				buf = buf.substr(0, buf.length());
			else
				buf = buf.substr(0, p);
			break;
		}
		buf = buf.substr(p + 1, buf.length() - p);
		c++;
	}
	while (p >= 0);
	
	buf = buf.substr(1, buf.length() - 2);
	*pBstrValueName =::SysAllocString(buf);

	return 0;
}
BOOL OPM_GetStyleName()
{
	try
	{
		IAlxdApplicationPtr alxdapp(L"AlxdGrid.AlxdApplication"); 

		_bstr_t fname;
		IAlxdStyleManagerPtr alxdstylemanager = alxdapp->AlxdStyleManager;
		int ret = alxdstylemanager->Select(fname.GetAddress());
		if (ret == IDOK)
		{
			IAlxdSpreadSheetStylePtr tempStyle = alxdapp->CreateAlxdSpreadSheetStyle();

			if (tempStyle->LoadFrom(fname))
			{
				acutPrintf(_T("\nATable style [%s] loaded successfully."), fname.GetBSTR());

				IAlxdEditorPtr alxdeditor = alxdapp->AlxdEditor;
				IAlxdSpreadSheetsPtr alxdspreadsheets = alxdeditor->AlxdSpreadSheets;			

				struct resbuf *filter = acutBuildList(RTDXF0, _T("INSERT"), 0);
				ads_name sset;

				int r = acedSSGet(_T("_I"), NULL, NULL, filter, sset);
				acutRelRb(filter);

				if (r == RTNORM)
				{
					ads_name entres;
					AcDbObjectId objId;
					long len = 0;

					acedSSLength(sset, &len);

					for (int i = 0; i < len; i++)
					{
						acedSSName(sset, i, entres);
						acdbGetObjectId(objId, entres);
							
						if (HasAlxdGridEntity(objId) == TRUE)
						{
							int i = alxdspreadsheets->Add();
							IAlxdSpreadSheetPtr alxdspreadsheet = alxdspreadsheets->Items[i];

							#if !defined(_WIN64) && !defined (_AC64)
								alxdspreadsheet->put_BlockReferenceID32(objId.asOldId());
							#else
								alxdspreadsheet->put_BlockReferenceID(objId.asOldId());
							#endif

							alxdspreadsheet->ReadFromDictionary();

							alxdspreadsheet->AlxdSpreadSheetStyle->CopyFrom(tempStyle);
							alxdspreadsheet->RedrawBlockDefinitionFull();
							alxdspreadsheet->WriteToDictionary();
						}//if...
					}//for...

					acedSSFree(sset);
					//acedSSSetFirst(NULL, NULL);
				}//if
			}
			else
				acutPrintf(_T("\nFailed to load ATable style [%s]."), fname.GetBSTR());
		}
		alxdapp->Quit();
	}
	catch(...)
	{
		return FALSE;
	}
	
	return TRUE;
}




/*
void iSpreadSheet::setOpenState()
{
	struct resbuf *val = acutNewRb(RTSTR);
	acutUpdString(_T("ATABLEOPENED"), val->resval.rstring);
	acedSetVar(_T("USERS5"), val);
	acutDelString(val->resval.rstring);
	acutRelRb(val);
}

void iSpreadSheet::setCloseState()
{
	struct resbuf *val = acutNewRb(RTSTR);
	acutUpdString(_T(""), val->resval.rstring);
	acedSetVar(_T("USERS5"), val);
	acutDelString(val->resval.rstring);
	acutRelRb(val);
}

static bool FindInSelection(iSpreadSheet* ssh, ads_name sset)
	{
		bool ret = false;

		ads_name entres;
		ads_point entpt;
		AcDbObjectId objId;
		AcGePoint3d pickpoint;
		long len = 0;

		acedSSLength(sset, &len);

		for (int i = 0; i < len; i++)
		{
			struct resbuf *pRb;
			int res = acedSSNameX(&pRb, sset, 0);

			if (res != RTNORM)
				continue;

			int j;
			struct resbuf *pTemp;
			for (j=1, pTemp = pRb; j<3; j++, pTemp = pTemp->rbnext) { ; }
			ads_name_set(pTemp->resval.rlname, entres);
			acdbGetObjectId(objId, entres);

			for (j=1, pTemp = pRb; j<7; j++, pTemp = pTemp->rbnext) { ; }
			ads_point_set(pTemp->resval.rpoint, entpt);
			pickpoint = asPnt3d(entpt);
			
			acutRelRb(pRb);

			//acedSSName(sset, i, entres);
			//acdbGetObjectId(objId, entres);
				
			//check here, if there is that grid!!! like Has(objid)
			//if (HasAlxdGridEntity(objId))
			if (ssh->IsAlxdATable(objId))
			{
				ssh->Read();
				ssh->RedrawBlockDefinition(0, 0, true);

				AcGeMatrix3d transform = ssh->getBlockRefTransform();
				transform.invert();
				pickpoint.transformBy(transform);

				iAlxdSelections* selections = ssh->getSelections();
				POINT cell = selections->getCellFromPickPoint(pickpoint);
				int k = selections->Add();

				iAlxdSelection* selection = selections->Items(k);
				CRect rs = new CRect(cell.x, cell.y, cell.x, cell.y);
				selection->setSelectionRect(rs);

				ret = true;
				break;
			}
		}//for...

		return ret;
	}

	static bool SelectOnScreen(iSpreadSheet* ssh)
	{
		ads_name sset;	
		struct resbuf *filter = acutBuildList(RTDXF0, _T("INSERT"), 0);
		int res = RTERROR;							
		bool ret = false;

		while ((res != RTNORM) && (res != RTCAN))
			res = acedSSGet(NULL, NULL, NULL, filter, sset);

		if (res != RTNORM)
			acutPrintf(_T("\nNothing selected."));
		else
		{
			ret = FindInSelection(ssh, sset);
			acedSSFree(sset);
		}
		acutRelRb(filter);

		return ret;
	}

	static bool InsertNew(iSpreadSheet* ssh)
	{
		bool ret = false;
		AlxdJig* pJig = new AlxdJig(ssh->getBlockDefId());

		AcEdJig::DragStatus status;
		do
		{
			status = pJig->startJig();
			switch (status)
			{
				case AcEdJig::kKW1:
					{
						acutPrintf(_T("Style"));
						break;
					}
				case AcEdJig::kKW2:
					{
						acutPrintf(_T("Properties"));
						break;
					}
				case AcEdJig::kKW3:
					{
						acutPrintf(_T("Justify"));
						break;
					}
				case AcEdJig::kKW4:
					{
						acutPrintf(_T("Edit"));
						if (SelectOnScreen(ssh))
						{
							//DocVars.docData().xSpreadSheet->setSpreadSheet(ssh);
							//DocVars.docData().setIsATableOpened(true);
							//ssh->setOpenState();
							//PostMessage(adsw_acadMainWnd(), WM_GRAPHICSREDRAW, 0, 0);
							//PostMessage(adsw_acadMainWnd(), WM_SELECTIONREDRAW, 0, 0);
						}
						status = AcEdJig::kCancel;
						ret = true;
						break;
					}
				case AcEdJig::kKW5:
					{
						acutPrintf(_T("Recalculate"));
						break;
					}
				case AcEdJig::kKW6:
					{
						status = AcEdJig::kCancel;
						break;
					}
				case AcEdJig::kNormal:
					{
						ssh->setBlockRefId(pJig->getObjectId());

						ssh->getStyle()->setColCount(5);
						ssh->getStyle()->setRowCount(10);
						int cc = ssh->getStyle()->getColCount();
						int rc = ssh->getStyle()->getRowCount();

						for (int i = 0; i < cc; i++)
							for (int j = 0; j < rc; j++)
							{
								AcString tmp;
								tmp.format(_T("this is a text in cell %ix%i"), i, j);
								ssh->getCell(i, j)->setText(tmp);
							}

						ssh->getCol(0)->setSize(30);
						ssh->getCell(0, 0)->setText(_T("zero"));

						RECT r;
						r.left = 1;
						r.top = 2;
						r.right = 3;
						r.bottom = 4;
						ssh->getCells()->JoinCellInRect(r);

						r.left = 1;
						r.top = 0;
						r.right = 3;
						r.bottom = 0;
						ssh->getCells()->JoinCellInRect(r);

						ssh->getVerBorder(0,9)->setState(dbNoDraw);
						ssh->getHorBorder(0,10)->setState(dbNoDraw);

						ssh->AddRow();
						ssh->InsertRow(0);
						ssh->InsertRow(4);

						ssh->AddColumn();
						ssh->InsertColumn(0);
						ssh->InsertColumn(3);

						ssh->DeleteRow(0);
						//ssh->DeleteRow(4);

						ssh->DeleteColumn(0);
						ssh->DeleteColumn(3);
						ssh->DeleteColumn(3);




						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);

						ssh->Write();

						//int k = ssh->getSelections()->Add();
						//ssh->getSelections()->Items(k)->setSelectionRect(CRect(0,0,0,0));
						int k = ssh->getSelections()->Add();
						ssh->getSelections()->Items(k)->setSelectionRect(CRect(0,0,0,0));
						


						status = AcEdJig::kCancel;
						ret = true;
						break;
					}
			}
		}
		while (status != AcEdJig::kCancel);
		delete pJig;

		return ret;
	}

	static bool EditGroupTable(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Close eXit"));
			ret = acedGetKword(_T("\nSelect operation [Close/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Close")))
				{
					DocVars.docData().setIsATableOpened(false);
					ssh->setCloseState();
					return true; //exit immediate
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
						canExit = true;
			}
			else
			if (ret == RTCAN)
					canExit = true;
		}

		return false;
	}

	static bool EditGroupStyle(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("DefaultSize Justify Borders FillCell Text VerBorders HorBorders eXit"));
			ret = acedGetKword(_T("\nSelect property [DefaultSize/Justify/Borders/FillCell/Text/VerBorders/HorBorders/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("DefaultSize")))
					canExit = EditGroupStyleDefaultSize(ssh);
				else
				if (!_tcsicmp(buf, _T("Justify")))
				{
					canExit = EditGroupStyleJustify(ssh);
				}
				else
				if (!_tcsicmp(buf, _T("Borders")))
				{
					canExit = EditGroupStyleBorders(ssh);
				}
				else
				if (!_tcsicmp(buf, _T("FillCell")))
				{
					canExit = EditGroupStyleFillCell(ssh);
				}
				else
				if (!_tcsicmp(buf, _T("Text")))
				{
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("VerBorders")))
				{
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("HorBorders")))
				{
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
						canExit = true;
			}
			else
			if (ret == RTCAN)
					canExit = true;
		}

		return false;
	}

	static bool EditGroupStyleDefaultSize(iSpreadSheet* ssh)
	{
		ads_real r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, NULL);
			ret = acedGetReal(_T("\nSpecify default size of cells: "), &r);

			if (ret == RTNORM)
			{
				//ssh->getCells()->setTextHeight(r);
				ssh->getStyle()->setDefaultSize(r);
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;
			}
			else
			if (ret == RTCAN)
				canExit = true;
			
		}//while
		return false;
	}

	static bool EditGroupStyleJustify(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("TLeft TRight BLeft BRight"));
			ret = acedGetKword(_T("\nSpecify justify of table [TLeft/TRight/BLeft/BRight]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("TLeft")))
				{
					ssh->getStyle()->setJustify(jsTopLeft);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("TRight")))
				{
					ssh->getStyle()->setJustify(jsTopRight);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("BLeft")))
				{
					ssh->getStyle()->setJustify(jsBottomLeft);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("BRight")))
				{
					ssh->getStyle()->setJustify(jsBottomRight);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}				
			}
			else
			if (ret == RTCAN)
				canExit = true;
		}//while
		return false;
	}

	static bool EditGroupStyleBorders(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("NoDraw Draw"));
			ret = acedGetKword(_T("\nSpecify borders state of table [NoDraw/Draw]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("NoDraw")))
				{
					ssh->getStyle()->setDrawBorder(dbNoDraw);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Draw")))
				{
					ssh->getStyle()->setDrawBorder(dbDraw);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}			
			}
			else
			if (ret == RTCAN)
				canExit = true;
		}//while
		return false;
	}

	static bool EditGroupStyleFillCell(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("NoFill Fill"));
			ret = acedGetKword(_T("\nSpecify fill cell state of table [NoFill/Fill]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("NoFill")))
				{
					ssh->getStyle()->setFillCell(fcNoFill);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Fill")))
				{
					ssh->getStyle()->setFillCell(fcFill);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}			
			}
			else
			if (ret == RTCAN)
				canExit = true;
		}//while
		return false;
	}

	static bool EditGroupColumns(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Add Insert Delete MultiAdd eXit"));
			ret = acedGetKword(_T("\nSelect operation [Add/Insert/Delete/MultiAdd/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Add")))
				{
					ssh->AddColumn();
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
				}
				else
				if (!_tcsicmp(buf, _T("Insert")))
				{
					ssh->InsertColumns();
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
				}
				else
				if (!_tcsicmp(buf, _T("Delete")))
				{
					ssh->DeleteColumns();
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
				}
				else
				if (!_tcsicmp(buf, _T("MultiAdd")))
				{
					int numbers = 0;
					acedInitGet(RSG_NOZERO | RSG_NONEG, NULL);
					ret = acedGetInt(_T("\nEnter the number of columns : "), &numbers);

					if (ret == RTNORM)
					{
						for (int i = 0; i < numbers; i++) { ssh->AddColumn(); }
						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);
						ssh->RedrawBlockReference();
						ssh->Write();
					}
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
						canExit = true;
			}
			else
			if (ret == RTCAN)
					canExit = true;
		}

		return false;
	}

	static bool EditGroupRows(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Add Insert Delete MultiAdd eXit"));
			ret = acedGetKword(_T("\nSelect operation [Add/Insert/Delete/MultiAdd/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Add")))
				{
					ssh->AddRow();
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
				}
				else
				if (!_tcsicmp(buf, _T("Insert")))
				{
					ssh->InsertRows();
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
				}
				else
				if (!_tcsicmp(buf, _T("Delete")))
				{
					ssh->DeleteRows();
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
				}
				else
				if (!_tcsicmp(buf, _T("MultiAdd")))
				{
					int numbers = 0;
					acedInitGet(RSG_NOZERO | RSG_NONEG, NULL);
					ret = acedGetInt(_T("\nEnter the number of rows : "), &numbers);

					if (ret == RTNORM)
					{
						for (int i = 0; i < numbers; i++) { ssh->AddRow(); }
						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);
						ssh->RedrawBlockReference();
						ssh->Write();
					}
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
						canExit = true;
			}
			else
			if (ret == RTCAN)
					canExit = true;
		}
		return false;
	}

	static bool EditGroupCells(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Fit Type Style Height WidthFactor ObliqueAngle Between Rotation HAlign VAlign Margins Color Layer LIneweight eXit"));
			ret = acedGetKword(_T("\nSelect property [Fit/Type/Style/Height/WidthFactor/ObliqueAngle/Between/Rotation/HAlign/VAlign/Margins/Color/Layer/LIneweight/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Fit")))
					canExit = EditGroupCellsTextFit(ssh);
				else
				if (!_tcsicmp(buf, _T("Type")))
					canExit = EditGroupCellsTextType(ssh);
				else
				if (!_tcsicmp(buf, _T("Style")))
					canExit = EditGroupCellsStyle(ssh);
				else
				if (!_tcsicmp(buf, _T("Height")))
					canExit = EditGroupCellsTextHeight(ssh);
				else
				if (!_tcsicmp(buf, _T("WidthFactor")))
					canExit = EditGroupCellsTextWidthFactor(ssh);
				else
				if (!_tcsicmp(buf, _T("ObliqueAngle")))
					canExit = EditGroupCellsTextObliqueAngle(ssh);
				else
				if (!_tcsicmp(buf, _T("Between")))
					canExit = EditGroupCellsBetween(ssh);
				else
				if (!_tcsicmp(buf, _T("Rotation")))
					canExit = EditGroupCellsRotation(ssh);
				else
				if (!_tcsicmp(buf, _T("HAlign")))
					canExit = EditGroupCellsHAlign(ssh);
				else
				if (!_tcsicmp(buf, _T("VAlign")))
					canExit = EditGroupCellsVAlign(ssh);
				else
				if (!_tcsicmp(buf, _T("Margins")))
					canExit = EditGroupCellsMargins(ssh);
				else
				if (!_tcsicmp(buf, _T("Color")))
					canExit = EditGroupCellsColor(ssh);
				else
				if (!_tcsicmp(buf, _T("Layer")))
					canExit = EditGroupCellsLayer(ssh);
				else
				if (!_tcsicmp(buf, _T("LIneweight")))
					canExit = EditGroupCellsLineweight(ssh);				
				else
					if (!_tcsicmp(buf, _T("eXit")))
						canExit = true;
			}
			else
			if (ret == RTCAN)
					canExit = true;
		}
		return false;
	}

	static bool EditGroupCellsTextFit(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Default Fit Break Unbreaked Fitted eXit"));
			ret = acedGetKword(_T("\nSelect text fit [Default/Fit/Break/Unbreaked/Fitted/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Default")))
				{
					ssh->getCells()->setTextFit(ctfDefault);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Fit")))
				{
					ssh->getCells()->setTextFit(ctfsFit);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Break")))
				{
					ssh->getCells()->setTextFit(ctfsBreak);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Unbreaked")))
				{
					ssh->getCells()->setTextFit(ctfsUnbreaked);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Fitted")))
				{
					ssh->getCells()->setTextFit(ctfsFitted);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsTextType(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Default MText DText Block eXit"));
			ret = acedGetKword(_T("\nSelect text type [Default/MText/DText/Block/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Default")))
				{
					ssh->getCells()->setTextType(cttsDefault);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("MText")))
				{
					ssh->getCells()->setTextType(cttsMText);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("DText")))
				{
					ssh->getCells()->setTextType(cttsDText);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Block")))
				{
					ssh->getCells()->setTextType(cttsBText);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsTextHeight(iSpreadSheet* ssh)
	{
		ads_real r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Default eXit"));
			ret = acedGetReal(_T("\nSpecify height of text or [Default/eXit]: "), &r);

			if (ret == RTKWORD)
			{
				acedGetInput(buf);
				if (!_tcsicmp(buf, _T("Default")))
				{
					ssh->getCells()->setTextHeight(0);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTNORM)
			{
				ssh->getCells()->setTextHeight(r);
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsTextWidthFactor(iSpreadSheet* ssh)
	{
		ads_real r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Default eXit"));
			ret = acedGetReal(_T("\nSpecify width factor of text or [Default/eXit]: "), &r);

			if (ret == RTKWORD)
			{
				acedGetInput(buf);
				if (!_tcsicmp(buf, _T("Default")))
				{
					ssh->getCells()->setTextWidthFactor(0);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTNORM)
			{
				ssh->getCells()->setTextWidthFactor(r);
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsTextObliqueAngle(iSpreadSheet* ssh)
	{
		ads_real r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Default eXit"));
			ret = acedGetReal(_T("\nSpecify oblique angle of text or [Default/eXit]: "), &r);

			if (ret == RTKWORD)
			{
				acedGetInput(buf);
				if (!_tcsicmp(buf, _T("Default")))
				{
					ssh->getCells()->setTextObliqueAngle(-86);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTNORM)
			{
				ssh->getCells()->setTextObliqueAngle(r);
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsBetween(iSpreadSheet* ssh)
	{
		ads_real r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Default eXit"));
			ret = acedGetReal(_T("\nSpecify distance between lines of text or [Default/eXit]: "), &r);

			if (ret == RTKWORD)
			{
				acedGetInput(buf);
				if (!_tcsicmp(buf, _T("Default")))
				{
					ssh->getCells()->setBetween(0);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTNORM)
			{
				ssh->getCells()->setBetween(r);
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsRotation(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("0 90 eXit"));
			ret = acedGetKword(_T("\nSelect text rotation [0/90/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("0")))
				{
					ssh->getCells()->setRotation(0);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("90")))
				{
					ssh->getCells()->setRotation(90);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsHAlign(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Default Left Center Right eXit"));
			ret = acedGetKword(_T("\nSelect alignment [Default/Left/Center/Right/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Default")))
				{
					ssh->getCells()->setHorizontalAlignment(cthaDefault);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Left")))
				{
					ssh->getCells()->setHorizontalAlignment(cthaLeft);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Center")))
				{
					ssh->getCells()->setHorizontalAlignment(cthaCenter);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Right")))
				{
					ssh->getCells()->setHorizontalAlignment(cthaRight);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsVAlign(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Default Baseline Bottom Middle Top eXit"));
			ret = acedGetKword(_T("\nSelect alignment [Default/Baseline/Bottom/Middle/Top/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Default")))
				{
					ssh->getCells()->setVerticalAlignment(ctvaDefault);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Baseline")))
				{
					ssh->getCells()->setVerticalAlignment(ctvaBaseline);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Bottom")))
				{
					ssh->getCells()->setVerticalAlignment(ctvaBottom);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Middle")))
				{
					ssh->getCells()->setVerticalAlignment(ctvaMiddle);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Top")))
				{
					ssh->getCells()->setVerticalAlignment(ctvaTop);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsMargins(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Left Top Right Bottom eXit"));
			ret = acedGetKword(_T("\nSelect margin of text [Left/Top/Right/Bottom/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Left")))
				{
					EditGroupCellsMargin(ssh, 140);
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Top")))
				{
					EditGroupCellsMargin(ssh, 143);
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Right")))
				{
					EditGroupCellsMargin(ssh, 142);
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Bottom")))
				{
					EditGroupCellsMargin(ssh, 141);
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsMargin(iSpreadSheet* ssh, int index)
	{
		ads_real r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			ACHAR* ind;

			switch (index)
			{
			case 140:
				acutUpdString(_T("left"), ind);
				break;
			case 141:
				acutUpdString(_T("bottom"), ind);
				break;
			case 142:
				acutUpdString(_T("right"), ind);
				break;
			case 143:
				acutUpdString(_T("top"), ind);
				break;
			}
			
			ACHAR tmp[100];
			_stprintf(tmp, _T("\nSpecify %s margin of text or [Default/eXit]: "), ind);

			acedInitGet(0, _T("Default eXit"));
			ret = acedGetReal(tmp, &r);

			if (ret == RTKWORD)
			{
				acedGetInput(buf);
				if (!_tcsicmp(buf, _T("Default")))
				{
					switch (index)
					{
					case 140:
						ssh->getCells()->setMarginLeft(-1);
					case 141:
						ssh->getCells()->setMarginBottom(-1);
					case 142:
						ssh->getCells()->setMarginRight(-1);
					case 143:
						ssh->getCells()->setMarginTop(-1);
					}
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTNORM)
			{
				switch (index)
				{
				case 140:
					ssh->getCells()->setMarginLeft(r);
				case 141:
					ssh->getCells()->setMarginBottom(r);
				case 142:
					ssh->getCells()->setMarginRight(r);
				case 143:
					ssh->getCells()->setMarginTop(r);
				}
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;
			}
			
		}//while
		return false;
	}

	static bool EditGroupCellsColor(iSpreadSheet* ssh)
	{
		int r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			AcCmColor c;
			acedInitGet(0, _T("Defaut Color eXit"));
			ret = acedGetInt(_T("\nSpecify color of text or [Default/Color/eXit]: "), &r);
			//ret = acedGetKword(_T("\nSelect color of text [Defaut/Color/eXit]: "), buf);

			if (ret == RTKWORD)
			{
				acedGetInput(buf);
				if (!_tcsicmp(buf, _T("Defaut")))
				{
					ssh->getCells()->setHasDefaultColor(true);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Color")))
				{
					Adesk::Boolean s = acedSetColorDialog(r, Adesk::kTrue, 0);
					if (s == Adesk::kTrue)
					{
						c.setColorIndex(r);
						ssh->getCells()->setColor(c);
						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);
						ssh->RedrawBlockReference();
						ssh->Write();
						canExit = true;
					}
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTNORM)
			{
				c.setColorIndex(r);
				ssh->getCells()->setColor(c);
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;
			}
		}//while
		return false;
	}

	static bool EditGroupCellsStyle(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			AcDbObjectId objId;
			acedInitGet(0, _T("Defaut Style eXit"));
			ret = acedGetKword(_T("\nSelect option [Default/Style/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Defaut")))
				{
					objId.setNull();
					ssh->getCells()->setTextStyleObjectId(objId);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Style")))
				{
					int r;
					int c = EditGroupCellsStyleList();
					while (!canExit)
					{
						acedInitGet(0, NULL);
						ret = acedGetInt(_T("\nSpecify style of text: "), &r);

						if (ret == RTNORM)
						{
							if ((r < 1) || (r > c))
								acutPrintf(_T("\nNumber of text style is must be in range [1...%i]."), c);
							else
							{
								objId = EditGroupCellsStyleIndex2Id(r);
								if (objId.isNull())
									acutPrintf(_T("\nText style not found! Please, try again."));
								else
								{
									ssh->getCells()->setTextStyleObjectId(objId);
									ssh->Recoordinate();
									ssh->RedrawBlockDefinition(0, 0, true);
									ssh->RedrawBlockReference();
									ssh->Write();
									canExit = true;
								}
							}
						}
						else
						if (ret == RTCAN)
							canExit = true;
					}//while
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
		}//while
		return false;
	}

	static int EditGroupCellsStyleList()
	{
		acutPrintf(_T("Text styles:"));
		AcDbTextStyleTable *pTextStyleTable;
		acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pTextStyleTable, AcDb::kForRead);

		int i = 0;
		AcDbTextStyleTableIterator *pItr;
		if (pTextStyleTable->newIterator(pItr) == Acad::eOk) 
		{
			AcDbTextStyleTableRecord *pRecord = NULL;

			while (!pItr->done())
			{
				i++;
				if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
				{
					AcString pName;
					ACHAR* pTypeface = NULL;
					Adesk::Boolean bDummy;
					int iDummy;
					pRecord->getName(pName);

					pRecord->font(pTypeface, bDummy, bDummy, iDummy, iDummy);
					if (_tcslen(pTypeface) != 0)
						acutPrintf(_T("\n%d. Style name: \"%s\"\tFont typeface: %s"), i, pName.kACharPtr(), pTypeface);
					else
					{
						pRecord->fileName(pTypeface);
						acutPrintf(_T("\n%d. Style name: \"%s\"\tFont files: %s"), i, pName.kACharPtr(), pTypeface);
					}

					double dHeight = pRecord->textSize();
					double dWidthFactor = pRecord->xScale();
					double dObliquingAngle = pRecord->obliquingAngle();

					//ACHAR pHeight[30];
					//acdbRToS(dHeight, -1, -1, pHeight);
					acutPrintf(_T("\n\tHeight: %f  Width factor: %f  Obliquing angle: %f"), dHeight, dWidthFactor, dObliquingAngle);
					
					acutPrintf(_T("\n"));
					acutDelString(pTypeface);
					pRecord->close();
				}	 
				pItr->step();
			}
		}//if 
		delete pItr;
		pTextStyleTable->close();

		return i;
	}

	static AcDbObjectId EditGroupCellsStyleIndex2Id(int index)
	{
		AcDbTextStyleTable *pTextStyleTable;
		acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pTextStyleTable, AcDb::kForRead);

		int i = 0;
		AcDbObjectId ret;
		ret.setNull();
		AcDbTextStyleTableIterator *pItr;
		if (pTextStyleTable->newIterator(pItr) == Acad::eOk) 
		{
			AcDbTextStyleTableRecord *pRecord = NULL;

			while (!pItr->done())
			{
				i++;
				if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
				{
					if (i == index)
						ret = pRecord->objectId();
					
					pRecord->close();
				}	 
				pItr->step();
			}
		}//if 
		delete pItr;
		pTextStyleTable->close();

		return ret;
	}


	static bool EditGroupCellsLayer(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			AcDbObjectId objId;
			acedInitGet(0, _T("Defaut Layer eXit"));
			ret = acedGetKword(_T("\nSelect option [Default/Layer/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Defaut")))
				{
					ssh->getCells()->setLayer(_T(""));
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Layer")))
				{
					ACHAR layer[1024];
					int c = EditGroupCellsLayerList();
					while (!canExit)
					{
						acedInitGet(0, NULL);
						ret = acedGetString(1, _T("\nSpecify layer of text: "), layer);

						if (ret == RTNORM)
						{
							if (!EditGroupCellsLayerNameCheck(layer))
								acutPrintf(_T("\nLayer not found! Please, try again."));
							else
							{
								ssh->getCells()->setLayer(layer);
								ssh->Recoordinate();
								ssh->RedrawBlockDefinition(0, 0, true);
								ssh->RedrawBlockReference();
								ssh->Write();
								canExit = true;
							}
						}
						else
						if (ret == RTCAN)
							canExit = true;
					}//while
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
		}//while
		return false;
	}

	static int EditGroupCellsLayerList()
	{
		acutPrintf(_T("Layers:"));
		AcDbLayerTable *pLayerTable;
		acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pLayerTable, AcDb::kForRead);

		int i = 0;
		AcDbLayerTableIterator *pItr;
		if (pLayerTable->newIterator(pItr) == Acad::eOk) 
		{
			AcDbLayerTableRecord *pRecord = NULL;

			while (!pItr->done())
			{
				i++;
				if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
				{
					AcString pName;
					pRecord->getName(pName);
					pRecord->close();

					acutPrintf(_T("\n%d. Layer name: \"%s\""), i, pName.kACharPtr());
				}	 
				pItr->step();
			}
		}//if 
		delete pItr;
		pLayerTable->close();
		return i;
	}

	static bool EditGroupCellsLayerNameCheck(ACHAR* layer)
	{
		AcDbLayerTable *pLayerTable;
		acdbHostApplicationServices()->workingDatabase()->getSymbolTable(pLayerTable, AcDb::kForRead);

		bool ret = false;
		int i = 0;
		AcDbLayerTableIterator *pItr;
		if (pLayerTable->newIterator(pItr) == Acad::eOk) 
		{
			AcDbLayerTableRecord *pRecord = NULL;

			while (!pItr->done())
			{
				i++;
				if (pItr->getRecord(pRecord, AcDb::kForRead) == Acad::eOk) 
				{
					AcString pName;
					pRecord->getName(pName);
					pRecord->close();

					if (pName == layer)
						ret = true;
				}	 
				pItr->step();
			}
		}//if 
		delete pItr;
		pLayerTable->close();
		return ret;
	}
	static bool EditGroupCellsLineweight(iSpreadSheet* ssh)
	{
		ads_real r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			AcDbObjectId objId;
			acedInitGet(0, _T("Defaut DefaultBySettings ByLayer ByBlock eXit"));
			ret = acedGetReal(_T("\nSpecify lineweight of text or [Default/DefaultBySettings/ByLayer/ByBlock/eXit]: "), &r);

			if (ret == RTKWORD)
			{
				acedGetInput(buf);
				if (!_tcsicmp(buf, _T("Defaut")))
				{
					ssh->getCells()->setHasDefaultWeight(true);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("DefaultBySettings")))
				{
					ssh->getCells()->setWeight(AcDb::kLnWtByLwDefault);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;					
				}
				else
				if (!_tcsicmp(buf, _T("ByLayer")))
				{
					ssh->getCells()->setWeight(AcDb::kLnWtByLayer);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;					
				}
				else
				if (!_tcsicmp(buf, _T("ByBlock")))
				{
					ssh->getCells()->setWeight(AcDb::kLnWtByBlock);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;						
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTNORM)
			{
				int i = 0;
				if (r < 0)
					i = r;
				else
					i = r * 100;
				ssh->getCells()->setWeight((AcDb::LineWeight)i);
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;	
			}
		}//while
		return false;
	}	

	static bool EditGroupBorders(iSpreadSheet* ssh, AlxdBorderType bt)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("State Color Layer LIneweight eXit"));
			ret = acedGetKword(_T("\nSelect property [State/Color/Layer/LIneweight/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("State")))
					canExit = EditGroupBordersState(ssh, bt);
				else
				if (!_tcsicmp(buf, _T("Color")))
					canExit = EditGroupBordersColor(ssh, bt);
				else
				if (!_tcsicmp(buf, _T("Layer")))
					canExit = EditGroupBordersLayer(ssh, bt);
				else
				if (!_tcsicmp(buf, _T("LIneweight")))
					canExit = EditGroupBordersLineweight(ssh, bt);				
				else
					if (!_tcsicmp(buf, _T("eXit")))
						canExit = true;
			}
			else
			if (ret == RTCAN)
					canExit = true;
		}
		return false;
	}

	static bool EditGroupBordersState(iSpreadSheet* ssh, AlxdBorderType bt)
	{
		ACHAR buf[30];
		int ret;
		int stt;
		bool canExit = false;

		//AlxdDrawBorder v1;
		//AlxdDrawBorder v2;
		//AlxdDrawBorder v3;
		//ssh->getVerBorders()->getState(&v1, &v2, &v3);
		//ssh->getHorBorders()->getState(&v1, &v2, &v3);

		while (!canExit)
		{
			if (bt == btVer)
			{
				acedInitGet(0, _T("Left Right Inside eXit"));
				ret = acedGetKword(_T("\nSelect border for change [Left/Right/Inside/eXit]: "), buf);
			}
			else
			{
				acedInitGet(0, _T("Top Bottom Inside eXit"));
				ret = acedGetKword(_T("\nSelect border for change [Top/Bottom/Inside/eXit]: "), buf);
			}			

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Left")))
				{
					stt = EditGroupBordersStateOnOff();
					if (stt != -1)
					{
						ssh->getVerBorders()->setState((AlxdDrawBorder)stt, dbMixed, dbMixed);
						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);
						ssh->RedrawBlockReference();
						ssh->Write();
					}
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Right")))
				{
					stt = EditGroupBordersStateOnOff();
					if (stt != -1)
					{
						ssh->getVerBorders()->setState(dbMixed, (AlxdDrawBorder)stt, dbMixed);
						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);
						ssh->RedrawBlockReference();
						ssh->Write();
					}
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Top")))
				{
					stt = EditGroupBordersStateOnOff();
					if (stt != -1)
					{
						ssh->getHorBorders()->setState((AlxdDrawBorder)stt, dbMixed, dbMixed);
						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);
						ssh->RedrawBlockReference();
						ssh->Write();
					}
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Bottom")))
				{
					stt = EditGroupBordersStateOnOff();
					if (stt != -1)
					{
						ssh->getHorBorders()->setState(dbMixed, (AlxdDrawBorder)stt, dbMixed);
						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);
						ssh->RedrawBlockReference();
						ssh->Write();
					}
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Inside")))
				{
					stt = EditGroupBordersStateOnOff();
					if (stt != -1)
					{
						if (bt == btVer)
							ssh->getVerBorders()->setState(dbMixed, dbMixed, (AlxdDrawBorder)stt);
						else
							ssh->getHorBorders()->setState(dbMixed, dbMixed, (AlxdDrawBorder)stt);
						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);
						ssh->RedrawBlockReference();
						ssh->Write();
					}
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTCAN)
					canExit = true;
		}//while
		return false;
	}

	static int EditGroupBordersStateOnOff()
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("On Off eXit"));
			ret = acedGetKword(_T("\nSelect state of border [On/Off/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("On")))
				{
					ret = 1;
					canExit = true;
				}
				if (!_tcsicmp(buf, _T("Off")))
				{
					ret = 0;
					canExit = true;
				}
				if (!_tcsicmp(buf, _T("eXit")))
				{
					ret = -1;
					canExit = true;
				}
			}
		}
		return ret;
	}

	static bool EditGroupBordersColor(iSpreadSheet* ssh, AlxdBorderType bt)
	{
		int r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			AcCmColor c;
			acedInitGet(0, _T("Defaut Color eXit"));
			ret = acedGetInt(_T("\nSpecify color of text or [Default/Color/eXit]: "), &r);
			//ret = acedGetKword(_T("\nSelect color of text [Defaut/Color/eXit]: "), buf);

			if (ret == RTKWORD)
			{
				acedGetInput(buf);
				if (!_tcsicmp(buf, _T("Defaut")))
				{
					if (bt == btVer)
						ssh->getVerBorders()->setHasDefaultColor(true);
					else
						ssh->getHorBorders()->setHasDefaultColor(true);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Color")))
				{
					Adesk::Boolean s = acedSetColorDialog(r, Adesk::kTrue, 0);
					if (s == Adesk::kTrue)
					{
						c.setColorIndex(r);
						if (bt == btVer)
							ssh->getVerBorders()->setColor(c);
						else
							ssh->getHorBorders()->setColor(c);
						ssh->Recoordinate();
						ssh->RedrawBlockDefinition(0, 0, true);
						ssh->RedrawBlockReference();
						ssh->Write();
						canExit = true;
					}
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTNORM)
			{
				c.setColorIndex(r);
				if (bt == btVer)
					ssh->getVerBorders()->setColor(c);
				else
					ssh->getHorBorders()->setColor(c);
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;
			}
		}//while
		return false;
	}

	static bool EditGroupBordersLayer(iSpreadSheet* ssh, AlxdBorderType bt)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			AcDbObjectId objId;
			acedInitGet(0, _T("Defaut Layer eXit"));
			ret = acedGetKword(_T("\nSelect option [Default/Layer/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Defaut")))
				{
					if (bt == btVer)
						ssh->getVerBorders()->setLayer(_T(""));
					else
						ssh->getHorBorders()->setLayer(_T(""));
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("Layer")))
				{
					ACHAR layer[1024];
					int c = EditGroupCellsLayerList();
					while (!canExit)
					{
						acedInitGet(0, NULL);
						ret = acedGetString(1, _T("\nSpecify layer of text: "), layer);

						if (ret == RTNORM)
						{
							if (!EditGroupCellsLayerNameCheck(layer))
								acutPrintf(_T("\nLayer not found! Please, try again."));
							else
							{
								if (bt == btVer)
									ssh->getVerBorders()->setLayer(layer);
								else
									ssh->getHorBorders()->setLayer(layer);
								ssh->Recoordinate();
								ssh->RedrawBlockDefinition(0, 0, true);
								ssh->RedrawBlockReference();
								ssh->Write();
								canExit = true;
							}
						}
						else
						if (ret == RTCAN)
							canExit = true;
					}//while
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
		}//while
		return false;
	}

	static bool EditGroupBordersLineweight(iSpreadSheet* ssh, AlxdBorderType bt)
	{
		ads_real r;
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			AcDbObjectId objId;
			acedInitGet(0, _T("Defaut DefaultBySettings ByLayer ByBlock eXit"));
			ret = acedGetReal(_T("\nSpecify lineweight of text or [Default/DefaultBySettings/ByLayer/ByBlock/eXit]: "), &r);

			if (ret == RTKWORD)
			{
				acedGetInput(buf);
				if (!_tcsicmp(buf, _T("Defaut")))
				{
					if (bt == btVer)
						ssh->getVerBorders()->setHasDefaultWeight(true);
					else
						ssh->getHorBorders()->setHasDefaultWeight(true);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;
				}
				else
				if (!_tcsicmp(buf, _T("DefaultBySettings")))
				{
					if (bt == btVer)
						ssh->getVerBorders()->setWeight(AcDb::kLnWtByLwDefault);
					else
						ssh->getHorBorders()->setWeight(AcDb::kLnWtByLwDefault);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;					
				}
				else
				if (!_tcsicmp(buf, _T("ByLayer")))
				{
					if (bt == btVer)
						ssh->getVerBorders()->setWeight(AcDb::kLnWtByLayer);
					else
						ssh->getHorBorders()->setWeight(AcDb::kLnWtByLayer);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;					
				}
				else
				if (!_tcsicmp(buf, _T("ByBlock")))
				{
					if (bt == btVer)
						ssh->getVerBorders()->setWeight(AcDb::kLnWtByBlock);
					else
						ssh->getHorBorders()->setWeight(AcDb::kLnWtByBlock);
					ssh->Recoordinate();
					ssh->RedrawBlockDefinition(0, 0, true);
					ssh->RedrawBlockReference();
					ssh->Write();
					canExit = true;						
				}
				else
				if (!_tcsicmp(buf, _T("eXit")))
					canExit = true;
			}
			else
			if (ret == RTNORM)
			{
				int i = 0;
				if (r < 0)
					i = r;
				else
					i = r * 100;
				if (bt == btVer)
					ssh->getVerBorders()->setWeight((AcDb::LineWeight)i);
				else
					ssh->getHorBorders()->setWeight((AcDb::LineWeight)i);
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);
				ssh->RedrawBlockReference();
				ssh->Write();
				canExit = true;	
			}
		}//while
		return false;
	}	

	static void EditOpened(iSpreadSheet* ssh)
	{
		ACHAR buf[30];
		int ret;
		bool canExit = false;

		while (!canExit)
		{
			acedInitGet(0, _T("Table Style Columns Rows CElls VerBorders HorBorders eXit"));
			ret = acedGetKword(_T("\nSelect operation group [Table/Style/Columns/Rows/CElls/VerBorders/HorBorders/eXit]: "), buf);

			if (ret == RTNORM)
			{
				if (!_tcsicmp(buf, _T("Table")))
					canExit = EditGroupTable(ssh);
				else
				if (!_tcsicmp(buf, _T("Style")))
					canExit = EditGroupStyle(ssh);
				else
				if (!_tcsicmp(buf, _T("Columns")))
					canExit = EditGroupColumns(ssh);
				else
				if (!_tcsicmp(buf, _T("Rows")))
					canExit = EditGroupRows(ssh);
				else
				if (!_tcsicmp(buf, _T("Cells")))
					canExit = EditGroupCells(ssh);
				else
				if (!_tcsicmp(buf, _T("VerBorders")))
					canExit = EditGroupBorders(ssh, btVer);
				else
				if (!_tcsicmp(buf, _T("HorBorders")))
					canExit = EditGroupBorders(ssh, btHor);
				else
				if (!_tcsicmp(buf, _T("eXit")))
						canExit = true;
			}
			else
			if (ret == RTCAN)
					canExit = true;
		}
	}

	// - AlxdATable._atable command (do not rename)
	static void AlxdATable_atable(void)
	{
		if (DocVars.docData().getIsATableOpened())
		{
			CSpreadSheet* pSsh = DocVars.docData().xSpreadSheet;
			iSpreadSheet* ssh = pSsh->getSpreadSheet();
			
			EditOpened(ssh);

			if (!DocVars.docData().getIsATableOpened())
			{
				pSsh->Quit();
				pSsh->Release();
			}

			return;
		}

		ads_name sset;
		struct resbuf *filter = acutBuildList(RTDXF0, _T("INSERT"), 0);
		int res = acedSSGet(_T("_I"), NULL, NULL, filter, sset);
		acutRelRb(filter);

		if (res != RTNORM)
		{
			CComObject<CSpreadSheet>* pSsh = 0;
			HRESULT hr = CComObject<CSpreadSheet>::CreateInstance(&pSsh); 
			if (SUCCEEDED(hr))
			{
				pSsh->AddRef();

				iSpreadSheet* ssh = pSsh->getSpreadSheet();
				ssh->CreateBlockDefinition();
				ssh->Recoordinate();
				ssh->RedrawBlockDefinition(0, 0, true);

				if (InsertNew(ssh))
				{
					//open for edit
					DocVars.docData().xSpreadSheet = pSsh;
					DocVars.docData().setIsATableOpened(true);
					ssh->setOpenState();
					PostMessage(adsw_acadMainWnd(), WM_GRAPHICSREDRAW, 0, 0);
					PostMessage(adsw_acadMainWnd(), WM_SELECTIONREDRAW, 0, 0);
				}

				if (!DocVars.docData().getIsATableOpened())
				{
					pSsh->Quit();
					pSsh->Release();
				}
			}

			return;
		}//if (res != RTNORM)

		//there are pickfirst
		if (res == RTNORM)
		{
			CComObject<CSpreadSheet>* pSsh = 0;
			HRESULT hr = CComObject<CSpreadSheet>::CreateInstance(&pSsh); 
			if (SUCCEEDED(hr))
			{
				pSsh->AddRef();

				iSpreadSheet* ssh = pSsh->getSpreadSheet();
				if (FindInSelection(ssh, sset))
				{
					//DocVars.docData().xSpreadSheet->setSpreadSheet(ssh);
					DocVars.docData().xSpreadSheet = pSsh;
					DocVars.docData().setIsATableOpened(true);
					ssh->setOpenState();
					PostMessage(adsw_acadMainWnd(), WM_GRAPHICSREDRAW, 0, 0);
					PostMessage(adsw_acadMainWnd(), WM_SELECTIONREDRAW, 0, 0);

					acedSSSetFirst(NULL, NULL);
				}

				acedSSFree(sset);
				//ssh->CreateBlockDefinition();
				//ssh->Recoordinate();
				//ssh->RedrawBlockDefinition(0, 0, true);

				//InsertNew(ssh);

				if (!DocVars.docData().getIsATableOpened())
				{
					pSsh->Quit();
					pSsh->Release();
				}
			}

			//iSpreadSheet* ssh = new iSpreadSheet();
			//if (FindInSelection(ssh, sset))
			//{
			//	//DocVars.docData().xSpreadSheet->setSpreadSheet(ssh);
			//	//DocVars.docData().setIsATableOpened(true);
			//	//ssh->setOpenState();
			//	//PostMessage(adsw_acadMainWnd(), WM_GRAPHICSREDRAW, 0, 0);
			//	//PostMessage(adsw_acadMainWnd(), WM_SELECTIONREDRAW, 0, 0);

			//	acedSSSetFirst(NULL, NULL);
			//}

			//acedSSFree(sset);

			//if (!DocVars.docData().getIsATableOpened())
			//	delete ssh;
		}
	}
*/