unit uoarxImport;

interface

uses
  Windows, SysUtils, uAlxdSystem;

const
  alxdgridarx = 'AlxdGrid.arx';
  acadexe = 'acad.exe';

  RTNORM = 5100;
  RTERROR = -5001;

type
  PWasLocked = ^TWasLocked;
  TWasLocked = record
	  TextLayer: boolean;
	  VerBorderLayer: boolean;
	  HorBorderLayer: boolean;
  end;

{$IFDEF DLL}
//common
function  oarxAcDbRToS(Value: double; var Text: WideString): integer; cdecl; external alxdgridarx;
function  oarxAcDbAngToS(Value: double; var Text: WideString): integer; cdecl; external alxdgridarx;
function  oarxAcDbDisToF(const Text: WideString; Value: PDouble): integer; cdecl; external alxdgridarx;
function  oarxAcEdGetDist(const Text: WideString; Value: PDouble): integer; cdecl; external alxdgridarx;
function  oarxAcUtPrintf(const Text: WideString): integer; cdecl; external alxdgridarx;
function  oarxAcEdGetRGB(color: integer): integer; cdecl; external alxdgridarx;

procedure oarxRegisterOnIdleWinMsg; cdecl; external alxdgridarx;
procedure oarxRemoveOnIdleWinMsg; cdecl; external alxdgridarx;
procedure oarxRegisterWinMsg(h: HWND); cdecl; external alxdgridarx;
procedure oarxRemoveWinMsg; cdecl; external alxdgridarx;
procedure oarxDisableDocumentActivation; cdecl; external alxdgridarx;
procedure oarxEnableDocumentActivation; cdecl; external alxdgridarx;
procedure oarxSendStringToExecute(const pszExecute: WideString; bActivate, bWrapUpInactiveDoc, bEchoString: boolean); cdecl; external alxdgridarx;

//validate name functions
function  oarxValidLayerName(var LayerName: WideString): boolean; cdecl; external alxdgridarx;
function  oarxValidTextStyleName(var TextStyle, TextStyleFontName, TextStyleBigFontName: WideString; var id: Longint): boolean; cdecl; external alxdgridarx;

function  oarxSaveLayersLock(Value: PAlxdSpreadSheetStyleExchange; locked: PWasLocked): boolean; cdecl; external alxdgridarx;
function  oarxLoadLayersLock(Value: PAlxdSpreadSheetStyleExchange; locked: PWasLocked): boolean; cdecl; external alxdgridarx;

function  oarxId2Handle(id: longint; var Text: WideString): boolean; cdecl; external alxdgridarx;
function  oarxImportFuncList(var Value: WideString): boolean; cdecl; external alxdgridarx;

//combolists
procedure oarxGetTextStyles(ControlHandle: HWND); cdecl; external alxdgridarx;
procedure oarxGetLayers(ControlHandle: HWND); cdecl; external alxdgridarx;
procedure oarxGetLinetypes(ControlHandle: HWND); cdecl; external alxdgridarx;
procedure oarxGetBlocks(ControlHandle: HWND); cdecl; external alxdgridarx;

function  oarxGetTextStyleId(StyleName: WideString): Longint; cdecl; external alxdgridarx;
//function  oarxGetTextStyleName(objId: Longint; var StyleName: WideString): boolean; cdecl; external alxdgridarx;
procedure oarxGetTextStyleName(objId: Longint; var StyleName: WideString); cdecl; external alxdgridarx;
procedure oarxGetTextStyleProperties(objId: Longint; var dHeight, dWidthFactor, dOblique: double; var isV: boolean); cdecl; external alxdgridarx;

//Color ComboBox
function  oarxAttachColorCombo(hWnd: HWND): integer; cdecl; external alxdgridarx;
function  oarxInsertColorItemInList(index: integer; Name: PWideChar; cargo: integer): integer; cdecl; external alxdgridarx;
function  oarxAddColorToColorCombo(colorIndex: integer): integer; cdecl; external alxdgridarx;
function  oarxOnColorComboDrawItem(lpDrawItemStruct: PDrawItemStruct): integer; cdecl; external alxdgridarx;
function  oarxOnColorComboDropDown: integer; cdecl; external alxdgridarx;
function  oarxOnColorComboCloseUp: integer; cdecl; external alxdgridarx;
function  oarxOnColorComboSelectOther(isOther: integer; CurSel: integer; var NewSel: Integer): boolean; cdecl; external alxdgridarx;
procedure oarxSetUseByBlock(use: integer); cdecl; external alxdgridarx;
procedure oarxSetUseByLayer(use: integer); cdecl; external alxdgridarx;
function  oarxDetachColorCombo: integer; cdecl; external alxdgridarx;

//Lineweight ComboBox
function  oarxAttachLineWeightCombo(hWnd: HWND): integer; cdecl; external alxdgridarx;
function  oarxInsertLineWeightItemInList(index: integer; Name: PWideChar; cargo: integer): integer; cdecl; external alxdgridarx;
function  oarxFindItemByLineWeight(colorIndex: integer): integer; cdecl; external alxdgridarx;
function  oarxGetCurrentItemLineWeight: integer; cdecl; external alxdgridarx;
function  oarxGetItemLineWeight(item: integer): integer; cdecl; external alxdgridarx;
function  oarxOnLineWeightComboDrawItem(lpDrawItemStruct: PDrawItemStruct): integer; cdecl; external alxdgridarx;
function  oarxOnLineWeightComboDropDown: integer; cdecl; external alxdgridarx;
function  oarxDetachLineWeightCombo: integer; cdecl; external alxdgridarx;

//borders
function oarxReadBordersList(Obj: longint; func: TAlxdBorderExchangeFunc; dictid: longint; AColCount, ARowCount: integer; AType: TAlxdBorderType): boolean; cdecl; external alxdgridarx;
function oarxWriteBordersList(Obj: longint; func: TAlxdBorderExchangeFunc; dictid: longint; AColCount, ARowCount: integer; AType: TAlxdBorderType): boolean; cdecl; external alxdgridarx;
function oarxEraseBorder(Value: PAlxdBorderExchange): boolean; cdecl; external alxdgridarx;
function oarxRedrawBorder(stCoord: PDrawingPair; endCoord: PDrawingPair; Value: PAlxdBorderExchange): boolean; cdecl; external alxdgridarx;

//fills
function oarxReadFillsList(Obj: longint; func: TAlxdFillExchangeFunc; dictid: longint; AColCount, ARowCount: integer): boolean; cdecl; external alxdgridarx;
function oarxWriteFillsList(Obj: longint; func: TAlxdFillExchangeFunc; dictid: longint; AColCount, ARowCount: integer): boolean; cdecl; external alxdgridarx;
function oarxEraseFill(Value: PAlxdFillExchange; KeptLines: integer): boolean; cdecl; external alxdgridarx;
function oarxRedrawFill(Value: PAlxdFillExchange): boolean; cdecl; external alxdgridarx;

//cells
function oarxReadCellsList(Obj: longint; func: TAlxdCellExchangeFunc; dictid: longint; AColCount, ARowCount: integer): boolean; cdecl; external alxdgridarx;
function oarxWriteCellsList(Obj: longint; func: TAlxdCellExchangeFunc; dictid: longint; AColCount, ARowCount: integer): boolean; cdecl; external alxdgridarx;
function oarxEraseCell(Value: PAlxdCellExchange; KeptLines: integer): boolean; cdecl; external alxdgridarx;
function oarxRedrawCell(Coord: PDrawingPair; Size: PDrawingPair; Value: PAlxdCellExchange; var ActualLinesInCell: integer): boolean; cdecl; external alxdgridarx;

//items
function oarxReadItemsList(Obj: longint; func: TAlxdItemExchangeFunc; dictid: longint; ACount: integer; AType: TAlxdItemType): boolean; cdecl; external alxdgridarx;
function oarxWriteItemsList(Obj: longint; func: TAlxdItemExchangeFunc; dictid: longint; ACount: integer; AType: TAlxdItemType): boolean; cdecl; external alxdgridarx;

//header
function oarxEraseHeader(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxRedrawHeader(style: PAlxdSpreadSheetStyleExchange; Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxRedrawAttributeRef(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxRepositionAttributeRef(const Value: PAlxdSpreadSheetExchange; oldPt: TAds_point): boolean; cdecl; external alxdgridarx;
//style
function oarxReadStyleList(style: PAlxdSpreadSheetStyleExchange; value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxWriteStyleList(style: PAlxdSpreadSheetStyleExchange; value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;

//spreadsheet
function oarxIsUniqueGrid(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxEraseGrid(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxOpenGrid(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxCloseGrid(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxApplyBlockRef(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxCreateBlockDef(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
function oarxBoundaryBlockDef(const Value: PAlxdSpreadSheetExchange; var pminPt, pmaxPt: Variant): boolean; cdecl; external alxdgridarx;
function oarxLockDocument(const refId: longint): boolean; cdecl; external alxdgridarx;
function oarxRedrawScreen(const refId: longint): boolean; cdecl; external alxdgridarx;


//import
//function oarxImportAcDbTableCells(entid: longint; Obj: longint; cells: TAlxdCellExchangeFunc): boolean; cdecl; external alxdgridarx;
//function oarxImportAcDbTableItems(entid: longint; Obj: longint; cells: TAlxdItemExchangeFunc; atype: TAlxdItemType): boolean; cdecl; external alxdgridarx;
//function oarxImportAcDbTableStyle(Value: PAlxdSpreadSheetStyleExchange; var entid: longint): boolean; cdecl; external alxdgridarx;

//dialogs
function oarxAcEdSetColorDialog(Color: Pinteger; AllowMetaColor: Boolean; CurLayerColor: integer): boolean; cdecl; external alxdgridarx;
function oarxAcEdGetFileNavDialog(const title, def, ext, dlgname: WideString; flags: integer; var res: WideString): integer; cdecl; external alxdgridarx;

//calculate
function oarxAcEdEvaluateLisp(const Text: WideString; var pVarData: Variant; var pResType: integer): integer; cdecl; external alxdgridarx;

//utility
function adsw_acadMainWnd: HWND; cdecl; external acadexe;
//function acedEvaluateLisp: HWND; cdecl; external acadexe;
//int __cdecl acedEvaluateLisp(ACHAR const *,struct resbuf * &);

//function acedRegisterFilterWinMsg(): integer; cdecl; external acadexe;
{$ENDIF}

function AlxdRToS(Value: double): WideString;
function AlxdAngToS(Value: double): WideString;
function AlxdDisToF(const Text: WideString; var Value: Double): boolean;

implementation

function AlxdRToS(Value: Double): WideString;
{$IFDEF DLL}
var
//  buf: array[0..20] of char;
  buf: WideString;
{$ENDIF}
begin
  try
{$IFDEF DLL}
  oarxAcDbRToS(Value, buf);
  Result:=buf;
{$ELSE}
  Result:=FloatToStr(Value);
{$ENDIF}
  except
    on E:Exception do
      AlxdMessageBox(0, 'AlxdRToS', '', 0);
  end;
end;


function AlxdAngToS(Value: Double): WideString;
{$IFDEF DLL}
var
//  buf: array[0..20] of char;
  buf: WideString;
  sign: boolean;
{$ENDIF}
begin
  try
{$IFDEF DLL}
  sign := (Value < 0);

  oarxAcDbAngToS(Abs(Value), buf);

  if sign then
    buf:='-' + buf;

  Result:=buf;
{$ELSE}
  Result:=FloatToStr(Value);
{$ENDIF}
  except
    on E:Exception do
      AlxdMessageBox(0, 'AlxdAngToS', '', 0);
  end;
end;


function AlxdDisToF(const Text: WideString; var Value: Double): boolean;
begin
  try
{$IFDEF DLL}
    Result:=(oarxAcDbDisToF(PWideChar(Text), @Value) = RTNORM);
{$ELSE}
    Value:=StrToFloat(Text);
    Result:=True;
{$ENDIF}
  except
    on E:Exception do
    //begin
      //AlxdMessageBox(0, 'AlxdDisToF', '', 0);
      Result:=False;
    //end;
  end;
end;


end.
