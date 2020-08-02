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
//----- AlxdEditorReactor.cpp : Implementation of AlxdEditorReactor
//-----------------------------------------------------------------------------
#include "StdAfx.h"
#include "oarxExport.h"
#include "AlxdEditorReactor.h"

enum
{
	SO_NONE		= 0,
	SO_ATTRIB	= 1,
    SO_INSERT	= 2
};
//static long DoubleClickSuccess = 0;
static AcDbObjectId SuccessObjId;
static int SuccessObjSO;

static AcEdCommand * cmd = NULL;
static AcRxFunctionPtr oldBEditAddr = NULL;
static AcRxFunctionPtr oldRefEditAddr = NULL;
static AcRxFunctionPtr oldEAttEditAddr = NULL;
static AcRxFunctionPtr oldSibBEdit = NULL;

void restoreAddr()
{
	if (NULL != oldBEditAddr)
	{
		cmd = acedRegCmds->lookupGlobalCmd(_T("BEDIT"));	

		if (NULL != cmd)
		{
			cmd->functionAddr(oldBEditAddr);
			oldBEditAddr = NULL;
		}
	}

	if (NULL != oldRefEditAddr)
	{
		cmd = acedRegCmds->lookupGlobalCmd(_T("REFEDIT"));	

		if (NULL != cmd)
		{
			cmd->functionAddr(oldRefEditAddr);
			oldRefEditAddr = NULL;
		}
	}

	if (NULL != oldEAttEditAddr)
	{
		cmd = acedRegCmds->lookupGlobalCmd(_T("EATTEDIT"));

		if (NULL != cmd)
		{
			cmd->functionAddr(oldEAttEditAddr);
			oldEAttEditAddr = NULL;
		}
	}	

	if (NULL != oldSibBEdit)
	{
		cmd = acedRegCmds->lookupGlobalCmd(_T("SIBBEDIT"));

		if (NULL != cmd)
		{
			cmd->functionAddr(oldSibBEdit);
			oldSibBEdit = NULL;
		}
	}	
}

void callbackfunc()
{
	//hook to AutoCAD error
	if (SuccessObjId.isNull())
	{
		SuccessObjSO = SO_NONE;
		restoreAddr();
		return;
	}

	//if (SuccessObjSO == SO_ATTRIB)
	//{
	//	ACHAR pCommand[255];
	//	_stprintf(pCommand, _T("_.eattedit %f,%f,%f\r"), DocVars.docData().LastClickPoint[0], DocVars.docData().LastClickPoint[1], DocVars.docData().LastClickPoint[2]);
	//	acDocManager->sendStringToExecute(acDocManager->curDocument(), pCommand, false, false, false);
	//	return;
	//}
	/*
	if (acdbOpenObject(pEnt, SuccessObjId, AcDb::kForRead) == Acad::eOk)
	{
		bEntityIsAttribute = (pEnt->isA() == AcDbAttribute::desc());
		pEnt->close();
	}
	*/

	if (SuccessObjSO == SO_INSERT)
	{
		ACHAR pBuf[20];
		SuccessObjId.handle().getIntoAsciiBuffer(pBuf);

		ACHAR pCommand[100];
		AcGePoint3d pt = DocVars.docData().LastClickPoint;
		_stprintf(pCommand, _T("(AlxdAt (cons 5 \"%s\") (list %f %f %f))\r"), pBuf, pt.x, pt.y, pt.z);
		//_tcprintf(pCommand, _T("(AlxdAt (cons 5 \"%s\"))\r"), pBuf);
		acDocManager->sendStringToExecute(acDocManager->curDocument(), pCommand, false, false, false);	
	}
}

void saveAddr()
{
	cmd = acedRegCmds->lookupGlobalCmd(_T("BEDIT"));

	if (NULL != cmd)
	{
		oldBEditAddr = cmd->functionAddr();
		cmd->functionAddr(&callbackfunc);
	}

	cmd = acedRegCmds->lookupGlobalCmd(_T("REFEDIT"));

	if (NULL != cmd)
	{
		oldRefEditAddr = cmd->functionAddr();
		cmd->functionAddr(&callbackfunc);
	}

	cmd = acedRegCmds->lookupGlobalCmd(_T("EATTEDIT"));

	if (NULL != cmd)
	{
		oldEAttEditAddr = cmd->functionAddr();
		cmd->functionAddr(&callbackfunc);
	}

	cmd = acedRegCmds->lookupGlobalCmd(_T("SIBBEDIT"));

	if (NULL != cmd)
	{
		oldSibBEdit = cmd->functionAddr();
		cmd->functionAddr(&callbackfunc);
	}
}

//-----------------------------------------------------------------------------
ACRX_CONS_DEFINE_MEMBERS(AlxdEditorReactor, AcEditorReactor, 1)

//-----------------------------------------------------------------------------
AlxdEditorReactor::AlxdEditorReactor (const bool autoInitAndRelease) : AcEditorReactor(), mbAutoInitAndRelease(autoInitAndRelease) 
{
	if ( autoInitAndRelease ) {
		if ( acedEditor )
			acedEditor->addReactor (this) ;
		else
			mbAutoInitAndRelease =false ;
	}
}

//-----------------------------------------------------------------------------
AlxdEditorReactor::~AlxdEditorReactor () 
{
	Detach () ;
}

//-----------------------------------------------------------------------------
void AlxdEditorReactor::Attach () 
{
	Detach () ;
	if ( !mbAutoInitAndRelease ) {
		if ( acedEditor ) {
			acedEditor->addReactor (this) ;
			mbAutoInitAndRelease =true ;
		}
	}
}

void AlxdEditorReactor::Detach () 
{
	if ( mbAutoInitAndRelease ) {
		if ( acedEditor ) {
			acedEditor->removeReactor (this) ;
			mbAutoInitAndRelease =false ;
		}
	}
}

AcEditor *AlxdEditorReactor::Subject () const
{
	return (acedEditor) ;
}

bool AlxdEditorReactor::IsAttached () const
{
	return (mbAutoInitAndRelease) ;
}

void AlxdEditorReactor::beginDoubleClick(const AcGePoint3d& clickPoint)
{
	DocVars.docData().LastClickPoint = clickPoint;

	ads_point wcs_pickpoint;
	ads_point ucs_pickpoint;
	//memcpy(pickpoint, asDblArray(clickPoint), 24);
	ads_point_set(asDblArray(clickPoint), wcs_pickpoint); 

	bool b = acdbWcs2Ucs(wcs_pickpoint, ucs_pickpoint, false);
	ads_name ent;
	ads_matrix xformres;
	struct resbuf *refstkres;

	// Return selected object and owners
	int ret = acedNEntSelP(NULL, ent, ucs_pickpoint, TRUE, xformres, &refstkres);
	if (ret != RTNORM)
	{
		//acutPrintf(_T("\nFailure in acedNEntSelP"));
		return;
	}

	//bool bEntityIsAttribute = false;
	//bool bOwnerIsInsert = false;
	
	SuccessObjSO = SO_NONE;

	AcDbObjectId objId;
	AcDbEntity *pEnt = NULL;

	// define entity type (attribute or no?)
	//acdbGetObjectId(objId, ent);
	//if (acdbOpenObject(pEnt, objId, AcDb::kForRead) == Acad::eOk)
	//{
	//	//bEntityIsAttribute = (pEnt->isA() == AcDbAttribute::desc());
	//	if (pEnt->isA() == AcDbAttribute::desc())
	//		SuccessObjSO = SO_ATTRIB;
	//	pEnt->close();
	//}

	////if selected ATTRIB, then release and exit
	////if (ename == "ATTRIB")
	//if (SuccessObjSO == SO_ATTRIB)
	//{
	//	/*
	//	ACHAR pCommand[255];
	//	_stprintf(pCommand, _T("_.eattedit %f,%f,%f\r"), clickPoint[0], clickPoint[1], clickPoint[2]);
	//	acDocManager->sendStringToExecute(acDocManager->curDocument(), pCommand, false, false, false);
	//	*/
	//	if (refstkres)
	//		acutRelRb(refstkres);
	//	acedSSSetFirst(NULL, NULL);

	//	SuccessObjId = objId;
	//	saveAddr();
	//	return;
	//}

	//AcDbObjectId objId2;
	//AcDbEntity *pEnt2 = NULL;
	// define owner type (blockref or no?)
	if (refstkres)
	{
		struct resbuf *pTemp = NULL;
		pTemp = refstkres;
		while (pTemp->rbnext)
		{
			pTemp = pTemp->rbnext;
		}
		//memcpy(ent, pTemp->resval.rlname, sizeof(ads_name));
		ads_name_set(pTemp->resval.rlname, ent);
		
		acdbGetObjectId(objId, ent);
		if (acdbOpenObject(pEnt, objId, AcDb::kForRead) == Acad::eOk)
		{
			//bOwnerIsInsert = (pEnt->isA() == AcDbBlockReference::desc());
			//bOwnerIsInsert = (pEnt2->isA() == AcDbBlockReference::desc());
			if (pEnt->isA() == AcDbBlockReference::desc())
				SuccessObjSO = SO_INSERT;
			pEnt->close();
		}
	}
	if (refstkres)
		acutRelRb(refstkres);

	if (SuccessObjSO == SO_INSERT)
		if (HasAlxdGridEntity(objId))
		{
			SuccessObjId = objId;
			saveAddr();			
		}
		else
			SuccessObjId.setNull();

//	//if (oname == "INSERT")
//	if (bOwnerIsInsert)
//	{
//		SuccessObjId = objId2;
//		if (HasAlxdGridEntity(SuccessObjId))
//		{
//			//acutPrintf("\nATable object founded...");
//			//acDocManager->sendStringToExecute(acDocManager->curDocument(), "_at ", false, false, true);	
//			//DocVars.docData().LastClickPoint = pt;
//			//DocVars.docData().LastClickPoint = clickPoint;
//
//			//ads_name entres;
//
//			//acedSSName(sset, 0, entres);
//			//acdbGetObjectId(SuccessObjId, entres);
//			//acedSSFree(sset);
//
//			//if (HasAlxdGridEntity(SuccessObjId))
//			//{
//				saveAddr();			
//			//}
//			//else
//			//{
//			//	SuccessObjId.setNull();
//			//}
//
//			/*
//			ACHAR pBuf[20];
//			objId.handle().getIntoAsciiBuffer(pBuf);
//
//			ACHAR pCommand[50];
//			_stprintf(pCommand, _T("(AlxdAt (cons 5 \"%s\"))\r"), pBuf);
//			acDocManager->sendStringToExecute(acDocManager->curDocument(), pCommand, false, false, false);
//			acedSSSetFirst(NULL,NULL);
//*/
//			return;
//		}
//
//		SuccessObjId.setNull();
//
//		/*
//		struct resbuf cmd;
//		double minorver = 0;
//		acedGetVar(_T("ACADVER"), &cmd);
//		minorver = _tstof(cmd.resval.rstring);
//
//		if (minorver < 16.2) //AutoCAD 2002, 2004 or 2005
//		{
//			ACHAR pCommand[255];
//			_tcprintf(pCommand, _T("_.refedit %f,%f,%f\r"), pt[0], pt[1], pt[2]);
//			acDocManager->sendStringToExecute(acDocManager->curDocument(), pCommand, false, false, false);
//			acedSSSetFirst(NULL,NULL);
//		}
//		else
//		if (minorver >= 16.2) //AutoCAD 2006, 2007, 2008
//		{
//			acDocManager->sendStringToExecute(acDocManager->curDocument(), _T("_.bedit "), false, false, false);
//		}		
//		*/
//		return;
//	}

	/*
	struct resbuf *filter = acutBuildList(RTDXF0, _T("INSERT"), 0);
	ads_name sset;

	DocVars.docData().LastClickPoint = clickPoint;

	if (acedSSGet(_T("_I"), NULL, NULL, filter, sset) == RTNORM)
	{
		ads_name entres;

		acedSSName(sset, 0, entres);
		acdbGetObjectId(SuccessObjId, entres);
		acedSSFree(sset);

		if (HasAlxdGridEntity(SuccessObjId))
		{
			saveAddr();			
		}
		else
		{
			SuccessObjId.setNull();
		}
	}
	acutRelRb(filter);
	*/
}

void AlxdEditorReactor::commandEnded(const ACHAR* cmdStr)
{
	if (SuccessObjId.isNull())
		return;

	SuccessObjId.setNull();

	restoreAddr();
}
