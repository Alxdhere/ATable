unit uAlxdBorder;

interface

uses
  Windows, Classes, Types, TypInfo, SysUtils, XMLDoc, XMLIntf,
  uAlxdSystem, uoarxImport, xAlxdBorder, AlxdGrid_TLB;

const
  AlxdBorderRoot = 'AlxdBorder';
  AlxdBorderPropValues: array[0..2] of string = ('State', 'Color', 'Weight');

type
  TAlxdBorderInt = class(TComponent, IAlxdBorder)
  private
    FAlxdBorder: IAlxdBorder;
    //internal variables
    FCol: integer;
    FRow: integer;
    FType: TAlxdBorderType;
    FKeepObjects: boolean;
    FNeedRedraw: boolean;

    //int/ext variables
    FAlxdBorderExchange: TAlxdBorderExchange;
    FNeedCheck: boolean;

    function  Get_PaintColor: integer;
    function  Get_DrawingSize: double;
    function  Get_RealState: TAlxdDrawBorder;
    function  Get_RealColor: integer;
    function  Get_RealLayer: WideString;
    function  Get_RealWeight: integer;

    function  Get_PropertyByNum(Index: Integer): OleVariant;

    procedure Set_State(Value: TAlxdDrawBorder);
    procedure Set_Color(Value: integer);
    procedure Set_Layer(Value: WideString);
    procedure Set_Weight(Value: integer);
    procedure Set_ObjectId(Value: integer);

    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant);

  public
    //DirectAccess
    property Intf: IAlxdBorder read FAlxdBorder implements IAlxdBorder;
    property AlxdBorderExchange: TAlxdBorderExchange read FAlxdBorderExchange;

    //property
    property KeepObjects: boolean read FKeepObjects write FKeepObjects;
    property NeedRedraw: boolean read FNeedRedraw write FNeedRedraw;
    property ObjectId: integer read FAlxdBorderExchange.ObjectId write Set_ObjectId;
    property PaintColor: integer read Get_PaintColor;
    property DrawingSize: double read Get_DrawingSize;
    property PropertyByNum[Index: integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;

    //property real
    property RealState: TAlxdDrawBorder read Get_RealState;
    property RealColor: integer read Get_RealColor;
    property RealLayer: WideString read Get_RealLayer;
    property RealWeight: integer read Get_RealWeight;

    //methods
    function WriteToXML(ADoc: IXMLNode): boolean;
    function ReadFromXML(ADoc: IXMLNode): boolean;

    procedure Redraw(motive: TAlxdRedrawMotive);

    procedure Assign(Source: TPersistent); override;
    constructor CreateEx(AOwner: TComponent; ACol, ARow: integer; AType: TAlxdBorderType);
    destructor  Destroy; override;
  published
    //assigning properties
    property  State: TAlxdDrawBorder read FAlxdBorderExchange.State write Set_State;
    property  Color: integer read FAlxdBorderExchange.Color write Set_Color;
    property  Layer: WideString read FAlxdBorderExchange.Layer write Set_Layer;
    property  Weight: integer read FAlxdBorderExchange.Weight write Set_Weight;
  end;

implementation

uses
  uAlxdEditor, uAlxdSpreadSheetArray, uAlxdSpreadSheet, uAlxdBorders;

////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdBorderInt.Get_PaintColor: integer;
begin
  {$IFDEF DLL}
  Result:=oarxAcEdGetRGB(RealColor);
  if Result=$FFFFFF then
    Result:=0;
  {$ELSE}
  Result:=RealColor;
  {$ENDIF}
end;

function  TAlxdBorderInt.Get_DrawingSize: double;
begin
  with (Owner as TAlxdSpreadSheetArray) do
    if FType = btVer then
      //Result:=Rows.Items[FRow].RealSize * Rows.Items[FRow].LineCount
      Result:=Rows.Items[FRow].DrawingSize
    else
      //Result:=Columns.Items[FCol].RealSize * Columns.Items[FCol].LineCount;
      Result:=Columns.Items[FCol].DrawingSize;
end;

function  TAlxdBorderInt.Get_RealState: TAlxdDrawBorder;
begin
  Result:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.DrawBorder;

  if Result = dbDraw then
    Result:=State;
end;

function  TAlxdBorderInt.Get_RealColor: integer;
begin
  if Color <= 0 then
  begin
    if FType = btVer then
      Result:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.VerBorderColor
    else
      Result:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.HorBorderColor;

    if Result = 0 then
      Result:=256;
  end
  else
    Result:=Color;
end;

function  TAlxdBorderInt.Get_RealLayer: WideString;
begin
  if Layer = '' then
  begin
    if FType = btVer then
      Result:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.VerBorderLayer
    else
      Result:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.HorBorderLayer;
  end
  else
    Result:=Layer;
end;

function  TAlxdBorderInt.Get_RealWeight: integer;
begin
  if Weight < -3 then
  begin
    if FType = btVer then
      Result:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.VerBorderWeight
    else
      Result:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.HorBorderWeight;
  end
  else
    Result:=Weight;
end;

function  TAlxdBorderInt.Get_PropertyByNum(Index: Integer): OleVariant;
begin
//
end;

procedure TAlxdBorderInt.Set_State(Value: TAlxdDrawBorder);
begin
  if not (Value in [dbNoDraw, dbDraw]) then
  begin
    AlxdIndexedMessageBox(0, 1, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  with FAlxdBorderExchange do
  if State <> Value then
  begin
    State:=Value;
    NeedRedraw:=True;
    FfrmEditor.ActionUpdate([aumBorders]);
  end;
end;

procedure TAlxdBorderInt.Set_Color(Value: integer);
begin
  {if (Value < -1) or (Value > 256) then
  begin
    AlxdIndexedMessageBox(0, 1, '', MB_ICONWARNING + MB_OK);
    exit;
  end;}

  with FAlxdBorderExchange do
  if Color <> Value then
  begin
    Color:=Value;
    NeedRedraw:=True;
    FfrmEditor.ActionUpdate([aumBorders]);
  end;
end;

procedure TAlxdBorderInt.Set_Layer(Value: WideString);
begin
  {
  ValidName?
  if (Value < -1) or (Value > 256) then
  begin
    AlxdIndexedMessageBox(0, 1, '', MB_ICONWARNING + MB_OK);
    exit;
  end;}

  with FAlxdBorderExchange do
  if FAlxdBorderExchange.Layer <> Value then
  begin
    Layer:=Value;
    NeedRedraw:=True;
    FfrmEditor.ActionUpdate([aumBorders]);
  end;
end;

procedure TAlxdBorderInt.Set_Weight(Value: integer);
begin
  {if (Value < -4) then
  begin
    AlxdIndexedMessageBox(0, 1, '', MB_ICONWARNING + MB_OK);
    exit;
  end;}

  with FAlxdBorderExchange do
  if Weight <> Value then
  begin
    Weight:=Value;
    NeedRedraw:=True;
    FfrmEditor.ActionUpdate([aumBorders]);
  end;
end;

procedure TAlxdBorderInt.Set_ObjectId(Value: integer);
begin
  FAlxdBorderExchange.ObjectId:=Value;
end;

procedure TAlxdBorderInt.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  case Index of
  10: State:=Value;
  60: Color:=Value;
  65: Weight:=Value;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////
function TAlxdBorderInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc.AddChild(AlxdBorderRoot);
    root.SetAttributeNS('Column', '', FCol);
    root.SetAttributeNS('Row', '', FRow);

    //write properties
    for i := 0 to High(AlxdBorderPropValues) do
    begin
      node:=root.AddChild(AlxdBorderPropValues[i]);
      node.NodeValue:=GetPropValue(Self, AlxdBorderPropValues[i]);
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

function TAlxdBorderInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc;//.ChildNodes.FindNode(AlxdBorderRoot);
    if root = nil then
    begin
      //raise EXMLDocError.Create('');
      Result:=False;
      exit;
    end;
    //FCol:=root.GetAttributeNS('Column', '');
    //FRow:=root.GetAttributeNS('Row', '');

    for i := 0 to High(AlxdBorderPropValues) do
    begin
      node:=root.ChildNodes.FindNode(AlxdBorderPropValues[i]);
      if node <> nil then
        //raise EXMLDocError.Create('');
        SetPropValue(Self, AlxdBorderPropValues[i], node.NodeValue);
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

procedure TAlxdBorderInt.Redraw(motive: TAlxdRedrawMotive);
var
  tmpStCoord: TDrawingPair;
  tmpEndCoord: TDrawingPair;
  tmpValue: TAlxdBorderExchange;
//  drwcol, drwrow: integer;
  candraw: boolean;
  jp: TAlxdJoinedPlace;
begin
//  candraw:=false;
  jp:=[jpLeft, jpTop, jpRight, jpBottom];

  with (Owner as TAlxdSpreadSheetArray) do
    if (FCol < ColCountInt) and (FRow < RowCountInt) then
      jp:=Cells.Items[FCol, FRow].JoinedPlace;

  if (rmAll in motive) or (rmAllBorders in motive) or (NeedRedraw and ((rmVerBorders in motive) or (rmHorBorders in motive))) then
  begin
    with (Owner as TAlxdSpreadSheetArray) do
    if FType = btVer then
    begin
      candraw:=(jpLeft in jp);
      if FCol < ColCountInt then
      begin
        if not Cells.Items[FCol, FRow].IsVisibleCell then
          candraw:=false;
      end
      else
        if not Rows.Items[FRow].Visible then
          candraw:=false;

      if candraw then
      begin
        if FCol < ColCountInt then
        begin
          tmpStCoord.x:=Columns.Items[FCol].Coord;
          tmpStCoord.y:=Rows.Items[FRow].Coord;
        end
        else
        begin
          tmpStCoord.x:=Columns.Items[FCol-1].Coord + Columns.Items[FCol-1].DrawingSize;//RealSize;
          tmpStCoord.y:=Rows.Items[FRow].Coord;
        end;

        tmpEndCoord.x:=tmpStCoord.x;
        tmpEndCoord.y:=tmpStCoord.y - DrawingSize;
      end;
    end
    else
    begin
      candraw:=(jpTop in jp);
      if FRow < RowCountInt then
      begin
        if not Cells.Items[FCol, FRow].IsVisibleCell then
          candraw:=false;
      end
      else
        if not Columns.Items[FCol].Visible then
          candraw:=false;

      if candraw then
      begin
        if FRow < RowCountInt then
        begin
          tmpStCoord.x:=Columns.Items[FCol].Coord;
          tmpStCoord.y:=Rows.Items[FRow].Coord;
        end
        else
        begin
          tmpStCoord.x:=Columns.Items[FCol].Coord;
          tmpStCoord.y:=Rows.Items[FRow-1].Coord - Rows.Items[FRow-1].DrawingSize;
        end;

        tmpEndCoord.x:=tmpStCoord.x + DrawingSize;
        tmpEndCoord.y:=tmpStCoord.y;
      end;
    end;

    if candraw then
    begin
      tmpValue.State:=RealState;
      tmpValue.Color:=RealColor;
      tmpValue.Layer:=RealLayer;
      tmpValue.Weight:=RealWeight;
    end;

    {$IFDEF DLL}
    tmpValue.ObjectId:=ObjectId;
    if candraw then
    begin
      oarxLockDocument(((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).BlockReferenceId);
      oarxRedrawBorder(@tmpStCoord, @tmpEndCoord, @tmpValue);
    end
    else
      oarxEraseBorder(@tmpValue);
    ObjectId:=tmpValue.ObjectId;
    {$ENDIF}

    NeedRedraw:=False;
  end;
end;

procedure TAlxdBorderInt.Assign(Source: TPersistent);
var
  i: integer;
begin
  if Source is TAlxdBorderInt then
    for i := 0 to High(AlxdBorderPropValues) do
    begin
      SetPropValue(Self, AlxdBorderPropValues[i], GetPropValue(Source, AlxdBorderPropValues[i]));
    end;

  if Source is TAlxdBordersInt then
  begin
    FNeedCheck:=false;

    for i := 0 to High(AlxdBordersPropValues) do
    begin
      SetPropValue(Self, AlxdBordersPropValues[i], GetPropValue(Source, AlxdBordersPropValues[i]));
    end;
    
    FNeedCheck:=true;
  end;
end;

constructor TAlxdBorderInt.CreateEx(AOwner: TComponent; ACol, ARow: integer; AType: TAlxdBorderType);
begin
  inherited Create(AOwner);
  FAlxdBorder:=TAlxdBorder.Create(Self);
  FCol:=ACol;
  FRow:=ARow;
  FType:=AType;
  FKeepObjects:=false;
  FNeedRedraw:=true;

  with FAlxdBorderExchange do
  begin
    State:=dbDraw;//включить отображение бордюра по-умолчанию
    Color:=-1;
    Weight:=-4;
    ObjectId:=0;
  end;
end;

destructor TAlxdBorderInt.Destroy;
{$IFDEF DLL}
var
  tmpValue: TAlxdBorderExchange;
{$ENDIF}
begin
  {$IFDEF DLL}
  if not KeepObjects then
  begin
    tmpValue.ObjectId:=ObjectId;
    oarxEraseBorder(@tmpValue);
    ObjectId:=tmpValue.ObjectId;
  end;
  {$ENDIF}
  inherited;
end;

end.
