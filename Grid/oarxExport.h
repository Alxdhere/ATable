#include "stdafx.h"

void InitAcUiComboBoxs();
void FreeAcUiComboBoxs();

BOOL HasAlxdGridEntity(AcDbObjectId objId);
AcDbObjectId OPM_GetObjectId(IUnknown *pUnk);
int	OPM_GetNumData(AcDbObjectId objId, long index, VARIANT* pVarData);
int OPM_SetNumData(AcDbObjectId objId, long index, const VARIANT varData);
int OPM_GetCellTextData(AcDbObjectId objId, VARIANT* pVarData);
int OPM_SetCellTextData(AcDbObjectId objId, const VARIANT varData);
int OPM_GetTextStyleCount();
int OPM_GetTextStyleNameAt(int index, BSTR *pBstrValueName);
int OPM_GetTextStyleHandleAt(int index, VARIANT* pValue);
int OPM_GetTextStyleCurrentValueData(IUnknown *pUnk, VARIANT *pVarData);
int OPM_SetTextStyleCurrentValueData(IUnknown *pUnk, const VARIANT varData);
int OPM_GetValueByIndex(int index, ACHAR *pValue, BSTR *pBstrValueName);
BOOL OPM_GetStyleName();
//bool oarxInternalOpen();
//bool oarxInternalClose();

void INT_AlxdGrid_At(bool cmdPrompt);
void INT_AlxdGrid_Ats();
int  INT_AlxdGrid_ads_alxdat(struct resbuf *pArg);
void INT_AlxdGrid_Atc();

