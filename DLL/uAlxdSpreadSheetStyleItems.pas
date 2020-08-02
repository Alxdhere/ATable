unit uAlxdSpreadSheetStyleItems;

interface


uses
  Windows, Classes, Types, SysUtils, TypInfo, uoarxImport, XMLDoc, XMLIntf,
  uAlxdSystem, uAlxdSpreadSheetStyleItem{, AlxdGrid_TLB};

const
  AlxdSpreadSheetStyleItemsRoot = 'AlxdSpreadSheetStyleItems';

type
  TAlxdSpreadSheetStyleItemArray = array of TAlxdSpreadSheetStyleItemInt;

  TAlxdSpreadSheetStyleItemsInt = class(TComponent{, IAlxdItem})
  private
    FItems: TAlxdSpreadSheetStyleItemArray;

    function Get_Count: integer;
    function Get_Items(Index: integer): TAlxdSpreadSheetStyleItemInt;

    procedure Set_Count(Value: integer);
    procedure Set_Items(Index: integer; Value: TAlxdSpreadSheetStyleItemInt);
  public
    property Items[Index: integer]: TAlxdSpreadSheetStyleItemInt read Get_Items write Set_Items;

    function WriteToXML(ADoc: IXMLNode): boolean;
    function ReadFromXML(ADoc: IXMLNode): boolean;

    //inherited
    procedure Assign(Source: TPersistent); override;
    constructor CreateEx(AOwner: TComponent);
    destructor Destroy; override;
  published
    property Count: integer read Get_Count write Set_Count;
  end;

implementation

uses
  uAlxdSpreadSheetStyle, uAlxdItems;

function  TAlxdSpreadSheetStyleItemsInt.Get_Count: integer;
var
  c: integer;
begin
  c:=High(FItems);
  if c < 0 then
    c:=0
  else
    c:=c+1;
  Result:=c;
end;

function TAlxdSpreadSheetStyleItemsInt.Get_Items(Index: integer): TAlxdSpreadSheetStyleItemInt;
begin
  if (Index < 0) or (Index > Count - 1) then
  begin
    exit;
  end;

  Result:=FItems[Index];
end;

procedure TAlxdSpreadSheetStyleItemsInt.Set_Count(Value: integer);
var
  i: integer;
  oldcount: integer;
begin
  if Value < 0 then
    exit;

  if Value < Count then
  begin
    oldcount:=Count;
    for i := Value to oldcount - 1 do
    begin
      FItems[i].Free;
      FItems[i]:=nil;
    end;
    SetLength(FItems, Value);
  end;

  if Value > Count then
  begin
    oldcount:=Count;
    SetLength(FItems, Value);
    for i := oldcount to Value - 1 do
    begin
      FItems[i]:=TAlxdSpreadSheetStyleItemInt.CreateEx(Self, i);
    end;
  end;
end;

procedure TAlxdSpreadSheetStyleItemsInt.Set_Items(Index: integer; Value: TAlxdSpreadSheetStyleItemInt);
begin
  if (Index < 0) or (Index > Count - 1) then
  begin
    exit;
  end;

  FItems[Index].Assign(Value);
end;

function TAlxdSpreadSheetStyleItemsInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
//  node: IXMLNode;
  i: integer;
  c: integer;
begin
  try
    c:=Count;
    root:=ADoc.AddChild(AlxdSpreadSheetStyleItemsRoot);

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

function TAlxdSpreadSheetStyleItemsInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
  c: integer;
begin
  try
    c:=Count;
    root:=ADoc.ChildNodes.FindNode(AlxdSpreadSheetStyleItemsRoot);
    if root = nil then
    begin
      Result:=False;
      exit;
      //raise EXMLDocError.Create('');
    end;

    node:=root.ChildNodes.First;
    for i := 0 to c-1 do
    begin
      Items[i].ReadFromXML(node);
      node:=node.NextSibling;
      if node = nil then break;      
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

procedure TAlxdSpreadSheetStyleItemsInt.Assign(Source: TPersistent);
var
  i: integer;
//  c: integer;
begin
  if Source is TAlxdSpreadSheetStyleItemsInt then
    if Count = (Source as TAlxdSpreadSheetStyleItemsInt).Count then
      for i := 0 to Count - 1 do
      begin
        Items[i].Assign((Source as TAlxdSpreadSheetStyleItemsInt).Items[i]);
      end;

  if Source is TAlxdItemsInt then
    if Count = (Source as TAlxdItemsInt).Count then
      for i := 0 to Count - 1 do
      begin
        Items[i].Assign((Source as TAlxdItemsInt).Items[i]);
      end;

{  if Source is TAlxdSpreadSheetStyleItemsInt then
  begin
    if Count < (Source as TAlxdSpreadSheetStyleItemsInt).Count then
    begin

    end;
  end;}
{    for i := 0 to High(AlxdItemPropValues) do
    begin
      SetPropValue(Self, AlxdItemPropValues[i], GetPropValue(Source, AlxdItemPropValues[i]));
    end;}
end;

constructor TAlxdSpreadSheetStyleItemsInt.CreateEx(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //FAlxdItem:=TAlxdItem.Create(Self);
  
  Count:=0;
end;

destructor TAlxdSpreadSheetStyleItemsInt.Destroy;
begin
  Count:=0;
  inherited;
end;

end.
