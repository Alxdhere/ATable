unit uAlxdSpreadSheetSelections;

interface

uses
  SysUtils, Messages,
  Windows, Classes, Forms, Controls, TypInfo, XMLDoc, XMLIntf,
  uAlxdSystem, uAlxdSpreadSheetSelection, uAlxdLocalizer,
  uAlxdPasteSpecial, RegExpr, Graphics, xAlxdSpreadSheetSelections, AlxdGrid_TLB;

const
  AlxdSelectionsRoot = 'AlxdSelections';
  AlxdSelectionsPropValues: array[0..0] of string = ('Count');
  AlxdSelectionColors: array[0..6] of integer = ($0000FF, $008200, $9C00CE, $840000, $00CF31, $FF6500, $CE009C);

type
  TAlxdSpreadSheetSelectionsInt = class(TComponent, IAlxdSpreadSheetSelections)
  private
    FAlxdSpreadSheetSelections: IAlxdSpreadSheetSelections;

    FAlxdSpreadSheetSelectionsInts: TList;
    FCurrentCell: TAlxdSpreadSheetSelectionInt;
    FLastSelectedCell: TAlxdSpreadSheetSelectionInt;
{
    //активна€ €чейка и
    //пр€моугольник объединенной €чейки, если она объединена
    FCurrentCell: TPoint;
    FCurrentRect: TRect;

    //последн€€ выранна€ €чейка и
    //пр€моугольник объединенной €чейки, если она объединена
    FLastSelectedCell: TPoint;
    FLastSelectedRect: TRect;
}
    function  Get_Multiselect: boolean;
    function  Get_Count: integer;
    function  Get_Items(Index: Integer): TAlxdSpreadSheetSelectionInt;
    procedure Set_Items(Index: integer; Value: TAlxdSpreadSheetSelectionInt);
    procedure SortArray(var SelArr: TPtArray);
    procedure Sort;

  public
    property  Intf: IAlxdSpreadSheetSelections read FAlxdSpreadSheetSelections implements IAlxdSpreadSheetSelections;

    property  Items[Index: integer]: TAlxdSpreadSheetSelectionInt read Get_Items write Set_Items;
    //property  Count: integer read Get_Count;
    property  Multiselect: boolean read Get_Multiselect;

    property  CurrentCell: TAlxdSpreadSheetSelectionInt read FCurrentCell write FCurrentCell;
    property  LastSelectedCell: TAlxdSpreadSheetSelectionInt read FLastSelectedCell write FLastSelectedCell;

    //methods
    function  Add: Integer;
    procedure ClearToOne;
    procedure Clear;
    procedure Delete(Index: integer);
    procedure SelectAll;

    function  HasColumnsOnly: boolean;
    function  HasRowsOnly: boolean;
    function  HasColumn(ACol: integer; CheckType: boolean = false): boolean;
    function  HasRow(ARow: integer; CheckType: boolean = false): boolean;
    function  HasCell(ACol, ARow: integer): boolean;
    function  HasOneCellOnly: boolean;
    function  HasText: boolean;

    function  HorPosDelta: TPtArray;
    function  VerPosDelta: TPtArray;

    function  FindSelectionByCell(ACol, ARow: integer): integer;
    function  TabCell(ACell: TPoint; AReverse: boolean = false): TPoint;
    function  Find(AShow: boolean = false): boolean;

    procedure Join(KeepText: boolean = false);
    procedure JoinByRow(KeepText: boolean = false);
    procedure JoinByColumn(KeepText: boolean = false);
    procedure Disjoin;

    function  Update: boolean;
    procedure FillOutByFormula(AFormula: WideString);
    function  FindByFormula(AFormula: WideString): integer;
    function  ColorByIndex(Index: integer): integer;

    //function  SaveToXML(AFileName: WideString): boolean;
    //function  LoadFromXML(AFileName: WideString): boolean;
    procedure CutToClipboard;
    procedure CopyToClipboard;
    procedure PasteFromClipboard;
    procedure PasteSpecialFromClipboard;
    procedure PasteAsCF_AXML;
    procedure PasteAsCF_UNICODETEXT;

    function  SaveAsMText(var AValue: WideString): boolean;
    function  LoadAsMText(AValue: WideString): boolean;

    function  SaveAsXML(var AValue: WideString): boolean;
    function  LoadAsXML(AValue: WideString): boolean;

    function  WriteToXML(ADoc: IXMLNode): boolean;
    function  ReadFromXML(ADoc: IXMLNode): boolean;

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    property  Count: integer read Get_Count;
  end;

implementation

uses
  uAlxdEditor, uAlxdSpreadSheet, uAlxdOptions;

////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

function TAlxdSpreadSheetSelectionsInt.Get_Multiselect: boolean;
begin
  Result:=(Count > 1);
end;

function TAlxdSpreadSheetSelectionsInt.Get_Count: integer;
begin
  Result:=FAlxdSpreadSheetSelectionsInts.Count;
end;

function TAlxdSpreadSheetSelectionsInt.Get_Items(Index: Integer): TAlxdSpreadSheetSelectionInt;
begin
  if (Index < 0) or (Index > Count)  then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    Result:=nil;
    exit;
  end;

  Result:=FAlxdSpreadSheetSelectionsInts.Items[Index];
end;

procedure TAlxdSpreadSheetSelectionsInt.Set_Items(Index: integer; Value: TAlxdSpreadSheetSelectionInt);
begin
  if (Index < 0) or (Index > Count)  then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  TAlxdSpreadSheetSelectionInt(FAlxdSpreadSheetSelectionsInts.Items[Index]).Assign(Value);
end;

procedure TAlxdSpreadSheetSelectionsInt.SortArray(var SelArr: TPtArray);
var
  i: integer;
  sorted: boolean;
  pt: TPoint;
begin
{$IFDEF SDEBUG}
  OutputDebugString(#10'TAlxdSpreadSheetSelectionsInt.SortArray');
{$ENDIF}
  sorted:=false;
  while not sorted do
  begin
    sorted:=true;
    for i:=1 to Count - 1 do
      if SelArr[i].X > SelArr[i-1].X then
      begin
        Pt:=SelArr[i-1];
        SelArr[i-1]:=SelArr[i];
        SelArr[i]:=Pt;
        sorted:=false;
      end;
  end;
end;

procedure TAlxdSpreadSheetSelectionsInt.Sort;
  function Compare(Item1, Item2: Pointer): Integer;
  begin
    Result:=Integer((TAlxdSpreadSheetSelectionInt(Item1).SelectionRect.Left > TAlxdSpreadSheetSelectionInt(Item2).SelectionRect.Left) or
            (TAlxdSpreadSheetSelectionInt(Item1).SelectionRect.Top > TAlxdSpreadSheetSelectionInt(Item2).SelectionRect.Top));
  end;
begin
{$IFDEF SDEBUG}
  OutputDebugString(#10'TAlxdSpreadSheetSelectionsInt.Sort');
{$ENDIF}
  if Count > 1 then
    FAlxdSpreadSheetSelectionsInts.Sort(@Compare);
end;


////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

function TAlxdSpreadSheetSelectionsInt.Add: Integer;
begin
  Result:=FAlxdSpreadSheetSelectionsInts.Add(TAlxdSpreadSheetSelectionInt.Create(Self));
end;

procedure TAlxdSpreadSheetSelectionsInt.ClearToOne;
begin
  while Count > 1 do
    Delete(0);
end;

procedure TAlxdSpreadSheetSelectionsInt.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

procedure TAlxdSpreadSheetSelectionsInt.Delete(Index: integer);
begin
  if (Index < 0) or (Index > Count)  then
  begin
    AlxdIndexedMessageBox(0, 102, '', MB_ICONWARNING + MB_OK);
    exit;
  end;

  Items[Index].Free;
  FAlxdSpreadSheetSelectionsInts.Delete(Index);
end;

procedure TAlxdSpreadSheetSelectionsInt.SelectAll;
begin
  ClearToOne;
  Items[0].SelectionType:=stAll;
end;

function  TAlxdSpreadSheetSelectionsInt.HasColumnsOnly: boolean;
var
  i: integer;
begin
  Result:=True;
  for i := 0 to Count - 1 do
    if Items[i].SelectionType <> stColumn then
    begin
      Result:=False;
      break;
    end;
  {$IFDEF DEBUG}
  OutputDebugString(PChar(Format('TAlxdSpreadSheetSelectionsInt.HasColumnsOnly : %d', [Ord(Result)])));
  {$ENDIF}
end;

function  TAlxdSpreadSheetSelectionsInt.HasRowsOnly: boolean;
var
  i: integer;
begin
  Result:=True;
  for i := 0 to Count - 1 do
    if Items[i].SelectionType <> stRow then
    begin
      Result:=False;
      break;
    end;
  {$IFDEF DEBUG}
  OutputDebugString(PChar(Format('TAlxdSpreadSheetSelectionsInt.HasRowsOnly : %d', [Ord(Result)])));
  {$ENDIF}
end;

function  TAlxdSpreadSheetSelectionsInt.HasColumn(ACol: integer; CheckType: boolean): boolean;
var
  i: integer;
begin
  Result:=False;
  for i := 0 to Count - 1 do
    Result:=Result or Items[i].HasColumn(ACol, CheckType);
end;

function  TAlxdSpreadSheetSelectionsInt.HasRow(ARow: integer; CheckType: boolean): boolean;
var
  i: integer;
begin
  Result:=False;
  for i := 0 to Count - 1 do
    Result:=Result or Items[i].HasRow(ARow, CheckType);
end;

function  TAlxdSpreadSheetSelectionsInt.HasCell(ACol, ARow: integer): boolean;
var
  i: integer;
begin
  Result:=False;
  for i := 0 to Count - 1 do
    Result:=Result or Items[i].HasCell(ACol, ARow);
end;

function  TAlxdSpreadSheetSelectionsInt.HasOneCellOnly: boolean;
begin
  Result:=(Multiselect = false);
  if not Result then exit;
  Result:=Items[0].HasOneCellOnly;
end;

function  TAlxdSpreadSheetSelectionsInt.HasText: boolean;
var
  i: integer;
begin
  Result:=False;
  for i := 0 to Count - 1 do
    if Items[i].HasText then
    begin
      Result:=True;
      exit;
    end;
end;

function  TAlxdSpreadSheetSelectionsInt.HorPosDelta: TPtArray;
var
  i: integer;
begin
  SetLength(Result, Count);
  for i := 0 to Count - 1 do
    Result[i]:=Items[i].HorPosDelta;

  SortArray(Result);
end;

function  TAlxdSpreadSheetSelectionsInt.VerPosDelta: TPtArray;
var
  i: integer;
begin
  SetLength(Result, Count);
  for i := 0 to Count - 1 do
    Result[i]:=Items[i].VerPosDelta;

  SortArray(Result);
end;

function  TAlxdSpreadSheetSelectionsInt.FindSelectionByCell(ACol, ARow: integer): integer;
var
  i: integer;
begin
  Result:=-1;
  for i := 0 to Count - 1 do
    if Items[i].HasCell(ACol, ARow) then
    begin
      Result:=i;
      break;
    end;
end;

function  TAlxdSpreadSheetSelectionsInt.TabCell(ACell: TPoint; AReverse: boolean = false): TPoint;
var
  i: integer;
  pt: TPoint;
  tmpSelection: TAlxdSpreadSheetSelectionInt;
begin
  Result:=Point(-1, -1);

  if HasOneCellOnly then
  begin
    tmpSelection:=TAlxdSpreadSheetSelectionInt.Create(Self);
    try
      tmpSelection.SelectionRect:=Rect(0, 0, (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.ColCountInt-1, (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt-1);
      tmpSelection.SelectionType:=stUsually;
      pt:=tmpSelection.TabCell(ACell, AReverse);

      if PointsEqual(pt, Point(-1, -1)) then
        if AReverse then
          pt:=tmpSelection.SelectionRect.BottomRight
        else
          pt:=tmpSelection.SelectionRect.TopLeft;

      Result:=pt;
    finally
      tmpSelection.Free;
    end;
  end
  else
  begin
    for i := 0 to Count - 1 do
    begin
      pt:=Items[i].TabCell(ACell, AReverse);
      if not PointsEqual(pt, Point(-1, -1)) then
      begin
        Result:=pt;
        break;
      end;
    end;

    if PointsEqual(pt, Point(-1, -1)) then
    begin
      i:=FindSelectionByCell(ACell.X, ACell.Y);
      if i >= 0 then
        if AReverse then
        begin
          if i > 0 then
            pt:=Items[i-1].SelectionRect.BottomRight
          else
            pt:=Items[Count-1].SelectionRect.BottomRight;
          //pt:=Items[Count-1].SelectionRect.BottomRight
        end
        else
        begin
          if i < Count -1 then
            pt:=Items[i+1].SelectionRect.TopLeft
          else
            pt:=Items[0].SelectionRect.TopLeft;
        end;
      Result:=pt;
    end;
  end;
end;

function  TAlxdSpreadSheetSelectionsInt.Find(AShow: boolean = false): boolean;
var
  tmpSelection: TAlxdSpreadSheetSelectionInt;
  ass: TAlxdSpreadSheetInt;
  i: integer;
begin
  Result:=False;
  ass:=(Owner as TAlxdSpreadSheetInt);

  if HasOneCellOnly then
  begin
    tmpSelection:=TAlxdSpreadSheetSelectionInt.Create(Self);
    try
      tmpSelection.SelectionRect:=Rect(0, 0, ass.AlxdSpreadSheetArray.ColCountInt-1, ass.AlxdSpreadSheetArray.RowCountInt-1);
      tmpSelection.SelectionType:=stUsually;

      with FvarOptions do
      if PointsEqual(FindCell, Point(-1, -1)) then
        FindCell:=Point(0, 0)
      else
        FindCell:=CurrentCell.SelectionCell;

      Result:=tmpSelection.Find;

      if Result then
      begin
        if AShow then
        with FvarOptions do
        begin
          CurrentCell.SelectionRect:=Rect(FindCell, FindCell);
          CurrentCell.SelectionCell:=Point(CurrentCell.SelectionCell.X, CurrentCell.SelectionRect.Top);

          LastSelectedCell.Assign(CurrentCell);
          Items[0].Assign(CurrentCell);

          with ass do
          begin
            EditorMode:=True;
            SendMessage(EditorHandle, EM_SETSEL, FindPos-1, FindPos + FindLen - 1);
          end;
        end;
      end;

    finally
      tmpSelection.Free;
    end;
  end
  else
  begin
    with FvarOptions do
    if PointsEqual(FindCell, Point(-1, -1)) then
    begin
      FindCell:=Point(Items[0].Left, Items[0].Top);
      i:=0;
    end
    else
    begin
      FindCell:=CurrentCell.SelectionCell;
      i:=FindSelectionByCell(FindCell.X, FindCell.Y);
    end;

    while i < Count do
    begin
      Result:=Items[i].Find;
      if Result then
      begin
        if AShow then
        with FvarOptions do
        begin
          CurrentCell.SelectionRect:=Rect(FindCell, FindCell);
          with ass do
          begin
            EditorMode:=True;
            SendMessage(EditorHandle, EM_SETSEL, FindPos-1, FindPos + FindLen - 1);
          end;
        end;//AShow
      end;//Result
      Inc(i);
    end;//while

  end;
end;

procedure TAlxdSpreadSheetSelectionsInt.Join(KeepText: boolean);
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Items[i].Join(KeepText);

  Update;
  (Owner as TAlxdSpreadSheetInt).AlxdUndo.Fix;
end;

procedure TAlxdSpreadSheetSelectionsInt.JoinByRow(KeepText: boolean);
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Items[i].JoinByRow(KeepText);

  Update;
  (Owner as TAlxdSpreadSheetInt).AlxdUndo.Fix;
end;

procedure TAlxdSpreadSheetSelectionsInt.JoinByColumn(KeepText: boolean);
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Items[i].JoinByColumn(KeepText);

  Update;
  (Owner as TAlxdSpreadSheetInt).AlxdUndo.Fix;
end;

procedure TAlxdSpreadSheetSelectionsInt.Disjoin;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Items[i].Disjoin;

  Update;
  (Owner as TAlxdSpreadSheetInt).AlxdUndo.Fix;
end;

function  TAlxdSpreadSheetSelectionsInt.Update: boolean;
var
  i: integer;
begin
  Result:=False;
  for i := 0 to Count - 1 do
    Result:=Result or Items[i].Update;


  CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionCell, CurrentCell.SelectionCell);
  CurrentCell.Update;

  LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionCell, LastSelectedCell.SelectionCell);
  LastSelectedCell.Update;

  //FCurrentCell.Update;
  //FLastSelectedCell.Update;
end;

procedure TAlxdSpreadSheetSelectionsInt.FillOutByFormula(AFormula: WideString);
var
  r: TRegExpr;
  i: integer;
begin
  r:=TRegExpr.Create;
  try
    r.Expression:='(\$??[A-Za-z]+\$??[0-9]+:\$??[A-Za-z]+\$??[0-9]+)|(\$??[A-Za-z]+\$??[0-9]+)';
    i:=0;
    if r.Exec(AFormula) then
    repeat
      if i >= Count then
        Add;

      Items[i].Formula:=r.Match[0];
      Inc(i);
    until not r.ExecNext;

    while Count > i do
      Delete(Count - 1);
  finally
    r.Free;
  end;
end;

function  TAlxdSpreadSheetSelectionsInt.FindByFormula(AFormula: WideString): integer;
var
  i: integer;
begin
  Result:=-1;
  for i := 0 to Count - 1 do
    if CompareText(AFormula, Items[i].Formula) = 0 then
    begin
      Result:=i;
      break;
    end;
end;

function  TAlxdSpreadSheetSelectionsInt.ColorByIndex(Index: integer): integer;
var
  i: integer;
begin
  Result:=clBlack;
  if (Index < 0) or (Index > Count)  then
    exit;

  i:=Index div High(AlxdSelectionColors);
  i:=High(AlxdSelectionColors) * i;
  i:=Index - i;
  Result:=AlxdSelectionColors[i];
//7 colors
//AlxdSelectionColors
end;

procedure TAlxdSpreadSheetSelectionsInt.CutToClipboard;
begin
  CopyToClipboard;
  (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Cells.ClearAll;
end;

procedure TAlxdSpreadSheetSelectionsInt.CopyToClipboard;
var
  ws: WideString;
begin
  if HasText then
  begin
    OpenClipboard(Application.Handle);
    try
      EmptyClipboard;

      SaveAsMText(ws);
      ClipboardSetBuffer(CF_UNICODETEXT, PWideChar(ws)^, Length(ws) * 2 + 2);
      SaveAsXML(ws);
      ClipboardSetBuffer(CF_AXML, PWideChar(ws)^, Length(ws) * 2 + 2);

    finally
      CloseClipboard;
    end;
  end;
end;

procedure TAlxdSpreadSheetSelectionsInt.PasteFromClipboard;

begin
  OpenClipboard(Application.Handle);

  try
    if IsClipboardFormatAvailable(CF_AXML) then
      PasteAsCF_AXML
    else
    if IsClipboardFormatAvailable(CF_UNICODETEXT) then
      PasteAsCF_UNICODETEXT;

  finally
    CloseClipboard;
  end;
end;

procedure TAlxdSpreadSheetSelectionsInt.PasteSpecialFromClipboard;
var
  FAlxdPasteSpecial: TAlxdPasteSpecial;
  hr: integer;
  hi: integer;
  s: string;
begin

  FAlxdPasteSpecial:=TAlxdPasteSpecial.Create(FfrmEditor);
  try
    s:='ATable format|ATable format';//MessageMemIniFile(532);
    FAlxdPasteSpecial.AddFormat(CF_AXML, GetShortHint(s), GetLongHint(s), 0{OLEUIPASTE_PASTEONLY});
    s:=MessageMemIniFile(531);
    FAlxdPasteSpecial.AddFormat(CF_UNICODETEXT, GetShortHint(s), GetLongHint(s), 0);
    s:=MessageMemIniFile(530);
    FAlxdPasteSpecial.AddFormat(CF_TEXT, GetShortHint(s), GetLongHint(s), 0);

    hr:=FAlxdPasteSpecial.DoModal;
    hi:=FAlxdPasteSpecial.SelectedIndex;
  finally
    FAlxdPasteSpecial.Free;
  end;

  if hr = 1 then
  try
    OpenClipboard(Application.Handle);
    case hi of
    0: PasteAsCF_AXML;
    1: PasteAsCF_UNICODETEXT;
    2: PasteAsCF_UNICODETEXT;
    //2: PasteFromClipboard_CF_TEXT;
    end;
  finally
    CloseClipboard;
  end;
end;

procedure TAlxdSpreadSheetSelectionsInt.PasteAsCF_AXML;
var
  ws: string;
  Data: THandle;
begin
  Data:=GetClipboardData(CF_AXML);
  if Data <> 0 then
  try
    ws:=PWideChar(GlobalLock(Data));
    LoadAsXML(ws);
  finally
    GlobalUnlock(Data);
  end;
end;

procedure TAlxdSpreadSheetSelectionsInt.PasteAsCF_UNICODETEXT;
var
  ws: string;
  Data: THandle;
begin
  Data:=GetClipboardData(CF_UNICODETEXT);
  if Data <> 0 then
  try
    ws:=PWideChar(GlobalLock(Data));
    LoadAsMText(ws);
  finally
    GlobalUnlock(Data);
  end;
end;

function  TAlxdSpreadSheetSelectionsInt.SaveAsMText(var AValue: WideString): boolean;
var
//  ass: TAlxdSpreadSheetInt;
  k: integer;
begin
  AValue:='';
  for k := 0 to Count - 1 do
  begin
    if k > 0 then
      AValue:=AValue + #13#10;
    (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Cells.WriteToMText(AValue, Items[k].SelectionRect);
  end;
end;

function  TAlxdSpreadSheetSelectionsInt.LoadAsMText(AValue: WideString): boolean;
var
  i: integer;
  d, e: integer;
  tempselection: TAlxdSpreadSheetSelectionInt;
begin
  Result:=False;
  tempselection:=TAlxdSpreadSheetSelectionInt.Create(Self);
  try
    tempselection.ReadFromMText(AValue);

    for i := 0 to Count - 1 do
    begin
      e:=Items[i].Left + tempselection.Right - tempselection.Left;
      if e > (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.ColCountInt - 1 then
        (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.ColCountInt:=e + 1;
      Items[i].Right:=e;

      d:=Items[i].Top + tempselection.Bottom - tempselection.Top;
      if d > (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt - 1 then
        (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt:=d + 1;
      Items[i].Bottom:=d;
      Items[i].Update;
      Items[i].Disjoin;

      Items[i].Right:=e;
      Items[i].Bottom:=d;
      Items[i].Update;
      //раскидывание текста
      (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Cells.ReadFromMText(AValue, Items[i].SelectionRect);
    end;
    Result:=True;
  finally
    tempselection.Free;
  end;
end;

function  TAlxdSpreadSheetSelectionsInt.SaveAsXML(var AValue: WideString): boolean;
var
  doc: IXMLDocument;
begin
  doc:=TXMLDocument.Create(nil) as IXMLDocument;
  try
    doc.Active:=true;
    doc.Encoding := 'UTF-8';

    WriteToXML(doc.Node);

    doc.SaveToXML(AValue);
    Result:=true;
  except
    on E:Exception do
    begin
      //AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function  TAlxdSpreadSheetSelectionsInt.LoadAsXML(AValue: WideString): boolean;
var
  doc: IXMLDocument;
  n: IXMLNode;
begin
  doc:=TXMLDocument.Create(nil) as IXMLDocument;
  try
    doc.LoadFromXML(AValue);

    n:=doc.Node;
    ReadFromXML(n);

    Result:=true;
  except
    on E:Exception do
    begin
      //AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function  TAlxdSpreadSheetSelectionsInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  Result:=False;
  try
    Sort;

    root:=ADoc.AddChild(AlxdSelectionsRoot);

    //write properties
    for i := 0 to High(AlxdSelectionsPropValues) do
    begin
      node:=root.AddChild(AlxdSelectionsPropValues[i]);
      node.NodeValue:=GetPropValue(Self, AlxdSelectionsPropValues[i]);
    end;

    for i := 0 to Count - 1 do
    begin
      node:=root.AddChild(AlxdSelectionRoot);
      Items[i].WriteToXML(node);

      (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Cells.WriteToXML(node, Items[i].SelectionRect);
      //(Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Fills.WriteToXML(node, Items[i].SelectionRect);
      //(Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray..WriteToXML(node, Items[i].SelectionRect);
    end;

    //write content
    //(Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Cells.WriteToXML(root, Items[i].SelectionRect);
    Result:=True;
  except
    on E:Exception do
    begin
      AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function  TAlxdSpreadSheetSelectionsInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  c, i, j, d, e: integer;
  rt: TRect;
  tempselection: TAlxdSpreadSheetSelectionInt;
  b: boolean;
begin
  try
    root:=ADoc.ChildNodes.FindNode(AlxdSelectionsRoot);
    if root = nil then
      raise EXMLDocError.Create('');

    //read properties
    node:=root.ChildNodes.FindNode(AlxdSelectionsPropValues[0]);
    c:=node.NodeValue;

    b:=(Count < c);
    while Count < c do
      Self.Add;

    node:=root.ChildNodes.FindNode(AlxdSelectionRoot);
    for i := 0 to Count - 1 do
    begin
      tempselection:=TAlxdSpreadSheetSelectionInt.Create(Self);
      try
        tempselection.ReadFromXML(node);
        if b and (i >= c - 1) then
        begin
          Items[i].Assign(Items[i-1]);
          //hor displacement
          e:=Items[i].Left + tempselection.Left - rt.Left;
          if e > (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.ColCountInt - 1 then
            (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.ColCountInt:=e + 1;
          //ver displacement
          //d:=Items[i].Bottom - Items[i].Top + 1;
          d:=Items[i].Top + tempselection.Top - rt.Top;
          if d > (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt - 1 then
            (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt:=d + 1;
          Items[i].Offset(e, d);
        end;

        e:=Items[i].Left + tempselection.Right - tempselection.Left;
        if e > (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.ColCountInt - 1 then
          (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.ColCountInt:=e + 1;
        Items[i].Right:=e;

        d:=Items[i].Top + tempselection.Bottom - tempselection.Top;
        if d > (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt - 1 then
          (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.RowCountInt:=d + 1;
        Items[i].Bottom:=d;
        Items[i].Update;
        Items[i].Disjoin;

        Items[i].Right:=e;
        Items[i].Bottom:=d;
        Items[i].Update;

        (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Cells.ReadFromXML(node, Items[i].SelectionRect);

         rt:=tempselection.SelectionRect;
      finally
        tempselection.Free;
      end;
      
      node:=node.NextSibling;
      if node = nil then
        node:=root.ChildNodes.FindNode(AlxdSelectionRoot);
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

constructor TAlxdSpreadSheetSelectionsInt.Create(AOwner: TComponent);
begin
  inherited;
  FAlxdSpreadSheetSelectionsInts:=TList.Create;
{  FCurrentCell:=Point(0, 0);
  FCurrentRect:=Rect(0, 0, 0, 0);
  FLastSelectedCell:=Point(0, 0);
  FLastSelectedRect:=Rect(0, 0, 0, 0);}
  FCurrentCell:=TAlxdSpreadSheetSelectionInt.Create(Self);
  FLastSelectedCell:=TAlxdSpreadSheetSelectionInt.Create(Self);
//  FLastSelectedCell:=TAlxdSpreadSheetSelectionInt.Create(Self);

  //Add;
  FAlxdSpreadSheetSelections:=TAlxdSpreadSheetSelections.Create(Self);
end;

destructor  TAlxdSpreadSheetSelectionsInt.Destroy;
begin
  FLastSelectedCell.Free;
  FCurrentCell.Free;
  FAlxdSpreadSheetSelectionsInts.Free;
  inherited;
end;

end.
