unit uAlxdItem;

interface

uses
  Windows, Classes, Types, SysUtils, TypInfo, XMLDoc, XMLIntf,
  uoarxImport, uAlxdSystem, xAlxdItem, AlxdGrid_TLB;

const
  AlxdItemRoot = 'AlxdItem';
  AlxdItemPropValues: array[0..5] of string = ('Size', 'Title', 'HorizontalAlignment', 'VerticalAlignment', 'Visible', 'LineCount');

type
  TAlxdItemInt = class(TComponent, IAlxdItem)
  private
    FAlxdItem: IAlxdItem;

    FIndex: integer;
    FAlxdItemType: TAlxdItemType;

    FAlxdItemExchange: TAlxdItemExchange;
    FChanged: boolean;
    FCoord: double;
    FLineCount: integer;

    function  Get_Changed: boolean;
    function  Get_RealSize: double;
    function  Get_PaintSize: integer;
    function  Get_PaintTitle: WideString;
    function  Get_DrawingSize: double;
    function  Get_LineCount: integer;

    function  Get_PropertyByNum(Index: Integer): OleVariant;

    procedure Set_Size(Value: double);
    procedure Set_Title(Value: WideString);
    procedure Set_HorizontalAlignment(Value: TAlxdItemTextHorAlignment);
    procedure Set_VerticalAlignment(Value: TAlxdItemTextVerAlignment);
    procedure Set_Visible(Value: boolean);
    procedure Set_LineCount(Value: integer);

    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant);

  public
    //Interface to class
    property Intf: IAlxdItem read FAlxdItem implements IAlxdItem;
    property AlxdItemExchange: TAlxdItemExchange read FAlxdItemExchange;

    //state
    property  Changed: boolean read Get_Changed;

    //internal property
    property  Coord: double read FCoord write FCoord;
    property  RealSize: double read Get_RealSize;

    property  PaintSize: integer read Get_PaintSize;
    property  PaintTitle: WideString read Get_PaintTitle;

    property  DrawingSize: double read Get_DrawingSize;
    property  PropertyByNum[Index: integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;

    //methods
    function  IndexFirstSimpleCell: integer;

    procedure ResetSize;
    procedure MaxSize;

    function  WriteToXML(ADoc: IXMLNode): boolean;
    function  ReadFromXML(ADoc: IXMLNode): boolean;

    //inherited
    procedure Assign(Source: TPersistent); override;
    constructor CreateEx(AOwner: TComponent; AIndex: integer; AType: TAlxdItemType);
    destructor Destroy; override;
  published
    property  Size: double read FAlxdItemExchange.Size write Set_Size;
    property  Title: WideString read FAlxdItemExchange.Title write Set_Title;
    property  HorizontalAlignment: TAlxdItemTextHorAlignment read FAlxdItemExchange.HorizontalAlignment write Set_HorizontalAlignment;
    property  VerticalAlignment: TAlxdItemTextVerAlignment read FAlxdItemExchange.VerticalAlignment write Set_VerticalAlignment;
    property  Visible: boolean read FAlxdItemExchange.Visible write Set_Visible;
    property  LineCount: integer read Get_LineCount write Set_LineCount;
  end;

implementation

uses
  uAlxdOptions, uAlxdSpreadSheet, uAlxdSpreadSheetArray;

////////////////////////////////////////////////////////////////////////////////
//
//  Private Get
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdItemInt.Get_Changed: boolean;
begin
  {$IFDEF TICK}
  //OutputDebugString(PChar(Format(#10'TAlxdItemInt.Get_Changed :%d', [Integer(FChanged)])));
  {$ENDIF}
  Result:=FChanged;
  FChanged:=False;
end;

function  TAlxdItemInt.Get_RealSize: double;
begin
  if FAlxdItemExchange.Size = 0 then
    //Result:=(FindOwner(Self, 'TAlxdSpreadSheetInt') as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.DefaultSize
    Result:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.DefaultSize
  else
    Result:=FAlxdItemExchange.Size;
end;

function  TAlxdItemInt.Get_PaintSize: integer;
begin
  if FAlxdItemType = itCol then
    Result:=Trunc(RealSize * FvarOptions.PixelToMmX)
  else
    Result:=Trunc(RealSize * FvarOptions.PixelToMmY);
end;

function  TAlxdItemInt.Get_PaintTitle: WideString;
begin
  if FAlxdItemType = itCol then
    Result:=NumToString(FIndex + 1) + #10
  else
    Result:=IntToStr(FIndex + 1) + #10;

  if Size = 0 then
    Result:=Result + '[' + AlxdRToS(RealSize) + '*]'
  else
    Result:=Result + '[' + AlxdRToS(RealSize) + ']';

  if Title <> '' then
    Result:=Result + #10 + Title;
end;

//for recoordinate
function  TAlxdItemInt.Get_DrawingSize: double;
begin
  Result:=0;
  if Visible then
    if FAlxdItemExchange.Size = 0 then
      Result:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.DefaultSize * FLineCount
    else
      Result:=FAlxdItemExchange.Size;
    //Result:=RealSize;
end;

function  TAlxdItemInt.Get_LineCount: integer;
var
  i: integer;
  max: integer;
  tmp: integer;
begin
  {if FChanged then
  begin
    Result:=FLineCount;
    exit;
  end;}

  max:=1;

  with (Owner as TAlxdSpreadSheetArray) do
  if FAlxdItemType = itCol then
  begin
    for i := 0 to RowCountInt - 1 do
      if Cells.Items[FIndex, i].Rotation = 90 then
      begin
        tmp:=Cells.Items[FIndex, i].ActualLinesInCell;
        if max < tmp then
          max:=tmp;
      end;
  end
  else
  begin
    for i := 0 to ColCountInt - 1 do
      if Cells.Items[i, FIndex].Rotation = 0 then
      begin
        tmp:=Cells.Items[i, FIndex].ActualLinesInCell;
        if max < tmp then
          max:=tmp;
      end;
  end;

  if max <> FLineCount then
  begin
    FLineCount:=max;
    FChanged:=True;
  end;

  Result:=FLineCount;
end;

function  TAlxdItemInt.Get_PropertyByNum(Index: Integer): OleVariant;
begin
  case Index of
  1:  Result:=Title;
  40: Result:=Size;
  72: Result:=HorizontalAlignment;
  73: Result:=VerticalAlignment;
  280:Result:=Visible;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Private Set
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdItemInt.Set_Size(Value: double);
begin
  if (Value < 0) then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  if (Value <> FAlxdItemExchange.Size) then
    FAlxdItemExchange.Size:=Value;
end;

procedure TAlxdItemInt.Set_Title(Value: WideString);
begin
  FAlxdItemExchange.Title:=Value;
end;

procedure TAlxdItemInt.Set_HorizontalAlignment(Value: TAlxdItemTextHorAlignment);
begin
  FAlxdItemExchange.HorizontalAlignment:=Value;
end;

procedure TAlxdItemInt.Set_VerticalAlignment(Value: TAlxdItemTextVerAlignment);
begin
  FAlxdItemExchange.VerticalAlignment:=Value;
end;

procedure TAlxdItemInt.Set_Visible(Value: boolean);
begin
  if (Value <> FAlxdItemExchange.Visible) then
    FAlxdItemExchange.Visible:=Value;
end;

procedure TAlxdItemInt.Set_LineCount(Value: integer);
begin
  if (Value < 1) then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  if (Value <> FLineCount) then
    FLineCount:=Value;
end;

procedure TAlxdItemInt.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  case Index of
  1:  Title:=Value;
  40: Size:=Value;
  72: HorizontalAlignment:=Value;
  73: VerticalAlignment:=Value;
  280:Visible:=Value;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdItemInt.IndexFirstSimpleCell: integer;
var
  i: integer;
begin
  Result:=0;
  with (Owner as TAlxdSpreadSheetArray) do
  if FAlxdItemType = itCol then
  begin
    for i := 0 to RowCountInt - 1 do
      if Cells.Items[FIndex, i].IsSimpleCell then
      begin
        Result:=i;
        exit;
      end;
  end
  else
  begin
    for i := 0 to ColCountInt - 1 do
      if Cells.Items[i, FIndex].IsSimpleCell then
      begin
        Result:=i;
        exit;
      end;
  end;
end;

procedure TAlxdItemInt.ResetSize;
begin
  FAlxdItemExchange.Size:=0;
end;

procedure TAlxdItemInt.MaxSize;
begin
  FAlxdItemExchange.Size:=LineCount * ((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.DefaultSize;
end;

function  TAlxdItemInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc.AddChild(AlxdItemRoot);
    root.SetAttributeNS('Index', '', FIndex);

    //write properties
    for i := 0 to High(AlxdItemPropValues) do
    begin
      node:=root.AddChild(AlxdItemPropValues[i]);
      node.NodeValue:=GetPropValue(Self, AlxdItemPropValues[i]);
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

function  TAlxdItemInt.ReadFromXML(ADoc: IXMLNode): boolean;
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
      Result:=False;
      exit;
    end;
    //FCol:=root.GetAttributeNS('Column', '');
    //FRow:=root.GetAttributeNS('Row', '');

    for i := 0 to High(AlxdItemPropValues) do
    begin
      node:=root.ChildNodes.FindNode(AlxdItemPropValues[i]);
      if node <> nil then
        //raise EXMLDocError.Create('');
        SetPropValue(Self, AlxdItemPropValues[i], node.NodeValue);
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

procedure TAlxdItemInt.Assign(Source: TPersistent);
var
  i: integer;
begin
  if Source is TAlxdItemInt then
    for i := 0 to High(AlxdItemPropValues) do
    begin
      SetPropValue(Self, AlxdItemPropValues[i], GetPropValue(Source, AlxdItemPropValues[i]));
    end;
end;

constructor TAlxdItemInt.CreateEx(AOwner: TComponent; AIndex: integer; AType: TAlxdItemType);
begin
  inherited Create(AOwner);
  FAlxdItem:=TAlxdItem.Create(Self);

  FIndex:=AIndex;
  FAlxdItemType:=AType;

  FChanged:=false;
  FCoord:=0;
  FLineCount:=1;

  FAlxdItemExchange.Size:=0;
  //FAlxdItemExchange.Title:='';
  FAlxdItemExchange.Visible:=True;
end;

destructor TAlxdItemInt.Destroy;
begin
  inherited;
end;

end.
