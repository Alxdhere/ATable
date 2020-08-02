unit uAlxdCells;

interface

uses
  Windows, Classes, SysUtils, XMLDoc, XMLIntf,
  uAlxdCell, uAlxdSystem, uoarxImport, xAlxdCells, AlxdGrid_TLB,
  TntClasses, TypInfo, uAlxdLocalizer;

const
  AlxdCellsRoot = 'AlxdCells';
  AlxdCellsPropValues: array[0..16] of string = ('TextStyleObjectId', 'TextType', 'HorizontalAlignment', 'VerticalAlignment', 'TextFit', 'Height', 'WidthFactor', 'ObliqueAngle', 'Between', 'MarginLeft', 'MarginTop', 'MarginRight', 'MarginBottom', 'Rotation', 'Color', 'Layer', 'Weight');

type
  TFunctionSet = function (Item: TAlxdCellInt; P: Pointer): boolean;
  //TFunctionGet = function (Item: TAlxdCellInt; P: Pointer): boolean;

  TAlxdCellsInt = class(TComponent, IAlxdCells)
  private
    FAlxdCells: IAlxdCells;

    //function  CycleGet(F: TFunctionCall): Pointer;
    //function  CycleGet(F: TFunctionGet): Pointer;
    procedure CycleSet(F: TFunctionSet; const P: Pointer);

    function  Get_TextStyleObjectId: integer;
    function  Get_TextType: TAlxdCellTextType;
    function  Get_HorizontalAlignment: TAlxdCellTextHorAlignment;
    function  Get_VerticalAlignment: TAlxdCellTextVerAlignment;
    function  Get_TextFit: TAlxdCellTextFit;
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
    function  Get_Color: integer;
    function  Get_Layer: WideString;
    function  Get_Weight: integer;

    procedure Set_TextStyleObjectId(Value: integer);
    procedure Set_TextType(Value: TAlxdCellTextType);
    procedure Set_HorizontalAlignment(Value: TAlxdCellTextHorAlignment);
    procedure Set_VerticalAlignment(Value: TAlxdCellTextVerAlignment);
    procedure Set_TextFit(Value: TAlxdCellTextFit);
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
    procedure Set_Color(Value: integer);
    procedure Set_Layer(Value: WideString);
    procedure Set_Weight(Value: integer);

    function  Get_Items(ACol, ARow: integer): TAlxdCellInt;

    procedure Set_Items(ACol, ARow: integer; Value: TAlxdCellInt);
  public
    //methods
    property Intf: IAlxdCells read FAlxdCells implements IAlxdCells;

    procedure ClearFormat;
    procedure ClearContent;
    procedure ClearAll;

    function WriteToDictionary(dictid: longint): boolean;
    function ReadFromDictionary(dictid: longint): boolean;

    function WriteToXML(ADoc: IXMLNode): boolean; overload;
    function ReadFromXML(ADoc: IXMLNode; ReadAttr: boolean = false): boolean; overload;
    function WriteToXML(ADoc: IXMLNode; Rt: TRect): boolean; overload;
    function ReadFromXML(ADoc: IXMLNode; Rt: TRect): boolean; overload;

    function WriteToMText(var AValue: WideString; Rt: TRect): boolean;
    function ReadFromMText(AValue: WideString; Rt: TRect): boolean;

    property Items[ACol, ARow: integer]: TAlxdCellInt read Get_Items write Set_Items;
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published

    property TextStyleObjectId: integer read Get_TextStyleObjectId write Set_TextStyleObjectId;

    property TextType: TAlxdCellTextType read Get_TextType write Set_TextType;
    property HorizontalAlignment: TAlxdCellTextHorAlignment read Get_HorizontalAlignment write Set_HorizontalAlignment;
    property VerticalAlignment: TAlxdCellTextVerAlignment read Get_VerticalAlignment write Set_VerticalAlignment;
    property TextFit: TAlxdCellTextFit read Get_TextFit write Set_TextFit;

    property Height: double read Get_Height write Set_Height;
    property WidthFactor: double read Get_WidthFactor write Set_WidthFactor;
    property ObliqueAngle: double read Get_ObliqueAngle write Set_ObliqueAngle;
    property Between: double read Get_Between write Set_Between;

    property Margins: TAlxdMargins read Get_Margins write Set_Margins;
    property MarginLeft: double read Get_MarginLeft write Set_MarginLeft;
    property MarginTop: double read Get_MarginTop write Set_MarginTop;
    property MarginRight: double read Get_MarginRight write Set_MarginRight;
    property MarginBottom: double read Get_MarginBottom write Set_MarginBottom;

    property Rotation: double read Get_Rotation write Set_Rotation;
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

{function TAlxdCellsInt.CycleGet(F: TFunctionGet): Pointer;
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
            //Result:=
            F(Self.Items[i, j], Result);
            first:=false;
          end;
          if first then
          begin
            Result:=Self.Items[i, j].TextType;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].TextType then
          begin
            Result:=cttsMixed;
            break;
          end;
        end;
end;}

procedure TAlxdCellsInt.CycleSet(F: TFunctionSet; const P: Pointer);
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
begin
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          F(Self.Items[i, j], P);
          //Self.Items[i, j].TextType:=Value;

  ass.AlxdUndo.Fix;
end;

function  TAlxdCellsInt.Get_TextStyleObjectId: integer;
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
  first: boolean;
  {function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    //TAlxdCellTextType(P):=Item.TextType;
    //Item.TextType:=TAlxdCellTextType(P^);
    //Result:=True;
  end;}
begin
  //Result:=TAlxdCellTextType(CycleGet(@Dummy)^);
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  first:=true;
  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
        begin
          if first then
          begin
            Result:=Self.Items[i, j].TextStyleObjectId;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].TextStyleObjectId then
          begin
            Result:=-1;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_TextType: TAlxdCellTextType;
var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;
  first: boolean;
  {function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    //TAlxdCellTextType(P):=Item.TextType;
    //Item.TextType:=TAlxdCellTextType(P^);
    //Result:=True;
  end;}
begin
  //Result:=TAlxdCellTextType(CycleGet(@Dummy)^);
  ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  first:=true;
  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
        begin
          if first then
          begin
            Result:=Self.Items[i, j].TextType;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].TextType then
          begin
            Result:=cttsMixed;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_HorizontalAlignment: TAlxdCellTextHorAlignment;
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
            Result:=Self.Items[i, j].HorizontalAlignment;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].HorizontalAlignment then
          begin
            Result:=cthaMixed;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_VerticalAlignment: TAlxdCellTextVerAlignment;
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
            Result:=Self.Items[i, j].VerticalAlignment;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].VerticalAlignment then
          begin
            Result:=ctvaMixed;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_TextFit: TAlxdCellTextFit;
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
            Result:=Self.Items[i, j].TextFit;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].TextFit then
          begin
            Result:=ctfsMixed;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_Height: double;
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
            Result:=Self.Items[i, j].Height;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].Height then
          begin
            Result:=-1;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_WidthFactor: double;
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
            Result:=Self.Items[i, j].WidthFactor;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].WidthFactor then
          begin
            Result:=-1;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_ObliqueAngle: double;
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
            Result:=Self.Items[i, j].ObliqueAngle;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].ObliqueAngle then
          begin
            Result:=-87;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_Between: double;
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
            Result:=Self.Items[i, j].Between;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].Between then
          begin
            Result:=-1;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_Margins: TAlxdMargins;
begin
  Result.Left:=MarginLeft;
  Result.Top:=MarginTop;
  Result.Right:=MarginRight;
  Result.Bottom:=MarginBottom;
end;

function  TAlxdCellsInt.Get_MarginLeft: double;
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
            Result:=Self.Items[i, j].MarginLeft;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].MarginLeft then
          begin
            Result:=-2;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_MarginTop: double;
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
            Result:=Self.Items[i, j].MarginTop;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].MarginTop then
          begin
            Result:=-2;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_MarginRight: double;
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
            Result:=Self.Items[i, j].MarginRight;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].MarginRight then
          begin
            Result:=-2;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_MarginBottom: double;
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
            Result:=Self.Items[i, j].MarginBottom;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].MarginBottom then
          begin
            Result:=-2;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_Rotation: double;
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
            Result:=Self.Items[i, j].Rotation;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].Rotation then
          begin
            Result:=-1;
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_Color: integer;
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
            Result:=Self.Items[i, j].Color;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].Color then
          begin
            Result:=-2;//this is different colors!
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_Layer: WideString;
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
            Result:=Self.Items[i, j].Layer;
            first:=false;
            continue;
          end;

          if Result <> Self.Items[i, j].Layer then
          begin
            Result:=MessageMemIniFile(2720);
            break;
          end;
        end;
end;

function  TAlxdCellsInt.Get_Weight: integer;
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

procedure TAlxdCellsInt.Set_TextStyleObjectId(Value: integer);
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Item.TextStyleObjectId:=Integer(P^);
    Result:=True;
  end;
begin
  CycleSet(@Dummy, @Value);
end;

procedure TAlxdCellsInt.Set_TextType(Value: TAlxdCellTextType);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    if TAlxdCellTextType(P^) <> cttsMixed then
    begin
      Item.TextType:=TAlxdCellTextType(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].TextType:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_HorizontalAlignment(Value: TAlxdCellTextHorAlignment);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    if TAlxdCellTextHorAlignment(P^) <> cthaMixed then
    begin
      Item.HorizontalAlignment:=TAlxdCellTextHorAlignment(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].HorizontalAlignment:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_VerticalAlignment(Value: TAlxdCellTextVerAlignment);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    if TAlxdCellTextVerAlignment(P^) <> ctvaMixed then
    begin
      Item.VerticalAlignment:=TAlxdCellTextVerAlignment(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].VerticalAlignment:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_TextFit(Value: TAlxdCellTextFit);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    if TAlxdCellTextFit(P^) <> ctfsMixed then
    begin
      Item.TextFit:=TAlxdCellTextFit(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].TextFit:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_Height(Value: double);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    if Double(P^) >= 0 then
    begin
      Item.Height:=Double(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].Height:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_WidthFactor(Value: double);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    if Double(P^) >= 0 then
    begin
      Item.WidthFactor:=Double(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].WidthFactor:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_ObliqueAngle(Value: double);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    if Double(P^) >= -86 then
    begin
      Item.ObliqueAngle:=Double(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].ObliqueAngle:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_Between(Value: double);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    if Double(P^) >= 0 then
    begin
      Item.Between:=Double(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].Between:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_Margins(Value: TAlxdMargins);
begin
  MarginLeft:=Value.Left;
  MarginTop:=Value.Top;
  MarginRight:=Value.Right;
  MarginBottom:=Value.Bottom;
end;

procedure TAlxdCellsInt.Set_MarginLeft(Value: double);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Result:=False;
    if Double(P^) >= -1 then
    begin
      Item.MarginLeft:=Double(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].MarginLeft:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_MarginTop(Value: double);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Result:=False;
    if Double(P^) >= -1 then
    begin
      Item.MarginTop:=Double(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].MarginTop:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_MarginRight(Value: double);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Result:=False;
    if Double(P^) >= -1 then
    begin
      Item.MarginRight:=Double(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].MarginRight:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_MarginBottom(Value: double);
{var
  ass: TAlxdSpreadSheetInt;
  i, j, k: integer;}
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Result:=False;
    if Double(P^) >= -1 then
    begin
      Item.MarginBottom:=Double(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
  {ass:=((Owner as TAlxdSpreadSheetArray).Owner as TAlxdSpreadSheetInt);

  with ass.AlxdSpreadSheetSelections do
    for k := 0 to Count - 1 do
      for i := Items[k].Left to Items[k].Right do
        for j := Items[k].Top to Items[k].Bottom do
          Self.Items[i, j].MarginBottom:=Value;

  ass.AlxdUndo.Fix;}
end;

procedure TAlxdCellsInt.Set_Rotation(Value: double);

  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Result:=False;
    if Double(P^) >= 0 then
    begin
      Item.Rotation:=Double(P^);
      Result:=True;
    end;
  end;

begin
  CycleSet(@Dummy, @Value);
end;

procedure TAlxdCellsInt.Set_Color(Value: integer);

  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Result:=False;
    if Integer(P^) > -2 then
    begin
      Item.Color:=Integer(P^);
      Result:=True;
    end;
  end;

begin
  CycleSet(@Dummy, @Value);
end;

procedure TAlxdCellsInt.Set_Layer(Value: WideString);

  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Result:=False;
    if WideString(P^) <> MessageMemIniFile(2720) then
    begin
      Item.Layer:=WideString(P^);
      Result:=True;
    end;
  end;

begin
  CycleSet(@Dummy, @Value);
end;

procedure TAlxdCellsInt.Set_Weight(Value: integer);
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Result:=False;
    if Integer(P^) >= -4 then
    begin
      Item.Weight:=Integer(P^);
      Result:=True;
    end;
  end;
begin
  CycleSet(@Dummy, @Value);
end;

function  TAlxdCellsInt.Get_Items(ACol, ARow: integer): TAlxdCellInt;
begin
  Result:=(Owner as TAlxdSpreadSheetArray).DirectCells[ACol, ARow];
end;

procedure TAlxdCellsInt.Set_Items(ACol, ARow: integer; Value: TAlxdCellInt);
begin
  (Owner as TAlxdSpreadSheetArray).DirectCells[ACol, ARow].Assign(Value);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdCellsInt.ClearFormat;
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Item.ClearFormat;
    Result:=True;
  end;
begin
  CycleSet(@Dummy, nil);
end;

procedure TAlxdCellsInt.ClearContent;
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Item.ClearContent;
    Result:=True;
  end;
begin
  CycleSet(@Dummy, nil);
end;

procedure TAlxdCellsInt.ClearAll;
  function Dummy(Item: TAlxdCellInt; P: Pointer): boolean;
  begin
    Item.ClearFormat;  
    Item.ClearContent;
    Result:=True;
  end;
begin
  CycleSet(@Dummy, nil);
end;

function TAlxdCellsInt.WriteToDictionary(dictid: longint): boolean;

  function dummy(Obj: longint; ACol, ARow: integer): PAlxdCellExchange; cdecl;
  begin
    {$IFDEF DEBUG}
    OutputDebugString(#10'TAlxdCellsInt dummy write');
    {$ENDIF}
    Result:=@TAlxdCellsInt(Obj).Items[ACol, ARow].AlxdCellExchange;
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
  oarxWriteCellsList(longint(Self), @dummy, dictid, c, r);
  {$ENDIF}

  Result:=True;
end;

function TAlxdCellsInt.ReadFromDictionary(dictid: longint): boolean;

  function dummy(Obj: longint; ACol, ARow: integer): PAlxdCellExchange; cdecl;
  begin
    {$IFDEF DEBUG}
    OutputDebugString(#10'TAlxdCellsInt dummy read');
    {$ENDIF}
    Result:=@TAlxdCellsInt(Obj).Items[ACol, ARow].AlxdCellExchange;
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
  oarxReadCellsList(longint(Self), @dummy, dictid, c, r);
  {$ENDIF}

  Result:=True;
end;

function TAlxdCellsInt.WriteToXML(ADoc: IXMLNode): boolean;
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

function TAlxdCellsInt.ReadFromXML(ADoc: IXMLNode; ReadAttr: boolean): boolean;
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
    root:=ADoc.ChildNodes.FindNode(AlxdCellsRoot);
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

function TAlxdCellsInt.WriteToXML(ADoc: IXMLNode; Rt: TRect): boolean;
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
    root:=ADoc.AddChild(AlxdCellsRoot);

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

function TAlxdCellsInt.ReadFromXML(ADoc: IXMLNode; Rt: TRect): boolean;
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
    root:=ADoc.ChildNodes.FindNode(AlxdCellsRoot);
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

function TAlxdCellsInt.WriteToMText(var AValue: WideString; Rt: TRect): boolean;
var
  i, j: integer;
begin
  result:=true;
  for j := Rt.Top to Rt.Bottom do
  begin
    if j > Rt.Top then
      AValue:=AValue + #13#10;

    for i := Rt.Left to Rt.Right do
    begin
      if i > Rt.Left then
        AValue:=AValue + #9;

      AValue:=AValue + Items[i, j].ContainAsMText;
    end;
  end;
end;

function TAlxdCellsInt.ReadFromMText(AValue: WideString; Rt: TRect): boolean;
var
  sr, sc: TTntStrings;
  i, j: integer;
  ws: WideString;
begin
  result:=false;

  sr:=TTntStringList.Create;
  try
    sr.Text:=AValue;

    sc:=TTntStringList.Create;
    try
      for i := 0 to sr.Count - 1 do
      begin
        ws:=sr[i];
        ws:=StringReplace(ws, #9, #13#10, [rfReplaceAll, rfIgnoreCase]);

        sc.Text:=ws;
        for j := 0 to sc.Count - 1 do
        begin
          Items[Rt.Left + j, Rt.Top + i].ContainAsMText:=sc[j];
        end;
        
      end;
      result:=true;
    finally
      sc.Free
    end;
    
  finally
    sr.Free;
  end;
end;

procedure TAlxdCellsInt.Assign(Source: TPersistent);
var
  i: integer;
begin
  if Source is TAlxdCellsInt then
    for i := 0 to High(AlxdCellsPropValues) do
    begin
      SetPropValue(Self, AlxdCellsPropValues[i], GetPropValue(Source, AlxdCellsPropValues[i]));
    end;

  if Source is TAlxdCellInt then
    for i := 0 to High(AlxdCellsPropValues) do
    begin
      SetPropValue(Self, AlxdCellsPropValues[i], GetPropValue(Source, AlxdCellsPropValues[i]));
    end;
end;

constructor TAlxdCellsInt.Create(AOwner: TComponent);
begin
  inherited;
  FAlxdCells:=TAlxdCells.Create(Self);
end;

destructor TAlxdCellsInt.Destroy;
begin
  inherited;
end;

end.
