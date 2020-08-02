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

//-----------------------------------------------------------------------------
//- AlxdJig.h
#pragma once

//-----------------------------------------------------------------------------
struct AlxdJigAttDefInfo
{
	const ACHAR* tag;
	AcGePoint3d	pos;
	AcGePoint3d	aln;
};

typedef AcArray<AlxdJigAttDefInfo> AlxdJigAttDefInfoArray;

//class AlxdAttInfo {
//private:
//	AcGePoint3d	_pos;
//	AcGePoint3d	_aln;
//	bool		_aligned;
//
//public:
//	AlxdAttInfo(AcGePoint3d pos, AcGePoint3d aln, bool aligned) {_pos = pos; _aln = aln; _aligned = aligned;};
//	void setPosition(AcGePoint3d value) {_pos = value;};
//	AcGePoint3d	Position() {return _pos;};
//	void setAlignment(AcGePoint3d value) {_aln = value;};
//	AcGePoint3d	Alignment() {return _aln;};
//	void setIsAligned(bool value) {_aligned = value;};
//	bool IsAligned() {return _aligned;};
//};
//
//typedef AcArray<AcDbObjectId, AlxdAttInfo> AlxdAttInfoArray;

class AlxdJig : public AcEdJig {

private:
	//- Member variables
	//- current input level, increment for each input
	int mCurrentInputLevel ;
	//- Dynamic dimension info
	AcDbDimDataPtrArray mDimData ;

public:
	//- Array of input points, each level corresponds to the mCurrentInputLevel
	//AcGePoint3dArray mInputPoints ;
	AcGePoint3d mInputPoint;
	//- Entity being jigged
	AcDbBlockReference *mpEntity;	
	AlxdJigAttDefInfoArray *attInfo;

public:
	AlxdJig () ;
	~AlxdJig () ;

	//- Command invoke the jig, call passing a new'd instance of the object to jig
	AcEdJig::DragStatus startJig (AcDbBlockReference *pEntityToJig, AlxdJigAttDefInfoArray *pAttInfo) ;

protected:
	//- AcEdJig overrides
	//- input sampler
	virtual DragStatus sampler () ;
	//- jigged entity update
	virtual Adesk::Boolean update () ;
	//- jigged entity pointer return
	virtual AcDbEntity *entity () const ;
	//- dynamic dimension data setup
	//virtual AcDbDimDataPtrArray *dimData (const double dimScale) ;
	//- dynamic dimension data update
	//virtual Acad::ErrorStatus setDimValue (const AcDbDimData *pDimData, const double dimValue) ;

	//- Standard helper functions
	//- dynamic dimdata update function
	//virtual Adesk::Boolean updateDimData () ;

} ;
