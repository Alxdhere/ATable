unit uAlxdCell;

interface

uses
  Windows, SysUtils, Classes, Types, TypInfo, XMLDoc, XMLIntf,
  uAlxdSystem, uAlxdObjectIDs, uoarxImport, xAlxdCell, AlxdGrid_TLB, RegExpr;

const
  AlxdCellRoot = 'AlxdCell';
  AlxdCellPropValues: array[0..16] of string = ({'Contain'}'JoinedCols', 'JoinedRows', 'ContainAsMText', 'TextType', 'Height', 'TextStyleObjectId', 'WidthFactor', 'ObliqueAngle', 'Between', 'MarginLeft', 'MarginTop', 'MarginRight', 'MarginBottom', 'Rotation', 'HorizontalAlignment', 'VerticalAlignment', 'TextFit');

type
  TAlxdCellInt = class(TComponent, IAlxdCell)
  private
    FAlxdCell: IAlxdCell;

    FCol: integer;
    FRow: integer;
    FKeepObjects: boolean;
    FNeedRedraw: boolean;
    //: boolean;

    FAlxdCellExchange: TAlxdCellExchange;

    //FText: WideString;
    //FFormula: WideString;
    //FTextType: TAlxdCellTextType;

    //FRotation: double;

    FActualLinesInCell: integer;
    FAlxdObjectIDs: TAlxdObjectIDsInt;
    FNeedCheck: boolean;

  protected
    //get
    function  Get_Text: WideString;
    function  Get_Formula: WideString;
    function  Get_Contain: WideString;
    function  Get_ContainAsMText: WideString;
    function  Get_TextType: TAlxdCellTextType;
    function  Get_TextStyleObjectId: integer;
    function  Get_Height: double;
    function  Get_WidthFactor: double;
    function  Get_ObliqueAngle: double;
    function  Get_Between: double;
    function  Get_Margins: TAlxdMargins;
    function  Get_MarginLeft: double;
    function  Get_MarginTop: double;
    function  Get_MarginRight: double;
    function  Get_MarginBottom: double;

    function  Get_Rotation: double;
    function  Get_HorizontalAlignment: TAlxdCellTextHorAlignment;
    function  Get_VerticalAlignment: TAlxdCellTextVerAlignment;
    function  Get_TextFit: TAlxdCellTextFit;
    function  Get_Color: integer;
    function  Get_Layer: WideString;
    function  Get_Weight: integer;

    function  Get_JoinedPlace: TAlxdJoinedPlace;
    function  Get_JoinedRect: TRect;

    function  Get_RealSizeX: Double;
    function  Get_RealSizeY: Double;
    function  Get_RealMarginLeft: Double;
    function  Get_RealMarginTop: Double;
    function  Get_RealMarginRight: Double;
    function  Get_RealMarginBottom: Double;
    function  Get_RealTextType: TAlxdCellTextType;
    function  Get_RealTextStyleObjectId: integer;
    function  Get_RealHeight: double;
    function  Get_RealWidthFactor: double;
    function  Get_RealObliqueAngle: double;
    function  Get_RealBetween: double;
    function  Get_RealRotation: double;
    function  Get_RealHorizontalAlignment: TAlxdCellTextHorAlignment;
    function  Get_RealVerticalAlignment: TAlxdCellTextVerAlignment;
    function  Get_RealTextFit: TAlxdCellTextFit;
    function  Get_RealColor: integer;
    function  Get_RealLayer: WideString;
    function  Get_RealWeight: integer;

    function  Get_PaintSize: TRect;
    function  Get_PaintHorizontalAlignment: TAlxdPaintHorAlign;
    function  Get_PaintVerticalAlignment: TAlxdPaintVerAlign;

    function  Get_DrawingSize: TDrawingPair;
    function  Get_ActualLinesInCell: integer;
    function  Get_PropertyByNum(Index: Integer): OleVariant;

    //set
    procedure Set_Text(Value: WideString);
    procedure Set_Formula(Value: WideString);
    procedure Set_Contain(Value: WideString);
    procedure Set_ContainAsMText(Value: WideString);
    procedure Set_TextType(Value: TAlxdCellTextType);
    procedure Set_TextStyleObjectId(Value: integer);
    procedure Set_Height(Value: double);
    procedure Set_WidthFactor(Value: double);
    procedure Set_ObliqueAngle(Value: double);
    procedure Set_Between(Value: double);
    procedure Set_Margins(Value: TAlxdMargins);
    procedure Set_MarginLeft(Value: double);
    procedure Set_MarginTop(Value: double);
    procedure Set_MarginRight(Value: double);
    procedure Set_MarginBottom(Value: double);

    procedure Set_Rotation(Value: double);
    procedure Set_HorizontalAlignment(Value: TAlxdCellTextHorAlignment);
    procedure Set_VerticalAlignment(Value: TAlxdCellTextVerAlignment);
    procedure Set_TextFit(Value: TAlxdCellTextFit);

    procedure Set_Color(Value: Integer);
    procedure Set_Layer(Value: WideString);
    procedure Set_Weight(Value: Integer);

    procedure Set_JoinedCols(Value: integer);
    procedure Set_JoinedRows(Value: integer);
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant);

  public
    //DirectAccess
    property  Intf: IAlxdCell read FAlxdCell implements IAlxdCell;

    property  AlxdCellExchange: TAlxdCellExchange read FAlxdCellExchange;

    //property
    property  KeepObjects: boolean read FKeepObjects write FKeepObjects;
    property  NeedRedraw: boolean read FNeedRedraw write FNeedRedraw;

    property  Joined: TAlxdJoined read FAlxdCellExchange.Joined;
    property  JoinedPlace: TAlxdJoinedPlace read Get_JoinedPlace;
    property  JoinedRect: TRect read Get_JoinedRect;

    property  RealSizeX: Double read Get_RealSizeX;
    property  RealSizeY: Double read Get_RealSizeY;
    property  RealTextType: TAlxdCellTextType read Get_RealTextType;
    property  RealTextStyleObjectId: integer read Get_RealTextStyleObjectId;
    property  RealHeight: double read Get_RealHeight;
    property  RealWidthFactor: double read Get_RealWidthFactor;
    property  RealObliqueAngle: double read Get_RealObliqueAngle;
    property  RealBetween: double read Get_RealBetween;
    property  RealRotation: double read Get_RealRotation;

    property  RealMarginLeft: double read Get_RealMarginLeft;
    property  RealMarginTop: double read Get_RealMarginTop;
    property  RealMarginRight: double read Get_RealMarginRight;
    property  RealMarginBottom: double read Get_RealMarginBottom;

    property  RealHorizontalAlignment: TAlxdCellTextHorAlignment read Get_RealHorizontalAlignment;
    property  RealVerticalAlignment: TAlxdCellTextVerAlignment read Get_RealVerticalAlignment;
    property  RealTextFit: TAlxdCellTextFit read Get_RealTextFit;

    property  RealColor: integer read Get_RealColor;
    property  RealLayer: WideString read Get_RealLayer;
    property  RealWeight: integer read Get_RealWeight;

    property  PaintSize: TRect read Get_PaintSize;
    property  PaintHorizontalAlignment: TAlxdPaintHorAlign read Get_PaintHorizontalAlignment;
    property  PaintVerticalAlignment: TAlxdPaintVerAlign read Get_PaintVerticalAlignment;

    property  DrawingSize: TDrawingPair read Get_DrawingSize;

    property  ActualLinesInCell: integer read Get_ActualLinesInCell;
    property  PropertyByNum[Index: integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;

    //methods
    function  HasFormula: boolean;
    //это просто €чейка (без объединений)
    function  IsSimpleCell: boolean;
    //это объединенна€ €чейка, т.е. входит в состав объединенной €чейки,
    //но не €вл€етс€ объедин€ющей
    function  IsJoinedCell: boolean;
    //это объедин€юща€ €чейка, т.е. она объедин€ет р€дом сто€щие €чейки
    function  IsJoiningCell: boolean;
    //это €чейка, у которой "нет размера", т.е. размер колонки или р€да = 0
    function  IsResetedCell: boolean;
    function  IsVisibleCell: boolean;
    function  IsRotatedCell: boolean;

    function  Find: boolean;

    procedure ClearFormat;
    procedure ClearContent;
    procedure ClearAll;
    procedure CopyFormat(Source: TAlxdCellInt);
    procedure CopyContent(Source: TAlxdCellInt);
    procedure CopyAll(Source: TAlxdCellInt);

    function  WriteToXML(ADoc: IXMLNode): boolean;
    function  ReadFromXML(ADoc: IXMLNode): boolean;

    function  Redraw(motive: TAlxdRedrawMotive): boolean;

    procedure Assign(Source: TPersistent); override;
    constructor CreateEx(AOwner: TComponent; ACol, ARow: integer);
    destructor Destroy; override;
  published
    property  Text: WideString read Get_Text write Set_Text;
    property  Formula: WideString read Get_Formula write Set_Formula;
    property  Contain: WideString read Get_Contain write Set_Contain;
    property  ContainAsMText: WideString read Get_ContainAsMText write Set_ContainAsMText;
    property  TextType: TAlxdCellTextType read Get_TextType write Set_TextType;
    property  TextStyleObjectId: integer read Get_TextStyleObjectId write Set_TextStyleObjectId;
    property  Height: double read Get_Height write Set_Height;
    property  WidthFactor: double read Get_WidthFactor write Set_WidthFactor;
    property  ObliqueAngle: double read Get_ObliqueAngle write Set_ObliqueAngle;
    property  Between: double read Get_Between write Set_Between;

    property  Margins: TAlxdMargins read Get_Margins write Set_Margins;
    property  MarginLeft: double read Get_MarginLeft write Set_MarginLeft;
    property  MarginTop: double read Get_MarginTop write Set_MarginTop;
    property  MarginRight: double read Get_MarginRight write Set_MarginRight;
    property  MarginBottom: double read Get_MarginBottom write Set_MarginBottom;

    property  Rotation: double read Get_Rotation write Set_Rotation;
    property  HorizontalAlignment: TAlxdCellTextHorAlignment read Get_HorizontalAlignment write Set_HorizontalAlignment;
    property  VerticalAlignment: TAlxdCellTextVerAlignment read Get_VerticalAlignment write Set_VerticalAlignment;
    property  TextFit: TAlxdCellTextFit read Get_TextFit write Set_TextFit;

    property  Color: Integer read Get_Color write Set_Color;
    property  Layer: WideString read Get_Layer write Set_Layer;
    property  Weight: Integer read Get_Weight write Set_Weight;

    property  JoinedCols: integer read FAlxdCellExchange.Joined.Cols write Set_JoinedCols;
    property  JoinedRows: integer read FAlxdCellExchange.Joined.Rows write Set_JoinedRows;
  end;

implementation

uses
  uAlxdSpreadSheet, uAlxdSpreadSheetArray, uAlxdOptions, uAlxdCells;

function  TAlxdCellInt.Get_Text: WideString;
begin
  Result:=FAlxdCellExchange.Text;
end;

function  TAlxdCellInt.Get_Formula: WideString;
begin
  Result:=FAlxdCellExchange.Formula;
end;

function  TAlxdCellInt.Get_Contain: WideString;
begin
  if HasFormula then
    Result:=Formula
  else
    Result:=Text;
end;

function  TAlxdCellInt.Get_ContainAsMText: WideString;
begin
  Result:=Contain;
  Result:=StringReplace(Result, #13#10, #13, [rfReplaceAll]);
  Result:=StringReplace(Result, #10, #13, [rfReplaceAll]);
  Result:=StringReplace(Result, #13, '\P', [rfReplaceAll]);
      //если текст содержит #13#10 или #10,
      //то заменить все вхождени€ на \P

  //Result:=StringReplace(Result, #13#10, #13, [rfReplaceAll]);
  //Result:=StringReplace(Result, '\P', #13, [rfReplaceAll]);

end;

function  TAlxdCellInt.Get_TextType: TAlxdCellTextType;
begin
  Result:=FAlxdCellExchange.TextType;
end;

function  TAlxdCellInt.Get_TextStyleObjectId: integer;
begin
  Result:=FAlxdCellExchange.TextStyleObjectId;
end;

function  TAlxdCellInt.Get_Height: double;
begin
  Result:=FAlxdCellExchange.Height;
end;

function  TAlxdCellInt.Get_WidthFactor: double;
begin
  Result:=FAlxdCellExchange.WidthFactor;
end;

function  TAlxdCellInt.Get_ObliqueAngle: double;
begin
  Result:=FAlxdCellExchange.ObliqueAngle - 86;
end;

function  TAlxdCellInt.Get_Between: double;
begin
  Result:=FAlxdCellExchange.Between;
end;

function  TAlxdCellInt.Get_Margins: TAlxdMargins;
begin
  Result.Left:=MarginLeft;
  Result.Top:=MarginTop;
  Result.Right:=MarginRight;
  Result.Bottom:=MarginBottom;
end;

function  TAlxdCellInt.Get_MarginLeft: double;
begin
  Result:=FAlxdCellExchange.Margins.Left;
end;

function  TAlxdCellInt.Get_MarginTop: double;
begin
  Result:=FAlxdCellExchange.Margins.Top;
end;

function  TAlxdCellInt.Get_MarginRight: double;
begin
  Result:=FAlxdCellExchange.Margins.Right;
end;

function  TAlxdCellInt.Get_MarginBottom: double;
begin
  Result:=FAlxdCellExchange.Margins.Bottom;
end;

function  TAlxdCellInt.Get_TextFit: TAlxdCellTextFit;
begin
  Result:=FAlxdCellExchange.TextFit;
end;

function  TAlxdCellInt.Get_Color: integer;
begin
  Result:=FAlxdCellExchange.Color;
end;

function  TAlxdCellInt.Get_Layer: WideString;
begin
  Result:=FAlxdCellExchange.Layer;
end;

function  TAlxdCellInt.Get_Weight: integer;
begin
  Result:=FAlxdCellExchange.Weight;
end;

function  TAlxdCellInt.Get_Rotation: double;
begin
  Result:=FAlxdCellExchange.Rotation;
end;

function  TAlxdCellInt.Get_HorizontalAlignment: TAlxdCellTextHorAlignment;
begin
  Result:=FAlxdCellExchange.HorizontalAlignment;
end;

function  TAlxdCellInt.Get_VerticalAlignment: TAlxdCellTextVerAlignment;
begin
  Result:=FAlxdCellExchange.VerticalAlignment;
end;

function  TAlxdCellInt.Get_JoinedPlace: TAlxdJoinedPlace;
begin
  if IsSimpleCell then
  begin
    Result:=[jpLeft, jpTop, jpRight, jpBottom];
    exit;
  end;

  Result:=[];

  if JoinedCols >= 0 then
    Include(Result, jpLeft);

  if JoinedRows >= 0 then
    Include(Result, jpTop);

  if JoinedRows < 0 then
//    if (Owner as TAlxdSpreadSheetArray).Cells[FRow + JoinedRows, FCol].JoinedRows + JoinedRows = 0 then
    if (Owner as TAlxdSpreadSheetArray).Cells.Items[FCol, FRow + JoinedRows].JoinedRows + JoinedRows = 0 then
      Include(Result, jpBottom);

  if JoinedCols < 0 then
//    if (Owner as TAlxdSpreadSheetArray).Cells[FRow, FCol + JoinedCols].JoinedCols + JoinedCols = 0 then
    if (Owner as TAlxdSpreadSheetArray).Cells.Items[FCol + JoinedCols, FRow].JoinedCols + JoinedCols = 0 then
      Include(Result, jpRight);
end;

function  TAlxdCellInt.Get_JoinedRect: TRect;
begin
  Result:=Rect(FCol, FRow, FCol, FRow);

  if not IsSimpleCell then
  begin
    if IsJoinedCell then
      Result:=Rect(FCol + JoinedCols, FRow + JoinedRows, FCol, FRow);

    with Result do
    begin
      Right:=Left + (Owner as TAlxdSpreadSheetArray).Cells.Items[Left, Top].JoinedCols;
      Bottom:=Top + (Owner as TAlxdSpreadSheetArray).Cells.Items[Left, Top].JoinedRows;
    end;
  end;

end;

function  TAlxdCellInt.Get_RealSizeX: Double;
begin
  Result:=0;

  if IsVisibleCell then
    with (Owner as TAlxdSpreadSheetArray) do
    if IsSimpleCell then
      //Result:=Columns.Items[FCol].RealSize * Columns.Items[FCol].LineCount
      Result:=Columns.Items[FCol].DrawingSize//это быстрее!!!
    else
    if IsJoiningCell then
      Result:=Columns.RealDeltaSize(JoinedRect.Left, JoinedRect.Right - JoinedRect.Left + 1);
end;

function  TAlxdCellInt.Get_RealSizeY: Double;
begin
  Result:=0;

  if IsVisibleCell then
    with (Owner as TAlxdSpreadSheetArray) do
    if IsSimpleCell then
      //Result:=Rows.Items[FRow].RealSize * Rows.Items[FRow].LineCount
      Result:=Rows.Items[FRow].DrawingSize//это быстрее!!!
    else
    if IsJoiningCell then
      Result:=Rows.RealDeltaSize(JoinedRect.Top, JoinedRect.Bottom - JoinedRect.Top + 1);
end;

function  TAlxdCellInt.Get_RealMarginLeft: Double;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=MarginLeft;

  if Result < 0 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextMarginLeft;
  end;
end;

function  TAlxdCellInt.Get_RealMarginTop: Double;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=MarginTop;

  if Result < 0 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextMarginTop;
  end;
end;

function  TAlxdCellInt.Get_RealMarginRight: Double;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=MarginRight;

  if Result < 0 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextMarginRight;
  end;
end;

function  TAlxdCellInt.Get_RealMarginBottom: Double;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=MarginBottom;

  if Result < 0 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextMarginBottom;
  end;
end;

function  TAlxdCellInt.Get_RealTextType: TAlxdCellTextType;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=TextType;

  if Result = cttsDefault then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    if ass.AlxdSpreadSheetStyle.TextType = ttsMText then
      Result:=cttsMText;
    if ass.AlxdSpreadSheetStyle.TextType = ttsDText then
      Result:=cttsDText;
  end;
end;

function  TAlxdCellInt.Get_RealTextStyleObjectId: integer;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=TextStyleObjectId;

  if Result = 0 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextStyleObjectId;
  end;
end;

function  TAlxdCellInt.Get_RealHeight: double;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=Height;

  if Result = 0 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextHeight;
  end;
end;

function  TAlxdCellInt.Get_RealWidthFactor: double;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=WidthFactor;

  if Result = 0 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextWidthFactor;
  end;
end;

function  TAlxdCellInt.Get_RealObliqueAngle: double;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=ObliqueAngle;

  if Result = -86 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextObliqueAngle;
  end;
end;

function   TAlxdCellInt.Get_RealBetween: double;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=Between;

  if Result = 0 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.DefaultSize;
  end;
end;

function   TAlxdCellInt.Get_RealRotation: double;
begin
  Result:=Rotation;
end;

function  TAlxdCellInt.Get_RealHorizontalAlignment: TAlxdCellTextHorAlignment;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=HorizontalAlignment;

  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
  if Result = cthaDefault then
    if ass.AlxdSpreadSheetStyle.Primary = prColumn then
      Result:=TAlxdCellTextHorAlignment(Ord(ass.AlxdSpreadSheetArray.Columns.Items[FCol].HorizontalAlignment) + 1)
    else
      Result:=TAlxdCellTextHorAlignment(Ord(ass.AlxdSpreadSheetArray.Rows.Items[FRow].HorizontalAlignment) + 1);
end;

function  TAlxdCellInt.Get_RealVerticalAlignment: TAlxdCellTextVerAlignment;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=VerticalAlignment;

  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
  if Result = ctvaDefault then
    if ass.AlxdSpreadSheetStyle.Primary = prColumn then
      Result:=TAlxdCellTextVerAlignment(Ord(ass.AlxdSpreadSheetArray.Columns.Items[FCol].VerticalAlignment) + 1)
    else
      Result:=TAlxdCellTextVerAlignment(Ord(ass.AlxdSpreadSheetArray.Rows.Items[FRow].VerticalAlignment) + 1);
    //Result:=ctvaBaseline;

  if RealTextType = cttsMText then
    if Result < ctvaBottom then
      Result:=ctvaBottom;
end;

function  TAlxdCellInt.Get_RealTextFit: TAlxdCellTextFit;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=TextFit;

  if Result = ctfsDefault then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    if ass.AlxdSpreadSheetStyle.TextFit = tfsBreak then
      Result:=ctfsBreak;
    if ass.AlxdSpreadSheetStyle.TextFit = tfsFit then
      Result:=ctfsFit;
  end;
end;

function  TAlxdCellInt.Get_RealColor: integer;
var
  ass: TAlxdSpreadSheetInt;
begin
  if Color < 0 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextColor;
  end
  else
    Result:=Color;
end;

function  TAlxdCellInt.Get_RealLayer: WideString;
var
  ass: TAlxdSpreadSheetInt;
begin
  if Layer = '' then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextLayer;
  end
  else
    Result:=Layer;
end;

function  TAlxdCellInt.Get_RealWeight: integer;
var
  ass: TAlxdSpreadSheetInt;
begin
  if Weight < -3 then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    Result:=ass.AlxdSpreadSheetStyle.TextWeight;
  end
  else
    Result:=Weight;
end;

function  TAlxdCellInt.Get_PaintHorizontalAlignment: TAlxdPaintHorAlign;
begin
  Result:=TAlxdPaintHorAlign(Integer(RealHorizontalAlignment) - 1);
end;

function  TAlxdCellInt.Get_PaintVerticalAlignment: TAlxdPaintVerAlign;
begin
  if RealVerticalAlignment <= ctvaBottom then
    Result:=pvaBottom
  else
    Result:=TAlxdPaintVerAlign(Integer(RealVerticalAlignment) - 2);
end;

function  TAlxdCellInt.Get_PaintSize: TRect;
begin
  {$IFDEF DEBUG}
  //OutputDebugString(PChar(Format(#10'TAlxdCellInt.Get_PaintSize %d, %d', [FCol, FRow])));
  {$ENDIF}

  Result:=Rect(0, 0, 0, 0);

  if IsSimpleCell then
  begin
    Result.Right:=(Owner as TAlxdSpreadSheetArray).Columns.Items[FCol].PaintSize;
    Result.Bottom:=(Owner as TAlxdSpreadSheetArray).Rows.Items[FRow].PaintSize;
  end
  else
  if IsJoiningCell then
  begin
    Result.Right:=(Owner as TAlxdSpreadSheetArray).Columns.PaintDeltaSize(JoinedRect.Left, JoinedRect.Right - JoinedRect.Left + 1);
    Result.Bottom:=(Owner as TAlxdSpreadSheetArray).Rows.PaintDeltaSize(JoinedRect.Top, JoinedRect.Bottom - JoinedRect.Top + 1);
  end;
end;

function  TAlxdCellInt.Get_DrawingSize: TDrawingPair;
begin
  Result.x:=RealSizeX;// - RealMarginLeft;
  Result.y:=RealSizeY;
end;

function  TAlxdCellInt.Get_ActualLinesInCell: integer;
begin
  Result:=1;
  if IsSimpleCell then
    Result:=FActualLinesInCell;
end;

function  TAlxdCellInt.Get_PropertyByNum(Index: Integer): OleVariant;
begin
//
end;

procedure TAlxdCellInt.Set_Text(Value: WideString);
begin
{  if IsFormula(Value) then
  begin
    Formula:=Value;
    exit;
  end;}

  if not (IsSimpleCell or IsJoiningCell) then
    FAlxdCellExchange.Text:=''
  else
  if FAlxdCellExchange.Text <> Value then
  begin
    FAlxdCellExchange.Text:=Value;
    NeedRedraw:=True;
  end;

end;

procedure TAlxdCellInt.Set_Formula(Value: WideString);
begin
{  if not IsFormula(Value) then
  begin
    Text:=Value;
    exit;
  end;}
  if not (IsSimpleCell or IsJoiningCell) then
    FAlxdCellExchange.Formula:=''
  else
  if FAlxdCellExchange.Formula <> Value then
  begin
    FAlxdCellExchange.Formula:=Value;
  end;
end;

procedure TAlxdCellInt.Set_Contain(Value: WideString);
//var
//  ass: TAlxdSpreadSheetInt;
begin
  if IsFormula(Value) then
  begin
    Text:='';
    Formula:=Value;
  end
  else
  begin
    Formula:='';
    Text:=Value;
  end;

  //ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
  //if not ass.AlxdUndo.Proceed then
  //  ass.AlxdUndo.Fix;
end;

procedure TAlxdCellInt.Set_ContainAsMText(Value: WideString);
begin
  //Value:=StringReplace(Value, #13#10, #13, [rfReplaceAll]);
  //Value:=StringReplace(Value, '\P', #13, [rfReplaceAll]);

  Value:=StringReplace(Value, '\P', #13#10, [rfReplaceAll]);
  Contain:=Value;
end;

procedure TAlxdCellInt.Set_TextType(Value: TAlxdCellTextType);
begin
  if FAlxdCellExchange.TextType <> Value then
  begin
    FAlxdCellExchange.TextType:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_TextStyleObjectId(Value: integer);
begin
{  if Value < 0 then
  begin
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  if FAlxdCellExchange.Height <> Value then}
  //begin
    FAlxdCellExchange.TextStyleObjectId:=Value;

    FNeedRedraw:=True;
  //end;
end;

procedure TAlxdCellInt.Set_Height(Value: double);
begin
  if FNeedCheck then
    if Value < 0 then
    begin
      AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
      exit;
    end;

  if FAlxdCellExchange.Height <> Value then
  begin
    FAlxdCellExchange.Height:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_WidthFactor(Value: double);
begin
  if FNeedCheck then
    if Value < 0 then
    begin
      AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
      exit;
    end;

  if FAlxdCellExchange.WidthFactor <> Value then
  begin
    FAlxdCellExchange.WidthFactor:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_ObliqueAngle(Value: double);
begin
//-87 = undefined (mixed)
//-86 = default (by style)
//-85 = -85 degree
//-84 = -84 degree & etc
  if FNeedCheck then
    if (Value < -86) or (Value > 85) then
    begin
      AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
      exit;
    end;

  Value:=Value + 86;
  if FAlxdCellExchange.ObliqueAngle <> Value then
  begin
    FAlxdCellExchange.ObliqueAngle:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_Between(Value: double);
begin
  if FNeedCheck then
    if Value < 0 then
    begin
      AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
      exit;
    end;

  if FAlxdCellExchange.Between <> Value then
  begin
    FAlxdCellExchange.Between:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_Margins(Value: TAlxdMargins);
begin
  if Value.Left > MixedAlxdMargins.Left then MarginLeft:=Value.Left;
  if Value.Top > MixedAlxdMargins.Top then MarginTop:=Value.Top;
  if Value.Right > MixedAlxdMargins.Right then MarginRight:=Value.Right;
  if Value.Bottom > MixedAlxdMargins.Bottom then MarginBottom:=Value.Bottom;
end;

procedure TAlxdCellInt.Set_MarginLeft(Value: double);
begin
  if FNeedCheck then
    if Value < -1 then
    begin
      AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
      exit;
    end;

  if FAlxdCellExchange.Margins.Left <> Value then
  begin
    FAlxdCellExchange.Margins.Left:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_MarginTop(Value: double);
begin
  if FNeedCheck then
    if Value < -1 then
    begin
      AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
      exit;
    end;

  if FAlxdCellExchange.Margins.Top <> Value then
  begin
    FAlxdCellExchange.Margins.Top:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_MarginRight(Value: double);
begin
  if FNeedCheck then
    if Value < -1 then
    begin
      AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
      exit;
    end;

  if FAlxdCellExchange.Margins.Right <> Value then
  begin
    FAlxdCellExchange.Margins.Right:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_MarginBottom(Value: double);
begin
  if FNeedCheck then
    if Value < -1 then
    begin
      AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
      exit;
    end;

  if FAlxdCellExchange.Margins.Bottom <> Value then
  begin
    FAlxdCellExchange.Margins.Bottom:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_TextFit(Value: TAlxdCellTextFit);
begin
  if FAlxdCellExchange.TextFit <> Value then
  begin
    FAlxdCellExchange.TextFit:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_Color(Value: Integer);
begin
//  if Value > -2 then
  if FAlxdCellExchange.Color <> Value then
  begin
    FAlxdCellExchange.Color:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_Layer(Value: WideString);
begin
  if FAlxdCellExchange.Layer <> Value then
  begin
    FAlxdCellExchange.Layer:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_Weight(Value: Integer);
begin
  if FAlxdCellExchange.Weight <> Value then
  begin
    FAlxdCellExchange.Weight:=Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdCellInt.Set_Rotation(Value: double);
begin
  FAlxdCellExchange.Rotation:=Value;
  FNeedRedraw:=True;
end;

procedure TAlxdCellInt.Set_HorizontalAlignment(Value: TAlxdCellTextHorAlignment);
begin
  FAlxdCellExchange.HorizontalAlignment:=Value;
  FNeedRedraw:=True;
end;

procedure TAlxdCellInt.Set_VerticalAlignment(Value: TAlxdCellTextVerAlignment);
begin
  FAlxdCellExchange.VerticalAlignment:=Value;
  FNeedRedraw:=True;
end;


procedure TAlxdCellInt.Set_JoinedCols(Value: integer);
begin
  FAlxdCellExchange.Joined.Cols:=Value;

  if FAlxdCellExchange.Joined.Cols < 0 then
    Contain:='';

  FNeedRedraw:=True;
end;

procedure TAlxdCellInt.Set_JoinedRows(Value: integer);
begin
  FAlxdCellExchange.Joined.Rows:=Value;

  if FAlxdCellExchange.Joined.Rows < 0 then
    Contain:='';

  FNeedRedraw:=True;
end;

procedure TAlxdCellInt.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  case Index of
  1:  Text:=Value;
  3:  Formula:=Value;
  11:
    begin
      JoinedCols:=Value[0];
      JoinedRows:=Value[1];
    end;
  40: Height:=Value;
  41: WidthFactor:=Value;
  42: ObliqueAngle:=Value;
  43: Between:=Value;
  50: Rotation:=Value;
  60: Color:=Value;
  65: Weight:=Value;
  72: HorizontalAlignment:=Value;
  73: VerticalAlignment:=Value;
//  90:
  140:MarginLeft:=Value;
  141:MarginBottom:=Value;
  142:MarginRight:=Value;
  143:MarginTop:=Value;
  282:TextType:=Value;
  283:TextFit:=Value;
  end;
end;

function  TAlxdCellInt.HasFormula: boolean;
begin
  Result:=(Formula <> '');
end;

function  TAlxdCellInt.IsSimpleCell: boolean;
begin
  Result:=(FAlxdCellExchange.Joined.Cols = 0) and (FAlxdCellExchange.Joined.Rows = 0);
end;

function  TAlxdCellInt.IsJoinedCell: boolean; 
begin
  Result:=(FAlxdCellExchange.Joined.Cols < 0) or (FAlxdCellExchange.Joined.Rows < 0);
end;

function  TAlxdCellInt.IsJoiningCell: boolean;
begin
  Result:=(FAlxdCellExchange.Joined.Cols > 0) or (FAlxdCellExchange.Joined.Rows > 0);
end;

function  TAlxdCellInt.IsResetedCell: boolean;
begin
  if Rotation = 0 then
    Result:=(Owner as TAlxdSpreadSheetArray).Rows.Items[FRow].Size = 0
  else
    Result:=(Owner as TAlxdSpreadSheetArray).Columns.Items[FCol].Size = 0;
end;

function  TAlxdCellInt.IsVisibleCell: boolean;
begin
  Result:=((Owner as TAlxdSpreadSheetArray).Columns.Items[FCol].Visible and (Owner as TAlxdSpreadSheetArray).Rows.Items[FRow].Visible);
end;

function  TAlxdCellInt.IsRotatedCell: boolean;
begin
  Result:=(Rotation = 90);
end;

function  TAlxdCellInt.Find: boolean;
var
  r: TRegExpr;
begin
  result:=false;

  r:=TRegExpr.Create;
  try
    r.Expression:=FvarOptions.FindText;
    r.InputString:=Contain;

    Result:=r.ExecPos(FvarOptions.FindOffset);
    if Result then
    begin
      FvarOptions.FindPos:=r.MatchPos[0];
      FvarOptions.FindLen:=r.MatchLen[0];
    end;
    result:=true;
  finally
    r.Free;
  end;
end;

procedure TAlxdCellInt.ClearFormat;
begin
  with FAlxdCellExchange do
  begin
    TextType:=cttsDefault;

    TextStyleObjectId:=0;

    Height:=0;
    WidthFactor:=0;
    ObliqueAngle:=0;
    Between:=0;
    Rotation:=0;

    HorizontalAlignment:=cthaDefault;
    VerticalAlignment:=ctvaDefault;
    TextFit:=ctfsDefault;
    Margins.Left:=-1;
    Margins.Top:=-1;
    Margins.Right:=-1;
    Margins.Bottom:=-1;

    //Color: integer;
    //Weight: integer;
  end;
end;

procedure TAlxdCellInt.ClearContent;
begin
  Contain := '';
end;

procedure TAlxdCellInt.ClearAll;
begin
  ClearFormat;
  ClearContent;
end;

procedure TAlxdCellInt.CopyFormat(Source: TAlxdCellInt);
begin
  TextType:=Source.TextType;

  Height:=Source.Height;
  WidthFactor:=Source.WidthFactor;
  ObliqueAngle:=Source.ObliqueAngle;
  Between:=Source.Between;
  Rotation:=Source.Rotation;

  HorizontalAlignment:=Source.HorizontalAlignment;
  VerticalAlignment:=Source.VerticalAlignment;
  TextFit:=Source.TextFit;
  Margins:=Source.Margins;

  //Color:=Source.Color;
  //Weight:=Source.Weight;
end;

procedure TAlxdCellInt.CopyContent(Source: TAlxdCellInt);
begin
  Contain:=Source.Contain;
end;

procedure TAlxdCellInt.CopyAll(Source: TAlxdCellInt);
begin
  CopyFormat(Source);
  CopyContent(Source);
end;

function TAlxdCellInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc.AddChild(AlxdCellRoot);
    root.SetAttributeNS('Column', '', FCol);
    root.SetAttributeNS('Row', '', FRow);

    //write properties
    for i := 0 to High(AlxdCellPropValues) do
    begin
      node:=root.AddChild(AlxdCellPropValues[i]);
      node.NodeValue:=GetPropValue(Self, AlxdCellPropValues[i]);
    end;

    Result:=True;
  except
    on E:Exception do
    begin
      AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function TAlxdCellInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc;//.ChildNodes.FindNode(AlxdCellRoot);
    if root = nil then
    begin
      //raise EXMLDocError.Create('');
      Result:=false;
      exit;
    end;
    //FCol:=root.GetAttributeNS('Column', '');
    //FRow:=root.GetAttributeNS('Row', '');

    for i := 0 to High(AlxdCellPropValues) do
    begin
      node:=root.ChildNodes.FindNode(AlxdCellPropValues[i]);
      if node <> nil then
        //raise EXMLDocError.Create('');
        SetPropValue(Self, AlxdCellPropValues[i], node.NodeValue);
    end;

    Result:=True;
  except
    on E:Exception do
    begin
      AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function  TAlxdCellInt.Redraw(motive: TAlxdRedrawMotive): boolean;
var
  tmpCoord: TDrawingPair;
  tmpSize: TDrawingPair;
  tmpValue: TAlxdCellExchange;
  tmpActualLinesInCell: integer;
//  i,j: integer;
//  l: integer;
  {$IFDEF TICK}
  tick: Cardinal;
  {$ENDIF}
begin
  {$IFDEF TICK}
  tick:=GetTickCount;
  OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw coord:%d, %d', [FCol, FRow])));
  {$ENDIF}
  try

    {$IFDEF DEBUG}
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw SizeOf(tmpValue.Text): %d', [SizeOf(tmpValue.Text)])));
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw SizeOf(tmpValue.TextType): %d', [SizeOf(tmpValue.TextType)])));
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw SizeOf(ttmpValuemp.Height): %d', [SizeOf(tmpValue.Height)])));
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw SizeOf(tmpValue.Margins): %d', [SizeOf(tmpValue.Margins)])));
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw SizeOf(tmpValue.Color): %d', [SizeOf(tmpValue.Color)])));
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw SizeOf(tmpValue.ObjectIds): %d', [SizeOf(tmpValue.ObjectIds)])));
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw SizeOf(tmpValue): %d', [SizeOf(tmpValue)])));
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw + tmpValue.ObjectIds : %p', [tmpValue.ObjectIds])));
    {$ENDIF}

    //if NeedRedraw or (rmAll in motive) or (rmCells in motive) then
    if (rmAll in motive) or (rmAllCells in motive) or (NeedRedraw and (rmCells in motive)) then
    begin
      tmpCoord.x:=(Owner as TAlxdSpreadSheetArray).Columns.Items[FCol].Coord;
      tmpCoord.y:=(Owner as TAlxdSpreadSheetArray).Rows.Items[FRow].Coord;
      tmpSize:=DrawingSize;

      tmpValue.Text:=Text;
      //если текст содержит #13#10 или #10,?
      //то заменить все вхождени€ на \P?

      //если текст содержит #13#10, #10, \P
      //то заменить все вхождени€ на #13
      //ContainAsMText?
      //tmpValue.Text:=StringReplace(tmpValue.Text, #13#10, #13, [rfReplaceAll]);
      //tmpValue.Text:=StringReplace(tmpValue.Text, '\P', #13, [rfReplaceAll]);
      //tmpValue.Text:=StringReplace(tmpValue.Text, #13#10, #13, [rfReplaceAll]);
      //tmpValue.Text:=StringReplace(tmpValue.Text, #10, #13, [rfReplaceAll]);
      //tmpValue.Text:=StringReplace(tmpValue.Text, '\P', #13, [rfReplaceAll]);

      tmpValue.Formula:=Formula;
      tmpValue.TextType:=RealTextType;

      //tmpValue.TextStyleName:='';
      tmpValue.TextStyleObjectId:=RealTextStyleObjectId;

      tmpValue.Height:=RealHeight;
      tmpValue.WidthFactor:=RealWidthFactor;
      tmpValue.ObliqueAngle:=RealObliqueAngle;
      tmpValue.Between:=RealBetween;
      tmpValue.Rotation:=RealRotation;
      tmpValue.HorizontalAlignment:=RealHorizontalAlignment;
      tmpValue.VerticalAlignment:=RealVerticalAlignment;
      tmpValue.TextFit:=RealTextFit;//ctfsUnbreaked;
      //tmpValue.TextFit:=ctfsFit;
      tmpValue.Margins.Left:=RealMarginLeft;
      tmpValue.Margins.Top:=RealMarginTop;
      tmpValue.Margins.Right:=RealMarginRight;
      tmpValue.Margins.Bottom:=RealMarginBottom;

      tmpValue.IsJoiningCell:=IsJoiningCell;
      tmpValue.IsResetedCell:=IsResetedCell;
      tmpValue.IsVisibleCell:=IsVisibleCell;

      tmpValue.Color:=RealColor;
      tmpValue.Layer:=RealLayer;
      tmpValue.Weight:=RealWeight;

//      tmpValue.HatchName:=FAlxdCellExchange.HatchName;
//      tmpValue.HatchColor:=2;
//      tmpValue.HatchStyle:=chsFull;
//      tmpValue.HatchId:=FAlxdCellExchange.HatchId;
      //копирует указатель, а не содержимое!
      tmpValue.ObjectIds:=FAlxdObjectIDs.DirectObjectIDs;
      tmpValue.DefaultSize:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.DefaultSize;
      //((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle

      tmpActualLinesInCell:=1;
      {$IFDEF DLL}
      oarxLockDocument(((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).BlockReferenceId);
      if oarxRedrawCell(@tmpCoord, @tmpSize, @tmpValue, tmpActualLinesInCell) then
      {$ENDIF}
        if FActualLinesInCell <> tmpActualLinesInCell then
        begin
          FActualLinesInCell:=tmpActualLinesInCell;
          //(Owner as TAlxdSpreadSheetArray).Columns.Items[FCol].LineCount;
          //(Owner as TAlxdSpreadSheetArray).Rows.Items[FRow].LineCount;
        end;

{
     with (Owner as TAlxdSpreadSheetArray) do
        if tmpValue.Rotation = 0 then
        begin
          if Rows.Items[FRow].LineCount <> l then
            Rows.Items[FRow].LineCount:=Max(l
          else
            NeedRedraw:=False;
        end
        else
        begin
          if Columns.Items[FCol].LineCount <> l then
            Columns.Items[FCol].LineCount:=l
          else
            NeedRedraw:=False;
        end;
}
      FAlxdObjectIDs.DirectObjectIDs:=tmpValue.ObjectIds;
      NeedRedraw:=False;
    end;
    Result:=True;

    {$IFDEF DEBUG}
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw + tmpValue.ObjectIds : %p', [tmpValue.ObjectIds])));
//    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw + FAlxdObjectIDs.DirectObjectIDs : %p', [FAlxdObjectIDs.DirectObjectIDs])));
    {$ENDIF}

  except
    Result:=False;
  end;
  {$IFDEF TICK}
  if GetTickCount <> tick then
    OutputDebugString(PChar(Format(#10'TAlxdCellInt.Redraw tick:%d', [GetTickCount - tick])));
  //OutputDebugString(#10'TAlxdCellInt.Redraw finished');
  {$ENDIF}
end;

procedure TAlxdCellInt.Assign(Source: TPersistent);
var
  i: integer;
begin
  if Source is TAlxdCellInt then
    for i := 0 to High(AlxdCellPropValues) do
    begin
      SetPropValue(Self, AlxdCellPropValues[i], GetPropValue(Source, AlxdCellPropValues[i]));
    end;

  if Source is TAlxdCellsInt then
  begin
    FNeedCheck:=false;

    for i := 0 to High(AlxdCellsPropValues) do
    begin
      SetPropValue(Self, AlxdCellsPropValues[i], GetPropValue(Source, AlxdCellsPropValues[i]));
    end;
    
    FNeedCheck:=true;
  end;
end;

constructor TAlxdCellInt.CreateEx(AOwner: TComponent; ACol, ARow: integer);
begin
  inherited Create(AOwner);
  FNeedCheck:=True;
  FAlxdCell:=TAlxdCell.Create(Self);

  FCol:=ACol;
  FRow:=ARow;
  FAlxdObjectIDs:=TAlxdObjectIDsInt.Create(Self);
  FKeepObjects:=false;
  FNeedRedraw:=true;
  //FAlxdCellExchange.ObliqueAngle:=0;
  FAlxdCellExchange.Rotation:=0;
  FAlxdCellExchange.Joined.Cols:=0;
  FAlxdCellExchange.Joined.Rows:=0;

  FAlxdCellExchange.Margins.Left:=-1;
  FAlxdCellExchange.Margins.Top:=-1;
  FAlxdCellExchange.Margins.Right:=-1;
  FAlxdCellExchange.Margins.Bottom:=-1;

  FAlxdCellExchange.Color:=-1;
  FAlxdCellExchange.Layer:='';
  FAlxdCellExchange.Weight:=-4;
//  FAlxdCellExchange.HatchName:='SOLID';
//  FAlxdCellExchange.HatchId:=0;
end;

destructor TAlxdCellInt.Destroy;
{$IFDEF DLL}
var
  tmpValue: TAlxdCellExchange;
{$ENDIF}
begin
  if Assigned(FAlxdObjectIDs) then
  begin
    {$IFDEF DLL}
    if not KeepObjects then
    begin
      tmpValue.ObjectIds:=FAlxdObjectIDs.DirectObjectIDs;
      oarxEraseCell(@tmpValue, 0);
      FAlxdObjectIDs.DirectObjectIDs:=tmpValue.ObjectIds;
    end;
    {$ENDIF}
    FAlxdObjectIDs.Free;
  end;
  inherited;
end;

end.
