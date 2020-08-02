unit uAlxdSystem;

interface

uses Windows, Classes, Graphics, Variants, ComCtrls, SysUtils,
 TypInfo, Messages, ExtCtrls;

const
  WM_ALXD_EDITORMODE         = WM_USER + $7D01;
  WM_ALXD_IDLE               = WM_USER + $7D05;
  WM_ALXD_CLOSE              = WM_USER + $7D06;
  WM_ALXD_SWITCH_TAB         = WM_USER + $7D07;
  WM_ALXD_SELTEXTISSELECTION = WM_USER + $7D0A;

  AlxdGridTitle = 'ATable 8.0 - [%s]';
  AlxdSpreadSheetTitle = '[%s] %s';
  DefaultString = 'Default';

type
  TPtArray = array of TPoint;
  
  TAlxdActionUpdateMotive = set of (aumStyle, aumBorders, aumCells, aumSelections);
  TAlxdRedrawMotive = set of (rmOneCell, rmCells, rmVerBorders, rmHorBorders, rmFills, rmAll, rmHeader, rmCopyOnWrite, rmAllCells, rmAllBorders, rmAllFills);

  TAlxdItemType = (itCol, itRow);
  TAlxdBorderType = (btVer, btHor);
  TAlxdSelectionType = (stUsually, stColumn, stRow, stAll);
  TAlxdDirectionTab = (dtLeft2Right, dtUp2Down);
  TAlxdDirectionEnter = (deLeft, deDown, deRight, deUp);

  TAlxdJoinedPlace = set of (jpLeft, jpTop, jpRight, jpBottom);

  TAlxdPrimary = (prColumn, prRow);
  TAlxdJustify = (jsTopLeft, jsTopRight, jsBottomLeft, jsBottomRight);
  TAlxdDrawBorder = (dbNoDraw, dbDraw);
  TAlxdDrawBorders = set of (dbLeft, dbTop, dbRight, dbBottom, dbVer, dbHor);
  TAlxdFillCell = (fcNoFill, fcFill);
  TAlxdTextFit = (tfsFit, tfsBreak);
  TAlxdTextType = (ttsMText, ttsDText);

  TAlxdMargins = record
    Left: double;
    Bottom: double;
    Right: double;
    Top: double;
  end;

  TAlxdJoined = record
    Cols: integer;
    Rows: integer;
  end;

  TAlxdPaintHorAlign = (phaLeft, phaCenter, phaRight);
  TAlxdPaintVerAlign = (pvaBottom, pvaMiddle, pvaTop);

  TObjectIDs = array of Integer;
  TIntegers = array of Integer;

  TAlxdItemTextHorAlignment = (ithaLeft, ithaCenter, ithaRight);
  TAlxdItemTextVerAlignment = (itvaBaseline, itvaBottom, itvaMiddle, itvaTop);

  TAlxdCellTextType = (cttsDefault, cttsMText, cttsDText, cttsBText, cttsMixed);
  TAlxdCellTextHorAlignment = (cthaDefault, cthaLeft, cthaCenter, cthaRight, cthaMixed);
  TAlxdCellTextVerAlignment = (ctvaDefault, ctvaBaseline, ctvaBottom, ctvaMiddle, ctvaTop, ctvaMixed);
  TAlxdCellTextFit = (ctfsDefault, ctfsFit, ctfsBreak, ctfsUnbreaked, ctfsFitted, ctfsMixed);

  TAlxdFillType = (ftDefault, ftEmpty, ftFill, ftMixed);
  TAlxdFillHatchType = (chtEmpty, chtFull, chtExcludeText, chtMixed);

  PDrawingPair = ^TDrawingPair;
  TDrawingPair = record
    x: double;
    y: double;
  end;

  TAds_point = array[0..2] of Double;

  PAlxdSpreadSheetStyleExchange = ^TAlxdSpreadSheetStyleExchange;
  TAlxdSpreadSheetStyleExchange = record
    ColCount: integer;
    RowCount: integer;
    DefaultSize: double;
    Primary: TAlxdPrimary;
    Justify: TAlxdJustify;

    DrawBorder: TAlxdDrawBorder;
    FillCell: TAlxdFillCell;
    TextFit: TAlxdTextFit;
    TextType: TAlxdTextType;

    StyleName: WideString;
    TextStyleName: WideString;
    TextStyleFontName: WideString;
    TextStyleBigFontName: WideString;

    TextHeight: double;
    TextWidthFactor: double;
    TextObliqueAngle: double;
    TextMargins: TAlxdMargins;

    TextColor: integer;
    TextLayer: WideString;
    TextWeight: integer;

    VerBorderColor: integer;
    VerBorderLayer: WideString;
    VerBorderWeight: integer;

    HorBorderColor: integer;
    HorBorderLayer: WideString;
    HorBorderWeight: integer;

    HeaderFileName: WideString;
    HeaderBlockName: WideString;

    Lock: boolean;

    Note: WideString;
  end;

  PAlxdSpreadSheetExchange = ^TAlxdSpreadSheetExchange;
  TAlxdSpreadSheetExchange = record
    BlockDefId: longint;
    BlockRefId: longint;
    BlockRefPtrJig: longint;
    DictionaryId: longint;
    HeaderRefId: longint;

    BlockDefInsPt: TAds_point;
    BlockRefInsPt: TAds_point;
    BlockRefSclFt: TAds_point;
  end;

  PAlxdItemExchange = ^TAlxdItemExchange;
  TAlxdItemExchange = record
    Size: double;
    Title: WideString;
    HorizontalAlignment: TAlxdItemTextHorAlignment;
    VerticalAlignment: TAlxdItemTextVerAlignment;
    Visible: boolean;
  end;
  TAlxdItemExchangeFunc = function (Obj: Pointer; ACol, ARow: integer): PAlxdItemExchange; cdecl;

  PAlxdCellExchange = ^TAlxdCellExchange;
  TAlxdCellExchange = record
    Text: WideString;
    Formula: WideString;

    TextType: TAlxdCellTextType;
    MTextBackgroundMaskState: boolean;

    //TextStyleName: WideString;
    TextStyleObjectId: integer;

    Height: double;
    WidthFactor: double;
    ObliqueAngle: double;
    Between: double;
    Rotation: double;

    HorizontalAlignment: TAlxdCellTextHorAlignment;
    VerticalAlignment: TAlxdCellTextVerAlignment;
    TextFit: TAlxdCellTextFit;
    Margins: TAlxdMargins;

    IsJoiningCell: boolean;
    IsResetedCell: boolean;
    IsVisibleCell: boolean;

    Color: integer;     //-1 - default
    Layer: WideString;  //'' - default
    Weight: integer;    //-4 - default

    Joined: TAlxdJoined;
    ObjectIds: TObjectIds;
    DefaultSize: double;
  end;
  TAlxdCellExchangeFunc = function (Obj: Pointer; ACol, ARow: integer): PAlxdCellExchange; cdecl;

  PAlxdFillExchange = ^TAlxdFillExchange;
  TAlxdFillExchange = record
    Coord: TDrawingPair;
    Size: TDrawingPair;
    FillType: TAlxdFillType;
    LineCount: integer;
    ObjectIds: TObjectIds;

    IsRotatedCell: boolean;
    DefaultSize: double;

    HatchName: WideString;
    HatchColor: integer;
    HatchType: TAlxdFillHatchType;
    HatchId: longint;
  end;
  TAlxdFillExchangeFunc = function (Obj: Pointer; ACol, ARow: integer): PAlxdFillExchange; cdecl;

  PAlxdBorderExchange = ^TAlxdBorderExchange;
  TAlxdBorderExchange = record
    State: TAlxdDrawBorder;

    Color: integer;
    Layer: WideString;
    Weight: integer;
    ObjectId: Integer;
  end;
  TAlxdBorderExchangeFunc = function (Obj: Pointer; ACol, ARow: integer): PAlxdBorderExchange; cdecl;

//--------------------
  TApplicationOption = record
    Language: WideString;
    LanguagePath: WideString;
    UseDynamicProperties: boolean;
    Transparency: boolean;
    TransparencyValue: integer;
  end;

  TStyleManagerOption = record
    StylePath: WideString;
    StyleCurrent: WideString;
  end;

  TSpreadSheetOption = record
    FontName: WideString;
    FontSize: integer;

    FixedColor: TColor;
    FixedLineColor: TColor;
    FixedColWidth: integer;
    FixedRowHeight: integer;
    PixelToMmX: double;
    PixelToMmY: double;
    SelectionColor: TColor;
    DrawingSelectionColor: integer;

    DirectionTab: TAlxdDirectionTab;
    DirectionEnter: TAlxdDirectionEnter;
    DrawHidedBorders: boolean;
    ExitOnEnter: boolean;
    WordWrap: boolean;
    SyncDelay: integer;
  end;

  PFind = ^TFind;
  TFind = record
    FindText: WideString;
    ReplaceText: WideString;
    FindTexts: WideString;
    ReplaceTexts: WideString;
    FindOffset: integer;
    FindCell: TPoint;
    FindPos: integer;
    FindLen: integer;
    //LowerCase: WideString;//
    //UpperCase: WideString;//
    FindUseCase: boolean;//
    FindUseReplace: boolean;
  end;

{
  TFinded = record
    LastCell: TPoint;
    Start: integer;
    Found: integer;
    StartSymbol: integer;
    FoundSymbol: integer;
    EOF: boolean;
  end;
}

  TCellCoord = record
    Cell: TPoint;
    Xconst: boolean;
    Yconst: boolean;
  end;

  TShiftParams = record
    FromCol: integer;
    FromRow: integer;
  end;

const
  MixedAlxdMargins: TAlxdMargins = (Left: -2; Bottom: -2; Right: -2; Top: -2);

procedure SetPropValue(Instance: TObject; const PropName: string; const Value: Variant);
procedure ClipboardSetBuffer(Format: Word; var Buffer; Size: Integer);

procedure Exchange(var v1, v2: integer);
function FindOwner(AOwner: TComponent; AClassName: string): TComponent;

//function Sign(const AValue: Integer): integer;
function IsFormula(Text: WideString): boolean;
function IsDefault(Value: WideString): boolean;
function InIntegerArray(value: integer; arr: array of Integer): boolean;

function NumToString(N: integer): string;
function StringToNum(S: string): Integer;

function RectIsPt(r: TRect): boolean;
function RectHavePt(Rt: TRect; Pt: TPoint): boolean;

//function EqualMargins(v1, v2: TAlxdMargins): boolean;

Function  AlxdMessageBox(Handle: HWND; Value: WideString; Caption: WideString; MessageType: Cardinal): integer;
Function  AlxdIndexedMessageBox(Handle: HWND; Index: integer; Caption: WideString; MessageType: Cardinal): integer;

function  AlxdDrawAlignedText(DC: HDC; lpchText: WideString; var p4: TRect; dwDTFormat: UINT; DTParams: PDrawTextParams; VerticalAlignment: TAlxdPaintVerAlign): Integer;
function  AlxdDrawText(DC: HDC; lpchText: WideString; cchText: Integer; var p4: TRect; dwDTFormat: UINT; DTParams: PDrawTextParams): Integer;

function  AlxdDoubleOrString(Def, Value, RealDef: double; isAngle: boolean = false): string;

procedure AlxdColorText(Node: TTreeNode; Value: integer);
procedure AlxdLineweightText(Node: TTreeNode; Value: Double);

procedure AlxdFloatKeyPress(Sender: TObject; var Key: Char; Minus: Boolean);
procedure AlxdIntegerKeyPress(Sender: TObject; var Key: Char; Minus: Boolean);

function  AlxdColorToPrettyName(Color: TColor; var Name: string): Boolean;

implementation

uses uoarxImport, uAlxdLocalizer;

//функция-заглушка для функции TypInfo.SetPropValue
procedure SetPropValue(Instance: TObject; const PropName: string; const Value: Variant);
begin
  if PropIsType(Instance, PropName, tkEnumeration) and
    (VarType(Value) = varOleStr) then
    TypInfo.SetPropValue(Instance, PropName, AnsiString(Value))
  else
    TypInfo.SetPropValue(Instance, PropName, Value);
end;

//функция для работы с буфером
procedure ClipboardSetBuffer(Format: Word; var Buffer; Size: Integer);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Size);
  try
    DataPtr := GlobalLock(Data);
    try
      Move(Buffer, DataPtr^, Size);
      SetClipboardData(Format, Data);
    finally
      GlobalUnlock(Data);
    end;
  except
    GlobalFree(Data);
    raise;
  end;
end;


procedure Exchange(var v1, v2: integer);
var
  tmp: integer;
begin
  tmp:=v1;
  v1:=v2;
  v2:=tmp;
end;

function FindOwner(AOwner: TComponent; AClassName: string): TComponent;
var
  o: TComponent;
begin
  o:=AOwner;

  while not o.ClassNameIs(AClassName) do
  begin
    o:=o.Owner;
    if o = nil then break;
  end;

  Result:=o;
end;
{
function Sign(const AValue: Integer): integer;
begin
  Result := 0;
  if AValue < 0 then
    Result := -1
  else if AValue > 0 then
    Result := 1;
end;
}
function IsFormula(Text: WideString): boolean;
begin
  Result:=((Length(Text) > 0) and (Text[1] = '='));
end;

function IsDefault(Value: WideString): boolean;
begin
  //result:=(StrLIComp(PAnsiChar(Value), DefaultString, Length(DefaultString)) = 0);
  result:=WideCompareText(Value, DefaultString) >= 0;
end;

function InIntegerArray(value: integer; arr: array of Integer): boolean;
var
  i: integer;
begin
  Result:=false;

  for i:=Low(arr) to High(arr) do
  if arr[i] = value then
  begin
    Result:=true;
    break;
  end; 
end;

function NumToString(N: integer): string;
var
  m:integer;
begin
  result:='';
  while n>0 do begin
    n:=n-1;
    m:=n mod 26;
    n:=n div 26;
    result:=Chr(m+65)+result;
  end;
end;

function StringToNum(S: string): Integer;
var
  i, l: Integer;
begin
  result:=0;
  l:=1;
  for i:=Length(s) downto 1 do
  begin
    result:=(ord(s[i])-64)*l+result;
    l:=26*l;
  end;
end;

function RectIsPt(r: TRect): boolean;
begin
  Result:=(r.Left = r.Right) and (r.Top = r.Bottom);
end;

function RectHavePt(Rt: TRect; Pt: TPoint): boolean;
begin
  result:=(Pt.X >= Rt.Left) and (Pt.X <= Rt.Right) and
          (Pt.Y >= Rt.Top) and (Pt.Y <= Rt.Bottom);
end;
{
function EqualMargins(v1, v2: TAlxdMargins): boolean;
begin
  result:=(v1.Left = v2.Left) and (v1.Top = v2.Top) and
          (v1.Right = v2.Right) and (v1.Bottom = v2.Bottom);
end;
}
Function AlxdMessageBox(Handle: HWND; Value: WideString; Caption: WideString; MessageType: Cardinal): integer;
var
  ACaption: PWideChar;
begin
  ACaption:=nil;
  if Caption<>'' then
    ACaption:=PWideChar(Caption);
  Result:=MessageBoxW(Handle, PWideChar(Value), ACaption, MessageType);
end;

Function AlxdIndexedMessageBox(Handle: HWND; Index: integer; Caption: WideString; MessageType: Cardinal): integer;
//var
//  Value: WideString;
begin
  //convert Index to Message
  //Value:=VarToStr(Index);
  Result:=AlxdMessageBox(Handle, MessageMemIniFile(Index), Caption, MessageType);
end;

function AlxdDrawAlignedText(DC: HDC; lpchText: WideString; var p4: TRect; dwDTFormat: UINT; DTParams: PDrawTextParams; VerticalAlignment: TAlxdPaintVerAlign): Integer;
var
  r: TRect;
  h: integer;
begin
  with p4 do
    if VerticalAlignment = pvaBottom then
    begin
      r:=Rect(0, 0, Right - Left, 0);
      h:=AlxdDrawText(DC, lpchText, -1, r, dwDTFormat or DT_CALCRECT, DTParams);
      h:=Bottom - h;
      if h > Top then Top:=h;
    end
    else
    if VerticalAlignment = pvaMiddle then
    begin
      r:=Rect(0, 0, Right - Left, 0);
      h:=AlxdDrawText(DC, lpchText, -1, r, dwDTFormat or DT_CALCRECT, DTParams);
      h:=((Bottom - Top) - h) div 2 + Top;
      if h > Top then Top:=h;
    end;

  r:=p4;
  Result:=AlxdDrawText(DC, lpchText, -1, r, dwDTFormat, DTParams);
end;

function AlxdDrawText(DC: HDC; lpchText: WideString; cchText: Integer; var p4: TRect; dwDTFormat: UINT; DTParams: PDrawTextParams): Integer;
begin
//  {$IFDEF DLL}
//  if Win32Platform = VER_PLATFORM_WIN32_NT then
//    Result:=DrawTextExW(DC, PWideChar(lpchText), cchText, p4, dwDTFormat, DTParams)
//  else
//    Result:=DrawTextEx(DC, PChar(WideCharToString(lpchText)),  cchText, p4, dwDTFormat, DTParams);
//  {$ELSE}
  Result:=DrawTextExW(DC, PWideChar(lpchText), cchText, p4, dwDTFormat, DTParams);
//  {$ENDIF}
end;

function  AlxdDoubleOrString(Def, Value, RealDef: double; isAngle: boolean = false): string;
var
  str: String;
begin
  try
  if Value<Def then
    result:=''
  else
    if Value=Def then
    begin
      if isAngle then
        str:=AlxdAngToS(RealDef)
      else
        str:=AlxdRToS(RealDef);
      result:=Format(DefaultString + ' [%s]',[String(str)]);
    end
    else
    begin
      if isAngle then
        str:=AlxdAngToS(Value)
      else
        str:=AlxdRToS(Value);
      result:=str;
    end;
  except
    on E:Exception do
      AlxdMessageBox(0, 'DoubleOrString', '', 0);
  end;
end;

procedure AlxdColorText(Node: TTreeNode; Value: integer);
var
  s: string;
begin
  case value of
 -1: s:='Inverse';
  0: s:='ByBlock';
  1: s:='Red';
  2: s:='Yellow';
  3: s:='Green';
  4: s:='Cyan';
  5: s:='Blue';
  6: s:='Magenta';
  7: s:='White';
  256: s:='ByLayer';
  else
  s:=Format('Color %d', [Value]);
  end;
  Node.Text:=Format(String(PChar(Node.data)),[s]);
end;

procedure AlxdLineweightText(Node: TTreeNode; Value: Double);
var
  s: string;
{$IFDEF DLL}
//  buffer: array[0..31] of char;
{$ENDIF}
begin
  if Value = -1 then
    s:='ByLayer'
  else
  if Value = -2 then
    s:='ByBlock'
  else
//  if Value = -2 then//?????
  if Value = -3 then
    s:='Default'
  else
  begin
    s:=AlxdRToS(Value/100);
  end;
  Node.Text:=Format(String(PChar(Node.data)),[s]);
end;

procedure AlxdFloatKeyPress(Sender: TObject; var Key: Char; Minus: Boolean);
begin
 case ord(key) of
  48..57,8,46,27: key:=key;
  44: key:='.';
  45: if not Minus then key:=#0;
 else
  key:=#0;
 end;
// if (key='.') and (pos('.',TEdit(Sender).Text)>0) then key:=#0;
// if (key='-') and (pos('-',TEdit(Sender).Text)>0) then key:=#0;
end;

procedure AlxdIntegerKeyPress(Sender: TObject; var Key: Char; Minus: Boolean);
begin
 case ord(key) of
  48..57,8,27:key:=key;
  45: if not Minus then key:=#0;
 else
  key:=#0;
 end;
// if (key='.') and (pos('.',TEdit(Sender).Text)>0) then key:=#0;
// if (key='-') and (pos('-',TEdit(Sender).Text)>0) then key:=#0;
end;

function AlxdColorToPrettyName(Color: TColor; var Name: string): Boolean;
const
  clNameBlack = 'Black';
  clNameMaroon = 'Maroon';
  clNameGreen = 'Green';
  clNameOlive = 'Olive';
  clNameNavy = 'Navy';
  clNamePurple = 'Purple';
  clNameTeal = 'Teal';
  clNameGray = 'Gray';
  clNameSilver = 'Silver';
  clNameRed = 'Red';
  clNameLime = 'Lime';
  clNameYellow = 'Yellow';
  clNameBlue = 'Blue';
  clNameFuchsia = 'Fuchsia';
  clNameAqua = 'Aqua';
  clNameWhite = 'White';
  clNameMoneyGreen = 'Money Green';
  clNameSkyBlue = 'Sky Blue';
  clNameCream = 'Cream';
  clNameMedGray = 'Medium Gray';
  clNameActiveBorder = 'Active Border';
  clNameActiveCaption = 'Active Caption';
  clNameAppWorkSpace = 'Application Workspace';
  clNameBackground = 'Background';
  clNameBtnFace = 'Button Face';
  clNameBtnHighlight = 'Button Highlight';
  clNameBtnShadow = 'Button Shadow';
  clNameBtnText = 'Button Text';
  clNameCaptionText = 'Caption Text';
  clNameDefault = 'Default';
  clNameGradientActiveCaption = 'Gradient Active Caption';
  clNameGradientInactiveCaption = 'Gradient Inactive Caption';
  clNameGrayText = 'Gray Text';
  clNameHighlight = 'Highlight Background';
  clNameHighlightText = 'Highlight Text';
  clNameHotLight = 'Hot Light';
  clNameInactiveBorder = 'Inactive Border';
  clNameInactiveCaption = 'Inactive Caption';
  clNameInactiveCaptionText = 'Inactive Caption Text';
  clNameInfoBk = 'Info Background';
  clNameInfoText = 'Info Text';
  clNameMenu = 'Menu Background';
  clNameMenuBar = 'Menu Bar';
  clNameMenuHighlight = 'Menu Highlight';
  clNameMenuText = 'Menu Text';
  clNameNone = 'None';
  clNameScrollBar = 'Scroll Bar';
  clName3DDkShadow = '3D Dark Shadow';
  clName3DLight = '3D Light';
  clNameWindow = 'Window Background';
  clNameWindowFrame = 'Window Frame';
  clNameWindowText = 'Window Text';
begin
  Result := True;
  case Color of
    clBlack: Name := clNameBlack;
    clMaroon: Name := clNameMaroon;
    clGreen: Name := clNameGreen;
    clOlive: Name := clNameOlive;
    clNavy: Name := clNameNavy;
    clPurple: Name := clNamePurple;
    clTeal: Name := clNameTeal;
    clGray: Name := clNameGray;
    clSilver: Name := clNameSilver;
    clRed: Name := clNameRed;
    clLime: Name := clNameLime;
    clYellow: Name := clNameYellow;
    clBlue: Name := clNameBlue;
    clFuchsia: Name := clNameFuchsia;
    clAqua: Name := clNameAqua;
    clWhite: Name := clNameWhite;
    clMoneyGreen: Name := clNameMoneyGreen;
    clSkyBlue: Name := clNameSkyBlue;
    clCream: Name := clNameCream;
    clMedGray: Name := clNameMedGray;

    clActiveBorder: Name := clNameActiveBorder;
    clActiveCaption: Name := clNameActiveCaption;
    clAppWorkSpace: Name := clNameAppWorkSpace;
    clBackground: Name := clNameBackground;
    clBtnFace: Name := clNameBtnFace;
    clBtnHighlight: Name := clNameBtnHighlight;
    clBtnShadow: Name := clNameBtnShadow;
    clBtnText: Name := clNameBtnText;
    clCaptionText: Name := clNameCaptionText;
    clDefault: Name := clNameDefault;
    clGrayText: Name := clNameGrayText;
    clGradientActiveCaption: Name := clNameGradientActiveCaption;
    clGradientInactiveCaption: Name := clNameGradientInactiveCaption;
    clHighlight: Name := clNameHighlight;
    clHighlightText: Name := clNameHighlightText;
    clHotLight: Name := clNameHotLight;
    clInactiveBorder: Name := clNameInactiveBorder;
    clInactiveCaption: Name := clNameInactiveCaption;
    clInactiveCaptionText: Name := clNameInactiveCaptionText;
    clInfoBk: Name := clNameInfoBk;
    clInfoText: Name := clNameInfoText;
    clMenu: Name := clNameMenu;
    clMenuBar: Name := clNameMenuBar;
    clMenuHighlight: Name := clNameMenuHighlight;
    clMenuText: Name := clNameMenuText;
    clNone: Name := clNameNone;
    clScrollBar: Name := clNameScrollBar;
    cl3DDkShadow: Name := clName3DDkShadow;
    cl3DLight: Name := clName3DLight;
    clWindow: Name := clNameWindow;
    clWindowFrame: Name := clNameWindowFrame;
    clWindowText: Name := clNameWindowText;
  else
    Result := False;
  end;
end;

end.
