unit uAlxdBorders;

interface

uses
  Windows, Classes, TypInfo, SysUtils, XMLDoc, XMLIntf, uAlxdBorder, uAlxdSystem,
  uoarxImport, xAlxdBorders, AlxdGrid_TLB, uAlxdLocalizer;

const
  AlxdVerBordersRoot = 'AlxdVerBorders';
  AlxdHorBordersRoot = 'AlxdHorBorders';
  AlxdBordersPropValues: array[0..2] of string = ({'State', }'Color', 'Layer', 'Weight');

type
  TFunctionSet = function (Item: TAlxdBorderInt; P: Pointer): boolean;

  TAlxdBordersInt = class(TComponent, IAlxdBorders)
  private
    FAlxdBorders: IAlxdBorders;
    FAlxdBorderType: TAlxdBorderType;

    procedure CycleSet(F: TFunctionSet; const P: Pointer);

    function  Get_Items(ACol, ARow: integer): TAlxdBorderInt;
    function  Get_State: TAlxdDrawBorders;
    function  Get_Color: integer;
    function  Get_Layer: WideString;
    function  Get_Weight: integer;

    procedure Set_Items(ACol, ARow: integer; Value: TAlxdBorderInt);
    procedure Set_State(Value: TAlxdDrawBorders);
    procedure Set_Color(Value: integer);
    procedure Set_Layer(Value: WideString);
    procedure Set_Weight(Value: integer);
  public
    //methods
    property Intf: IAlxdBorders read FAlxdBorders implements IAlxdBorders;

    function WriteToDictionary(dictid: longint): boolean;
    function ReadFromDictionary(dictid: longint): boolean;

    function WriteToXML(ADoc: IXMLNode): boolean; overload;
    function ReadFromXML(ADoc: IXMLNode; ReadAttr: boolean = false): boolean; overload;
    function WriteToXML(ADoc: IXMLNode; Rt: TRect): boolean; overload;
    function ReadFromXML(ADoc: IXMLNode; Rt: TRect): boolean; overload;

    property Items[ACol, ARow: integer]: TAlxdBorderInt read Get_Items write Set_Items;
    procedure Assign(Source: TPersistent); override;
    constructor CreateEx(AOwner: TComponent; AType: TAlxdBorderType);
    destructor Destroy; override;
  published
    property State:TAlxdDrawBorders read Get_State write Set_State;

    property Color: integer read Get_Color write Set_Color;
    property Layer: WideString read Get_Layer write Set_Layer;
    property Weight: integer read Get_Weight write Set_Weight;
  end;

implementation

uses
  uAlxdSpreadSheet, uAlxdSpreadSheetArray;

////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdBordersInt.CycleSet(F: TFunctionSet; const P: Pointer);
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right+1 do
        for j := Items[k].Top to Items[k].Bottom+1 do
          if FAlxdBorderType = btVer then
          begin
            if j <= Items[k].Bottom then
              F(Self.Items[i, j], P);
          end
          else
          begin
            if i <= Items[k].Right then
              F(Self.Items[i, j], P);
          end;
          //Self.Items[i, j].TextType:=Value;

  ass.AlxdUndo.Fix;
end;

function  TAlxdBordersInt.Get_Items(ACol, ARow: integer): TAlxdBorderInt;
begin
  if FAlxdBorderType = btVer then
    Result:=(Owner as TAlxdSpreadSheetArray).DirectVerBorders[ACol, ARow]
  else
    Result:=(Owner as TAlxdSpreadSheetArray).DirectHorBorders[ACol, ARow];
end;

function  TAlxdBordersInt.Get_State: TAlxdDrawBorders;
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
begin
  Result:=[];
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          if FAlxdBorderType = btVer then
          begin
            //check left border
            if i = Items[k].Left then
              if Self.Items[i, j].State = dbDraw then
                Include(Result, dbLeft);

            //check right border
            if i = Items[k].Right then
              if Self.Items[i+1, j].State = dbDraw then
                Include(Result, dbRight);

            //check vertical (inside selection) border
            if (i > Items[k].Left) and (i <= Items[k].Right) then
              if Self.Items[i, j].State = dbDraw then
                Include(Result, dbVer);
          end
          else
          begin
            //check top border
            if j = Items[k].Top then
              if Self.Items[i, j].State = dbDraw then
                Include(Result, dbTop);

            //check bottom border
            if j = Items[k].Bottom then
              if Self.Items[i, j+1].State = dbDraw then
                Include(Result, dbBottom);

            //check horizontal (inside selection) border
            if (j > Items[k].Top) and (j <= Items[k].Bottom) then
              if Self.Items[i, j].State = dbDraw then
                Include(Result, dbHor);
          end;
end;

function  TAlxdBordersInt.Get_Color: integer;
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
  first: boolean;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  first:=true;
  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right+1 do
        for j := Items[k].Top to Items[k].Bottom+1 do
          if FAlxdBorderType = btVer then
          begin
            if j <= Items[k].Bottom then
            begin
              if first then
              begin
                Result:=Self.Items[i, j].Color;
                first:=false;
                continue;
              end;

              if Result <> Self.Items[i, j].Color then
              begin
                Result:=-2;
                break;
              end;
            end;
          end
          else
          begin
            if i <= Items[k].Right then
            begin
              if first then
              begin
                Result:=Self.Items[i, j].Color;
                first:=false;
                continue;
              end;

              if Result <> Self.Items[i, j].Color then
              begin
                Result:=-2;
                break;
              end;
            end;
          end;
end;

function  TAlxdBordersInt.Get_Layer: WideString;
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
  first: boolean;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  first:=true;
  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right+1 do
        for j := Items[k].Top to Items[k].Bottom+1 do
          if FAlxdBorderType = btVer then
          begin
            if j <= Items[k].Bottom then
            begin
              if first then
              begin
                Result:=Self.Items[i, j].Layer;
                first:=false;
                continue;
              end;

              if Result <> Self.Items[i, j].Layer then
              begin
                Result:=MessageMemIniFile(2720);;
                break;
              end;
            end;
          end
          else
          begin
            if i <= Items[k].Right then
            begin
              if first then
              begin
                Result:=Self.Items[i, j].Layer;
                first:=false;
                continue;
              end;

              if Result <> Self.Items[i, j].Layer then
              begin
                Result:=MessageMemIniFile(2720);;
                break;
              end;
            end;
          end;
end;

function  TAlxdBordersInt.Get_Weight: integer;
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
  first: boolean;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  first:=true;
  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right+1 do
        for j := Items[k].Top to Items[k].Bottom+1 do
          if FAlxdBorderType = btVer then
          begin
            if j <= Items[k].Bottom then
            begin
              if first then
              begin
                Result:=Self.Items[i, j].Weight;
                first:=false;
                continue;
              end;

              if Result <> Self.Items[i, j].Weight then
              begin
                Result:=-5;
                break;
              end;
            end;
          end
          else
          begin
            if i <= Items[k].Right then
            begin
              if first then
              begin
                Result:=Self.Items[i, j].Weight;
                first:=false;
                continue;
              end;

              if Result <> Self.Items[i, j].Weight then
              begin
                Result:=-5;
                break;
              end;
            end;
          end;
end;

procedure TAlxdBordersInt.Set_Items(ACol, ARow: integer; Value: TAlxdBorderInt);
begin
  if FAlxdBorderType = btVer then
    (Owner as TAlxdSpreadSheetArray).DirectVerBorders[ACol, ARow].Assign(Value)
  else
    (Owner as TAlxdSpreadSheetArray).DirectHorBorders[ACol, ARow].Assign(Value);
end;

procedure TAlxdBordersInt.Set_State(Value: TAlxdDrawBorders);
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
  bs: TAlxdDrawBorders;
begin
  bs:=State;
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          if FAlxdBorderType = btVer then
          begin
            if i = Items[k].Left then
              if dbLeft in Value then
                Self.Items[i, j].State:=TAlxdDrawBorder(not (dbLeft in bs));

            if i = Items[k].Right then
              if dbRight in Value then
                Self.Items[i+1, j].State:=TAlxdDrawBorder(not (dbRight in bs));

            if (i > Items[k].Left) and (i <= Items[k].Right) then
              if dbVer in Value then
                Self.Items[i, j].State:=TAlxdDrawBorder(not (dbVer in bs));
          end
          else
          begin
            if j = Items[k].Top then
              if dbTop in Value then
                Self.Items[i, j].State:=TAlxdDrawBorder(not (dbTop in bs));

            if j = Items[k].Bottom then
              if dbBottom in Value then
                Self.Items[i, j+1].State:=TAlxdDrawBorder(not (dbBottom in bs));

            if (j > Items[k].Top) and (j <= Items[k].Bottom) then
              if dbHor in Value then
                Self.Items[i, j].State:=TAlxdDrawBorder(not (dbHor in bs));
          end;

  //ass.AlxdUndo.Fix;          
end;

procedure TAlxdBordersInt.Set_Color(Value: integer);

  function Dummy(Item: TAlxdBorderInt; P: Pointer): boolean;
  begin
    result:=false;
    if Integer(P^) > -2 then
    begin
      Item.Color:=Integer(P^);
      Result:=True;
    end;
  end;

begin
  CycleSet(@Dummy, @Value);
end;

procedure TAlxdBordersInt.Set_Layer(Value: WideString);

  function Dummy(Item: TAlxdBorderInt; P: Pointer): boolean;
  begin
    result:=false;
    if WideString(P^) <> MessageMemIniFile(2720) then
    begin
      Item.Layer:=WideString(P^);
      Result:=True;
    end;
  end;

begin
  CycleSet(@Dummy, @Value);
end;

procedure TAlxdBordersInt.Set_Weight(Value: integer);

  function Dummy(Item: TAlxdBorderInt; P: Pointer): boolean;
  begin
    result:=false;
    if Integer(P^) > -4 then
    begin
      Item.Weight:=Integer(P^);
      Result:=True;
    end;
  end;

begin
  CycleSet(@Dummy, @Value);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////
function TAlxdBordersInt.WriteToDictionary(dictid: longint): boolean;

  function dummy(Obj: longint; ACol, ARow: integer): PAlxdBorderExchange; cdecl;
  begin
    {$IFDEF DEBUG}
    OutputDebugString(#10'dummy write');
    {$ENDIF}
    Result:=@TAlxdBordersInt(Obj).Items[ACol, ARow].AlxdBorderExchange;
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
  oarxWriteBordersList(longint(Self), @dummy, dictid, c, r, FAlxdBorderType);
  {$ENDIF}

  Result:=True;
end;

function TAlxdBordersInt.ReadFromDictionary(dictid: longint): boolean;
  function dummy(Obj: longint; ACol, ARow: integer): PAlxdBorderExchange; cdecl;
  begin
    {$IFDEF DEBUG}
    OutputDebugString(#10'dummy read');
    {$ENDIF}
    Result:=@TAlxdBordersInt(Obj).Items[ACol, ARow].AlxdBorderExchange;
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
  oarxReadBordersList(longint(Self), @dummy, dictid, c, r, FAlxdBorderType);
  {$ENDIF}

  Result:=True;
end;

function TAlxdBordersInt.WriteToXML(ADoc: IXMLNode): boolean;
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

function TAlxdBordersInt.ReadFromXML(ADoc: IXMLNode; ReadAttr: boolean): boolean;
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
    if FAlxdBorderType = btVer then
      root:=ADoc.ChildNodes.FindNode(AlxdVerBordersRoot)
    else
      root:=ADoc.ChildNodes.FindNode(AlxdHorBordersRoot);

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

      if FAlxdBorderType = btVer then
      begin
        if (i >= 0) and (i <= c) and (j >= 0) and (j <= r-1) then
          Items[i, j].ReadFromXML(node);
      end
      else
      begin
        if (i >= 0) and (i <= c-1) and (j >= 0) and (j <= r) then
          Items[i, j].ReadFromXML(node);
      end;
      {if (i >= 0) and (i <= c-1) and (j >= 0) and (j <= r-1) then
        Items[i, j].ReadFromXML(node);}
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

function TAlxdBordersInt.WriteToXML(ADoc: IXMLNode; Rt: TRect): boolean;
var
  root: IXMLNode;
//  node: IXMLNode;
  i, j: integer;
//  c, r: integer;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    if Rt.Left < 0 then Rt.Left:=0;
    if Rt.Top < 0 then Rt.Top:=0;
    if Rt.Right >= ColCountInt then Rt.Right:=ColCountInt - 1;
    if Rt.Bottom >= RowCountInt then Rt.Bottom:=RowCountInt - 1;
  end;
  {with (Owner as TAlxdSpreadSheetArray) do
  begin
    c:=ColCountInt;
    r:=RowCountInt;
  end;}

  try
    if FAlxdBorderType = btVer then
      root:=ADoc.AddChild(AlxdVerBordersRoot)
    else
      root:=ADoc.AddChild(AlxdHorBordersRoot);
    //root.SetAttributeNS('Type', '', FAlxdBorderType);
//      node:=root.AddChild('Type');
//      node.NodeValue:=FAlxdBorderType;

{    for i := 0 to c do
      for j := 0 to r do}
    for i := Rt.Left to Rt.Right+1 do
      for j := Rt.Top to Rt.Bottom+1 do
      begin
        if FAlxdBorderType = btVer then
          //if j < r then
          if j <= Rt.Bottom then
            Items[i, j].WriteToXML(root);

        if FAlxdBorderType = btHor then
          //if i < c then
          if i <= Rt.Right then
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

function TAlxdBordersInt.ReadFromXML(ADoc: IXMLNode; Rt: TRect): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i, j: integer;
//  c, r: integer;
begin
  with (Owner as TAlxdSpreadSheetArray) do
  begin
    if Rt.Left < 0 then Rt.Left:=0;
    if Rt.Top < 0 then Rt.Top:=0;
    if Rt.Right >= ColCountInt then Rt.Right:=ColCountInt - 1;
    if Rt.Bottom >= RowCountInt then Rt.Bottom:=RowCountInt - 1;
  end;
  {with (Owner as TAlxdSpreadSheetArray) do
  begin
    c:=ColCountInt;
    r:=RowCountInt;
  end;}

  try
    if FAlxdBorderType = btVer then
      root:=ADoc.ChildNodes.FindNode(AlxdVerBordersRoot)
    else
      root:=ADoc.ChildNodes.FindNode(AlxdHorBordersRoot);

    if root = nil then
    begin
      //raise EXMLDocError.Create('');
      Result:=false;
      exit;
    end;
    //FAlxdBorderType:=root.GetAttributeNS('Type', '');

    node:=root.ChildNodes.First;
    {for i := 0 to c do
    begin
      for j := 0 to r do
      begin}
    for i := Rt.Left to Rt.Right+1 do
    begin
      for j := Rt.Top to Rt.Bottom+1 do
      begin
        if FAlxdBorderType = btVer then
          if j <= Rt.Bottom then
          begin
            Items[i, j].ReadFromXML(node);
            node:=node.NextSibling;
          end;

        if FAlxdBorderType = btHor then
          if i <= Rt.Right then
          begin
            Items[i, j].ReadFromXML(node);
            node:=node.NextSibling;
          end;

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

procedure TAlxdBordersInt.Assign(Source: TPersistent);
var
  i: integer;
begin
  if Source is TAlxdBordersInt then
    for i := 0 to High(AlxdBordersPropValues) do
    begin
      SetPropValue(Self, AlxdBordersPropValues[i], GetPropValue(Source, AlxdBordersPropValues[i]));
    end;

  if Source is TAlxdBorderInt then
    for i := 0 to High(AlxdBordersPropValues) do
    begin
      SetPropValue(Self, AlxdBordersPropValues[i], GetPropValue(Source, AlxdBordersPropValues[i]));
    end;
end;

constructor TAlxdBordersInt.CreateEx(AOwner: TComponent; AType: TAlxdBorderType);
begin
  inherited Create(AOwner);
  FAlxdBorders:=TAlxdBorders.Create(Self);
  FAlxdBorderType:=AType;
end;

destructor TAlxdBordersInt.Destroy;
begin
  inherited;
end;

end.
