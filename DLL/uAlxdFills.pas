unit uAlxdFills;

interface

uses
  Windows, Classes, SysUtils, XMLDoc, XMLIntf,
  uAlxdSystem, uAlxdFill, uoarxImport, xAlxdFills, AlxdGrid_TLB;

const
  AlxdFillsRoot = 'AlxdFills';

type
  //TFunctionCall = function (Item: TAlxdFillInt; var Value: Pointer): boolean;
  TFunctionCall = function (Item: TAlxdFillInt): Pointer;

  TAlxdFillsInt = class(TComponent, IAlxdFills)
  private
    FAlxdFills: IAlxdFills;
//    function  CycleGet(F: TFunctionCall): Pointer;

    function  Get_FillType: TAlxdFillType;
    procedure Set_FillType(Value: TAlxdFillType);
    function  Get_Items(ACol, ARow: integer): TAlxdFillInt;

    procedure Set_Items(ACol, ARow: integer; Value: TAlxdFillInt);
  public
    //methods
    property Intf: IAlxdFills read FAlxdFills implements IAlxdFills;

    property FillType: TAlxdFillType read Get_FillType write Set_FillType;

    function WriteToDictionary(dictid: longint): boolean;
    function ReadFromDictionary(dictid: longint): boolean;

    function WriteToXML(ADoc: IXMLNode): boolean; overload;
    function ReadFromXML(ADoc: IXMLNode; ReadAttr: boolean = false): boolean; overload;
    function WriteToXML(ADoc: IXMLNode; Rt: TRect): boolean; overload;
    function ReadFromXML(ADoc: IXMLNode; Rt: TRect): boolean; overload;

    property Items[ACol, ARow: integer]: TAlxdFillInt read Get_Items write Set_Items;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  uAlxdSpreadSheet, uAlxdSpreadSheetArray;

{function  TAlxdFillsInt.CycleGet(F: TFunctionCall): Pointer;
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
//  first: boolean;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  Result:=nil;
//  first:=true;
  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
        begin}
{          if first then
          begin
            Result:=Self.Items[i, j];
          end
          else}
          //if not F(Self.Items[i, j]) then
          //begin
          //  exit;
          //end;
{          Result:=F(Self.Items[i, j]);
        end;
end;
}
function  TAlxdFillsInt.Get_FillType: TAlxdFillType;

  //function dummy(Item: TAlxdFillInt; var Value: Pointer): boolean;
{  function dummy(Item: TAlxdFillInt): Pointer;
  var
    p: Pointer;
  begin}
//    if not Assigned(Value) then
{    if Value = nil then
    begin
      p:=Item.FillType;
       //copy(value, 0, SizeOf(Item.FillType));
       Value:=p;
       Result:=true;
       exit;
    end;
}
{    Result:=(Item.FillType = TAlxdFillType(Value^));
    if not Result then
      TAlxdFillType(Value^):=ftMixed
    else
      TAlxdFillType(Value^):=Item.FillType;}
{    Result:=Pointer(Item.FillType);
  end;

begin
  Result:=TAlxdFillType(CycleGet(@dummy)^);}
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
  first: boolean;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  first:=true;
  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
        begin
          if first then
          begin
            Result:=Self.Items[i, j].FillType;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].FillType then
          begin
            Result:=ftMixed;
            break;
          end;
        end;
end;

procedure TAlxdFillsInt.Set_FillType(Value: TAlxdFillType);
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].FillType:=Value;

  ass.AlxdUndo.Fix;          
end;

{
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
end;
}
////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdFillsInt.Get_Items(ACol, ARow: integer): TAlxdFillInt;
begin
  Result:=(Owner as TAlxdSpreadSheetArray).DirectFills[ACol, ARow];
end;

procedure TAlxdFillsInt.Set_Items(ACol, ARow: integer; Value: TAlxdFillInt);
begin
  (Owner as TAlxdSpreadSheetArray).DirectFills[ACol, ARow].Assign(Value);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

function TAlxdFillsInt.WriteToDictionary(dictid: longint): boolean;

  function dummy(Obj: longint; ACol, ARow: integer): PAlxdCellExchange; cdecl;
  begin
    {$IFDEF DEBUG}
    OutputDebugString(#10'TAlxdFillsInt dummy write');
    {$ENDIF}
    Result:=@TAlxdFillsInt(Obj).Items[ACol, ARow].AlxdFillExchange;
  end;

var
  c, r: integer;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    c:=ColCountInt;
    r:=RowCountInt;
  end;

  {$IFDEF DLL}
  oarxWriteFillsList(longint(Self), @dummy, dictid, c, r);
  {$ENDIF}

  Result:=True;
end;

function TAlxdFillsInt.ReadFromDictionary(dictid: longint): boolean;

  function dummy(Obj: longint; ACol, ARow: integer): PAlxdCellExchange; cdecl;
  begin
    {$IFDEF DEBUG}
    OutputDebugString(#10'TAlxdCellsInt dummy read');
    {$ENDIF}
    Result:=@TAlxdFillsInt(Obj).Items[ACol, ARow].AlxdFillExchange;
  end;

var
  c, r: integer;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    c:=ColCountInt;
    r:=RowCountInt;
  end;

  {$IFDEF DLL}
  oarxReadFillsList(longint(Self), @dummy, dictid, c, r);
  {$ENDIF}

  Result:=True;
end;

function TAlxdFillsInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  c, r: integer;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    c:=ColCountInt;
    r:=RowCountInt;
    //c:=ColCountInt * RowCountInt;
    Result:=WriteToXML(ADoc, Rect(0, 0, c, r));
  end;
end;

function TAlxdFillsInt.ReadFromXML(ADoc: IXMLNode; ReadAttr: boolean): boolean;
var
  //root: IXMLNode;
  node: IXMLNode;
  i, j: integer;
  c, r: integer;
  root: IXMLNode;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    c:=ColCountInt;
    r:=RowCountInt;
  end;

  if ReadAttr then
  try
    root:=ADoc.ChildNodes.FindNode(AlxdFillsRoot);
    if root = nil then
    begin
      Result:=false;
      exit;
    end;

    node:=root.ChildNodes.First;
    while node <> nil do
    begin
      i:=node.GetAttributeNS('Column', '');
      j:=node.GetAttributeNS('Row', '');

      if (i >= 0) and (i <= c-1) and (j >= 0) and (j <= r-1) then
        Items[i, j].ReadFromXML(node);
      node:=node.NextSibling;
    end;

    Result:=True;
  except
    on E:Exception do
    begin
      AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end
  else
    Result:=ReadFromXML(ADoc, Rect(0, 0, c, r));
end;

function TAlxdFillsInt.WriteToXML(ADoc: IXMLNode; Rt: TRect): boolean;
var
  root: IXMLNode;
//  node: IXMLNode;
  i, j: integer;
  //c, r: integer;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    if Rt.Left < 0 then Rt.Left:=0;
    if Rt.Top < 0 then Rt.Top:=0;
    if Rt.Right >= ColCountInt then Rt.Right:=ColCountInt - 1;
    if Rt.Bottom >= RowCountInt then Rt.Bottom:=RowCountInt - 1;
  end;

  try
    root:=ADoc.AddChild(AlxdFillsRoot);

    //for i := 0 to c - 1 do
    //  Items[i, j].WriteToXML(root);
    for i := Rt.Left to Rt.Right do
      for j := Rt.Top to Rt.Bottom do
      begin
        Items[i, j].WriteToXML(root);
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

function TAlxdFillsInt.ReadFromXML(ADoc: IXMLNode; Rt: TRect): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i, j: integer;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    if Rt.Left < 0 then Rt.Left:=0;
    if Rt.Top < 0 then Rt.Top:=0;
    if Rt.Right >= ColCountInt then Rt.Right:=ColCountInt - 1;
    if Rt.Bottom >= RowCountInt then Rt.Bottom:=RowCountInt - 1;
  end;

  try
    root:=ADoc.ChildNodes.FindNode(AlxdFillsRoot);
    if root = nil then
    begin
      //raise EXMLDocError.Create('');
      Result:=false;
      exit;
    end;

    node:=root.ChildNodes.First;

    for i := Rt.Left to Rt.Right do
    begin
      for j := Rt.Top to Rt.Bottom do
      begin
        Items[i, j].ReadFromXML(node);
        node:=node.NextSibling;
        if node = nil then
          break;
      end;

      if node = nil then
        break;
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

constructor TAlxdFillsInt.Create(AOwner: TComponent);
begin
  FAlxdFills:=TAlxdFills.Create(Self);

  inherited;
end;

destructor TAlxdFillsInt.Destroy;
begin
  inherited;
end;

end.
