// (C) Copyright 2005 by Autodesk, Inc. 
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
#include "StdAfx.h"
#include "AlxdJig.h"

//-----------------------------------------------------------------------------
AlxdJig::AlxdJig () : AcEdJig (),
	mCurrentInputLevel(0), mpEntity(NULL)
{
}

AlxdJig::~AlxdJig () {
}

//-----------------------------------------------------------------------------
AcEdJig::DragStatus AlxdJig::startJig (AcDbBlockReference *pEntityToJig, AlxdJigAttDefInfoArray *pAttInfo)
{
	//- Store the new entity pointer
	mpEntity = pEntityToJig;
	attInfo = pAttInfo;

	//- Setup each input prompt
	AcString inputPrompts[1] = {"\nSpecify insertion point or [Style/Properties/Justify/Edit/Recalculate/eXit]: "};

	//- Setup kwords for each input
	//AcString kwords[1] = {"Style Properties"};

	//bool appendOk =true ;
	AcEdJig::DragStatus status =AcEdJig::kNull;

	//mInputPoints.append (AcGePoint3d ()) ;
	setDispPrompt(inputPrompts[mCurrentInputLevel]);
	//setKeywordList(kwords[mCurrentInputLevel]);

	//- Loop the number of inputs
	/*
	for ( mCurrentInputLevel =0 ; mCurrentInputLevel < 1 ; mCurrentInputLevel++ ) {
		//- Add a new input point to the list of input points
		mInputPoints.append (AcGePoint3d ()) ;
		//- Set the input prompt
		setDispPrompt (inputPrompts [mCurrentInputLevel]) ;
		//- Setup the keywords required
		setKeywordList (kwords [mCurrentInputLevel]) ;

		bool quit =false ;
		//- Lets now do the input
		status =drag () ;
		
		if ( status != kNormal ) {
			//- If it's a keyword
			switch ( status ) {
				case kCancel: 
				case kNull:
					quit =true ;
					break ;

				case kKW1:
				case kKW2:
				case kKW3:
				case kKW4:
				case kKW5:
				case kKW6:
				case kKW7:
				case kKW8:
				case kKW9:
					//- Do something

					break ;
		  }
		} else {
			appendOk =true ;
		}

		//- If to finish
		if ( quit )
			break ;
	}

	//- If the input went well
	if ( appendOk )
		//- Append to the database
		append () ;
	else
		//- Clean up
		delete mpEntity  ;
	*/
	status = drag();

	if (status == AcEdJig::kNormal)
		append();

	//return status;

	return (status) ;
}

//-----------------------------------------------------------------------------
//- Input sampler
AcEdJig::DragStatus AlxdJig::sampler ()
{
	AcGePoint3d newPnt ;
	AcString kwords[1] = {"Style Properties Justify Edit Recalculate eXit"};
	setKeywordList(kwords[mCurrentInputLevel]);
	//- Get the point 
	AcEdJig::DragStatus status = acquirePoint(newPnt);
	//- If valid input
	if ( status == AcEdJig::kNormal ) {
		//- If there is no difference
		if (newPnt.isEqualTo(mInputPoint))
			return (AcEdJig::kNoChange);
		//- Otherwise update the point
		mInputPoint = newPnt;
	}
	return (status) ;

//	DragStatus stat;
//
////	if (JSubKeys == 0)
////		setKeywordList("Style Properties Justify Edit Update Recalculate REGister eXit");
////		setKeywordList("Style Properties Justify Edit Recalculate REGister eXit");
//
//	static AcGePoint3d tempPt;
//	stat = acquirePoint(JInsPt);
//	if (tempPt != JInsPt)
//		tempPt = JInsPt;
//	else 
//		if (stat == AcEdJig::kNormal)
//			return AcEdJig::kNoChange;
//
//	return stat;

	////- Setup the user input controls for each input
	//
	//AcEdJig::UserInputControls userInputControls [1] ={
	//	/*AcEdJig::UserInputControls::*/(AcEdJig::UserInputControls)0
	//} ;
	////- Setup the cursor type for each input
	//AcEdJig::CursorType cursorType [1] ={
	//	/*AcEdJig::CursorType::*/(AcEdJig::CursorType)0
	//} ;
	////- Setup the user input controls for each sample
	//setUserInputControls (userInputControls [mCurrentInputLevel]) ;
	//setSpecialCursorType (cursorType [mCurrentInputLevel]) ;

	//AcEdJig::DragStatus status =AcEdJig::kCancel ;
	////- Check the current input number to see which input to do
	//switch ( mCurrentInputLevel+1 ) {
	//	case 1:
	//		// TODO : get an input here
	//		//status =GetStartPoint () ;
	//		break ;

	//	default:
	//		break ;
	//}
	//return (status) ;
}

//-----------------------------------------------------------------------------
//- Jigged entity update
Adesk::Boolean AlxdJig::update()
{
	mpEntity->setPosition(mInputPoint);

	//AcArray<ACHAR*, >
	//Acad::ErrorStatus res;



	//for (pIterator->start(); !pIterator->done(); pIterator->step())
	//{
	//	pIterator->getEntity(pEnt, AcDb::kForRead);

	//	pAttDef = AcDbAttributeDefinition::cast(pEnt);
	//	if (pAttDef != NULL && !pAttDef->isConstant())
	//	{
	//		AcDbAttribute *pAtt = new AcDbAttribute();
	//		pAtt->setPropertiesFrom(pAttDef);
	//		//pAtt->setInvisible(pAttDef->isInvisible());
	//		pAtt->setAttributeFromBlock(pAttDef, pBlockRef->blockTransform());
	//		
	//		basePoint = pAtt->position();
	//		basePoint -= pBlockDef->origin().asVector();
	//		pAtt->setPosition(basePoint);

	//		basePoint = pAtt->alignmentPoint();
	//		basePoint -= pBlockDef->origin().asVector();
	//		pAtt->setAlignmentPoint(basePoint);

	//		res = pBlockRef->appendAttribute(pAtt);
	//		res = actrTransactionManager->addNewlyCreatedDBRObject(pAtt, true);
	//		pAtt->close();
	//	}
	//	pEnt->close();
	//}
	//delete pIterator;

	//AcDbObjectId defId;
	//defId = mpEntity->blockTableRecord;

	AcGePoint3d basePoint;
	AcDbObjectId attId;
	AcDbObjectIterator *pObjectIterator = NULL;

	pObjectIterator = mpEntity->attributeIterator();

	if (pObjectIterator == NULL)
		return Adesk::kFalse;
	
	//AcDbEntity *pEnt;
	//AcDbBlockTableRecord* pBlockDef = NULL;
	//AcDbAttributeDefinition *pAttDef;
	//AcDbBlockTableRecordIterator *pIterator;

	//if (acdbOpenObject(pBlockDef, mpEntity->blockTableRecord(), AcDb::kForRead) != Acad::eOk)
	//{
	//	if (pBlockDef)
	//		pBlockDef->close();
	//	return Adesk::kFalse;
	//}

	//pBlockDef->newIterator(pIterator);

	//if (pObjectIterator != NULL)
	//{
	//AcDbEntity *pEnt;
	AcDbAttribute *pAtt = NULL;
	while (!pObjectIterator->done())
	{
	//		//pEnt = NULL;
	//		//pEnt = pObjectIterator->entity();
		attId = pObjectIterator->objectId();

	//		//if (pEnt)
	//		//{
	//			//pAtt = AcDbAttribute::cast(pEnt);
		if (acdbOpenObject(pAtt, attId, AcDb::kForWrite) == Acad::eOk)
		{
			int i;
			bool found = false;
			for (i = 0; i < attInfo->length(); i++)
			{
				if (!_tcsicmp(attInfo->at(i).tag, pAtt->tag()))
				{
					found = true;
					break;
				}
			}
			//pBlockDef->newIterator(pIterator);

			//bool found = false;
			//for (pIterator->start(); !pIterator->done(); pIterator->step())
			//{
			//	pIterator->getEntity(pEnt, AcDb::kForRead);

			//	pAttDef = AcDbAttributeDefinition::cast(pEnt);
			//	if (pAttDef != NULL && !_tcsicmp(pAttDef->tag(), pAtt->tag()) && !pAttDef->isConstant())
			//	{
			//		found = true;
			//		break;
			//	}
			//}
			//delete pIterator;

			if (found)
			{
				//basePoint = pAttDef->position().transformBy(mpEntity->blockTransform());//pAtt->position() - vec;
				basePoint = attInfo->at(i).pos;
				basePoint = basePoint.transformBy(mpEntity->blockTransform());
				pAtt->setPosition(basePoint);

	//			
				//basePoint = pAttDef->alignmentPoint().transformBy(mpEntity->blockTransform());//mInputPoint;//pAtt->alignmentPoint() - vec;
				basePoint = attInfo->at(i).aln;
				basePoint = basePoint.transformBy(mpEntity->blockTransform());
				pAtt->setAlignmentPoint(basePoint);

	//				pEnt->close();
			}

			pAtt->close();
	//			//pEnt->close();
	//		//}
	//		}
		}
		pObjectIterator->step();
	}

	//pBlockDef->close();

	//delete pIterator;

	delete pObjectIterator;

	
	return Adesk::kTrue;

	//- Check the current input number to see which update to do
	//switch ( mCurrentInputLevel+1 ) {
	//	case 1:
	//		// TODO : update your entity for this input
	//		//mpEntity->setCenter (mInputPoints [mCurrentInputLevel]) ;
	//		break ;

	//	default:
	//		break ;
	//}

	//return (updateDimData ()) ;
}

//-----------------------------------------------------------------------------
//- Jigged entity pointer return
AcDbEntity *AlxdJig::entity()const
{
	return (mpEntity) ;
}

//-----------------------------------------------------------------------------
//- Dynamic dimension data setup
//AcDbDimDataPtrArray *AlxdJig::dimData (const double dimScale)
//{
	/* SAMPLE CODE:
	AcDbAlignedDimension *dim =new AcDbAlignedDimension () ;
	dim->setDatabaseDefaults () ;
	dim->setNormal (AcGeVector3d::kZAxis) ;
	dim->setElevation (0.0) ;
	dim->setHorizontalRotation (0.0) ;
	dim->setXLine1Point (m_originPoint) ;
	dim->setXLine2Point (m_lastPoint) ;
	//- Get the dimPoint, first the midpoint
	AcGePoint3d dimPoint =m_originPoint + ((m_lastPoint - m_originPoint) / 2.0) ;
	//- Then the offset
	dim->setDimLinePoint (dimPoint) ;
	dim->setDimtad (1) ;

	AcDbDimData *dimData = new AcDbDimData (dim) ;
	//AppData *appData =new AppData (1, dimScale) ;
	//dimData.setAppData (appData) ;
	dimData->setDimFocal (true) ;
	dimData->setDimHideIfValueIsZero (true) ;

	//- Check to see if it is required
	if ( getDynDimensionRequired (m_inputNumber) )
		dimData->setDimInvisible (false) ;
	else
		dimData->setDimInvisible (true) ;

	//- Make sure it is editable TODO: 
	dimData->setDimEditable (true) ;
	mDimData.append (dimData) ;

	return (&mDimData) ;
	*/
//	return (NULL) ;
//}

//-----------------------------------------------------------------------------
//- Dynamic dimension data update
//Acad::ErrorStatus AlxdJig::setDimValue(const AcDbDimData *pDimData, const double dimValue)
//{
//	Acad::ErrorStatus es = Acad::eOk;

	/* SAMPLE CODE:
	//- Convert the const pointer to non const
	AcDbDimData *dimDataNC =const_cast<AcDbDimData *>(pDimData) ;
	int inputNumber =-1 ;
	//- Find the dim data being passed so we can determine the input number
	if ( mDimData.find (dimDataNC, inputNumber) ) {
		//- Now get the dimension
		AcDbDimension *pDim =(AcDbDimension *)dimDataNC->dimension () ;
		//- Check it's the type of dimension we want
		AcDbAlignedDimension *pAlnDim =AcDbAlignedDimension::cast (pDim) ;
		//- If ok
		if ( pAlnDim ) {
			//- Extract the dimensions as they are now
			AcGePoint3d dimStart =pAlnDim->xLine1Point () ;
			AcGePoint3d dimEnd =pAlnDim->xLine2Point () ;
			//- Lets get the new point entered by the user 
			AcGePoint3d dimEndNew =dimStart + (dimEnd - dimStart).normalize () * dimValue ;
			//- Finally set the end dim point
			pAlnDim->setXLine2Point (dimEndNew) ;
			//- Now update the jig data to reflect the dynamic dimension input
			mInputPoints [mCurrentInputLevel] =dimEndNew ;
		}
	}*/
//	return (es) ;
//}

//-----------------------------------------------------------------------------
//- Various helper functions
//- Dynamic dimdata update function
/*
Adesk::Boolean AlxdJig::updateDimData()
{
	//- Check the dim data store for validity
	if ( mDimData.length () <= 0 )
		return (true) ;

	/* SAMPLE CODE :
	//- Extract the individual dimData
	AcDbDimData *dimData =mDimData [m_inputNumber] ;
	//- Now get the dimension
	AcDbDimension *pDim =(AcDbDimension *)dimData->dimension () ;
	//- Check it's the type of dimension we want
	AcDbAlignedDimension *pAlnDim =AcDbAlignedDimension::cast (pDim) ;
	//- If ok
	if ( pAlnDim ) {
		//- Check to see if it is required
		if ( getDynDimensionRequired (m_inputNumber) )
			dimData->setDimInvisible (false) ;
		else
			dimData->setDimInvisible (true) ;
		pAlnDim->setXLine1Point (m_originPoint) ;
		pAlnDim->setXLine2Point (m_lastPoint) ;
		//- Get the dimPoint, first the midpoint
		AcGePoint3d dimPoint =m_originPoint + ((m_lastPoint - m_originPoint) / 2.0) ;
		//- Then the offset
		pAlnDim->setDimLinePoint (dimPoint) ;
	} */
//	return (true) ;
//}


