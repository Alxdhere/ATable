unit uAlxdFill;

interface

uses
  Windows, SysUtils, Classes, Types, TypInfo, XMLDoc, XMLIntf,
  uAlxdSystem, uAlxdObjectIDs, uoarxImport, xAlxdFill, AlxdGrid_TLB;

const
  AlxdFillRoot = 'AlxdFill';
  AlxdFillPropValues: array[0..2] of string = ('FillType', 'HatchName', 'HatchColor');

type
  TAlxdFillInt = class(TComponent, IAlxdFill)
  private
    //internal
    FAlxdFill: IAlxdFill;

    FCol: integer;
    FRow: integer;
    FKeepObjects: boolean;

    //external
    //external.fill
    //FFillType: TAlxdFillType;

    //external.hatch
    //FHatchName: WideString;
    //FHatchColor: integer;
    //FHatchType: TAlxdFillHatchType;
    //FHatchId: longint;

    FNeedRedraw: boolean;
    FAlxdFillExchange: TAlxdFillExchange;

    FAlxdObjectIDs: TAlxdObjectIDsInt;

    function  Get_FillType: TAlxdFillType;
    function  Get_HatchName: WideString;
    function  Get_HatchColor: integer;
    function  Get_HatchType: TAlxdFillHatchType;
    function  Get_PropertyByNum(Index: Integer): OleVariant;

    procedure Set_FillType(Value: TAlxdFillType);
    procedure Set_HatchName(Value: WideString);
    procedure Set_HatchColor(Value: integer);
    procedure Set_HatchType(value: TAlxdFillHatchType);

    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant);

  public
    //DirectAccess
    property  Intf: IAlxdFill read FAlxdFill implements IAlxdFill;

    property  AlxdFillExchange: TAlxdFillExchange read FAlxdFillExchange;

    //property
    property  KeepObjects: boolean read FKeepObjects write FKeepObjects;
    property  NeedRedraw: boolean read FNeedRedraw write FNeedRedraw;

    function  RealFillType: TAlxdFillType;

    function  DrawingCoord: TDrawingPair;
    function  DrawingSize: TDrawingPair;
    function  DrawingLineCount: integer;

    property  PropertyByNum[Index: integer]: OleVariant read Get_PropertyByNum write Set_PropertyByNum;

    function  IsFillableCell: boolean;

    function  WriteToXML(ADoc: IXMLNode): boolean;
    function  ReadFromXML(ADoc: IXMLNode): boolean;

    function  Redraw(motive: TAlxdRedrawMotive): boolean;

    procedure Assign(Source: TPersistent); override;
    constructor CreateEx(AOwner: TComponent; ACol, ARow: integer);
    destructor Destroy; override;
  published
    property FillType: TAlxdFillType read Get_FillType write Set_FillType;
    property HatchName: WideString read Get_HatchName write Set_HatchName;
    property HatchColor: integer read Get_HatchColor write Set_HatchColor;
    property HatchType: TAlxdFillHatchType read Get_HatchType write Set_HatchType;
  end;

implementation

uses
  uAlxdSpreadSheet, uAlxdSpreadSheetArray;

////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdFillInt.Get_FillType: TAlxdFillType;
begin
  Result:=FAlxdFillExchange.FillType;
end;

function  TAlxdFillInt.Get_HatchName: WideString;
begin
  Result:=FAlxdFillExchange.HatchName;
end;

function  TAlxdFillInt.Get_HatchColor: integer;
begin
  Result:=FAlxdFillExchange.HatchColor;
end;

function  TAlxdFillInt.Get_HatchType: TAlxdFillHatchType;
begin
  Result:=FAlxdFillExchange.HatchType;
end;

function  TAlxdFillInt.Get_PropertyByNum(Index: Integer): OleVariant;
begin
//
end;

procedure TAlxdFillInt.Set_FillType(Value: TAlxdFillType);
begin
  if FAlxdFillExchange.FillType <> Value then
  begin
    FAlxdFillExchange.FillType := Value;
    FNeedRedraw:=True;
  end;
end;

procedure TAlxdFillInt.Set_HatchName(Value: WideString);
begin
{  if FAlxdFillExchange.HatchName <> Value then
  begin
    FAlxdFillExchange.HatchName := Value;
    FNeedRedraw:=True;
  end;}
end;

procedure TAlxdFillInt.Set_HatchColor(Value: integer);
begin
{  if (Value < -1) or (Value > 256) then
  begin
    AlxdIndexedMessageBox(0, 2, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  if FAlxdFillExchange.HatchColor <> Value then
  begin
    FAlxdFillExchange.HatchColor := Value;
    FNeedRedraw:=True;
  end;}
end;

procedure TAlxdFillInt.Set_HatchType(value: TAlxdFillHatchType);
begin
{  if FAlxdFillExchange.HatchType <> Value then
  begin
    FAlxdFillExchange.HatchType := Value;
    FNeedRedraw:=True;
  end;}
end;

procedure TAlxdFillInt.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  case Index of
  281:FillType:=Value;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdFillInt.RealFillType: TAlxdFillType;
var
  ass: TAlxdSpreadSheetInt;
begin
  Result:=FillType;

  if Result = ftDefault then
  begin
    ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);
    if ass.AlxdSpreadSheetStyle.FillCell = fcNoFill then
      Result:=ftEmpty;
    if ass.AlxdSpreadSheetStyle.FillCell = fcFill then
      Result:=ftFill;
  end;
end;

function  TAlxdFillInt.DrawingCoord: TDrawingPair;
begin
  Result.x:=(Owner as TAlxdSpreadSheetArray).Columns.Items[FCol].Coord;
  Result.y:=(Owner as TAlxdSpreadSheetArray).Rows.Items[FRow].Coord;
end;

function  TAlxdFillInt.DrawingSize: TDrawingPair;
begin
  Result:=(Owner as TAlxdSpreadSheetArray).Cells.Items[FCol, FRow].DrawingSize;
end;

function  TAlxdFillInt.DrawingLineCount: integer;
begin
  if (Owner as TAlxdSpreadSheetArray).Cells.Items[FCol, FRow].IsRotatedCell then
    Result:=(Owner as TAlxdSpreadSheetArray).Columns.Items[FCol].LineCount
  else
    Result:=(Owner as TAlxdSpreadSheetArray).Rows.Items[FRow].LineCount;
end;

function  TAlxdFillInt.IsFillableCell: boolean;
var
  ass: TAlxdSpreadSheetInt;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  Result:=((Owner as TAlxdSpreadSheetArray).Cells.Items[FCol, FRow].Between = 0) or
          ((Owner as TAlxdSpreadSheetArray).Cells.Items[FCol, FRow].Between = ass.AlxdSpreadSheetStyle.DefaultSize);
end;

function  TAlxdFillInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc.AddChild(AlxdFillRoot);
    root.SetAttributeNS('Column', '', FCol);
    root.SetAttributeNS('Row', '', FRow);

    //write properties
    for i := 0 to High(AlxdFillPropValues) do
    begin
      node:=root.AddChild(AlxdFillPropValues[i]);
      node.NodeValue:=GetPropValue(Self, AlxdFillPropValues[i]);
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

function  TAlxdFillInt.ReadFromXML(ADoc: IXMLNode): boolean;
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

    for i := 0 to High(AlxdFillPropValues) do
    begin
      node:=root.ChildNodes.FindNode(AlxdFillPropValues[i]);
      if node <> nil then
        //raise EXMLDocError.Create('');
        SetPropValue(Self, AlxdFillPropValues[i], node.NodeValue);
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

function  TAlxdFillInt.Redraw(motive: TAlxdRedrawMotive): boolean;
var
  tmpValue: TAlxdFillExchange;
  candraw: boolean;
begin
  try
    if (rmAll in motive) or (rmAllFills in motive) or (NeedRedraw and (rmFills in motive)) then
    begin
      tmpValue.Coord:=DrawingCoord;
      tmpValue.Size:=DrawingSize;
      tmpValue.FillType:=RealFillType;
      tmpValue.LineCount:=DrawingLineCount;
      tmpValue.ObjectIds:=FAlxdObjectIDs.DirectObjectIDs;
      tmpValue.IsRotatedCell:=(Owner as TAlxdSpreadSheetArray).Cells.Items[FCol, FRow].IsRotatedCell;
      tmpValue.DefaultSize:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.DefaultSize;

      tmpValue.HatchName:='';
      tmpValue.HatchColor:=0;
      tmpValue.HatchType:=chtEmpty;
      tmpValue.HatchId:=FAlxdFillExchange.HatchId;

      with (Owner as TAlxdSpreadSheetArray).Cells.Items[FCol, FRow] do
        candraw:=IsSimpleCell and IsFillableCell and IsResetedCell and IsVisibleCell and (tmpValue.FillType <> ftEmpty);

      {$IFDEF DLL}
      if candraw then
      begin
        oarxLockDocument(((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt).BlockReferenceId);
        oarxRedrawFill(@tmpValue);
      end
      else
        oarxEraseFill(@tmpValue, 0);
      {$ENDIF}

      FAlxdFillExchange.HatchId:=tmpValue.HatchId;
      FAlxdObjectIDs.DirectObjectIDs:=tmpValue.ObjectIds;
      NeedRedraw:=False;
    end;

    Result:=True;
  except
    Result:=False;
  end;
end;

procedure TAlxdFillInt.Assign(Source: TPersistent);
var
  i: integer;
begin
  if Source is TAlxdFillInt then
    for i := 0 to High(AlxdFillPropValues) do
    begin
      SetPropValue(Self, AlxdFillPropValues[i], GetPropValue(Source, AlxdFillPropValues[i]));
    end;
end;

constructor TAlxdFillInt.CreateEx(AOwner: TComponent; ACol, ARow: integer);
begin
  inherited Create(AOwner);
  FAlxdFill:=TAlxdFill.Create(Self);

  FCol:=ACol;
  FRow:=ARow;
  FAlxdObjectIDs:=TAlxdObjectIDsInt.Create(Self);
  FKeepObjects:=false;
  FNeedRedraw:=true;

  FAlxdFillExchange.HatchName:='SOLID';
  FAlxdFillExchange.HatchId:=0;

  //FAlxdFillExchange.
end;

destructor TAlxdFillInt.Destroy;
{$IFDEF DLL}
var
  tmpValue: TAlxdFillExchange;
{$ENDIF}
begin
  {$IFDEF DLL}
  if not KeepObjects then
  begin
    tmpValue.ObjectIds:=FAlxdObjectIDs.DirectObjectIDs;
    oarxEraseFill(@tmpValue, 0);
    FAlxdObjectIDs.DirectObjectIDs:=tmpValue.ObjectIds;
  end;
  {$ENDIF}
  FAlxdObjectIDs.Free;
  inherited;
end;

end.
