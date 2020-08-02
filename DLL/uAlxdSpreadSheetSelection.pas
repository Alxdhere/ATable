unit uAlxdSpreadSheetSelection;

interface

uses
  SysUtils,
  Windows, Classes, TypInfo, XMLDoc, XMLIntf,
  uAlxdSystem, uAlxdSpreadSheetArray, uAlxdOptions, TntClasses, RegExpr,
  xAlxdSpreadSheetSelection, AlxdGrid_TLB;

const
  AlxdSelectionRoot = 'AlxdSelection';
  AlxdSelectionPropValues: array[0..4] of string = ('Left', 'Top', 'Right', 'Bottom', 'SelectionType');

type
  TAlxdSpreadSheetSelectionInt = class(TComponent, IAlxdSpreadSheetSelection)
  private
    FAlxdSpreadSheetSelection: IAlxdSpreadSheetSelection;
    //FIsColSelection: boolean;
    //FIsRowSelection:
    FSelectionCell: TPoint;
    FSelectionRect: TRect;
    FAlxdSelectionType: TAlxdSelectionType;
    FAlxdSpreadSheetArray: TAlxdSpreadSheetArray;

    procedure Set_Left(Value: integer);
    procedure Set_Top(Value: integer);
    procedure Set_Right(Value: integer);
    procedure Set_Bottom(Value: integer);
    procedure Set_SelectionCell(Value: TPoint);
    procedure Set_SelectionRect(Value: TRect);
    procedure Set_SelectionType(Value: TAlxdSelectionType);

    procedure MakeCellLeft2RightArray(ACell: TPoint; var SelArr: TPtArray; var Index: integer);
    procedure MakeCellTop2BottomArray(ACell: TPoint; var SelArr: TPtArray; var Index: integer);

    function  Get_Formula: WideString;
    procedure Set_Formula(Value: WideString);

  public
    property  Intf: IAlxdSpreadSheetSelection read FAlxdSpreadSheetSelection implements IAlxdSpreadSheetSelection;

    function  NearestCell(ACell: TPoint): TPoint;
    procedure Offset(dx, dy: integer);

    function  PaintSize: TRect;

    function  HasColumn(ACol: integer; CheckType: boolean = false): boolean;
    function  HasRow(ARow: integer; CheckType: boolean = false): boolean;
    function  HasCell(ACol, ARow: integer): boolean;
    function  HasText: boolean;
    function  HasOneCellOnly: boolean;

    function  HorPosDelta: TPoint;
    function  VerPosDelta: TPoint;

    function  TabCell(ACell: TPoint; AReverse: boolean = false): TPoint;

    procedure Join(KeepText: boolean = false);
    procedure JoinByRow(KeepText: boolean = false);
    procedure JoinByColumn(KeepText: boolean = false);
    procedure Disjoin;
    procedure MakeFromDrawingPoint(x, y: double);
    function  Equal(Value: TAlxdSpreadSheetSelectionInt): boolean;
    function  Update: boolean;


    function  Find: boolean;
//    function  FindNext: boolean;

    property  Formula: WideString read Get_Formula write Set_Formula;

    //function  CutAsXML(ADoc: IXMLNode): boolean;
    //function  CopyAsXML: WideString;
    //function  PasteAsXML(ADoc: IXMLNode): boolean;

    //function  WriteRangeToXML(ADoc: IXMLNode): boolean;
    //function  ReadRangeFromXML(ADoc: IXMLNode): boolean;

//    function  SaveToXML(AFileName: WideString): boolean;
//    function  LoadFromXML(AFileName: WideString): boolean;

//    function  SaveAsXML(var AValue: WideString): boolean;
//    function  LoadAsXML(AValue: WideString): boolean;
    function  ReadFromMText(AValue: WideString): boolean;

    function  WriteToXML(ADoc: IXMLNode): boolean;
    function  ReadFromXML(ADoc: IXMLNode): boolean;

    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    property  Left: integer read FSelectionRect.Left write Set_Left;
    property  Top: integer read FSelectionRect.Top write Set_Top;
    property  Right: integer read FSelectionRect.Right write Set_Right;
    property  Bottom: integer read FSelectionRect.Bottom write Set_Bottom;
    property  SelectionCell: TPoint read FSelectionCell write Set_SelectionCell;
    property  SelectionRect: TRect read FSelectionRect write Set_SelectionRect;
    property  SelectionType: TAlxdSelectionType read FAlxdSelectionType write Set_SelectionType;
  end;

  function  Formula2Cell(AFormula: WideString; var ACell: TCellCoord): boolean;
  function  Cell2Formula(ACell: TCellCoord; var AFormula: WideString): boolean;

implementation

uses
  uAlxdEditor, uAlxdCell, uAlxdSpreadSheetSelections, uAlxdSpreadSheet;

procedure UpdateRect(var R: TRect);
begin
  with R do
  begin
    if (Left >= Right) then
      Exchange(Right, Left);
    if (Top >= Bottom) then
      Exchange(Top, Bottom);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdSpreadSheetSelectionInt.Set_Left(Value: integer);
begin
  FSelectionRect.Left:=Value;
  FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
end;

procedure TAlxdSpreadSheetSelectionInt.Set_Top(Value: integer);
begin
  FSelectionRect.Top:=Value;
  FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
end;

procedure TAlxdSpreadSheetSelectionInt.Set_Right(Value: integer);
begin
  FSelectionRect.Right:=Value;
  FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
end;

procedure TAlxdSpreadSheetSelectionInt.Set_Bottom(Value: integer);
begin
  FSelectionRect.Bottom:=Value;
  FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
end;

procedure TAlxdSpreadSheetSelectionInt.Set_SelectionCell(Value: TPoint);
begin
  FSelectionCell:=Value;
end;

procedure TAlxdSpreadSheetSelectionInt.Set_SelectionRect(Value: TRect);
begin
  UpdateRect(Value);

  if not EqualRect(FSelectionRect, Value) then
  begin
    FSelectionRect:=Value;
    Update;
  end;

  FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
end;

procedure TAlxdSpreadSheetSelectionInt.Set_SelectionType(Value: TAlxdSelectionType);
begin
  if FAlxdSelectionType <> Value then
  begin
    FAlxdSelectionType:=Value;
    Update;
  end;
  
  FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
end;

procedure TAlxdSpreadSheetSelectionInt.MakeCellLeft2RightArray(ACell: TPoint; var SelArr: TPtArray; var Index: integer);
var
  i, j: integer;
  l: integer;
begin
  l:=0;
  Index:=-1;
    for j:=SelectionRect.Top to SelectionRect.Bottom do
      for i:=SelectionRect.Left to SelectionRect.Right do
        //if not isJoinedCell(Point(i, j)) then
        if not FAlxdSpreadSheetArray.Cells.Items[i, j].IsJoinedCell then
        begin
          Inc(l);
          SetLength(SelArr, l);
          SelArr[l-1]:=Point(i, j);
          if PointsEqual(ACell, Point(i, j)) then Index:=l-1;
        end;
end;

procedure TAlxdSpreadSheetSelectionInt.MakeCellTop2BottomArray(ACell: TPoint; var SelArr: TPtArray; var Index: integer);
var
  i, j: integer;
  l: integer;
begin
  l:=0;
  Index:=-1;
    for i:=SelectionRect.Left to SelectionRect.Right do
      for j:=SelectionRect.Top to SelectionRect.Bottom do
        //if not isJoinedCell(Point(i, j)) then
        if not FAlxdSpreadSheetArray.Cells.Items[i, j].IsJoinedCell then
        begin
          Inc(l);
          SetLength(SelArr, l);
          SelArr[l-1]:=Point(i, j);
          if PointsEqual(ACell, Point(i, j)) then Index:=l-1;
        end;
end;

function  Formula2Cell(AFormula: WideString; var ACell: TCellCoord): boolean;
var
  i: integer;
  code: integer;
  r: TRegExpr;
  //w: WideString;
begin
  Result:=false;
  r:=TRegExpr.Create;
  try
    //r.Expression:='^(\$?)([A-Za-z]+)(\$?)([0-9]+)$';
    r.Expression:='(\$??)([A-Za-z]+?)(\$??)([0-9]+?)';
    if r.Exec(AFormula) then
      for i := 1 to r.SubExprMatchCount do
      case i of
      1:
        ACell.Xconst:=(r.Match[i] = '$');
      2:
        begin
          ACell.Cell.X:=StringToNum(r.Match[i]);
          Dec(ACell.Cell.X);
        end;
      3:
        ACell.Yconst:=(r.Match[i] = '$');
      4:
        begin
          Val(r.Match[i], ACell.Cell.Y, code);
          Dec(ACell.Cell.Y);
        end;
      end;
      Result:=True;
  finally
    r.Free;
  end;
end;

function  Cell2Formula(ACell: TCellCoord; var AFormula: WideString): boolean;
begin
  Result:=False;

  if (ACell.Cell.X < 0) and (ACell.Cell.Y < 0) then exit;

  AFormula:='';
  if ACell.Xconst then
    AFormula:='$';

  if ACell.Cell.X >= 0 then
    AFormula:=AFormula + NumToString(ACell.Cell.X + 1)
  else
    AFormula:=AFormula + '?';

  if ACell.Yconst then
    AFormula:=AFormula + '$';

  if ACell.Cell.Y >= 0 then
    AFormula:=AFormula + IntToStr(ACell.Cell.Y + 1)
  else
    AFormula:=AFormula + '?';

  Result:=true;
end;

function  TAlxdSpreadSheetSelectionInt.Get_Formula: WideString;
var
  c: TCellCoord;
  w, q: WideString;
begin
  w:='';
  c.Xconst := false;
  c.Yconst := false;  
  if RectIsPt(FSelectionRect) or HasOneCellOnly then
  begin
    c.Cell:=FSelectionRect.TopLeft;
    Cell2Formula(c, w);
  end
  else
  begin
    c.Cell:=FSelectionRect.TopLeft;
    Cell2Formula(c, w);
    c.Cell:=FSelectionRect.BottomRight;
    Cell2Formula(c, q);
    w:=w + ':' + q;
  end;

  Result:=w;
end;

procedure TAlxdSpreadSheetSelectionInt.Set_Formula(Value: WideString);
var
  r: TRegExpr;
  i: integer;
  c: TCellCoord;
begin
  r:=TRegExpr.Create;
  try
    //r.Expression:='(\$?[A-Za-z]+\$?[0-9]+:\$?[A-Za-z]+\$?[0-9]+)|(\$?[A-Za-z]+\$?[0-9]+)';
    r.Expression:='(\$??[A-Za-z]+\$??[0-9]+)';
    i:=0;
    if r.Exec(Value) then
    repeat
      c.Cell.X:=0;
      c.Cell.Y:=0;      
      if i = 0 then
      begin
        Formula2Cell(r.Match[0], c);
        FSelectionRect.TopLeft:=c.Cell;
        FSelectionRect.BottomRight:=c.Cell;
      end;

      if i = 1 then
      begin
        Formula2Cell(r.Match[0], c);
        FSelectionRect.BottomRight:=c.Cell;
      end;
      Inc(i);
    until not r.ExecNext;
    Update;
  finally
    r.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdSpreadSheetSelectionInt.NearestCell(ACell: TPoint): TPoint;
begin
  Result:=ACell;
  with FSelectionRect do
  begin
    if Result.X > Right then
      Result.X:=Right
    else
    if Result.X < Left then
      Result.X:=Left;

    if Result.Y < Top then
      Result.Y:=Top
    else
    if Result.Y > Bottom then
      Result.Y:=Bottom;
  end;
end;

procedure TAlxdSpreadSheetSelectionInt.Offset(dx, dy: integer);
var
  tmp: TRect;
  src: TRect;
begin
  src:=SelectionRect;
  tmp:=src;
  //OffsetRect(temp, ATarget.X - ASource.X, ATarget.Y - ASource.Y);
  OffsetRect(tmp, dx, dy);
  SelectionRect:=tmp;

  //FSelectionCell.X:=FSelectionCell.X + tmp.Left - src.Left;
  //FSelectionCell.Y:=FSelectionCell.Y + tmp.Top - src.Top;
end;

function  TAlxdSpreadSheetSelectionInt.PaintSize: TRect;
begin
  Result.Left:=FAlxdSpreadSheetArray.Columns.PaintDeltaSize(0, Left);
  Result.Top:=FAlxdSpreadSheetArray.Rows.PaintDeltaSize(0, Top);

  Result.Right:=Result.Left + FAlxdSpreadSheetArray.Columns.PaintDeltaSize(Left, Right - Left + 1);
  Result.Bottom:=Result.Top + FAlxdSpreadSheetArray.Rows.PaintDeltaSize(Top, Bottom - Top + 1);
end;

function  TAlxdSpreadSheetSelectionInt.HasColumn(ACol: integer; CheckType: boolean): boolean;
begin
  if CheckType then
    Result:=(ACol >= FSelectionRect.Left) and (ACol <= FSelectionRect.Right) and (FAlxdSelectionType = stColumn)
  else
    Result:=(ACol >= FSelectionRect.Left) and (ACol <= FSelectionRect.Right);
end;

function  TAlxdSpreadSheetSelectionInt.HasRow(ARow: integer; CheckType: boolean): boolean;
begin
  if CheckType then
    Result:=(ARow >= FSelectionRect.Top) and (ARow <= FSelectionRect.Bottom) and (FAlxdSelectionType = stRow)
  else
    Result:=(ARow >= FSelectionRect.Top) and (ARow <= FSelectionRect.Bottom);
end;

function  TAlxdSpreadSheetSelectionInt.HasCell(ACol, ARow: integer): boolean;
begin
  Result:=HasColumn(ACol) and HasRow(ARow);
end;

function  TAlxdSpreadSheetSelectionInt.HasText: boolean;
var
  i, j: integer;
begin
  Result:=False;

  for i := FSelectionRect.Left to FSelectionRect.Right do
    for j := FSelectionRect.Top to FSelectionRect.Bottom do
      if FAlxdSpreadSheetArray.Cells.Items[i, j].Contain <> '' then
      begin
        Result:=True;
        exit;
      end;
end;

function  TAlxdSpreadSheetSelectionInt.HasOneCellOnly: boolean;
var
  j: TAlxdJoined;
begin
  j:=FAlxdSpreadSheetArray.Cells.Items[FSelectionRect.Left, FSelectionRect.Top].Joined;
  Result:=(FSelectionRect.Right = FSelectionRect.Left + j.Cols) and (FSelectionRect.Bottom = FSelectionRect.Top + j.Rows);
end;

function  TAlxdSpreadSheetSelectionInt.HorPosDelta: TPoint;
begin
  Result:=Point(FSelectionRect.Left, FSelectionRect.Right - FSelectionRect.Left);
end;

function  TAlxdSpreadSheetSelectionInt.VerPosDelta: TPoint;
begin
  Result:=Point(FSelectionRect.Top, FSelectionRect.Bottom - FSelectionRect.Top);
end;

function  TAlxdSpreadSheetSelectionInt.TabCell(ACell: TPoint; AReverse: boolean = false): TPoint;
var
  sa: TPtArray;
  l: integer;
begin
  Result:=Point(-1, -1);

  if Self.HasCell(ACell.X, ACell.Y) then
  begin
    //left or right
    if FvarOptions.DirectionTab = dtLeft2Right then
      MakeCellLeft2RightArray(ACell, sa, l)
    else
    //top or bottom
      MakeCellTop2BottomArray(ACell, sa, l);

    if High(sa) = -1 then exit;

    if AReverse then
    begin
      if (l = 0) then exit;
      Result:=sa[l-1];
    end
    else
    begin
      if (l = High(sa)) then exit;
      Result:=sa[l+1];
    end;
  end;
end;

procedure TAlxdSpreadSheetSelectionInt.Join(KeepText: boolean);
begin
  FAlxdSpreadSheetArray.JoinCellInRect(FSelectionRect, KeepText);
//  Update;
end;

procedure TAlxdSpreadSheetSelectionInt.JoinByRow(KeepText: boolean);
var
  j: integer;
  r: TRect;
begin
  with FSelectionRect do
    for j := Top to Bottom do
    begin
      r:=Rect(Left, j, Right, j);
      FAlxdSpreadSheetArray.JoinCellInRect(r, KeepText);
    end;
//  Update;
end;

procedure TAlxdSpreadSheetSelectionInt.JoinByColumn(KeepText: boolean);
var
  i: integer;
  r: TRect;
begin
  with FSelectionRect do
    for i := Left to Right do
    begin
      r:=Rect(i, Top, i, Bottom);
      FAlxdSpreadSheetArray.JoinCellInRect(r, KeepText);
    end;
//  Update;
end;

procedure TAlxdSpreadSheetSelectionInt.Disjoin;
begin
  FAlxdSpreadSheetArray.UnjoinCellInRect(FSelectionRect);
//  Update;
end;

procedure TAlxdSpreadSheetSelectionInt.MakeFromDrawingPoint(x, y: double);
var
  i: integer;
  tcell: TPoint;
begin
  tcell:=Point(0, 0);
  with FAlxdSpreadSheetArray do
  begin
    //OutputDebugString(PChar(Format('MakeFromDrawingPoint : %f', [Columns.Items[0].Coord])));
    //OutputDebugString(PChar(Format('MakeFromDrawingPoint : %f', [Columns.Items[1].Coord])));
    //OutputDebugString(PChar(Format('MakeFromDrawingPoint : %f', [Columns.Items[2].Coord])));

    for i := 0 to Columns.Count - 1 do
    begin
      tcell.x:=i;
      with Columns.Items[i] do
      //if (x >= Coord) and (x <= Coord + DrawingSize) then
        if (x <= Coord + DrawingSize) then
          break;
    end;

    for i := 0 to Rows.Count - 1 do
    begin
      tcell.y:=i;
      with Rows.Items[i] do
      //if (y <= Coord) {and (y >= Coord - DrawingSize)} then
        if (y >= Coord - DrawingSize) then
          break;
    end;

    FSelectionRect:=Rect(tcell.x, tcell.y, tcell.x, tcell.y);
    FAlxdSelectionType:=stUsually;
    Update;

  end;
end;

function  TAlxdSpreadSheetSelectionInt.Equal(Value: TAlxdSpreadSheetSelectionInt): boolean;
begin
  Result:=EqualRect(Value.SelectionRect, Self.SelectionRect) and (Value.SelectionType = Self.SelectionType);
end;

function  TAlxdSpreadSheetSelectionInt.Update: boolean;
var
  ready: boolean;
  i, j: integer;
  k: TAlxdJoined;
begin
  with FSelectionRect do
  begin
    if Left < 0 then Left:=0;
    if Top < 0 then Top:=0;
    if Right < 0 then Right:=0;
    if Bottom < 0 then Bottom:=0;

    if Left > FAlxdSpreadSheetArray.ColCountInt-1 then Left:=FAlxdSpreadSheetArray.ColCountInt-1;
    if Top > FAlxdSpreadSheetArray.RowCountInt-1 then Top:=FAlxdSpreadSheetArray.RowCountInt-1;
    if Right > FAlxdSpreadSheetArray.ColCountInt-1 then Right:=FAlxdSpreadSheetArray.ColCountInt-1;
    if Bottom > FAlxdSpreadSheetArray.RowCountInt-1 then Bottom:=FAlxdSpreadSheetArray.RowCountInt-1;
  end;

  if FAlxdSelectionType = stAll then
    if (FSelectionRect.Left <> 0) or
       (FSelectionRect.Right <> FAlxdSpreadSheetArray.ColCountInt-1) or
       (FSelectionRect.Top <> 0) or
       (FSelectionRect.Bottom <> FAlxdSpreadSheetArray.RowCountInt-1) then
    begin
      FSelectionRect.Left:=0;
      FSelectionRect.Right:=FAlxdSpreadSheetArray.ColCountInt-1;
      FSelectionRect.Top:=0;
      FSelectionRect.Bottom:=FAlxdSpreadSheetArray.RowCountInt-1;
      Result:=True;
    end;

  if FAlxdSelectionType = stRow then
    if (FSelectionRect.Left <> 0) or (FSelectionRect.Right <> FAlxdSpreadSheetArray.ColCountInt-1) then
    begin
      FSelectionRect.Left:=0;
      FSelectionRect.Right:=FAlxdSpreadSheetArray.ColCountInt-1;
      Result:=True;
      exit;
    end;

  if FAlxdSelectionType = stColumn then
    if (FSelectionRect.Top <> 0) or (FSelectionRect.Bottom <> FAlxdSpreadSheetArray.RowCountInt-1) then
    begin
      FSelectionRect.Top:=0;
      FSelectionRect.Bottom:=FAlxdSpreadSheetArray.RowCountInt-1;
      Result:=True;
      exit;
    end;

  {if FAlxdSelectionType = stUsually then
    with FSelectionRect do
    begin
      if Left < 0 then Left:=0;
      if Top < 0 then Top:=0;
      if Right < 0 then Right:=0;
      if Bottom < 0 then Bottom:=0;

      if Left > FAlxdSpreadSheetArray.ColCountInt-1 then Left:=FAlxdSpreadSheetArray.ColCountInt-1;
      if Top > FAlxdSpreadSheetArray.RowCountInt-1 then Top:=FAlxdSpreadSheetArray.RowCountInt-1;
      if Right > FAlxdSpreadSheetArray.ColCountInt-1 then Right:=FAlxdSpreadSheetArray.ColCountInt-1;
      if Bottom > FAlxdSpreadSheetArray.RowCountInt-1 then Bottom:=FAlxdSpreadSheetArray.RowCountInt-1;
    end;}

  with FSelectionRect do
  begin
    if FSelectionCell.X < Left then FSelectionCell.X := Left;
    if FSelectionCell.X > Right then FSelectionCell.X := Right;
    if FSelectionCell.Y < Bottom then FSelectionCell.Y := Bottom;
    if FSelectionCell.Y > Top then FSelectionCell.Y := Top;
  end;

  ready:=false;

  with FSelectionRect do
    while not ready do
    begin
      ready:=true;
      for i:=Left to Right do
        for j:=Top to Bottom do
        begin
          k:=FAlxdSpreadSheetArray.Cells.Items[i, j].Joined;
          if k.Cols < 0 then
            if Left > i + k.Cols then
            begin
              Left:=i + k.Cols;
              ready:=false;
              break;
            end;
          if k.Cols > 0 then
            if Right < i + k.Cols then
            begin
              Right:=i + k.Cols;
              ready:=false;
              break;
            end;
          if k.Rows < 0 then
            if Top > j + k.Rows then
            begin
              Top:=j + k.Rows;
              ready:=false;
              break;
            end;
          if k.Rows > 0 then
            if Bottom < j + k.Rows then
            begin
              Bottom:=j + k.Rows;
              ready:=false;
              break;
            end;
        end;
    end;

end;

//найти _первое_ удовлетвор€ющее условию вхождение
{function  TAlxdSpreadSheetSelectionInt.Find: boolean;
var
  i, j: integer;
begin
  Result:=False;

  with FvarOptions do
  begin
    FindOffset:=1;
    FindCell:=FSelectionRect.TopLeft;
    FindPos:=0;
    FindLen:=0;
  end;

  with FSelectionRect do
  for i := Left to Right do
    for j := Top to Bottom do
      if FAlxdSpreadSheetArray.Cells.Items[i, j].Contain <> '' then
      begin
        Result:=FAlxdSpreadSheetArray.Cells.Items[i, j].Find;
        if Result then
        with FvarOptions do
        begin
          FindCell:=Point(i, j);
          FindOffset:=FindOffset + 1;
          exit;
        end;
      end;
end;}

function  TAlxdSpreadSheetSelectionInt.Find: boolean;
var
  i, j: integer;
begin
  Result:=False;

  with FSelectionRect do
  begin
    i:=FvarOptions.FindCell.X;
    j:=FvarOptions.FindCell.Y;

    while j <= Bottom do
    begin

      while i <= Right do
      begin
        if FAlxdSpreadSheetArray.Cells.Items[i, j].Contain <> '' then
        with FvarOptions do
        begin
          if not PointsEqual(FindCell, Point(i, j)) then
            FindOffset:=1;

          Result:=FAlxdSpreadSheetArray.Cells.Items[i, j].Find;

          if Result then
          begin
            FindCell:=Point(i, j);
            //FindOffset:=FindOffset + 1;
            FindOffset:=FindPos + FindLen;
            exit;
          end
          else
          begin
            FindOffset:=1;
          end;
        end;//if

        i:=i + 1;
      end;//while i
      i:=0;

      j:=j + 1;
    end;//while j
  end;//with
  FvarOptions.FindCell:=Point(-1, -1);
end;

{
function  TAlxdSpreadSheetSelectionInt.CutAsXML(ADoc: IXMLNode): boolean;
begin

end;

function  TAlxdSpreadSheetSelectionInt.CopyAsXML(ADoc: IXMLNode): boolean;
begin

end;

function  TAlxdSpreadSheetSelectionInt.PasteAsXML(ADoc: IXMLNode): boolean;
begin

end;
}
{
function TAlxdSpreadSheetSelectionInt.SaveToXML(AFileName: WideString): boolean;
var
  doc: IXMLDocument;
begin
  doc:=TXMLDocument.Create(nil) as IXMLDocument;
  try
    doc.Active:=true;
    doc.Encoding := 'UTF-8';

    WriteToXML(doc.Node);

    doc.SaveToFile(AFileName);
    Result:=true;
  except
    on E:Exception do
    begin
      //AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function TAlxdSpreadSheetSelectionInt.LoadFromXML(AFileName: WideString): boolean;
var
  doc: IXMLDocument;
  n: IXMLNode;
begin
  doc:=TXMLDocument.Create(nil) as IXMLDocument;
  try
    doc.LoadFromFile(AFileName);

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
}

function  TAlxdSpreadSheetSelectionInt.ReadFromMText(AValue: WideString): boolean;
var
  sr, sc: TTntStrings;
  i, j: integer;
  ws: WideString;
  dr, dc: integer;
begin
  dr:=0;
  dc:=0;
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
        if dc < sc.Count then
          dc:=sc.Count;
      end;
    finally
      sc.Free
    end;

    dr:=sr.Count;

  finally
    sr.Free;
  end;

  Right:=Left + dc - 1;
  Bottom:=Top + dr - 1;
  //Update;
end;

function  TAlxdSpreadSheetSelectionInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc;//.AddChild(AlxdSelectionRoot);

    //write properties
    for i := 0 to High(AlxdSelectionPropValues) do
    begin
      node:=root.AddChild(AlxdSelectionPropValues[i]);
      node.NodeValue:=GetPropValue(Self, AlxdSelectionPropValues[i]);
    end;

    //write content
    //if content then
    //begin
    //  FAlxdSpreadSheetArray.Cells.WriteToXML(root, FSelectionRect);
    //end;

  except
    on E:Exception do
    begin
      AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function  TAlxdSpreadSheetSelectionInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc;//.ChildNodes.FindNode(AlxdCellRoot);
    //root:=ADoc.ChildNodes.FindNode(AlxdSelectionRoot);
    if root = nil then
      raise EXMLDocError.Create('');
    //FCol:=root.GetAttributeNS('Column', '');
    //FRow:=root.GetAttributeNS('Row', '');
//OutputDebugString(PAnsiChar(string(root.Text)));
    for i := 0 to High(AlxdSelectionPropValues) do
    begin
//OutputDebugString(PAnsiChar(string(AlxdSelectionPropValues[i])));
      //node:=root.ChildNodes.First;
//OutputDebugString(PAnsiChar(string(node.NodeValue)));
      node:=root.ChildNodes.FindNode(AlxdSelectionPropValues[i]);
//OutputDebugString(PAnsiChar(string(node.NodeValue)));

      if node = nil then
        raise EXMLDocError.Create('');
      SetPropValue(Self, AlxdSelectionPropValues[i], node.NodeValue);
    end;
    //FSelectionRect

    //read content
    //if content then
    //begin
    //  FAlxdSpreadSheetArray.Cells.ReadFromXML(root, FSelectionRect);
    //end;

    //FAlxdSpreadSheetArray.Cells.ReadFromXML(root, FSelectionRect);

    Result:=True;
  except
    on E:Exception do
    begin
      AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;
{
function  TAlxdSpreadSheetSelectionInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc.AddChild(AlxdSelectionRoot);
    //root.SetAttributeNS('Column', '', FCol);
    //root.SetAttributeNS('Row', '', FRow);

    //write properties
    for i := 0 to High(AlxdSelectionPropValues) do
    begin
      node:=root.AddChild(AlxdSelectionPropValues[i]);
      node.NodeValue:=GetPropValue(Self, AlxdSelectionPropValues[i]);
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

function  TAlxdSpreadSheetSelectionInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
  node: IXMLNode;
  i: integer;
begin
  try
    root:=ADoc;//.ChildNodes.FindNode(AlxdCellRoot);
    if root = nil then
      raise EXMLDocError.Create('');
    //FCol:=root.GetAttributeNS('Column', '');
    //FRow:=root.GetAttributeNS('Row', '');

    for i := 0 to High(AlxdSelectionPropValues) do
    begin
      node:=root.ChildNodes.FindNode(AlxdSelectionPropValues[i]);
      if node = nil then
        raise EXMLDocError.Create('');
      SetPropValue(Self, AlxdSelectionPropValues[i], node.NodeValue);
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
}
procedure TAlxdSpreadSheetSelectionInt.Assign(Source: TPersistent);
//var
  //needupdate: boolean;
begin
  //needupdate:=not Self.Equal((Source as TAlxdSpreadSheetSelectionInt));
  if Source is TAlxdSpreadSheetSelectionInt then
  begin
    Self.FSelectionCell:=(Source as TAlxdSpreadSheetSelectionInt).SelectionCell;
    Self.FSelectionRect:=(Source as TAlxdSpreadSheetSelectionInt).SelectionRect;
    Self.FAlxdSelectionType:=(Source as TAlxdSpreadSheetSelectionInt).SelectionType;
  end;
  //if needupdate then
  //  FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
end;

constructor TAlxdSpreadSheetSelectionInt.Create(AOwner: TComponent);
begin
  inherited;
  FSelectionRect:=Rect(-1, -1, -1, -1);
  FAlxdSelectionType:=stUsually;

  FAlxdSpreadSheetArray:=(FindOwner(Self, 'TAlxdSpreadSheetInt') as TAlxdSpreadSheetInt).AlxdSpreadSheetArray;
  FAlxdSpreadSheetSelection:=TAlxdSpreadSheetSelection.Create(Self);
end;

destructor  TAlxdSpreadSheetSelectionInt.Destroy;
begin
  inherited;
end;

end.
