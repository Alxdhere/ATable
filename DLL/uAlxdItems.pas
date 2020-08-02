unit uAlxdItems;

interface

uses
  Windows, SysUtils,
  Classes, XMLDoc, XMLIntf,
  uAlxdSystem, uoarxImport, uAlxdItem, xAlxdItems, AlxdGrid_TLB;

const
  AlxdColumnsRoot = 'AlxdColumns';
  AlxdRowsRoot = 'AlxdRows';

type
  TFunctionCall = function (Item: TAlxdItemInt; P: Pointer): boolean;
  
  TAlxdItemsInt = class(TComponent, IAlxdItems)
  private
    FAlxdItems: IAlxdItems;

    FAlxdItemType: TAlxdItemType;

    //service private
    procedure CycleSet(F: TFunctionCall; const P: Pointer);

    //get
    function  Get_Items(Index: integer): TAlxdItemInt;
    function  Get_Count: integer;

    function  Get_Title: WideString;
    function  Get_Size: double;
    function  Get_Visible: boolean;

    //set
    procedure Set_Items(Index: integer; Value: TAlxdItemInt);
    procedure Set_Title(Value: WideString);
    procedure Set_Size(Value: double);
    procedure Set_Visible(Value: boolean);

  public
    //Interface to class
    property Intf: IAlxdItems read FAlxdItems implements IAlxdItems;

    //Items here
    property Items[Index: integer]: TAlxdItemInt read Get_Items write Set_Items;
    property Count: integer read Get_Count;
    //property LineCount: integer read Get_LineCount write Set_LineCount;

    //methods
    function  RealDeltaSize(Index, Delta: integer): Double;
    function  PaintDeltaSize(Index, Delta: integer): integer;
    function  Index(Coord: double): integer;

    procedure ResetSize;
    procedure MaxSize;

    function  WriteToDictionary(dictid: longint): boolean;
    function  ReadFromDictionary(dictid: longint): boolean;

    function  WriteToXML(ADoc: IXMLNode): boolean;
    function  ReadFromXML(ADoc: IXMLNode): boolean;

    //inherited
    constructor CreateEx(AOwner: TComponent; AType: TAlxdItemType); overload;
    destructor  Destroy; override;
  published
    property  Title: WideString read Get_Title write Set_Title;
    property  Size: double read Get_Size write Set_Size;
    property  Visible: boolean read Get_Visible write Set_Visible;
  end;

implementation

uses
  uAlxdSpreadSheetArray, uAlxdSpreadSheet;

procedure TAlxdItemsInt.CycleSet(F: TFunctionCall; const P: Pointer);
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      if FAlxdItemType = itCol then
      begin
        if Items[k].SelectionType = stColumn then
          for i := Items[k].Left to Items[k].Right do
            F(Self.Items[i], P);
      end
      else
      begin
        if Items[k].SelectionType = stRow then
          for j := Items[k].Top to Items[k].Bottom do
            F(Self.Items[j], P);
      end;

  ass.AlxdUndo.Fix;      
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Private Get
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdItemsInt.Get_Items(Index: integer): TAlxdItemInt;
begin
  {$IFDEF DEBUG}
//  OutputDebugString(PChar(Format('TAlxdItemsInt.Get_Items + Index : %d', [Index])));
  {$ENDIF}
  if FAlxdItemType = itCol then
    //Result:=(Owner as TAlxdSpreadSheetArray).Columns.Items[Index]//DirectCols[Index]
    Result:=(Owner as TAlxdSpreadSheetArray).DirectCols[Index]
  else
    Result:=(Owner as TAlxdSpreadSheetArray).DirectRows[Index];
  {$IFDEF DEBUG}
//    OutputDebugString(PChar(Format(#10'TAlxdItemsInt.Get_Items + Index: %d, %p', [Index, Pointer(Result)])));
  {$ENDIF}
end;

function  TAlxdItemsInt.Get_Count: integer;
begin
  if FAlxdItemType = itCol then
    Result:=(Owner as TAlxdSpreadSheetArray).ColCountInt
  else
    Result:=(Owner as TAlxdSpreadSheetArray).RowCountInt;
end;

function  TAlxdItemsInt.Get_Title: WideString;
var
  ass: TAlxdSpreadSheetInt;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
  if FAlxdItemType = itCol then
    Result:=Self.Items[ass.AlxdSpreadSheetSelections.Items[0].Left].Title
  else
    Result:=Self.Items[ass.AlxdSpreadSheetSelections.Items[0].Top].Title;
end;

function  TAlxdItemsInt.Get_Size: double;
var
  ass: TAlxdSpreadSheetInt;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
  if FAlxdItemType = itCol then
    Result:=Self.Items[ass.AlxdSpreadSheetSelections.Items[0].Left].RealSize
  else
    Result:=Self.Items[ass.AlxdSpreadSheetSelections.Items[0].Top].RealSize;
end;

function  TAlxdItemsInt.Get_Visible: boolean;
var
  ass: TAlxdSpreadSheetInt;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
  if FAlxdItemType = itCol then
    Result:=Self.Items[ass.AlxdSpreadSheetSelections.Items[0].Left].Visible
  else
    Result:=Self.Items[ass.AlxdSpreadSheetSelections.Items[0].Top].Visible;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Private Set
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdItemsInt.Set_Items(Index: integer; Value: TAlxdItemInt);
begin
  {$IFDEF DEBUG}
//  OutputDebugString(PChar(Format('TAlxdItemsInt.Set_Items + Index : %d', [Index])));
  {$ENDIF}
  if FAlxdItemType = itCol then
    (Owner as TAlxdSpreadSheetArray).DirectCols[Index].Assign(Value)
  else
    (Owner as TAlxdSpreadSheetArray).DirectRows[Index].Assign(Value);
end;

procedure TAlxdItemsInt.Set_Title(Value: WideString);
  function Dummy(Item: TAlxdItemInt; P: Pointer): boolean;
  begin
    Item.Title:=WideString(PWideChar(P^));
    Result:=True;
  end;
begin
  CycleSet(@Dummy, @Value);
end;

procedure TAlxdItemsInt.Set_Size(Value: double);
  function Dummy(Item: TAlxdItemInt; P: Pointer): boolean;
  begin
    Item.Size:=Double(P^);
    Result:=True;
  end;
begin
  CycleSet(@Dummy, @Value);
end;

procedure TAlxdItemsInt.Set_Visible(Value: boolean);
  function Dummy(Item: TAlxdItemInt; P: Pointer): boolean;
  begin
    Item.Visible:=Boolean(P^);
    Result:=True;
  end;
begin
  CycleSet(@Dummy, @Value);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdItemsInt.RealDeltaSize(Index, Delta: integer): Double;
var
  i: integer;
  sum: Double;
begin
  sum:=0;
  for i := Index to Index + Delta - 1 do
//    if FAlxdItemType = itCol then
//      sum:=sum + Items[i].RealSize * Items[i].LineCount
//    else
    if Items[i].Size = 0 then
      sum:=sum + Items[i].RealSize * Items[i].LineCount
    else
      sum:=sum + Items[i].RealSize;
  Result:=sum;
end;

function  TAlxdItemsInt.PaintDeltaSize(Index, Delta: integer): integer;
var
  i: integer;
  sum: integer;
begin
  sum:=0;
  for i := Index to Index + Delta - 1 do
//    if FAlxdItemType = itCol then
//      sum:=sum + Items[i].PaintSize
//    else
      sum:=sum + Items[i].PaintSize;
  Result:=sum;
end;

//определение номера (индекса) Item'а по координате
function  TAlxdItemsInt.Index(Coord: double): integer;
var
  i: integer;
  sum: double;
begin
  Result:=-1;
  sum:=0;
  for i := 0 to Count - 1 do
  begin
    if FAlxdItemType = itCol then
    begin
      sum:=sum + Items[i].RealSize * Items[i].LineCount;
      if Coord <= sum then
      begin
        Result:=i;
        break;
      end;
    end
    else
    begin
      sum:=sum - Items[i].RealSize * Items[i].LineCount;
      if Coord >= sum then
      begin
        Result:=i;
        break;
      end;
    end;
  end;
end;

procedure TAlxdItemsInt.ResetSize;
  function Dummy(Item: TAlxdItemInt; P: Pointer): boolean;
  begin
    Item.ResetSize;
    Result:=True;
  end;
begin
  CycleSet(@Dummy, nil);
end;

procedure TAlxdItemsInt.MaxSize;
  function Dummy(Item: TAlxdItemInt; P: Pointer): boolean;
  begin
    Item.MaxSize;
    Result:=True;
  end;
begin
  CycleSet(@Dummy, nil);
end;

function  TAlxdItemsInt.WriteToDictionary(dictid: longint): boolean;

  function dummy(Obj: longint; Index: integer): PAlxdItemExchange; cdecl;
  begin
    {$IFDEF DEBUG}
    OutputDebugString(#10'TAlxdItemsInt dummy write');
    {$ENDIF}
    Result:=@TAlxdItemsInt(Obj).Items[Index].AlxdItemExchange;
  end;

{$IFDEF DLL}
var
  c, r: integer;
{$ENDIF}
begin
  {$IFDEF DLL}
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    c:=Columns.Count;
    r:=Rows.Count;
  end;

  if FAlxdItemType = itCol then
    Result:=oarxWriteItemsList(longint(Self), @dummy, dictid, c, FAlxdItemType)
  else
    Result:=oarxWriteItemsList(longint(Self), @dummy, dictid, r, FAlxdItemType);
  {$ENDIF}

  {$IFNDEF DLL}
  Result:=True;
  {$ENDIF}
end;

function  TAlxdItemsInt.ReadFromDictionary(dictid: longint): boolean;

  function dummy(Obj: longint; Index: integer): PAlxdItemExchange; cdecl;
  begin
    {$IFDEF DEBUG}
    OutputDebugString(#10'TAlxdItemsInt dummy read');
    {$ENDIF}
    Result:=@TAlxdItemsInt(Obj).Items[Index].AlxdItemExchange;
  end;

{$IFDEF DLL}
var
  c, r: integer;
{$ENDIF}
begin
  {$IFDEF DLL}
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    c:=ColCountInt;
    r:=RowCountInt;
  end;


  if FAlxdItemType = itCol then
    Result:=oarxReadItemsList(longint(Self), @dummy, dictid, c, FAlxdItemType)
  else
    Result:=oarxReadItemsList(longint(Self), @dummy, dictid, r, FAlxdItemType);

  {$ELSE}
  Result:=True;
  {$ENDIF}
end;

function  TAlxdItemsInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
//  node: IXMLNode;
  i: integer;
  c: integer;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    if FAlxdItemType = itCol then
      c:=ColCountInt
    else
      c:=RowCountInt;
  end;

  try
    if FAlxdItemType = itCol then
      root:=ADoc.AddChild(AlxdColumnsRoot)
    else
      root:=ADoc.AddChild(AlxdRowsRoot);

    for i := 0 to c-1 do
    begin
      Items[i].WriteToXML(root);
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

function  TAlxdItemsInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
  c: integer;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    if FAlxdItemType = itCol then
      c:=ColCountInt - 1
    else
      c:=RowCountInt - 1;
  end;

  try
    if FAlxdItemType = itCol then
      root:=ADoc.ChildNodes.FindNode(AlxdColumnsRoot)
    else
      root:=ADoc.ChildNodes.FindNode(AlxdRowsRoot);
    if root = nil then
    begin
      //raise EXMLDocError.Create('');
      Result:=False;
      exit;
    end;

    //i:=0;
    node:=root.ChildNodes.First;
    {for i := 0 to c-1 do
    begin
      Items[i].ReadFromXML(node);
      node:=node.NextSibling;
      if node = nil then
        break;
    end;}
    while node <> nil do
    begin
      if node.HasAttribute('Index') then
      begin
        i:=node.GetAttributeNS('Index', '');

        if (i >= 0) and (i <= c) then
          Items[i].ReadFromXML(node);
      end;
      node:=node.NextSibling;
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

constructor TAlxdItemsInt.CreateEx(AOwner: TComponent; AType: TAlxdItemType);
begin
  inherited Create(AOwner);
  FAlxdItems:=TAlxdItems.Create(Self);
  FAlxdItemType:=AType;
end;

destructor TAlxdItemsInt.Destroy;
begin
  inherited;
end;

end.
