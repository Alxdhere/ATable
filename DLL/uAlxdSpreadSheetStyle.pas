unit uAlxdSpreadSheetStyle;

interface

uses
  TypInfo, SysUtils, Classes, Windows, uAlxdSystem, uAlxdSpreadSheetStyleItems,
  StdVcl, XMLDoc, XMLIntf, xAlxdSpreadSheetStyle, uoarxImport, AlxdGrid_TLB,
  IniFiles, TntSysUtils{, StrUtils};

const
  AlxdSpreadSheetStyleRoot = 'AlxdSpreadSheetStyle';
  AlxdSpreadSheetStylePropValues: array[0..31] of string =
    ('ColCount',
     'RowCount',
     'DefaultSize',
     'Primary',
     'Justify',
//     'Items',
     'DrawBorder',
     'FillCell',
     'TextFit',
     'TextType',
//должны быть до имени стиля!
     'TextStyleFontName',
     'TextStyleBigFontName',
//----
     'TextStyleName',
     'TextHeight',
     'TextWidthFactor',
     'TextObliqueAngle',
     'TextMarginLeft',
     'TextMarginTop',
     'TextMarginRight',
     'TextMarginBottom',
     'TextColor',
     'TextLayer',
     'TextWeight',
     'VerBorderColor',
     'VerBorderLayer',
     'VerBorderWeight',
     'HorBorderColor',
     'HorBorderLayer',
     'HorBorderWeight',
     'HeaderFileName',
     'HeaderBlockName',
     'Lock',
     'Note');

type
  TAlxdSpreadSheetStyleInt = class(TComponent, IAlxdSpreadSheetStyle)
  private
    { Private declarations }
    FAlxdSpreadSheetStyle: IAlxdSpreadSheetStyle;

    FColCount: integer;
    FRowCount: integer;
    FDefaultSize: double;
    FPrimary: TAlxdPrimary;
    FJustify: TAlxdJustify;

    FAlxdSpreadSheetStyleItems: TAlxdSpreadSheetStyleItemsInt;

    FDrawBorder: TAlxdDrawBorder;
    FFillCell: TAlxdFillCell;
    FTextFit: TAlxdTextFit;
    FTextType: TAlxdTextType;

    FStyleName: WideString;
    FStyleFileName: WideString;
    FTextStyleName: WideString;
    FTextStyleFontName: WideString;
    FTextStyleBigFontName: WideString;
    FTextStyleObjectId: Longint;

    FTextHeight: double;
    FTextWidthFactor: double;
    FTextObliqueAngle: double;
    FTextMargins: TAlxdMargins;

    FTextColor: integer;
    FTextLayer: WideString;
    FTextWeight: integer;

    FVerBorderColor: integer;
    FVerBorderLayer: WideString;
    FVerBorderWeight: integer;

    FHorBorderColor: integer;
    FHorBorderLayer: WideString;
    FHorBorderWeight: integer;

    FHeaderFileName: WideString;
    FHeaderBlockName: WideString;

    FLock: boolean;

    FNote: WideString;

    FMotive: TAlxdRedrawMotive;

  protected
    { Protected declarations }
    Function  Get_AlxdSpreadSheetStyleExchange: TAlxdSpreadSheetStyleExchange;

    function  Get_ColCount: integer;
    function  Get_RowCount: integer;
    function  Get_DefaultSize: double;
    function  Get_Primary: TAlxdPrimary;
    function  Get_Justify: TAlxdJustify;

    function  Get_Items: TAlxdSpreadSheetStyleItemsInt;

    function  Get_DrawBorder: TAlxdDrawBorder;
    function  Get_FillCell: TAlxdFillCell;
    function  Get_TextFit: TAlxdTextFit;
    function  Get_TextType: TAlxdTextType;

    function  Get_StyleFileName: WideString;
    function  Get_StyleName: WideString;

    function  Get_TextStyleName: WideString;
    function  Get_TextStyleFontName: WideString;
    function  Get_TextStyleBigFontName: WideString;
    function  Get_TextHeight: double;
    function  Get_TextWidthFactor: double;
    function  Get_TextObliqueAngle: double;
    function  Get_TextMargins: TAlxdMargins;
    function  Get_TextMarginLeft: double;
    function  Get_TextMarginTop: double;
    function  Get_TextMarginRight: double;
    function  Get_TextMarginBottom: double;

    function  Get_TextColor: integer;
    function  Get_TextLayer: WideString;
    function  Get_TextWeight: integer;

    function  Get_VerBorderColor: integer;
    function  Get_VerBorderLayer: WideString;
    function  Get_VerBorderWeight: integer;

    function  Get_HorBorderColor: integer;
    function  Get_HorBorderLayer: WideString;
    function  Get_HorBorderWeight: integer;

    function  Get_HeaderFileName: WideString;
    function  Get_HeaderBlockName: WideString;
    function  Get_Lock: boolean;
    function  Get_Note: WideString;

    function  Get_PropertyByNum(Index: Integer): OleVariant;


    procedure Set_AlxdSpreadSheetStyleExchange(Value: TAlxdSpreadSheetStyleExchange);

    procedure Set_ColCount(Value: integer);
    procedure Set_RowCount(Value: integer);
    procedure Set_DefaultSize(Value: double);
    procedure Set_Primary(Value: TAlxdPrimary);
    procedure Set_Justify(Value: TAlxdJustify);

    procedure Set_Items(Value: TAlxdSpreadSheetStyleItemsInt);

    procedure Set_DrawBorder(Value: TAlxdDrawBorder);
    procedure Set_FillCell(Value: TAlxdFillCell);
    procedure Set_TextFit(Value: TAlxdTextFit);
    procedure Set_TextType(Value: TAlxdTextType);

//    procedure Set_StyleFileName(Value: WideString);

    procedure Set_TextStyleName(Value: WideString);
    procedure Set_TextStyleFontName(Value: WideString);
    procedure Set_TextStyleBigFontName(Value: WideString);
    procedure Set_TextHeight(Value: double);
    procedure Set_TextWidthFactor(Value: double);
    procedure Set_TextObliqueAngle(Value: double);
    procedure Set_TextMargins(Value: TAlxdMargins);
    procedure Set_TextMarginLeft(Value: double);
    procedure Set_TextMarginTop(Value: double);
    procedure Set_TextMarginRight(Value: double);
    procedure Set_TextMarginBottom(Value: double);

    Procedure Set_TextColor(Value: integer);
    Procedure Set_TextLayer(Value: WideString);
    Procedure Set_TextWeight(Value: integer);

    Procedure Set_VerBorderColor(Value: integer);
    Procedure Set_VerBorderLayer(Value: WideString);
    Procedure Set_VerBorderWeight(Value: integer);

    Procedure Set_HorBorderColor(Value: integer);
    Procedure Set_HorBorderLayer(Value: WideString);
    Procedure Set_HorBorderWeight(Value: integer);

    procedure Set_HeaderFileName(Value: WideString);
    procedure Set_HeaderBlockName(Value: WideString);
    procedure Set_Lock(Value: boolean);
    procedure Set_Note(Value: WideString);

    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant);

  public
    { Public declarations }
    property Intf: IAlxdSpreadSheetStyle read FAlxdSpreadSheetStyle implements IAlxdSpreadSheetStyle;
    property AlxdSpreadSheetStyleExchange: TAlxdSpreadSheetStyleExchange read Get_AlxdSpreadSheetStyleExchange write Set_AlxdSpreadSheetStyleExchange;

    property PropertyByNum[Index: integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;
    property Motive: TAlxdRedrawMotive read FMotive write FMotive;

    function WriteToDictionary(var value: TAlxdSpreadSheetExchange): boolean;
    function ReadFromDictionary(var value: TAlxdSpreadSheetExchange): boolean;

    function WriteToXML(ADoc: IXMLNode): boolean;
    function ReadFromXML(ADoc: IXMLNode): boolean;

    function SaveToXML(AFileName: WideString): boolean;
    function LoadFromXML(AFileName: WideString): boolean;

    //for old versions
    function LoadFromATS(AFileName: WideString): boolean;
    function LoadFrom(AFileName: WideString): boolean;

    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property ColCount: integer read Get_ColCount write Set_ColCount;
    property RowCount: integer read Get_RowCount write Set_RowCount;
    property DefaultSize: double read Get_DefaultSize write Set_DefaultSize;
    property Primary: TAlxdPrimary read Get_Primary write Set_Primary;
    property Justify: TAlxdJustify read Get_Justify write Set_Justify;

    property Items: TAlxdSpreadSheetStyleItemsInt read Get_Items write Set_Items;

    property DrawBorder: TAlxdDrawBorder read Get_DrawBorder write Set_DrawBorder;
    property FillCell: TAlxdFillCell read Get_FillCell write Set_FillCell;
    property TextFit: TAlxdTextFit read Get_TextFit write Set_TextFit;
    property TextType: TAlxdTextType read Get_TextType write Set_TextType;

    property StyleFileName: WideString read Get_StyleFileName;
    property StyleName: WideString read Get_StyleName;

    property TextStyleName: WideString read Get_TextStyleName write Set_TextStyleName;
    property TextStyleFontName: WideString read Get_TextStyleFontName write Set_TextStyleFontName;
    property TextStyleBigFontName: WideString read Get_TextStyleBigFontName write Set_TextStyleBigFontName;
    property TextStyleObjectId: longint read FTextStyleObjectId;
    property TextHeight: double read Get_TextHeight write Set_TextHeight;
    property TextWidthFactor: double read Get_TextWidthFactor write Set_TextWidthFactor;
    property TextObliqueAngle: double read Get_TextObliqueAngle write Set_TextObliqueAngle;
    property TextMargins: TAlxdMargins read Get_TextMargins write Set_TextMargins;
    property TextMarginLeft: double read Get_TextMarginLeft write Set_TextMarginLeft;
    property TextMarginTop: double read Get_TextMarginTop write Set_TextMarginTop;
    property TextMarginRight: double read Get_TextMarginRight write Set_TextMarginRight;
    property TextMarginBottom: double read Get_TextMarginBottom write Set_TextMarginBottom;

    property TextColor: integer read Get_TextColor write Set_TextColor;
    property TextLayer: WideString read Get_TextLayer write Set_TextLayer;
    property TextWeight: integer read Get_TextWeight write Set_TextWeight;

    property VerBorderColor: integer read Get_VerBorderColor write Set_VerBorderColor;
    property VerBorderLayer: WideString read Get_VerBorderLayer write Set_VerBorderLayer;
    property VerBorderWeight: integer read Get_VerBorderWeight write Set_VerBorderWeight;

    property HorBorderColor: integer read Get_HorBorderColor write Set_HorBorderColor;
    property HorBorderLayer: WideString read Get_HorBorderLayer write Set_HorBorderLayer;
    property HorBorderWeight: integer read Get_HorBorderWeight write Set_HorBorderWeight;

    property HeaderFileName: WideString read Get_HeaderFileName write Set_HeaderFileName;
    property HeaderBlockName: WideString read Get_HeaderBlockName write Set_HeaderBlockName;
    property Lock: boolean read Get_Lock write Set_Lock;
    property Note: WideString read Get_Note write Set_Note;

  end;

//error group 000 (i.e. 001...099)

implementation

uses
  uAlxdEditor, uAlxdSpreadSheet, uAlxdOptions;

Function TAlxdSpreadSheetStyleInt.Get_AlxdSpreadSheetStyleExchange: TAlxdSpreadSheetStyleExchange;
begin
  Result.ColCount:=ColCount;
  Result.RowCount:=RowCount;
  Result.DefaultSize:=DefaultSize;
  Result.Primary:=Primary;
  Result.Justify:=Justify;

  Result.HeaderFileName:=FHeaderFileName;
  Result.HeaderBlockName:=FHeaderBlockName;

  Result.DrawBorder:=DrawBorder;
  Result.FillCell:=FillCell;
  Result.TextFit:=TextFit;
  Result.TextType:=TextType;

  Result.StyleName:=FStyleName;
  Result.TextStyleName:=TextStyleName;
  Result.TextStyleFontName:=TextStyleFontName;
  Result.TextStyleBigFontName:=TextStyleBigFontName;

  Result.TextHeight:=TextHeight;
  Result.TextWidthFactor:=TextWidthFactor;
  Result.TextObliqueAngle:=TextObliqueAngle;
  Result.TextMargins:=TextMargins;

  Result.TextColor:=TextColor;
  Result.TextLayer:=TextLayer;
  Result.TextWeight:=TextWeight;

  Result.VerBorderColor:=VerBorderColor;
  Result.VerBorderLayer:=VerBorderLayer;
  Result.VerBorderWeight:=VerBorderWeight;

  Result.HorBorderColor:=HorBorderColor;
  Result.HorBorderLayer:=HorBorderLayer;
  Result.HorBorderWeight:=HorBorderWeight;


//  Result.Lock:=FLock;
//  Result.Note:=FNote;

//  Result:=FAlxdSpreadSheetStyleExchange;
{
  if (Owner is TAlxdSpreadSheetInt) then
  with (Owner as TAlxdSpreadSheetInt) do
  begin
    Result.ColCount:=AlxdSpreadSheetArray.ColCount;
    Result.RowCount:=AlxdSpreadSheetArray.RowCount;
  end;
}
end;

Function TAlxdSpreadSheetStyleInt.Get_ColCount: integer;
begin
  if (Owner is TAlxdSpreadSheetInt) then
  begin
    Result:=(Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.ColCountInt;
{$IFDEF DEBUG}
    OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetStyleInt.Get_ColCount*: %d', [Result])));
{$ENDIF}
  end
  else
  begin
    Result:=FColCount;
{$IFDEF DEBUG}
    OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetStyleInt.Get_ColCount: %d', [Result])));
{$ENDIF}
  end;
end;

Function TAlxdSpreadSheetStyleInt.Get_RowCount: integer;
begin
  if (Owner is TAlxdSpreadSheetInt) then
  begin
    Result:=(Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt;
{$IFDEF DEBUG}
    OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetStyleInt.Get_RowCount*: %d', [Result])));
{$ENDIF}
  end
  else
  begin
    Result:=FRowCount;
{$IFDEF DEBUG}
    OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetStyleInt.Get_RowCount: %d', [Result])));
{$ENDIF}
  end;
end;

Function TAlxdSpreadSheetStyleInt.Get_DefaultSize: double;
begin
  Result:=FDefaultSize;
end;

Function TAlxdSpreadSheetStyleInt.Get_Primary: TAlxdPrimary;
begin
  Result:=FPrimary;
end;

Function TAlxdSpreadSheetStyleInt.Get_Justify: TAlxdJustify;
begin
  Result:=FJustify;
end;

function  TAlxdSpreadSheetStyleInt.Get_PropertyByNum(Index: Integer): OleVariant;
begin
  case Index of
  2:  Result:=StyleName;
  3:  Result:=HeaderFileName;
  4:  Result:=HeaderBlockName;
  6:  Result:=TextLayer;
  7:  Result:=TextStyleName;
  8:  Result:=VerBorderLayer;
  9:  Result:=HorBorderLayer;
  38: Result:=DefaultSize;
  40: Result:=TextHeight;
  41: Result:=TextWidthFactor;
  42: Result:=TextObliqueAngle;
  56: Result:=TextMarginLeft;
  57: Result:=TextMarginBottom;
  58: Result:=TextMarginRight;
  59: Result:=TextMarginTop;
  60: Result:=TextColor;
  61: Result:=VerBorderColor;
  62: Result:=HorBorderColor;
  64: Result:=TextWeight;
  65: Result:=VerBorderWeight;
  66: Result:=HorBorderWeight;
  70: Result:=ColCount;
  71: Result:=RowCount;
  280:Result:=DrawBorder;
  281:Result:=FillCell;
  282:Result:=TextFit;
  283:Result:=TextType;
  287:Result:=Primary;
  288:Result:=Justify;
  289:Result:=Lock;
  //330:Result:=
  end;
end;

function  TAlxdSpreadSheetStyleInt.Get_Items: TAlxdSpreadSheetStyleItemsInt;
begin
  if (Owner is TAlxdSpreadSheetInt) then
  begin
    if Primary = prColumn then
    begin
      FAlxdSpreadSheetStyleItems.Count:=ColCount;
      FAlxdSpreadSheetStyleItems.Assign((Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns);
    end
    else
    begin
      FAlxdSpreadSheetStyleItems.Count:=RowCount;
      FAlxdSpreadSheetStyleItems.Assign((Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Rows);
    end;

    Result:=FAlxdSpreadSheetStyleItems;
{    if Primary = prColumn then
      FAlxdSpreadSheetStyleItems.Count:=ColCount
    else
      FAlxdSpreadSheetStyleItems.Count:=RowCount;}
    //Result:=(Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt;
  //if (Owner is TAlxdSpreadSheetInt) then
  //begin
    //Result:=nil;
  end
  else
    Result:=FAlxdSpreadSheetStyleItems;
end;

function  TAlxdSpreadSheetStyleInt.Get_DrawBorder: TAlxdDrawBorder;
begin
  Result:=FDrawBorder;
end;

function  TAlxdSpreadSheetStyleInt.Get_FillCell: TAlxdFillCell;
begin
  Result:=FFillCell;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextFit: TAlxdTextFit;
begin
  Result:=FTextFit;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextType: TAlxdTextType;
begin
  Result:=FTextType;
end;

function  TAlxdSpreadSheetStyleInt.Get_StyleFileName: WideString;
begin
  Result:=FStyleFileName;
end;

function  TAlxdSpreadSheetStyleInt.Get_StyleName: WideString;
begin
  Result:=FStyleName;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextStyleName: WideString;
begin
  Result:=FTextStyleName;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextStyleFontName: WideString;
begin
  Result:=FTextStyleFontName;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextStyleBigFontName: WideString;
begin
  Result:=FTextStyleBigFontName;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextHeight: double;
begin
  Result:=FTextHeight;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextWidthFactor: double;
begin
  Result:=FTextWidthFactor;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextObliqueAngle: double;
begin
  Result:=FTextObliqueAngle;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextMargins: TAlxdMargins;
begin
  Result:=FTextMargins;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextMarginLeft: double;
begin
  Result:=FTextMargins.Left;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextMarginTop: double;
begin
  Result:=FTextMargins.Top;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextMarginRight: double;
begin
  Result:=FTextMargins.Right;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextMarginBottom: double;
begin
  Result:=FTextMargins.Bottom;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextColor: integer;
begin
  Result:=FTextColor;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextLayer: WideString;
begin
  Result:=FTextLayer;
end;

function  TAlxdSpreadSheetStyleInt.Get_TextWeight: integer;
begin
  Result:=FTextWeight;
end;

function  TAlxdSpreadSheetStyleInt.Get_VerBorderColor: integer;
begin
  Result:=FVerBorderColor;
end;

function  TAlxdSpreadSheetStyleInt.Get_VerBorderLayer: WideString;
begin
  Result:=FVerBorderLayer;
end;

function  TAlxdSpreadSheetStyleInt.Get_VerBorderWeight: integer;
begin
  Result:=FVerBorderWeight;
end;

function  TAlxdSpreadSheetStyleInt.Get_HorBorderColor: integer;
begin
  Result:=FHorBorderColor;
end;

function  TAlxdSpreadSheetStyleInt.Get_HorBorderLayer: WideString;
begin
  Result:=FHorBorderLayer;
end;

function  TAlxdSpreadSheetStyleInt.Get_HorBorderWeight: integer;
begin
  Result:=FHorBorderWeight;
end;

function  TAlxdSpreadSheetStyleInt.Get_HeaderFileName: WideString;
begin
  Result:=FHeaderFileName;
end;

function  TAlxdSpreadSheetStyleInt.Get_HeaderBlockName: WideString;
begin
  Result:=FHeaderBlockName;
end;

function  TAlxdSpreadSheetStyleInt.Get_Lock: boolean;
begin
  Result:=FLock;
end;

function  TAlxdSpreadSheetStyleInt.Get_Note: WideString;
begin
  Result:=FNote;
end;

procedure TAlxdSpreadSheetStyleInt.Set_AlxdSpreadSheetStyleExchange(Value: TAlxdSpreadSheetStyleExchange);
begin
  ColCount:=Value.ColCount;
  RowCount:=Value.RowCount;
  DefaultSize:=Value.DefaultSize;
  Primary:=Value.Primary;
  Justify:=Value.Justify;

  HeaderFileName:=Value.HeaderFileName;
  HeaderBlockName:=Value.HeaderBlockName;

  DrawBorder:=Value.DrawBorder;
  FillCell:=Value.FillCell;
  TextFit:=Value.TextFit;
  TextType:=Value.TextType;

  FStyleName:=Value.StyleName;
  FStyleFileName:=FvarOptions.StylePath + '\' + Value.StyleName;
  TextStyleFontName:=Value.TextStyleFontName;
  TextStyleBigFontName:=Value.TextStyleBigFontName;
  TextStyleName:=Value.TextStyleName;
  TextHeight:=Value.TextHeight;
  TextWidthFactor:=Value.TextWidthFactor;
  TextObliqueAngle:=Value.TextObliqueAngle;
  TextMargins:=Value.TextMargins;

  TextColor:=Value.TextColor;
  TextLayer:=Value.TextLayer;
  TextWeight:=Value.TextWeight;

  VerBorderColor:=Value.VerBorderColor;
  VerBorderLayer:=Value.VerBorderLayer;
  VerBorderWeight:=Value.VerBorderWeight;

  HorBorderColor:=Value.HorBorderColor;
  HorBorderLayer:=Value.HorBorderLayer;
  HorBorderWeight:=Value.HorBorderWeight;
{
    property DrawBorder: TAlxdDrawBorder read FDrawBorder write Set_DrawBorder;

    property VerBorderColor: integer read FVerBorderColor write Set_VerBorderColor;
    property VerBorderLayer: WideString read FVerBorderLayer write Set_VerBorderLayer;
    property VerBorderWeight: integer read FVerBorderWeight write Set_VerBorderWeight;

    property HorBorderColor: integer read FHorBorderColor write Set_HorBorderColor;
    property HorBorderLayer: WideString read FHorBorderLayer write Set_HorBorderLayer;
    property HorBorderWeight: integer read FHorBorderWeight write Set_HorBorderWeight;

}
{
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
}
end;

procedure TAlxdSpreadSheetStyleInt.Set_ColCount(Value: integer);
begin
  {$IFDEF TICK}
  OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetStyleInt.Set_ColCount Value:%d', [Value])));
  {$ENDIF}
  if Value < 1 then
    //Column count must be positive and nonzero!
    AlxdIndexedMessageBox(0, 1, '', MB_ICONWARNING + MB_OK)
  else
  if ColCount <> Value then
  begin
    FColCount:=Value;

    //вот здесь возможно надо спросить пользователя
    //надо ли менять количество колонок?
    if (Owner is TAlxdSpreadSheetInt) then
      (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.ColCountInt:=Value;
    //else

    if Primary = prColumn then
      Items.Count:=FColCount;

    Include(FMotive, rmVerBorders);
    Include(FMotive, rmHorBorders);
    Include(FMotive, rmFills);
  end;
  {$IFDEF TICK}
  OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetStyleInt.Set_ColCount Value:%d', [FColCount])));
  OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetStyleInt.Set_ColCount Items.Count:%d', [Items.Count])));
  {$ENDIF}
end;

procedure TAlxdSpreadSheetStyleInt.Set_RowCount(Value: integer);
begin
  if Value < 1 then
    //Row count must be positive and nonzero!
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if RowCount <> Value then
  begin
    FRowCount:=Value;
    //вот здесь возможно надо спросить пользователя
    //надо ли менять количество рядов?
    if (Owner is TAlxdSpreadSheetInt) then
      (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt:=Value;
    //else

    if Primary = prRow then
      Items.Count:=FRowCount;

    Include(FMotive, rmVerBorders);
    Include(FMotive, rmHorBorders);
    Include(FMotive, rmFills);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_DefaultSize(Value: double);
begin
  if Value <= 0 then
    //Row size must be positive and nonzero!
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if FDefaultSize <> Value then
  begin
    FDefaultSize:=Value;
    Include(FMotive, rmAll);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_Primary(Value: TAlxdPrimary);
begin
  if Value <> FPrimary then
  begin
    FPrimary:=Value;

    if FPrimary = prColumn then
      Items.Count:=ColCount
    else
      Items.Count:=RowCount;

    Include(FMotive, rmAll);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_Justify(Value: TAlxdJustify);
begin
  if Value <> FJustify then
  begin
    FJustify:=Value;

    if (Owner is TAlxdSpreadSheetInt) then
      FfrmEditor.ActionUpdate([aumStyle]);

    //Include(FMotive, rmAll);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_Items(Value: TAlxdSpreadSheetStyleItemsInt);
begin
  FAlxdSpreadSheetStyleItems.Assign(Value);
end;

Procedure TAlxdSpreadSheetStyleInt.Set_DrawBorder(Value: TAlxdDrawBorder);
begin
  if Value <> FDrawBorder then
  begin
    FDrawBorder:=Value;
    
    if (Owner is TAlxdSpreadSheetInt) then
    //begin
      //(Owner as TAlxdSpreadSheetInt).AlxdUndo.Fix; 
      FfrmEditor.ActionUpdate([aumStyle]);
    //end;
    Include(FMotive, rmAllBorders);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_FillCell(Value: TAlxdFillCell);
begin
  if Value <> FFillCell then
  begin
    FFillCell:=Value;

    if (Owner is TAlxdSpreadSheetInt) then
      FfrmEditor.ActionUpdate([aumStyle]);

    Include(FMotive, rmAllFills);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_TextFit(Value: TAlxdTextFit);
begin
  if Value <> FTextFit then
  begin
    FTextFit:=Value;

    if (Owner is TAlxdSpreadSheetInt) then
      FfrmEditor.ActionUpdate([aumStyle]);

    Include(FMotive, rmAllCells);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_TextType(Value: TAlxdTextType);
begin
  if Value <> FTextType then
  begin
    FTextType:=Value;

    if (Owner is TAlxdSpreadSheetInt) then
      FfrmEditor.ActionUpdate([aumStyle]);

    Include(FMotive, rmAllCells);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextStyleName(Value: WideString);
var
  tmpStyleName, tmpFontName, tmpBigFontName: WideString;
  tmpStyleId: longint;
begin
  if Value <> FTextStyleName then
  begin
    tmpStyleName:=Value;
    tmpFontName:=FTextStyleFontName;
    tmpBigFontName:=FTextStyleBigFontName;
    tmpStyleId:=FTextStyleObjectId;
{    tmpFontName:='';
    tmpBigFontName:='';
    tmpStyleId:=0;}
    {$IFDEF DLL}
    if oarxValidTextStyleName(tmpStyleName, tmpFontName, tmpBigFontName, tmpStyleId) then
    begin
    {$ENDIF}
      FTextStyleName:=tmpStyleName;
      FTextStyleFontName:=tmpFontName;
      FTextStyleBigFontName:=tmpBigFontName;
      FTextStyleObjectId:=tmpStyleId;
    {$IFDEF DLL}
    end;
    {$ENDIF}
    Include(FMotive, rmAllCells);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextStyleFontName(Value: WideString);
begin
  FTextStyleFontName:=Value;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextStyleBigFontName(Value: WideString);
begin
  FTextStyleBigFontName:=Value;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextHeight(Value: double);
begin
  if Value <= 0 then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> FTextHeight then
  begin
    FTextHeight:=Value;
    Include(FMotive, rmAllCells);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextWidthFactor(Value: double);
begin
  if Value <= 0 then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> FTextWidthFactor then
  begin
    FTextWidthFactor:=Value;
    Include(FMotive, rmAllCells);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextObliqueAngle(Value: double);
begin
  if (Value < -86) or (Value > 85) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> FTextObliqueAngle then
  begin
    FTextObliqueAngle:=Value;
    Include(FMotive, rmAllCells);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextMargins(Value: TAlxdMargins);
begin
  TextMarginLeft:=Value.Left;
  TextMarginTop:=Value.Top;
  TextMarginRight:=Value.Right;
  TextMarginBottom:=Value.Bottom;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextMarginLeft(Value: double);
begin
  if (Value < -1) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if FTextMargins.Left <> Value then
  begin
    FTextMargins.Left:=Value;
    Include(FMotive, rmAllCells);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextMarginTop(Value: double);
begin
  if (Value < -1) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if FTextMargins.Top <> Value then
  begin
    FTextMargins.Top:=Value;
    Include(FMotive, rmAllCells);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextMarginRight(Value: double);
begin
  if (Value < -1) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if FTextMargins.Right <> Value then
  begin
    FTextMargins.Right:=Value;
    Include(FMotive, rmAllCells);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_TextMarginBottom(Value: double);
begin
  if (Value < -1) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if FTextMargins.Bottom <> Value then
  begin
    FTextMargins.Bottom:=Value;
    Include(FMotive, rmAllCells);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_TextColor(Value: integer);
begin
  if (Value < -1) or (Value > 256) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> FTextColor then
  begin
    FTextColor:=Value;
    Include(FMotive, rmAllCells);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_TextLayer(Value: WideString);
begin
  if (Value <> FTextLayer) then
  begin
    FTextLayer:=Value;
    {$IFDEF DLL}
    oarxValidLayerName(FTextLayer);
    {$ENDIF}
    Include(FMotive, rmAllCells);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_TextWeight(Value: integer);
begin
  if (Value < -3) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> FTextWeight then
  begin
    FTextWeight:=Value;
    Include(FMotive, rmAllCells);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_VerBorderColor(Value: integer);
begin
  if (Value < -1) or (Value > 256) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> FVerBorderColor then
  begin
    FVerBorderColor:=Value;
    Include(FMotive, rmAllBorders);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_VerBorderLayer(Value: WideString);
begin
  if (Value <> FVerBorderLayer) then
  begin
    FVerBorderLayer:=Value;
    {$IFDEF DLL}
    oarxValidLayerName(FVerBorderLayer);
    {$ENDIF}
    Include(FMotive, rmAllBorders);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_VerBorderWeight(Value: integer);
begin
  if (Value < -3) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> FVerBorderWeight then
  begin
    FVerBorderWeight:=Value;
    Include(FMotive, rmAllBorders);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_HorBorderColor(Value: integer);
begin
  if (Value < -1) or (Value > 256) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> FHorBorderColor then
  begin
    FHorBorderColor:=Value;
    Include(FMotive, rmAllBorders);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_HorBorderLayer(Value: WideString);
begin
  if (Value <> FHorBorderLayer) then
  begin
    FHorBorderLayer:=Value;
    {$IFDEF DLL}
    oarxValidLayerName(FHorBorderLayer);
    {$ENDIF}
    Include(FMotive, rmAllBorders);
  end;
end;

Procedure TAlxdSpreadSheetStyleInt.Set_HorBorderWeight(Value: integer);
begin
  if (Value < -3) then
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> FHorBorderWeight then
  begin
    FHorBorderWeight:=Value;
    Include(FMotive, rmAllBorders);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_HeaderFileName(Value: WideString);
begin
  if Value <> FHeaderFileName then
  begin
    FHeaderFileName:=Value;
    Include(FMotive, rmHeader);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_HeaderBlockName(Value: WideString);
begin
  if Value <> FHeaderBlockName then
  begin
    FHeaderBlockName:=Value;
    Include(FMotive, rmHeader);
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_Lock(Value: boolean);
begin
  if Value <> FLock then
  begin
    FLock:=Value;
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_Note(Value: WideString);
begin
  if Value <> FNote then
  begin
    FNote:=Value;
  end;
end;

procedure TAlxdSpreadSheetStyleInt.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  case Index of
  //2:  StyleName:=Value;
  3:  HeaderFileName:=Value;
  4:  HeaderBlockName:=Value;
  6:  TextLayer:=Value;
  7:  TextStyleName:=Value;
  8:  VerBorderLayer:=Value;
  9:  HorBorderLayer:=Value;
  38: DefaultSize:=Value;
  40: TextHeight:=Value;
  41: TextWidthFactor:=Value;
  42: TextObliqueAngle:=Value;
  56: TextMarginLeft:=Value;
  57: TextMarginBottom:=Value;
  58: TextMarginRight:=Value;
  59: TextMarginTop:=Value;
  60: TextColor:=Value;
  61: VerBorderColor:=Value;
  62: HorBorderColor:=Value;
  64: TextWeight:=Value;
  65: VerBorderWeight:=Value;
  66: HorBorderWeight:=Value;
  70: ColCount:=Value;
  71: RowCount:=Value;
  280:DrawBorder:=Value;
  281:FillCell:=Value;
  282:TextFit:=Value;
  283:TextType:=Value;
  287:Primary:=Value;
  288:Justify:=Value;
  289:Lock:=Value;
  end;
end;

function TAlxdSpreadSheetStyleInt.WriteToDictionary(var value: TAlxdSpreadSheetExchange): boolean;
var
  tmpValue: TAlxdSpreadSheetStyleExchange;
begin
  tmpValue:=AlxdSpreadSheetStyleExchange;
  {$IFDEF DLL}
  Result:=oarxWriteStyleList(@tmpValue, @value);
  if not Result then
    AlxdIndexedMessageBox(0, 1, '', MB_ICONWARNING + MB_OK);
  {$ELSE}
  Result:=True;
  {$ENDIF}
end;

function TAlxdSpreadSheetStyleInt.ReadFromDictionary(var value: TAlxdSpreadSheetExchange): boolean;
var
  tmpValue: TAlxdSpreadSheetStyleExchange;
  tmpStyleId: longint;
begin
  tmpValue:=AlxdSpreadSheetStyleExchange;
  tmpValue.TextStyleFontName:='';
  tmpValue.TextStyleBigFontName:='';
  {$IFDEF DLL}
  Result:=oarxReadStyleList(@tmpValue, @value);
  if not Result then
  begin
    AlxdIndexedMessageBox(0, 1, '', MB_ICONWARNING + MB_OK);
    exit;
  end;
//  else
//  begin
//    tmpValue.TextStyleFontName:='';
//    tmpValue.TextStyleBigFontName:='';
//    Result:=oarxValidTextStyleName(tmpValue.TextStyleName, tmpValue.TextStyleFontName, tmpValue.TextStyleBigFontName, tmpStyleId);
//  end;
  {$ENDIF}
  AlxdSpreadSheetStyleExchange:=tmpValue;
end;

function TAlxdSpreadSheetStyleInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc.AddChild(AlxdSpreadSheetStyleRoot);
    
    for i := 0 to High(AlxdSpreadSheetStylePropValues) do
    begin
      node:=root.AddChild(AlxdSpreadSheetStylePropValues[i]);
      node.NodeValue:=GetPropValue(Self, AlxdSpreadSheetStylePropValues[i]);
    end;

    //FAlxdSpreadSheetStyleItems.WriteToXML(root);
    Items.WriteToXML(root);

    Result:=True;
  except
    on E:Exception do
    begin
      //AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function TAlxdSpreadSheetStyleInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc.ChildNodes.FindNode(AlxdSpreadSheetStyleRoot);
    if root = nil then
    begin
      //raise EXMLDocError.Create('');
      Result:=False;
      exit;
    end;

    for i := 0 to High(AlxdSpreadSheetStylePropValues) do
    begin
      node:=root.ChildNodes.FindNode(AlxdSpreadSheetStylePropValues[i]);
      if node <> nil then
        //raise EXMLDocError.Create('');
        SetPropValue(Self, AlxdSpreadSheetStylePropValues[i], node.NodeValue);
    end;

    Result:=FAlxdSpreadSheetStyleItems.ReadFromXML(root);

    //Result:=True;
  except
    on E:Exception do
    begin
      //AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function TAlxdSpreadSheetStyleInt.SaveToXML(AFileName: WideString): boolean;
var
  doc: IXMLDocument;
begin
  doc:=TXMLDocument.Create(nil) as IXMLDocument;
  try
    doc.Active:=true;
    doc.Encoding := 'UTF-8';

    WriteToXML(doc.Node);

    doc.SaveToFile(AFileName);
    Result:=true;
  except
    on E:Exception do
    begin
      //AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function TAlxdSpreadSheetStyleInt.LoadFromXML(AFileName: WideString): boolean;
var
  doc: IXMLDocument;
begin
  doc:=TXMLDocument.Create(nil) as IXMLDocument;
  try
    FStyleFileName:=AFileName;
    FStyleName:=AFileName;
    Delete(FStyleName, 1, Length(FvarOptions.StylePath) + 1);

    doc.LoadFromFile(AFileName);

    ReadFromXML(doc.Node);

    Result:=true;
  except
    on E:Exception do
    begin
      //AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function TAlxdSpreadSheetStyleInt.LoadFromATS(AFileName: WideString): boolean;
const
  INIMAINSECTION = 'Main';
  INITEXTSECTION = 'Text';
  INITEXTMARGINSECTION = 'TextMargins';
  INIITEMSECTION = 'Item %d';
  INIVERSECTION  = 'Vertical borders';
  INIHORSECTION  = 'Horizontal borders';
  INIHEADSECTION = 'Header';

  INICOLOR = 'Color';
  INILAYER = 'Layer';
  INIWEIGHT = 'Weight';

var
  inifile: TIniFile;
  version: double;
  i: integer;
  oha, ova: integer;
//  oldDefaultVerticalAlignment: integer;
//  itemcount: integer;

begin
  inifile := TIniFile.Create(AFileName);
  try
    if not inifile.SectionExists(INIMAINSECTION) then exit;
    try
        //общие параметры
        FStyleFileName:=AFileName;
        FStyleName:=AFileName;
        Delete(FStyleName, 1, Length(FvarOptions.StylePath) + 1);

        Version:=inifile.ReadFloat(INIMAINSECTION, 'Version', 2.0);
        ColCount:=inifile.ReadInteger(INIMAINSECTION, 'ColCount', 1);
        RowCount:=inifile.ReadInteger(INIMAINSECTION, 'RowCount', 1);

        TextMarginLeft:=inifile.ReadFloat(INITEXTMARGINSECTION, 'Left', 0.0);
        TextMarginBottom:=inifile.ReadFloat(INITEXTMARGINSECTION, 'Bottom', 0.0);
        TextMarginRight:=inifile.ReadFloat(INITEXTMARGINSECTION, 'Right', 0.0);
        TextMarginTop:=inifile.ReadFloat(INITEXTMARGINSECTION, 'Top', 0.0);

        //параметры версии 2.0
        if Version = 2.0 then
        begin
          DefaultSize:=inifile.ReadFloat(INITEXTSECTION, 'DefaultSize', 8.0);
          //Primary:=TAlxdPrimary(not inifile.ReadBool(INIMAINSECTION, 'PrimaryColOrRow', True));
          Justify:=TAlxdJustify(inifile.ReadInteger(INIMAINSECTION, 'GridBlockAlignment', 0));

          DrawBorder:=TAlxdDrawBorder(inifile.ReadBool(INIMAINSECTION, 'DefaultDrawBorder', True));
          FillCell:=TAlxdFillCell(inifile.ReadBool(INIMAINSECTION, 'DefaultFillCell', True));
          TextFit:=TAlxdTextFit(inifile.ReadBool(INIMAINSECTION, 'DefaultTextFit', True));
          TextType:=TAlxdTextType(inifile.ReadBool(INIMAINSECTION, 'DefaultTextType', True));

          TextStyleName:=inifile.ReadString(INITEXTSECTION, 'DefaultTextStyle', 'Standard');
          FTextStyleFontName:=inifile.ReadString(INITEXTSECTION, 'DefaultTextStyleFont', '');
          FTextStyleBigFontName:='';
          TextHeight:=inifile.ReadFloat(INITEXTSECTION, 'DefaultTextHeight', 3.0);
          TextWidthFactor:=inifile.ReadFloat(INITEXTSECTION, 'DefaultTextWidthFactor', 1.0);
          TextObliqueAngle:=inifile.ReadFloat(INITEXTSECTION, 'DefaultTextObliqueAngle', 0.0);

          TextColor:=inifile.ReadInteger(INITEXTSECTION, 'TextColor', 0);
          TextLayer:=inifile.ReadString(INITEXTSECTION, 'TextLayer', '0');
          TextWeight:=inifile.ReadInteger(INITEXTSECTION, 'TextWeight', -2);

          VerBorderColor:=inifile.ReadInteger('Vertical', 'VerBorderColor', 0);
          VerBorderLayer:=inifile.ReadString('Vertical', 'VerBorderLayer', '0');
          VerBorderWeight:=inifile.ReadInteger('Vertical', 'VerBorderWeight', -2);

          HorBorderColor:=inifile.ReadInteger('Horizontal', 'HorBorderColor', 0);
          HorBorderLayer:=inifile.ReadString('Horizontal', 'HorBorderLayer', '0');
          HorBorderWeight:=inifile.ReadInteger('Horizontal', 'HorBorderWeight', -2);

          HeaderFileName:=inifile.ReadString(INIMAINSECTION, 'HeaderFullName', '');
          HeaderBlockName:=inifile.ReadString(INIMAINSECTION, 'HeaderBlockName', '');
          if HeaderBlockName = '*none*' then FHeaderBlockName:='';

          Lock:=inifile.ReadBool(INIMAINSECTION, 'LockPropByStyle', False);

          oha:=inifile.ReadInteger(INITEXTSECTION, 'DefaultHorizontalAlignment', 0);
          ova:=inifile.ReadInteger(INITEXTSECTION, 'DefaultVerticalAlignment', 0);

{          if FPrimary = prColumn then
            itemcount:=FColCount
          else
            itemcount:=FRowCount;
          SetLength(FItems, itemcount);}

{          for i:=0 to itemcount-1 do
          begin
            FItems[i].Size:=inifile.ReadFloat('Sizes', Format('Size[%d]',[i]), 0.0);
            FItems[i].HorizontalAlignment:=oldDefaultHorizontalAlignment;
            FItems[i].VerticalAlignment:=oldDefaultVerticalAlignment;
          end;}

          with Items do
          for i:=0 to Count - 1 do
          begin
            Items[i].Size:=inifile.ReadFloat('Sizes', Format('Size[%d]',[i]), 0.0);
            Items[i].HorizontalAlignment:=TAlxdItemTextHorAlignment(oha);
            Items[i].VerticalAlignment:=TAlxdItemTextVerAlignment(ova);
          end;
        end;

        //параметры версии 4.0
        if Version = 4.0 then
        begin
          DefaultSize:=inifile.ReadFloat(INIMAINSECTION, 'DefaultSize', 8.0);
          Primary:=TAlxdPrimary(not inifile.ReadBool(INIMAINSECTION, 'Primary', True));
          Justify:=TAlxdJustify(inifile.ReadInteger(INIMAINSECTION, 'Justify', 0));

          DrawBorder:=TAlxdDrawBorder(inifile.ReadBool(INIMAINSECTION, 'DrawBorder', True));
          FillCell:=TAlxdFillCell(inifile.ReadBool(INIMAINSECTION, 'FillCell', True));
          TextFit:=TAlxdTextFit(inifile.ReadBool(INIMAINSECTION, 'TextFit', True));
          TextType:=TAlxdTextType(inifile.ReadBool(INIMAINSECTION, 'TextType', True));

          FTextStyleFontName:=inifile.ReadString(INITEXTSECTION, 'StyleFont', '');
          FTextStyleBigFontName:=inifile.ReadString(INITEXTSECTION, 'StyleBigFontName', '');
          TextStyleName:=inifile.ReadString(INITEXTSECTION, 'Style', 'Standard');
          TextHeight:=inifile.ReadFloat(INITEXTSECTION, 'Height', 3.0);
          TextWidthFactor:=inifile.ReadFloat(INITEXTSECTION, 'WidthFactor', 1.0);
          TextObliqueAngle:=inifile.ReadFloat(INITEXTSECTION, 'ObliqueAngle', 0.0);

//          FStyleName:=inifile.ReadString(INIMAINSECTION, 'GridStyleName', '');
          TextColor:=inifile.ReadInteger(INITEXTSECTION, INICOLOR, 0);
          TextLayer:=inifile.ReadString(INITEXTSECTION, INILAYER, '0');
          TextWeight:=inifile.ReadInteger(INITEXTSECTION, INIWEIGHT, -2);

          VerBorderColor:=inifile.ReadInteger(INIVERSECTION, INICOLOR, 0);
          VerBorderLayer:=inifile.ReadString(INIVERSECTION, INILAYER, '0');
          VerBorderWeight:=inifile.ReadInteger(INIVERSECTION, INIWEIGHT, -2);

          HorBorderColor:=inifile.ReadInteger(INIHORSECTION, INICOLOR, 0);
          HorBorderLayer:=inifile.ReadString(INIHORSECTION, INILAYER, '0');
          HorBorderWeight:=inifile.ReadInteger(INIHORSECTION, INIWEIGHT, -2);

          HeaderFileName:=inifile.ReadString(INIHEADSECTION, 'FileName', '');
          HeaderBlockName:=inifile.ReadString(INIHEADSECTION, 'BlockName', '');

          Lock:=inifile.ReadBool(INIMAINSECTION, 'Lock', False);

          {if FPrimary then
            itemcount:=FColCount
          else
            itemcount:=FRowCount;

          FAlxdSpreadSheetStyleItems.Count:=itemcount;}

          with Items do
          for i:=0 to Count - 1 do
          begin
            Items[i].Title:=IniFile.ReadString(Format(INIITEMSECTION,[i]), 'Title', '');
            Items[i].Size:=inifile.ReadFloat(Format(INIITEMSECTION,[i]), 'Size', 0.0);
            Items[i].HorizontalAlignment:=TAlxdItemTextHorAlignment(inifile.ReadInteger(Format(INIITEMSECTION,[i]), 'HorizontalAlignment', 0));
            Items[i].VerticalAlignment:=TAlxdItemTextVerAlignment(inifile.ReadInteger(Format(INIITEMSECTION,[i]), 'VerticalAlignment', 0));
          end;
        end;//if Version

//        AlxdMessageBox(0, 'Load', nil, 0);
        //MessageBox(0, PChar('LoadGridProperty'), nil, 0);
//        tempStr:=Copy(sFullFileName, Length(sPath) + 2, Length(sFullFileName) - Length(sPath) - 1);
//        ws:=Copy(FullFileName, Length(Path) + 2, Length(FullFileName) - Length(Path) - 1);
        //FStyleName:=Copy(sFullFileName, Length(sPath) + 2, Length(sFullFileName) - Length(sPath) - 1);
//        MessageBox(0, PChar(WideStringToMultiByteCIF(FullFileName)), nil, 0);
//        MessageBox(0, PChar(FStyleName), nil, 0);
//        MessageBoxW(0, PWideChar(StringToWideStringEx(FStyleName, CP_ACP)), nil, 0);
        //FStyleName:=WideStringToMultiByteCIF(WideString(tempStr));
//        {$IFDEF DLL}
//        FStyleName:=WideStringToMultiByteCIF(ws);
//        {$ENDIF}
        //FStyleName:=WideStringToStringEx(ws, CP_ACP);
        //FStyleName:=ws;
//        FStyleName:=WideStringToMultiByteCIF(StringToWideStringEx(Copy(sFullFileName, Length(sPath) + 2, Length(sFullFileName) - Length(sPath) - 1), CP_ACP));
        //FStyleName:=Copy(sFullFileName, Length(sPath) + 2, Length(sFullFileName) - Length(sPath) - 1);
        //AlxdMessageBox(0, PChar(FStyleName), nil, 0);

      Result:=true;

    except
      Result:=false;
//      result:=0;
    end;
  finally
    inifile.Free;
  end;
end;

function  TAlxdSpreadSheetStyleInt.LoadFrom(AFileName: WideString): boolean;
var
  ext: WideString;
begin
  ext:=WideExtractFileExt(AFileName);

  if ext = '.ats' then
    Result:=LoadFromATS(AFileName);

  if ext = '.xml' then
    Result:=LoadFromXML(AFileName);
end;

procedure TAlxdSpreadSheetStyleInt.Assign(Source: TPersistent);
var
  i: integer;
  //tmpStyleName, tmpFontName, tmpBigFontName: WideString;
  //tmpStyleId: longint;
begin
  {if Source is IAlxdSpreadSheetStyle then
  begin
    //
  end;}

  if Source is TAlxdSpreadSheetStyleInt then
  begin
    //make Text Style in drawing, if need
    //опирается на тот факт, что при присвоении стиля таблицы
    //в исходном стиле должен быть описан стиль текст (имя и шрифты)
    {$IFDEF DLL}
{    tmpFontName:=FTextStyleFontName;
    tmpBigFontName:=FTextStyleBigFontName;
    tmpStyleId:=FTextStyleObjectId;}

    {
    tmpStyleName:=(Source as TAlxdSpreadSheetStyleInt).TextStyleName;
    tmpFontName:=(Source as TAlxdSpreadSheetStyleInt).TextStyleFontName;
    tmpBigFontName:=(Source as TAlxdSpreadSheetStyleInt).TextStyleBigFontName;
    tmpStyleId:=0;//(Source as TAlxdSpreadSheetStyleInt).te;
    oarxValidTextStyleName(tmpStyleName, tmpFontName, tmpBigFontName, tmpStyleId);
    }
    //begin
      {FTextStyleName:=tmpStyleName;
      FTextStyleFontName:=tmpFontName;
      FTextStyleBigFontName:=tmpBigFontName;
      FTextStyleObjectId:=tmpStyleId;}
    //end;
    {$ENDIF}

    for i := 0 to High(AlxdSpreadSheetStylePropValues) do
    begin
      SetPropValue(Self, AlxdSpreadSheetStylePropValues[i], GetPropValue(Source, AlxdSpreadSheetStylePropValues[i]));
    end;

    //read-only properties
    FStyleName:=(Source as TAlxdSpreadSheetStyleInt).StyleName;
    FStyleFileName:=(Source as TAlxdSpreadSheetStyleInt).StyleFileName;

    Items.Assign((Source as TAlxdSpreadSheetStyleInt).Items);

    if (Owner is TAlxdSpreadSheetInt) then
    begin
      //FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections, aumStyle]);
//      FfrmEditor.tsAlxdSpreadSheets.
    end;
  end;
end;

constructor TAlxdSpreadSheetStyleInt.Create(AOwner: TComponent);
begin
  inherited;
  FAlxdSpreadSheetStyle:=TAlxdSpreadSheetStyle.Create(Self);

  FAlxdSpreadSheetStyleItems:=TAlxdSpreadSheetStyleItemsInt.Create(Self);

  ColCount:=1;
  RowCount:=1;
  DefaultSize:=10;
  Primary:=prColumn;
  Justify:=jsTopLeft;

  DrawBorder:=dbDraw;
  FillCell:=fcFill;
  TextFit:=tfsBreak;
  TextType:=ttsDText;

  TextStyleName:='Standard';
  TextHeight:=3;
  TextWidthFactor:=0.8;
  TextObliqueAngle:=0;

  TextColor:=0;
  TextLayer:='0';
  TextWeight:=-3;

  VerBorderColor:=0;
  VerBorderLayer:='0';
  VerBorderWeight:=-3;

  HorBorderColor:=0;
  HorBorderLayer:='0';
  HorBorderWeight:=-3;
end;

destructor TAlxdSpreadSheetStyleInt.Destroy;
begin
  FAlxdSpreadSheetStyleItems.Free;
  inherited;
end;

end.
