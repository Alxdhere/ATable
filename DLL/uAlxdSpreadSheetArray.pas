unit uAlxdSpreadSheetArray;

interface

uses
  SysUtils,
  Windows, Classes,
  uAlxdSystem, uAlxdItems, uAlxdItem, uAlxdCells, uAlxdCell,
  uAlxdFills, uAlxdFill, uAlxdBorders, uAlxdBorder, uAlxdParsers;

type
  TAlxdItemPropertyArray = array of TAlxdItemInt;
  TAlxdCellPropertyArray = array of array of TAlxdCellInt;
  TAlxdFillPropertyArray = array of array of TAlxdFillInt;
  TAlxdBorderPropertyArray = array of array of TAlxdBorderInt;

  TAlxdSpreadSheetArray = class(TComponent)
  private
    { Private declarations }
    FCols: TAlxdItemPropertyArray;
    FRows: TAlxdItemPropertyArray;
    FCells: TAlxdCellPropertyArray;
    FFills: TAlxdFillPropertyArray;
    FVerBorders: TAlxdBorderPropertyArray;
    FHorBorders: TAlxdBorderPropertyArray;
//    FFills: TAlxdFillPropertyArray;

    FAlxdCellsInt: TAlxdCellsInt;
    FAlxdFillsInt: TAlxdFillsInt;
    FAlxdColumnsInt: TAlxdItemsInt;
    FAlxdRowsInt: TAlxdItemsInt;
    FAlxdVerBordersInt: TAlxdBordersInt;
    FAlxdHorBordersInt: TAlxdBordersInt;

    FColCountInt: integer;
    FRowCountInt: integer;
    FColLineCount: integer;
    FRowLineCount: integer;
    FColDrawingSize: double;
    FRowDrawingSize: double;

    FShiftParams: TShiftParams;

    function  Get_ColCountInt: integer;
    function  Get_RowCountInt: integer;
{    function  Get_Cells(ACol, ARow: integer): TAlxdCellInt;
    function  Get_Columns(Index: integer): TAlxdItemInt;
    function  Get_Rows(Index: integer): TAlxdItemInt;
    function  Get_VerBorders(ACol, ARow: integer): TAlxdBorderInt;
    function  Get_HorBorders(ACol, ARow: integer): TAlxdBorderInt;
}
    procedure Set_ColCountInt(Value: integer);
    procedure Set_RowCountInt(Value: integer);
{    procedure Set_Cells(ACol, ARow: integer; Value: TAlxdCellInt);
    procedure Set_Columns(Index: integer; Value: TAlxdItemInt);
    procedure Set_Rows(Index: integer; Value: TAlxdItemInt);
    procedure Set_VerBorders(ACol, ARow: integer; Value: TAlxdBorderInt);
    procedure Set_HorBorders(ACol, ARow: integer; Value: TAlxdBorderInt);
}
    function  GetShiftedCells(const ACell: String; const DX, DY: integer; var AValue: String): boolean;
    procedure ShiftCellsValue(FromCol, FromRow, DeltaCol, DeltaRow: integer);
    procedure SizeChanged(ANewColCount, ANewRowCount: integer; AKeepObjects: boolean = false);

  public
    //direct access for ITEMS classes
    property  DirectCols: TAlxdItemPropertyArray read FCols;
    property  DirectRows: TAlxdItemPropertyArray read FRows;
    property  DirectCells: TAlxdCellPropertyArray read FCells;
    property  DirectFills: TAlxdFillPropertyArray read FFills;
    property  DirectVerBorders: TAlxdBorderPropertyArray read FVerBorders;
    property  DirectHorBorders: TAlxdBorderPropertyArray read FHorBorders;

    //access via ITEMS classes
    property  Cells: TAlxdCellsInt read FAlxdCellsInt;
    property  Fills: TAlxdFillsInt read FAlxdFillsInt;
    property  Columns: TAlxdItemsInt read FAlxdColumnsInt;
    property  Rows: TAlxdItemsInt read FAlxdRowsInt;
    property  VerBorders: TAlxdBordersInt read FAlxdVerBordersInt;
    property  HorBorders: TAlxdBordersInt read FAlxdHorBordersInt;
    //property  Cells[ACol, ARow: integer]: TAlxdCellInt read Get_Cells write Set_Cells;
    //property  Columns[Index: integer]: TAlxdItemInt read Get_Columns write Set_Columns;
    //property  Rows[Index: integer]: TAlxdItemInt read Get_Rows write Set_Rows;
    //property  VerBorders[ACol, ARow: integer]: TAlxdBorderInt read Get_VerBorders write Set_VerBorders;
    //property  HorBorders[ACol, ARow: integer]: TAlxdBorderInt read Get_HorBorders write Set_HorBorders;

    procedure JoinCellInRect(R: TRect; KeepText: boolean = false);
    procedure UnjoinCellInRect(R: TRect);

    procedure AddRow;
    procedure InsertRow(PrevRow: integer);
    procedure DeleteRow(ARow: integer);

    procedure AddColumn;
    procedure InsertColumn(PrevCol: integer);
    procedure DeleteColumn(ACol: integer);

{
    procedure AddRow;
    procedure InsertRow(ARow: integer); //ряд добавляется НАД ARow
    procedure DeleteRow(ARow: integer);

    procedure AddCol;
    procedure InsertCol(ACol: integer); //колонка добавляется НАД ARow
    procedure DeleteCol(ACol: integer);

    function Get_ColProperty: TClass;
    function Get_RowProperty: TClass;
    function Get_VerBorderProperty: TClass;
    function Get_HorBorderProperty: TClass;
    function Get_CellProperty: TClass;
    function Get_FillProperty: TClass;

    procedure Set_ColProperty(Value: TClass);
    procedure Set_RowProperty(Value: TClass);
    procedure Set_VerBorderProperty(Value: TClass);
    procedure Set_HorBorderProperty(Value: TClass);
    procedure Set_CellProperty(Value: TClass);
    procedure Set_FillProperty(Value: TClass);

    procedure MoveCell
    procedure CopyCell
    procedure ExchangeCell
    procedure AppendCell
    procedure ClearCell
    procedure DeleteCell
}
    property ColCountInt: integer read Get_ColCountInt write Set_ColCountInt;
    property RowCountInt: integer read Get_RowCountInt write Set_RowCountInt;
    property ColLineCount: integer read FColLineCount;
    property RowLineCount: integer read FRowLineCount;
    property ColDrawingSize: double read FColDrawingSize;
    property RowDrawingSize: double read FRowDrawingSize;

    function Recoordinate: boolean;
    function Redraw(fromColumn, fromRow: integer; motive: TAlxdRedrawMotive = [rmAll]): boolean;

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

implementation

uses
  uAlxdSpreadSheet, uAlxdSpreadSheetSelection, uoarxImport;

////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdSpreadSheetArray.Get_ColCountInt: integer;
begin
  Result:=FColCountInt;
  //Result:=(Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.ColCount;
end;

function  TAlxdSpreadSheetArray.Get_RowCountInt: integer;
begin
  Result:=FRowCountInt;
  //Result:=(Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.RowCount;
end;
{
function  TAlxdSpreadSheetArray.Get_Cells(ACol, ARow: integer): TAlxdCellInt;
begin
  Result:=FCells[ACol, ARow];
end;

function  TAlxdSpreadSheetArray.Get_Columns(Index: integer): TAlxdItemInt;
begin
  Result:=FCols[Index];
end;

function  TAlxdSpreadSheetArray.Get_Rows(Index: integer): TAlxdItemInt;
begin
  Result:=FRows[Index];
end;

function  TAlxdSpreadSheetArray.Get_VerBorders(ACol, ARow: integer): TAlxdBorderInt;
begin
  Result:=FVerBorders[ACol, ARow];
end;

function  TAlxdSpreadSheetArray.Get_HorBorders(ACol, ARow: integer): TAlxdBorderInt;
begin
  Result:=FHorBorders[ACol, ARow];
end;
}

procedure TAlxdSpreadSheetArray.Set_ColCountInt(Value: integer);
var
  i: integer;
begin
  if Value < FColCountInt then
    for i:=FColCountInt-1 downto Value do
      DeleteColumn(i)
  else
    for i := FColCountInt to Value-1 do
      AddColumn;

//  SizeChanged(Value, RowCountInt);
//  (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.ColCount:=ColCount;
end;

procedure TAlxdSpreadSheetArray.Set_RowCountInt(Value: integer);
var
  i: integer;
begin
  if Value < FRowCountInt then
    for i:=FRowCountInt-1 downto Value do
      DeleteRow(i)
  else
    for i := FRowCountInt to Value-1 do
      AddRow;

//  SizeChanged(ColCountInt, Value);
//  (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.RowCount:=RowCount;
end;

{
procedure TAlxdSpreadSheetArray.Set_Cells(ACol, ARow: integer; Value: TAlxdCellInt);
begin
  FCells[ACol, ARow].Assign(Value);
end;

procedure TAlxdSpreadSheetArray.Set_Columns(Index: integer; Value: TAlxdItemInt);
begin
  FCols[Index].Assign(Value);
end;

procedure TAlxdSpreadSheetArray.Set_Rows(Index: integer; Value: TAlxdItemInt);
begin
  FRows[Index].Assign(Value);
end;

procedure TAlxdSpreadSheetArray.Set_VerBorders(ACol, ARow: integer; Value: TAlxdBorderInt);
begin
  FVerBorders[ACol, ARow].Assign(Value);
end;

procedure TAlxdSpreadSheetArray.Set_HorBorders(ACol, ARow: integer; Value: TAlxdBorderInt);
begin
  FHorBorders[ACol, ARow].Assign(Value);
end;
}

function  TAlxdSpreadSheetArray.GetShiftedCells(const ACell: String; const DX, DY: integer; var AValue: String): boolean;
var
  Coord: TCellCoord;
  ddx, ddy: integer;
  removed: boolean;
  w: WideString;
begin
  AValue:=ACell;
  removed:=false;

  if not Formula2Cell(ACell, Coord) then
  begin
    if Coord.Cell.X > FColCountInt then Coord.Cell.X := -1;
    if Coord.Cell.Y > FRowCountInt then Coord.Cell.Y := -1;
  end;

  ddx:=dx;
  ddy:=dy;
  if Coord.Cell.X < FShiftParams.FromCol then ddx:=0;
  if Coord.Cell.Y < FShiftParams.FromRow then ddy:=0;

  if dx < 0 then
  begin
    removed:=(Coord.Cell.X = FShiftParams.FromCol);
    if removed then
      Coord.Cell.X := -1;
  end;

  if dy < 0 then
  begin
    removed:=(Coord.Cell.Y = FShiftParams.FromRow);
    if removed then
      Coord.Cell.Y := -1;
  end;

  if not removed then
  begin
    Coord.Cell.X := Coord.Cell.X + ddx;
    Coord.Cell.Y := Coord.Cell.Y + ddy;
  end;

  result:=Cell2Formula(Coord, w);
  AValue:=w;
end;

procedure TAlxdSpreadSheetArray.ShiftCellsValue(FromCol, FromRow, DeltaCol, DeltaRow: integer);
var
  i, j: integer;
  s,o: string;
begin
  FShiftParams.FromCol:=FromCol;
  FShiftParams.FromRow:=FromRow;

  for i:=0 to FColCountInt-1 do
    for j:=0 to FRowCountInt-1 do
      if FCells[i, j].HasFormula then
      begin
        s:=FCells[i, j].Formula;
        ShiftCells(s, o, DeltaCol, DeltaRow, GetShiftedCells);
        FCells[i, j].Formula:=o;
      end;
end;

procedure TAlxdSpreadSheetArray.SizeChanged(ANewColCount, ANewRowCount: integer; AKeepObjects: boolean = false);
var
  i, j: integer;
begin
{$IFDEF DEBUG}
  OutputDebugString(PChar(Format(#10'TAlxdSpreadSheet.SizeChanged(%p, %d, %d)', [Pointer(Self), ANewColCount, ANewRowCount])));
{$ENDIF}
{$IFDEF DLL}
  oarxLockDocument((Owner as TAlxdSpreadSheetInt).BlockReferenceId);
{$ENDIF}
//increase size
  if FColCountInt < ANewColCount then
  begin
    SetLength(FCells, ANewColCount, FRowCountInt);
    SetLength(FFills, ANewColCount, FRowCountInt);
    SetLength(FCols, ANewColCount);
    SetLength(FVerBorders, ANewColCount + 1, FRowCountInt);
    SetLength(FHorBorders, ANewColCount, FRowCountInt + 1);

    for i := FColCountInt to ANewColCount - 1 do
    begin
      FCols[i]:=TAlxdItemInt.CreateEx(Self, i, itCol);
      for j:=0 to FRowCountInt do
      begin
        if j < FRowCountInt then
        begin
          FVerBorders[i+1, j]:=TAlxdBorderInt.CreateEx(Self, i+1, j, btVer);
          FCells[i, j]:=TAlxdCellInt.CreateEx(Self, i, j);
          FFills[i, j]:=TAlxdFillInt.CreateEx(Self, i, j);
        end;
        FHorBorders[i, j]:=TAlxdBorderInt.CreateEx(Self, i, j, btHor);
      end;
    end;
    FColCountInt:=ANewColCount;
  end;

  if FRowCountInt < ANewRowCount then
  begin
    SetLength(FCells, FColCountInt, ANewRowCount);
    SetLength(FFills, FColCountInt, ANewRowCount);
    SetLength(FRows, ANewRowCount);
    SetLength(FVerBorders, FColCountInt + 1, ANewRowCount);
    SetLength(FHorBorders, FColCountInt, ANewRowCount + 1);

    for j := FRowCountInt to ANewRowCount - 1 do
    begin
      FRows[j]:=TAlxdItemInt.CreateEx(Self, j, itRow);
      for i:=0 to FColCountInt do
      begin
        if i < FColCountInt then
        begin
          FHorBorders[i, j+1]:=TAlxdBorderInt.CreateEx(Self, i, j+1, btHor);
          FCells[i, j]:=TAlxdCellInt.CreateEx(Self, i, j);
          FFills[i, j]:=TAlxdFillInt.CreateEx(Self, i, j);

          //!Move(EmptyBorderProperty, FHorBorders[i, j+1], SizeOf(TBorderProperty));
          //!Move(EmptyCellProperty, FCellsArray[i, j], SizeOf(TCellProperty));
          //!Move(EmptyTextProperty, FCellsArray[i, j].TextProperty, SizeOf(TTextProperty));
        end;
        FVerBorders[i, j]:=TAlxdBorderInt.CreateEx(Self, i, j, btVer);
      end;
    end;
    FRowCountInt:=ANewRowCount;
  end;

//decrease size
//FColCountInt = 2 -> ANewColCount = 1

  if FColCountInt > ANewColCount then
  begin
    for i := ANewColCount to FColCountInt-1 do
    begin
      FCols[i].Free;
      FCols[i]:=nil;
      for j:=0 to FRowCountInt do
      begin
        if j < FRowCountInt then
        begin
          FVerBorders[i+1, j].KeepObjects:=AKeepObjects;
          FVerBorders[i+1, j].Free;
          FVerBorders[i+1, j]:=nil;
          FCells[i, j].KeepObjects:=AKeepObjects;
          FCells[i, j].Free;
          FCells[i, j]:=nil;
          FFills[i, j].KeepObjects:=AKeepObjects;
          FFills[i, j].Free;
          FFills[i, j]:=nil;

        end;
        FHorBorders[i, j].KeepObjects:=AKeepObjects;
        FHorBorders[i, j].Free;
        FHorBorders[i, j]:=nil;
      end;
    end;
    SetLength(FCells, ANewColCount, FRowCountInt);
    SetLength(FFills, ANewColCount, FRowCountInt);
    SetLength(FCols, ANewColCount);
    SetLength(FVerBorders, ANewColCount + 1, FRowCountInt);
    SetLength(FHorBorders, ANewColCount, FRowCountInt + 1);
    FColCountInt:=ANewColCount;
  end;

//FRowCountInt = 2 -> ANewRowCount = 1
  if FRowCountInt > ANewRowCount then
  begin
    for j := ANewRowCount to FRowCountInt - 1 do
    begin
      FRows[j].Free;
      FRows[j]:=nil;
      //!Move(EmptyItemProperty, FRowProperty[j], SizeOf(TItemProperty));
      for i:=0 to FColCountInt do
      begin
        //!Move(EmptyBorderProperty, FVerBorders[i, j], SizeOf(TBorderProperty));
        if i < FColCountInt then
        begin
          FHorBorders[i, j+1].KeepObjects:=AKeepObjects;
          FHorBorders[i, j+1].Free;
          FHorBorders[i, j+1]:=nil;
          FCells[i, j].KeepObjects:=AKeepObjects;
          FCells[i, j].Free;
          FCells[i, j]:=nil;
          FFills[i, j].KeepObjects:=AKeepObjects;
          FFills[i, j].Free;
          FFills[i, j]:=nil;
          //!Move(EmptyBorderProperty, FHorBorders[i, j+1], SizeOf(TBorderProperty));
          //!Move(EmptyCellProperty, FCellsArray[i, j], SizeOf(TCellProperty));
          //!Move(EmptyTextProperty, FCellsArray[i, j].TextProperty, SizeOf(TTextProperty));
        end;
        FVerBorders[i, j].KeepObjects:=AKeepObjects;
        FVerBorders[i, j].Free;
        FVerBorders[i, j]:=nil;
      end;
    end;
    SetLength(FCells, FColCountInt, ANewRowCount);
    SetLength(FFills, FColCountInt, ANewRowCount);
    SetLength(FRows, ANewRowCount);
    SetLength(FVerBorders, FColCountInt + 1, ANewRowCount);
    SetLength(FHorBorders, FColCountInt, ANewRowCount + 1);
    FRowCountInt:=ANewRowCount;
  end;

  (Owner as TAlxdSpreadSheetInt).UpdateScrollBars;
//  (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetSelections.Update;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdSpreadSheetArray.JoinCellInRect(R: TRect; KeepText: boolean);
var
  i, j: integer;
  w: WideString;
  b: boolean;
begin
  with R do
  begin
    b:=Cells.Items[Left, Top].HasFormula;
    w:=Cells.Items[Left, Top].Contain;
    for j:=Top to Bottom do
      for i:=Left to Right do
        with Cells.Items[i, j] do
        begin
          if not b then
            if KeepText then
              if (i > Left) or (j > Top) then
                w:=w + Text;
              //ClearAll;
          JoinedCols:=Left - i;
          JoinedRows:=Top - j;
        end;
    with Cells.Items[Left, Top] do
    begin
      Contain:=w;
      JoinedCols:=Right - Left;
      JoinedRows:=Bottom - Top;
    end;
  end;
end;

procedure TAlxdSpreadSheetArray.UnjoinCellInRect(R: TRect);
var
  i, j: integer;
begin
  with R do
    for i:=Left to Right do
      for j:=Top to Bottom do
        with Cells.Items[i, j].Joined do
        begin
          Cols:=0;
          Rows:=0;
        end;
end;


procedure TAlxdSpreadSheetArray.AddRow;
var
  i, j: integer;
begin
  //with (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle do
  //RowCountInt:=RowCountInt + 1;
  SizeChanged(ColCountInt, RowCountInt + 1);

  j:=FRowCountInt - 1;
  if j > 0 then
  
  for i:=0 to FColCountInt do
  begin
    VerBorders.Items[i, j]:=VerBorders.Items[i, j-1];
    if (i < FColCountInt) then
    begin
      HorBorders.Items[i, j]:=HorBorders.Items[i, j-1];
      Cells.Items[i, j]:=Cells.Items[i, j-1];
//          ShiftCell(Point(i, j-1), Point(i, j));
      Cells.Items[i, j].Contain:='';
      Cells.Items[i, j].JoinedCols:=0;
      Cells.Items[i, j].JoinedRows:=0;
    end;
  end;//for i:=0 to FColCountInt do
end;

procedure TAlxdSpreadSheetArray.InsertRow(PrevRow: integer);
var
  i, j: integer;
  //cell: TPoint;
  Rt: TRect;
  LastJoinChanged: TPoint;
  s: WideString;
begin
  {$IFDEF DEBUG}
  OutputDebugString(PChar(Format('TAlxdSpreadSheetArray.InsertRow + PrevRow : %d', [PrevRow])));
  {$ENDIF}
  LastJoinChanged.X:=-1;
  LastJoinChanged.Y:=-1;

//  with FGridProperty do
//  begin
    //SizeChanged(FColCountInt, FRowCountInt + 1);
  //with (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle do
    //RowCountInt:=RowCountInt + 1;
  SizeChanged(ColCountInt, RowCountInt + 1);

    for j:=FRowCountInt downto PrevRow+1 do
    begin
      if j < FRowCountInt then
        Rows.Items[j]:=Rows.Items[j-1];

      for i:=0 to FColCountInt do
      begin
        if j < FRowCountInt then
          VerBorders.Items[i, j]:=VerBorders.Items[i, j-1];
        if i < FColCountInt then
          HorBorders.Items[i, j]:=HorBorders.Items[i, j-1];
        if (i < FColCountInt) and (j < FRowCountInt) then
        begin
          Cells.Items[i, j]:=Cells.Items[i, j-1];
//          ShiftCell(Point(i, j-1), Point(i, j));
          if j = PrevRow + 1 then
            Cells.Items[i, PrevRow].Contain:='';
        end;
      end;//for i:=0 to FColCountInt do
    end;

    Rows.Items[PrevRow]:=Rows.Items[PrevRow+1];

    for j:=0 to FColCountInt - 1 do
    begin
      //cell:=Point(j, PrevRow);
      //if isJoiningCell(cell) then
      if Cells.Items[j, PrevRow].IsJoiningCell then
      begin
        LastJoinChanged:=Point(j, PrevRow);
        UnjoinCellInRect(Rect(j, PrevRow, j + Cells.Items[j, PrevRow].JoinedCols, PrevRow));
      end
      else
      //if isJoinedCell(cell) then
      if Cells.Items[j, PrevRow].IsJoinedCell then
      begin
        //!JoinedCellToJoiningCell(cell);
        //!Rt:=JoiningCellToRect(cell);
        Rt:=Cells.Items[j, PrevRow].JoinedRect;
        if not PointsEqual(Rt.TopLeft, LastJoinChanged) then
        begin
          LastJoinChanged:=Rt.TopLeft;
          Inc(Rt.Bottom);
          s:=Cells.Items[j, PrevRow].Contain;
          JoinCellInRect(Rt);
          Cells.Items[j, PrevRow].Contain:=s;
        end;
      end;
    end;//for j:=0 to FRowCountInt - 1 do
  //end;//with FGridProperty do

  ShiftCellsValue(0, PrevRow, 0, 1);
  //!InvalidateFull:=True;
  {$IFDEF DEBUG}
  OutputDebugString('TAlxdSpreadSheetArray.InsertRow + finish');
  {$ENDIF}
end;

procedure TAlxdSpreadSheetArray.DeleteRow(ARow: integer);
var
  i, j: integer;
  //cell: TPoint;
  Rt: TRect;
  LastJoinChanged: TPoint;
  s: WideString;
begin
  {$IFDEF DEBUG}
  OutputDebugString(PChar(Format('TAlxdSpreadSheetArray.DeleteRow + ARow : %d', [ARow])));
  {$ENDIF}

  LastJoinChanged.X:=-1;
  LastJoinChanged.Y:=-1;

//  with FGridProperty do
//  begin
    if FRowCountInt = 1 then exit;

{    if ARow = FRowCountInt-1 then
    begin
      SizeChanged(FColCountInt, FRowCountInt-1);
      exit;
    end;
}
    for j:=ARow to FRowCountInt-1 do
    begin
      if j < FRowCountInt-1 then
        Rows.Items[j]:=Rows.Items[j+1];

//      for i:=0 to FColCountInt do
      for i:=FColCountInt downto 0 do
      begin
        if (j < FRowCountInt-1) then
          VerBorders.Items[i, j]:=VerBorders.Items[i, j+1];
        if (i < FColCountInt) then
          HorBorders.Items[i, j]:=HorBorders.Items[i, j+1];

        if (i < FColCountInt) and (j < FRowCountInt-1) then
        begin
          //!cell:=Point(i, j);
          //Fills.Items[i, j]:=Fills.Items[i, j+1];

          if (j = ARow) then
          begin
            //!if isJoiningCell(cell) then
            if Cells.Items[i, j].IsJoiningCell then
            begin
              with Cells.Items[i, j] do
                if JoinedRows = 0 then
                begin
                  Cells.Items[i, j]:=Cells.Items[i, j+1];
//                  ShiftCell(Point(i, j+1), Point(i, j));
                end
                else
                  JoinedRows:=JoinedRows - 1;
              LastJoinChanged:=Point(i, j);
            end
            else
            //!if isJoinedCell(cell) then
            if Cells.Items[i, j].IsJoinedCell then
            begin
              //!JoinedCellToJoiningCell(cell);
              //!Rt:=JoiningCellToRect(cell);
              Rt:=Cells.Items[i, j].JoinedRect;
              if j > Rt.Bottom - 1 then
              begin
                Cells.Items[i, j]:=Cells.Items[i, j+1];
//                ShiftCell(Point(i, j+1), Point(i, j));
                //!if not PointsEqual(cell, LastJoinChanged) then
                if not PointsEqual(Rt.TopLeft, LastJoinChanged) then
                with Cells.Items[Rt.Left, Rt.Top] do
                begin
                  if JoinedRows > 0 then
                    JoinedRows:=JoinedRows - 1;
                  LastJoinChanged:=Rt.TopLeft;
                end;
              end;
            end
            else
            if Cells.Items[i, j].isSimpleCell then
            begin
              Cells.Items[i, j]:=Cells.Items[i, j+1];
//              ShiftCell(Point(i, j+1), Point(i, j));
            end
          end
          else
          begin
            Cells.Items[i, j]:=Cells.Items[i, j+1];
//            ShiftCell(Point(i, j+1), Point(i, j));
          end;
        end;//if (i < FColCountInt-1) and (j < FRowCountInt) then
      end;//for i:=0 to FColCountInt do
    end;//for j:=ARow to FRowCountInt-1 do

    LastJoinChanged.X:=-1;
    LastJoinChanged.Y:=-1;

    for i:=0 to FColCountInt-1 do
    begin
      //!cell:=Point(i, ARow);
      //!if isJoiningCell(cell) then
      if Cells.Items[i, ARow].IsJoiningCell then
      begin
        //!Rt:=JoiningCellToRect(cell);
        Rt:=Cells.Items[i, ARow].JoinedRect;
        s:=Cells.Items[i, ARow].Contain;
        JoinCellInRect(Rt);
        Cells.Items[i, ARow].Contain:=s;
        LastJoinChanged:=Point(i, ARow);
      end;
      //!if isJoinedCell(cell) then
      if Cells.Items[i, ARow].IsJoinedCell then
      begin
        //!JoinedCellToJoiningCell(cell);
        Rt:=Cells.Items[i, ARow].JoinedRect;
        if not PointsEqual(Rt.TopLeft, LastJoinChanged) then
          //!if isSimpleCell(cell) then
          if Cells.Items[Rt.Left, Rt.Top].IsSimpleCell then
          begin
            Rt:=Rect(i, ARow, i, ARow);
            UnjoinCellInRect(Rt);
          end
          else
          begin
            Rt:=Cells.Items[Rt.Left, Rt.Top].JoinedRect;
            Dec(Rt.Bottom);
            UnjoinCellInRect(Rt);
            s:=Cells.Items[Rt.Left, Rt.Top].Contain;
            JoinCellInRect(Rt);
            Cells.Items[Rt.Left, Rt.Top].Contain:=s;
            LastJoinChanged:=Rt.TopLeft;
          end;
      end;
    end;

//    SizeChanged(FColCountInt, FRowCountInt-1);
  //with (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle do
  //  RowCountInt:=RowCountInt - 1;
  SizeChanged(ColCountInt, RowCountInt - 1);

//  end;//with FGridProperty do

  ShiftCellsValue(0, ARow, 0, -1);

  //!if TopRow > RowCount - 1 then
    //!TopRow:=RowCount-1;

  //!InvalidateFull:=True;
  {$IFDEF DEBUG}
  OutputDebugString('TAlxdSpreadSheetArray.DeleteRow + finish');
  {$ENDIF}
end;

procedure TAlxdSpreadSheetArray.AddColumn;
var
  i, j: integer;
begin
  //with (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle do
//    ColCountInt:=ColCountInt + 1;
  SizeChanged(ColCountInt + 1, RowCountInt);

  i:=FColCountInt - 1;
  if i > 0 then
  
  for j:=0 to FRowCountInt do
  begin
    HorBorders.Items[i, j]:=HorBorders.Items[i-1, j];
    if (j < FRowCountInt) then
    begin
      VerBorders.Items[i, j]:=VerBorders.Items[i-1, j];
      Cells.Items[i, j]:=Cells.Items[i-1, j];
      Cells.Items[i, j].Contain:='';
      Cells.Items[i, j].JoinedCols:=0;
      Cells.Items[i, j].JoinedRows:=0;
    end;
  end;//for j:=0 to FRowCountInt do
end;

procedure TAlxdSpreadSheetArray.InsertColumn(PrevCol: integer);
var
  i, j: integer;
//  cell: TPoint;
  Rt: TRect;
  LastJoinChanged: TPoint;
  s: WideString;
begin
  LastJoinChanged.X:=-1;
  LastJoinChanged.Y:=-1;

//  with FGridProperty do
//  begin
//    Inc(FColCountInt);
//    SizeChanged(FColCountInt + 1, FRowCountInt);
  //with (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle do
//    ColCountInt:=ColCountInt + 1;
  SizeChanged(ColCountInt + 1, RowCountInt);

    for i:=FColCountInt downto PrevCol+1 do
    begin
      if i < FColCountInt then
        Columns.Items[i]:=Columns.Items[i-1];

      for j:=0 to FRowCountInt do
      begin
        if j < FRowCountInt then
          VerBorders.Items[i, j]:=VerBorders.Items[i-1, j];
        if i < FColCountInt then
          HorBorders.Items[i, j]:=HorBorders.Items[i-1, j];
        if (i < FColCountInt) and (j < FRowCountInt) then
        begin
          Cells.Items[i, j]:=Cells.Items[i-1, j];
//          ShiftCell(Point(i-1, j), Point(i, j));
          if i = PrevCol + 1 then
            Cells.Items[PrevCol, j].Contain:='';
        end;
      end;//for j:=0 to FRowCountInt do
    end;

    //ColProperty[PrevCol]:=@EmptyItemProperty;
    Columns.Items[PrevCol]:=Columns.Items[PrevCol+1];

    for j:=0 to FRowCountInt - 1 do
    begin
      //cell:=Point(PrevCol, j);
      //!if isJoiningCell(cell) then
      if Cells.Items[PrevCol, j].IsJoiningCell then
      begin
        LastJoinChanged:=Point(PrevCol, j);
        UnjoinCellInRect(Rect(PrevCol, j, PrevCol, j + Cells.Items[PrevCol, j].JoinedRows));
      end
      else
      //!if isJoinedCell(cell) then
      if Cells.Items[PrevCol, j].isJoinedCell then
      begin
        //JoinedCellToJoiningCell(cell);
        //Rt:=JoiningCellToRect(cell);
        Rt:=Cells.Items[PrevCol, j].JoinedRect;
//        if not PointsEqual(Rt.TopLeft, Rt.BottomRight) and not PointsEqual(Rt.TopLeft, LastJoinChanged) then
        if not PointsEqual(Rt.TopLeft, LastJoinChanged) then
        begin
          LastJoinChanged:=Rt.TopLeft;
          Inc(Rt.Right);
          s:=Cells.Items[Rt.Left, Rt.Top].Contain;
          JoinCellInRect(Rt);
//          if HasFormula(cell.x, cell.y) then
//            ShiftCells(s, s, 1, 0, GetShiftedCell);
          Cells.Items[Rt.Left, Rt.Top].Contain:=s;
//          s:=CellText[cell.x, cell.y];
//          JoinCellInRect(Rt);
//          CellText[cell.x, cell.y]:=s;
        end
      end;
    end;//for j:=0 to FRowCountInt - 1 do
//  end;//with FGridProperty do

  ShiftCellsValue(PrevCol, 0, 1, 0);
  //!InvalidateFull:=True;
end;

procedure TAlxdSpreadSheetArray.DeleteColumn(ACol: integer);
var
  i, j: integer;
//  cell: TPoint;
  Rt: TRect;
  LastJoinChanged: TPoint;
  s: WideString;
begin
  LastJoinChanged.X:=-1;
  LastJoinChanged.Y:=-1;

//!  with FGridProperty do
//!  begin
    if FColCountInt = 1 then exit;

{    if ACol = FColCountInt-1 then
    begin
      SizeChanged(FColCountInt-1, FRowCountInt);
      exit;
    end;
}
    for i:=ACol to FColCountInt-1 do
    begin
      if i < FColCountInt-1 then
        Columns.Items[i]:=Columns.Items[i+1];

//      for j:=0 to FRowCountInt do
      for j:=FRowCountInt downto 0 do
      begin
        if (j < FRowCountInt) then
          VerBorders.Items[i, j]:=VerBorders.Items[i+1, j];
        if (i < FColCountInt-1) then
          HorBorders.Items[i, j]:=HorBorders.Items[i+1, j];

        if (i < FColCountInt-1) and (j < FRowCountInt) then
        begin
          //cell:=Point(i, j);

          if (i = ACol) then
          begin
            //!if isJoiningCell(cell) then
            if Cells.Items[i, j].IsJoiningCell then
            begin
              with Cells.Items[i, j] do
                if JoinedCols = 0 then
                  //Joined.Rows:=0
                  Cells.Items[i, j]:=Cells.Items[i+1, j]
                else
                  JoinedCols:=JoinedCols - 1;
              LastJoinChanged:=Point(i, j);
            end
            else
            //!if isJoinedCell(cell) then
            if Cells.Items[i, j].isJoinedCell then
            begin
              //!JoinedCellToJoiningCell(cell);
              //!Rt:=JoiningCellToRect(cell);
              Rt:=Cells.Items[i, j].JoinedRect;
              if i > Rt.Right - 1 then
              begin
                Cells.Items[i, j]:=Cells.Items[i+1, j];
                if not PointsEqual(Rt.TopLeft, LastJoinChanged) then
                with Cells.Items[Rt.Left, Rt.Top] do
                begin
                  if JoinedCols > 0 then
                    JoinedCols:=JoinedCols - 1;
                  LastJoinChanged:=Rt.TopLeft;
                end;
              end;
//              JoiningCellToRect(cell);
//              JoinedCellToJoiningCell(cell);
//              if not PointsEqual(cell, LastJoinChanged) then
//              LastJoinChanged:=cell;
            end
            else
            //!if isSimpleCell(cell) then
            if Cells.Items[i, j].IsSimpleCell then
            begin
              Cells.Items[i, j]:=Cells.Items[i+1, j];
//              ShiftCell(Point(i+1, j), Point(i, j));
            end;
          end
          else
          begin
            Cells.Items[i, j]:=Cells.Items[i+1, j];
//            ShiftCell(Point(i+1, j), Point(i, j));
          end;
        end;//if (i < FColCountInt-1) and (j < FRowCountInt) then
      end;//for j:=0 to FRowCountInt do
    end;//for i:=ACol to FColCountInt-1 do

    LastJoinChanged.X:=-1;
    LastJoinChanged.Y:=-1;

    for j:=0 to FRowCountInt-1 do
    begin
      //cell:=Point(ACol, j);
      //!if isJoiningCell(cell) then
      if Cells.Items[ACol, j].IsJoiningCell then
      begin
        //!Rt:=JoiningCellToRect(cell);
        Rt:=Cells.Items[ACol, j].JoinedRect;
        s:=Cells.Items[ACol, j].Contain;
        JoinCellInRect(Rt);
        Cells.Items[ACol, j].Contain:=s;
        LastJoinChanged:=Point(ACol, j);
      end;
      //!if isJoinedCell(cell) then
      if Cells.Items[ACol, j].IsJoinedCell then      
      begin
        //JoinedCellToJoiningCell(cell);
        Rt:=Cells.Items[ACol, j].JoinedRect;
        if not PointsEqual(Rt.TopLeft, LastJoinChanged) then
          //!if isSimpleCell(cell) then
          if Cells.Items[Rt.Left, Rt.Top].IsSimpleCell then
          begin
            Rt:=Rect(ACol, j, ACol, j);
            UnjoinCellInRect(Rt);
          end
          else
          begin
            //!Rt:=JoiningCellToRect(cell);
            Rt:=Cells.Items[Rt.Left, Rt.Top].JoinedRect;
            Dec(Rt.Right);
            UnjoinCellInRect(Rt);
            s:=Cells.Items[Rt.Left, Rt.Top].Contain;
            JoinCellInRect(Rt);
            Cells.Items[Rt.Left, Rt.Top].Contain:=s;
            LastJoinChanged:=Rt.TopLeft;
          end;
      end;
    end;

//    SizeChanged(FColCountInt-1, FRowCountInt);
  //with (Owner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle do
//    ColCountInt:=ColCountInt - 1;
  SizeChanged(ColCountInt - 1, RowCountInt);


//!  end;//with FGridProperty do

  ShiftCellsValue(ACol, 0, -1, 0);

  //!if LeftCol > ColCountInt - 1 then
    //!LeftCol:=ColCount-1;

  //!InvalidateFull:=True;
end;

function TAlxdSpreadSheetArray.Recoordinate: boolean;
var
  i, j: integer;
  sum: double;
//  tmp: integer;
  item: TAlxdItemInt;
  {$IFDEF TICK}
  tick: Cardinal;
  {$ENDIF}
begin
  {$IFDEF TICK}
  tick:=GetTickCount;
  //OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetArray.Recoordinate :%d', [GetTickCount])));
  {$ENDIF}
  Result:=false;

  //recoordinate
  sum:=0;
  FColLineCount:=0;
  with FAlxdColumnsInt do
    for i := 0 to ColCountInt - 1 do
    begin
      item:=Items[i];
      item.Coord:=sum;
      //if Items[i].Visible then
      //begin
        //tmp:=Items[i].LineCount;
        FColLineCount:=FColLineCount+item.LineCount;
        //sum:=sum + Items[i].RealSize * tmp;
        sum:=sum + item.DrawingSize;
        //FColLineCount:=FColLineCount + tmp;
        Result:=item.Changed or Result;
      //end;
    end;

  sum:=0;
  FRowLineCount:=0;
  with FAlxdRowsInt do
    for j := 0 to RowCountInt - 1 do
    begin
      item:=Items[j];
      item.Coord:=sum;
      //Items[j].Coord:=sum;
      //if Items[j].Visible then
      //begin
        //FRowLineCount:=FRowLineCount + Items[j].LineCount;
        FRowLineCount:=FRowLineCount + item.LineCount;
        //tmp:=Items[j].LineCount;
        //sum:=sum - Items[j].DrawingSize;//Items[j].RealSize * tmp;
        sum:=sum - item.DrawingSize;
        //FRowLineCount:=FRowLineCount + tmp;
        //Result:=Result or FAlxdRowsInt.Items[j].Changed;
        Result:=item.Changed or Result;
      //end;
    end;

  item:=FAlxdColumnsInt.Items[ColCountInt - 1];
  with item do
    sum:=Abs(Coord + DrawingSize);
  if sum <> FColDrawingSize then
  begin
    FColDrawingSize:=sum;
    (Owner as TAlxdSpreadSheetInt).Invalidate;
  end;

  item:=FAlxdRowsInt.Items[RowCountInt - 1];
  with item do
    sum:=Abs(Coord - DrawingSize);
  if sum <> FRowDrawingSize then
  begin
    FRowDrawingSize:=sum;
    (Owner as TAlxdSpreadSheetInt).Invalidate;
  end;

  {$IFDEF TICK}
  OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetArray.Recoordinate tick:%d', [GetTickCount - tick])));
  {$ENDIF}
end;

function TAlxdSpreadSheetArray.Redraw(fromColumn, fromRow: integer; motive: TAlxdRedrawMotive): boolean;
var
  brepeat: boolean;
  i, j: integer;
  {$IFDEF TICK}
  tick: Cardinal;
  cnt: integer;
  {$ENDIF}
begin
  {$IFDEF TICK}
  //OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetArray.Redraw :%d, %d', [fromColumn, fromRow])));
  //OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetArray.Redraw :%d', [GetTickCount])));
  tick:=GetTickCount;
  cnt:=0;
  {$ENDIF}
  Result:=false;
  try

    if rmOneCell in motive then
    begin
      Cells.Items[fromColumn, fromRow].Redraw(motive);
      brepeat:=Recoordinate;
      //Exclude(motive
      if brepeat then
      begin
        motive:=[rmAll];
        fromColumn:=0;
        fromRow:=0;
      end
      else
        exit;
    end
    else
    begin
      Recoordinate;
      brepeat:=true;
    end;

    while brepeat do
    begin
      //brepeat:=false;

      //redraw cells
      for i := fromColumn to ColCountInt-1 do
        for j := fromRow to RowCountInt-1 do
            Cells.Items[i, j].Redraw(motive);

      brepeat:=Recoordinate;

      if brepeat then motive:=[rmAll];

      if rmAll in motive then
      begin
        fromColumn:=0;
        fromRow:=0;
      end;
      {$IFDEF TICK}
      Inc(cnt);
      {$ENDIF}
    end;

    //redraw borders
    for i := fromColumn to ColCountInt do
      for j := fromRow to RowCountInt do
      begin
        if (i < ColCountInt) and (j < RowCountInt) then
          Fills.Items[i, j].Redraw(motive);

        if i < ColCountInt then
          HorBorders.Items[i, j].Redraw(motive);

        if j < RowCountInt then
          VerBorders.Items[i, j].Redraw(motive);
      end;

    Result:=true;
  finally
    {$IFDEF TICK}
    OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetArray.Redraw cnt:%d', [cnt])));
    OutputDebugString(PChar(Format(#10'TAlxdSpreadSheetArray.Redraw tick:%d', [GetTickCount - tick])));
    OutputDebugString(#10'TAlxdSpreadSheetArray.Redraw finished');
    {$ENDIF}
  end;
end;

constructor TAlxdSpreadSheetArray.Create(AOwner: TComponent);
begin
  inherited;
  FAlxdColumnsInt:=TAlxdItemsInt.CreateEx(Self, itCol);
  FAlxdRowsInt:=TAlxdItemsInt.CreateEx(Self, itRow);
  FAlxdCellsInt:=TAlxdCellsInt.Create(Self);
  FAlxdFillsInt:=TAlxdFillsInt.Create(Self);
  FAlxdVerBordersInt:=TAlxdBordersInt.CreateEx(Self, btVer);
  FAlxdHorBordersInt:=TAlxdBordersInt.CreateEx(Self, btHor);

  FColCountInt:=0;
  FRowCountInt:=0;

end;

destructor  TAlxdSpreadSheetArray.Destroy;
begin
  SizeChanged(0, 0, true);

  FAlxdHorBordersInt.Free;
  FAlxdVerBordersInt.Free;
  FAlxdFillsInt.Free;
  FAlxdCellsInt.Free;
  FAlxdRowsInt.Free;
  FAlxdColumnsInt.Free;

  inherited;
end;

end.
