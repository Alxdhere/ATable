unit uAlxdSpreadSheetStyleItem;

interface

uses
  Windows, Classes, Types, SysUtils, TypInfo, uoarxImport,
  XMLDoc, XMLIntf, uAlxdSystem{, AlxdGrid_TLB};

const
  AlxdSpreadSheetStyleItemRoot = 'AlxdSpreadSheetStyleItem';
  AlxdSpreadSheetStyleItemPropValues: array[0..4] of string = ('Size', 'Title', 'HorizontalAlignment', 'VerticalAlignment', 'Visible');

type
  TAlxdSpreadSheetStyleItemInt = class(TComponent{, IAlxdItem})
  private
    FIndex: integer;

    FSize: double;
    FTitle: WideString;
    FHorizontalAlignment: TAlxdItemTextHorAlignment;
    FVerticalAlignment: TAlxdItemTextVerAlignment;
    FVisible: boolean;

    function  Get_Size: double;
    function  Get_Title: WideString;
    function  Get_HorizontalAlignment: TAlxdItemTextHorAlignment;
    function  Get_VerticalAlignment: TAlxdItemTextVerAlignment;
    function  Get_Visible: boolean;

    //function  Get_PropertyByNum(Index: Integer): OleVariant;

    procedure Set_Size(Value: double);
    procedure Set_Title(Value: WideString);
    procedure Set_HorizontalAlignment(Value: TAlxdItemTextHorAlignment);
    procedure Set_VerticalAlignment(Value: TAlxdItemTextVerAlignment);
    procedure Set_Visible(Value: boolean);

    //procedure Set_PropertyByNum(Index: Integer; Value: OleVariant);

  public
    function  WriteToXML(ADoc: IXMLNode): boolean;
    function  ReadFromXML(ADoc: IXMLNode): boolean;

    //inherited
    procedure Assign(Source: TPersistent); override;
    constructor CreateEx(AOwner: TComponent; AIndex: integer);
    destructor Destroy; override;
  published
    property Size: double read Get_Size write Set_Size;
    property Title: WideString read Get_Title write Set_Title;
    property HorizontalAlignment: TAlxdItemTextHorAlignment read Get_HorizontalAlignment write Set_HorizontalAlignment;
    property VerticalAlignment: TAlxdItemTextVerAlignment read Get_VerticalAlignment write Set_VerticalAlignment;
    property Visible: boolean read Get_Visible write Set_Visible;
  end;

implementation

uses
  uAlxdSpreadSheetArray, uAlxdSpreadSheetStyleItems, uAlxdSpreadSheetStyle, uAlxdSpreadSheet;

function  TAlxdSpreadSheetStyleItemInt.Get_Size: double;
var
  a: TComponent;
begin
  Result:=FSize;

  a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
  if (a is TAlxdSpreadSheetInt) then
    with (a as TAlxdSpreadSheetInt) do
    if AlxdSpreadSheetStyle.Primary = prColumn then
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Items[FIndex].Size
    else
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Rows.Items[FIndex].Size
end;

function  TAlxdSpreadSheetStyleItemInt.Get_Title: WideString;
var
  a: TComponent;
begin
  Result:=FTitle;

  a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
  if (a is TAlxdSpreadSheetInt) then
    with (a as TAlxdSpreadSheetInt) do
    if AlxdSpreadSheetStyle.Primary = prColumn then
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Items[FIndex].Title
    else
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Rows.Items[FIndex].Title;
end;

function  TAlxdSpreadSheetStyleItemInt.Get_HorizontalAlignment: TAlxdItemTextHorAlignment;
var
  a: TComponent;
begin
  Result:=FHorizontalAlignment;

  a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
  if (a is TAlxdSpreadSheetInt) then
    with (a as TAlxdSpreadSheetInt) do
    if AlxdSpreadSheetStyle.Primary = prColumn then
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Items[FIndex].HorizontalAlignment
    else
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Rows.Items[FIndex].HorizontalAlignment;
end;

function  TAlxdSpreadSheetStyleItemInt.Get_VerticalAlignment: TAlxdItemTextVerAlignment;
var
  a: TComponent;
begin
  Result:=FVerticalAlignment;

  a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
  if (a is TAlxdSpreadSheetInt) then
    with (a as TAlxdSpreadSheetInt) do
    if AlxdSpreadSheetStyle.Primary = prColumn then
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Items[FIndex].VerticalAlignment
    else
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Rows.Items[FIndex].VerticalAlignment;
end;

function  TAlxdSpreadSheetStyleItemInt.Get_Visible: boolean;
var
  a: TComponent;
begin
  Result:=FVisible;

  a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
  if (a is TAlxdSpreadSheetInt) then
    with (a as TAlxdSpreadSheetInt) do
    if AlxdSpreadSheetStyle.Primary = prColumn then
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Items[FIndex].Visible
    else
      Result:=(a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Rows.Items[FIndex].Visible;
end;

{function  TAlxdSpreadSheetStyleItemInt.Get_PropertyByNum(Index: Integer): OleVariant;
begin
//
end;
}
procedure TAlxdSpreadSheetStyleItemInt.Set_Size(Value: double);
var
  //a: TAlxdSpreadSheetArray;
  a: TComponent;
begin
  if Value < 0 then
    AlxdIndexedMessageBox(0, 1, '', MB_ICONWARNING + MB_OK)
  else
  if Value <> Size then
  begin
    FSize:=Value;

    a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
    if (a is TAlxdSpreadSheetInt) then
      with (a as TAlxdSpreadSheetInt) do
      if AlxdSpreadSheetStyle.Primary = prColumn then
        AlxdSpreadSheetArray.Columns.Items[FIndex].Size:=FSize
      else
        AlxdSpreadSheetArray.Rows.Items[FIndex].Size:=FSize;

{    if (Owner is TAlxdSpreadSheetStyleItemsInt) then
    begin
      a:=(((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray;
      a.Columns.Items[FIndex].Size:=FSize;
    end;}
//    if (Owner is TAlxdSpreadSheetInt) then
//     (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.
    
  end;
end;

procedure TAlxdSpreadSheetStyleItemInt.Set_Title(Value: WideString);
var
  a: TComponent;
begin
  if Value <> Title then
  begin
    FTitle:=Value;

    a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
    if (a is TAlxdSpreadSheetInt) then
      with (a as TAlxdSpreadSheetInt) do
      if AlxdSpreadSheetStyle.Primary = prColumn then
        AlxdSpreadSheetArray.Columns.Items[FIndex].Title:=FTitle
      else
        AlxdSpreadSheetArray.Rows.Items[FIndex].Title:=FTitle;

    {a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
    if (a is TAlxdSpreadSheetInt) then
    begin
      (a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Items[FIndex].Title:=FTitle;
    end;}
  end;
end;

procedure TAlxdSpreadSheetStyleItemInt.Set_HorizontalAlignment(Value: TAlxdItemTextHorAlignment);
var
  a: TComponent;
begin
  if Value <> HorizontalAlignment then
  begin
    FHorizontalAlignment:=Value;

    a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
    if (a is TAlxdSpreadSheetInt) then
      with (a as TAlxdSpreadSheetInt) do
      if AlxdSpreadSheetStyle.Primary = prColumn then
        AlxdSpreadSheetArray.Columns.Items[FIndex].HorizontalAlignment:=FHorizontalAlignment
      else
        AlxdSpreadSheetArray.Rows.Items[FIndex].HorizontalAlignment:=FHorizontalAlignment;

    {a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
    if (a is TAlxdSpreadSheetInt) then
    begin
      (a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Items[FIndex].HorizontalAlignment:=FHorizontalAlignment;
    end;}
  end;
end;

procedure TAlxdSpreadSheetStyleItemInt.Set_VerticalAlignment(Value: TAlxdItemTextVerAlignment);
var
  a: TComponent;
begin
  if Value <> VerticalAlignment then
  begin
    FVerticalAlignment:=Value;

    a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
    if (a is TAlxdSpreadSheetInt) then
      with (a as TAlxdSpreadSheetInt) do
      if AlxdSpreadSheetStyle.Primary = prColumn then
        AlxdSpreadSheetArray.Columns.Items[FIndex].VerticalAlignment:=FVerticalAlignment
      else
        AlxdSpreadSheetArray.Rows.Items[FIndex].VerticalAlignment:=FVerticalAlignment;

    {a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
    if (a is TAlxdSpreadSheetInt) then
    begin
      (a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Items[FIndex].VerticalAlignment:=FVerticalAlignment;
    end;}
  end;
end;

procedure TAlxdSpreadSheetStyleItemInt.Set_Visible(Value: boolean);
var
  a: TComponent;
begin
  if Value <> Visible then
  begin
    FVisible:=Value;

    a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
    if (a is TAlxdSpreadSheetInt) then
      with (a as TAlxdSpreadSheetInt) do
      if AlxdSpreadSheetStyle.Primary = prColumn then
        AlxdSpreadSheetArray.Columns.Items[FIndex].Visible:=FVisible
      else
        AlxdSpreadSheetArray.Rows.Items[FIndex].Visible:=FVisible;

    {a:=((Owner as TAlxdSpreadSheetStyleItemsInt).Owner as TAlxdSpreadSheetStyleInt).Owner;
    if (a is TAlxdSpreadSheetInt) then
    begin
      (a as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Items[FIndex].Visible:=FVisible;
    end;}
  end;
end;

{procedure TAlxdSpreadSheetStyleItemInt.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
//
end;}

function TAlxdSpreadSheetStyleItemInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc.AddChild(AlxdSpreadSheetStyleItemRoot);

    //write properties
    for i := 0 to High(AlxdSpreadSheetStyleItemPropValues) do
    begin
      node:=root.AddChild(AlxdSpreadSheetStyleItemPropValues[i]);
      node.NodeValue:=GetPropValue(Self, AlxdSpreadSheetStyleItemPropValues[i]);
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

function TAlxdSpreadSheetStyleItemInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc;
    if root = nil then
      raise EXMLDocError.Create('');

    for i := 0 to High(AlxdSpreadSheetStyleItemPropValues) do
    begin
      node:=root.ChildNodes.FindNode(AlxdSpreadSheetStyleItemPropValues[i]);
      if node = nil then
        raise EXMLDocError.Create('');
      SetPropValue(Self, AlxdSpreadSheetStyleItemPropValues[i], node.NodeValue);
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

procedure TAlxdSpreadSheetStyleItemInt.Assign(Source: TPersistent);
var
  i: integer;
begin
  if Source is TAlxdSpreadSheetStyleItemInt then
    for i := 0 to High(AlxdSpreadSheetStyleItemPropValues) do
    begin
      SetPropValue(Self, AlxdSpreadSheetStyleItemPropValues[i], GetPropValue(Source, AlxdSpreadSheetStyleItemPropValues[i]));
    end;
end;

constructor TAlxdSpreadSheetStyleItemInt.CreateEx(AOwner: TComponent; AIndex: integer);
begin
  inherited Create(AOwner);
  //FAlxdItem:=TAlxdItem.Create(Self);
  FIndex:=AIndex;

  //FSize:=((Owner as TAlxdSpreadSheetStyleItems).Owner as TAlxdSpreadSheetStyle).DefaultSize;
  FTitle:='';
  FHorizontalAlignment:=ithaLeft;
  FVerticalAlignment:=itvaBaseline;
  FVisible:=true;
end;

destructor TAlxdSpreadSheetStyleItemInt.Destroy;
begin
  inherited;
end;

end.
