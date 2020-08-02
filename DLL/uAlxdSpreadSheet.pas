unit uAlxdSpreadSheet;

interface

uses
  Windows, Messages, SysUtils, XMLDoc, XMLIntf, Classes, Controls, Graphics,
  xAlxdSpreadSheet, AlxdGrid_TLB,
  uAlxdSystem, uAlxdOptions, uAlxdSpreadSheetArray, uAlxdSpreadSheetStyle,
  uAlxdSpreadSheetSelections, uAlxdSpreadSheetSelection, uAlxdItems, uAlxdEdit,
  uoarxImport, uAlxdUndo, uAlxdCell, RegExpr, Math, StrUtils, uAlxdParsers;

const
  AlxdSpreadSheetRoot = 'AlxdSpreadSheet';
  SELECTIONBORDER = 3;

type
  TAlxdSpreadSheetState = ( gsReadySelectCell,
                            gsReadySelectCol,
                            gsReadySelectRow,
                            gsReadySizingCol,
                            gsReadySizingRow,
                            gsReadySelectionMove,
                            gsReadySelectionCopy,
                            //gsReadySelectionCustomMove,
                            gsReadySelectionExpand,
                            gsReadySelectionExpandInc,
                            gsReadySelection2Assist,
                            gsSelectCell,
                            gsSelectCol,
                            gsSelectRow,
                            gsSizingCol,
                            gsSizingRow,
                            gsSelectionMove,
                            gsSelectionCopy,
                            gsSelectionExpand,
                            gsSelectionExpandInc,
                            gsReadyAddSelection2Formula, //готов выбирать при вводе формулы (после =, после WM_CHAR, при наличии выборки)
                            gsReadyChangeSelection2Formula,
                            gsSelectCell2Formula, //выбор €чеек, пока не WM_CHAR
                            gsSelectCol2Formula,
                            gsSelectRow2Formula,
                            gsWaitFormulaSelect//22
                          );

  TAlxdSpreadSheetPlace = ( gpZero,                //under zero cell
                            gpTopRow,              //under top row
                            gpLeftCol,             //under left col
                            gpCells,               //under cells
                            gpColSizing,           //under col border in top row
                            gpRowSizing,           //under row border in left col
                            //gpBorder,              //under border
                            gpSelectionBorder,     //under selection border (not multiselect)
                            gpSelectionDot,        //under selection dor (not multiselect)
                            gpEmpty                //under empty area (outside cells)
                          );
                          
  TAlxdSpreadSheetPlacePos = record
    place: TAlxdSpreadSheetPlace;
    cell: TPoint;
  end;

  TSizeInfo = record
    ItemNo: integer;
    StartCoord: TPoint;
    StartSize: double;
  end;

  TEditInfo = record
    FEditorMode: boolean;
    FEditor: TAlxdEdit;
    FEditCell: TAlxdSpreadSheetSelectionInt;

    FOldText: WideString;
    //FEditCell: TPoint;
    //FEditRect: TRect;
    FEditorRect: TRect;
    //FEnterFormula: boolean;
  end;

  TDragInfo = record
    FStartCell: TPoint;
    FStartSelection: TAlxdSpreadSheetSelectionInt;
    FCurrentSelection: TAlxdSpreadSheetSelectionInt;
  end;

  TRects = record
    FSourceRect: TRect;
    FDestRect: TRect;
  end;


  TChangeCell = procedure (Source, Dest: TPoint) of object;

  //TOnPopupMenu = procedure (Sender: TObject; Point: TPoint; Place: TAlxdSpreadSheetPlacePos) of object;
  //TOnCustomMovePopupMenu = procedure (Sender: TObject; Source, Dest: TSelection; Point: TPoint) of object;

  TAlxdSpreadSheetInt = class(TCustomControl, IAlxdSpreadSheet)
  private
    { Private declarations }
    //FIndex: integer;
    FFullFileName: WideString;
    FAlxdSpreadSheet: IAlxdSpreadSheet;
    FAlxdSpreadSheetStyleInt: TAlxdSpreadSheetStyleInt;
    FAlxdSpreadSheetArray: TAlxdSpreadSheetArray;

    FAlxdSpreadSheetSelectionsInt: TAlxdSpreadSheetSelectionsInt;
    FAlxdFormulaSelectionsInt: TAlxdSpreadSheetSelectionsInt;
    FAlxdUndo: TAlxdUndo;

    FLeftCol: integer;
    FTopRow: integer;
    //FRightCol: integer;
    //FBottomRow: integer;

    FSizeInfo: TSizeInfo;
    FEditInfo: TEditInfo;
    FDragInfo: TDragInfo;
    FAlxdSpreadSheetState: TAlxdSpreadSheetState;

    FAlxdSpreadSheetExchange: TAlxdSpreadSheetExchange;

    FParserParams: TParserParams;
    
    //FHorScrollVisible: boolean;
    //FVerScrollVisible: boolean;
    //Events
    //FOnPopupMenu: TOnPopupMenu;

//    function Get_ScaledColWidth(Index: integer): integer;
//    function Get_ScaledRowHeight(Index: integer): integer;

    function  CalcPage2TopLeft(currow, curcol: integer): TSize;
    function  CalcPage2BottomRight(currow, curcol: integer): TSize;
    function  CalcPlace(Pt: TPoint): TAlxdSpreadSheetPlacePos;

    function  NeedVerScrollBar: boolean;
    function  NeedHorScrollBar: boolean;
    procedure ModifyScrollBar(ScrollBar, ScrollCode, Pos: Cardinal);

    procedure Set_AlxdSpreadSheetState(Value: TAlxdSpreadSheetState);
    function  Get_AlxdSpreadSheetState: TAlxdSpreadSheetState;

    procedure Set_FullFileName(Value: WideString);
    function  Get_FullFileName: WideString;

    function  Get_BlockDefinitionHandle: WideString;
    function  Get_BlockReferenceHandle: WideString;

    function  GetCellValue(const ACell: String; var AValue: String): boolean;
    function  GetRangeValues(const AStartCell, AEndCell: String; var AValue: String): boolean;
    function  GetShiftedCell(const ACell: String; const DX, DY: integer; var AValue: String): boolean;
    procedure ShiftCellValue(Source, Dest: TPoint; dx, dy: integer); overload;
    procedure ShiftCellValue(Source, Dest: TPoint); overload;

  protected
    { Protected declarations }
    function  Get_AlxdSpreadSheetStyle: TAlxdSpreadSheetStyleInt;
    function  Get_AlxdSpreadSheetArray: TAlxdSpreadSheetArray;
    function  Get_AlxdSpreadSheetSelections: TAlxdSpreadSheetSelectionsInt;
    function  Get_EditorMode: boolean;
    function  Get_EditorHandle: integer;

    procedure Set_AlxdSpreadSheetStyle(Value: TAlxdSpreadSheetStyleInt);
    procedure Set_AlxdSpreadSheetArray(Value: TAlxdSpreadSheetArray);
    procedure Set_AlxdSpreadSheetSelections(Value: TAlxdSpreadSheetSelectionsInt);
    procedure Set_EditorMode(Value: boolean);

    procedure Set_BlockReferenceId(Value: longint);

    procedure Set_LeftCol(Value: integer);
    procedure Set_TopRow(Value: integer);
    function  Get_RightCol: integer;
    procedure Set_RightCol(Value: integer);
    function  Get_BottomRow: integer;
    procedure Set_BottomRow(Value: integer);

    //editor
    procedure ShowEditor;
    procedure HideEditor;
    procedure UpdateEditorPos;
    procedure UpdateEditorSize;
    procedure UpdateEditorText;
    procedure UpdateEditorSyntaxPattern;

    //change functions
    function  ChangeCellSelection(Source, Dest: TRect; ChangeCell: TChangeCell): boolean;
    function  ExpandCellSelection(Source, Dest: TRect; ChangeCell: TChangeCell): boolean;

    procedure MoveCellContent(Source, Dest: TPoint);
    procedure CopyCellContent(Source, Dest: TPoint);
    procedure IncCopyCellContent(Source, Dest: TPoint);
    procedure ExchangeCellContent(Source, Dest: TPoint);
    procedure AppendCellContent(Source, Dest: TPoint);
    procedure MoveCellFormat(Source, Dest: TPoint);
    procedure CopyCellFormat(Source, Dest: TPoint);
    procedure ExchangeCellFormat(Source, Dest: TPoint);
    procedure MoveCellAll(Source, Dest: TPoint);
    procedure CopyCellAll(Source, Dest: TPoint);
    procedure IncCopyCellAll(Source, Dest: TPoint);
    procedure ExchangeCellAll(Source, Dest: TPoint);

    //events
    procedure StateMachine(Message: TMessage);
    procedure StateMachineFormula(Message: TMessage);
    procedure WndProc(var Message: TMessage); override;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;

    //methods
    procedure PaintBackground(ACanvas: TCanvas);
    procedure PaintCells(ACanvas: TCanvas);
    procedure PaintSelection(ACanvas: TCanvas);
    procedure PaintFixed(ACanvas: TCanvas);
    procedure Paint; override;

    //properties
    property  AlxdSpreadSheetState: TAlxdSpreadSheetState read Get_AlxdSpreadSheetState write Set_AlxdSpreadSheetState;

    procedure CreateParams(var Params: TCreateParams); override;

  public
    { Public declarations }
    property  Intf: IAlxdSpreadSheet read FAlxdSpreadSheet implements IAlxdSpreadSheet;
    property  AlxdSpreadSheetStyle: TAlxdSpreadSheetStyleInt read Get_AlxdSpreadSheetStyle write Set_AlxdSpreadSheetStyle;
    property  AlxdSpreadSheetArray: TAlxdSpreadSheetArray read Get_AlxdSpreadSheetArray write Set_AlxdSpreadSheetArray;
    property  AlxdSpreadSheetSelections: TAlxdSpreadSheetSelectionsInt read Get_AlxdSpreadSheetSelections write Set_AlxdSpreadSheetSelections;
    property  AlxdUndo: TAlxdUndo read FAlxdUndo;
    property  EditorMode: boolean read Get_EditorMode write Set_EditorMode;
    property  EditorHandle: integer read Get_EditorHandle;//FEditInfo.FEditor.Handle;
    property  PopupMenu;
    property  FullFileName: WideString read Get_FullFileName write Set_FullFileName;

    procedure UpdateScrollBars;

    property  LeftCol: integer read FLeftCol write Set_LeftCol;
    property  TopRow: integer read FTopRow write Set_TopRow;
    property  RightCol: integer read Get_RightCol write Set_RightCol;
    property  BottomRow: integer read Get_BottomRow write Set_BottomRow;

    procedure AddRows(Count: Integer);
    procedure DeleteRows;
    procedure InsertRows;

    procedure AddColumns(Count: Integer);
    procedure DeleteColumns;
    procedure InsertColumns;

    //change procedures
    function  MoveCellsContent(Source, Dest: TRect): boolean;
    function  CopyCellsContent(Source, Dest: TRect): boolean;
    function  ExchangeCellsContent(Source, Dest: TRect): boolean;
    function  AppendCellsContent(Source, Dest: TRect): boolean;
    function  MoveCellsFormat(Source, Dest: TRect): boolean;
    function  CopyCellsFormat(Source, Dest: TRect): boolean;
    function  ExchangeCellsFormat(Source, Dest: TRect): boolean;
    function  MoveCellsAll(Source, Dest: TRect): boolean;
    function  CopyCellsAll(Source, Dest: TRect): boolean;
    function  ExchangeCellsAll(Source, Dest: TRect): boolean;

    function  ExpandCopyCellsContent(Source, Dest: TRect): boolean;
    function  ExpandCopyCellsFormat(Source, Dest: TRect): boolean;
    function  ExpandCopyCellsAll(Source, Dest: TRect): boolean;
    function  ExpandIncCopyCellsContent(Source, Dest: TRect): boolean;
    function  ExpandIncCopyCellsAll(Source, Dest: TRect): boolean;

//    procedure Join;
//    procedure Disjoin;

    procedure CreateBlockDefinition;
    procedure RedrawBlockDefinition(fromColumn: integer = 0; fromRow: integer = 0; motive: TAlxdRedrawMotive = [rmAll]);
    function  RedrawHeader(motive: TAlxdRedrawMotive): boolean;
    function  Recalculate: boolean;

    property  BlockDefinitionId: longint read FAlxdSpreadSheetExchange.BlockDefId;
    property  BlockReferenceId: longint read FAlxdSpreadSheetExchange.BlockRefId write Set_BlockReferenceId;
    property  BlockReferencePtrByJig: longint read FAlxdSpreadSheetExchange.BlockRefPtrJig write FAlxdSpreadSheetExchange.BlockRefPtrJig;
    property  HeaderReferenceId: longint read FAlxdSpreadSheetExchange.HeaderRefId;
    property  BlockDefinitionHandle: WideString read Get_BlockDefinitionHandle;
    property  BlockReferenceHandle: WideString read Get_BlockReferenceHandle;

    {property  BlockDefInsPt: TAds_point read FAlxdSpreadSheetExchange.BlockDefInsPt;
    property  BlockRefInsPt: TAds_point read FAlxdSpreadSheetExchange.BlockRefInsPt;
    property  BlockRefSclFt: TAds_point read FAlxdSpreadSheetExchange.BlockRefSclFt;}

    function  WriteToDictionary: boolean;
    function  ReadFromDictionary: boolean;

    function  WriteToXML(ADoc: IXMLNode): boolean;
    function  ReadFromXML(ADoc: IXMLNode): boolean;

    function  SaveToXML(AFileName: WideString): boolean;
    function  LoadFromXML(AFileName: WideString): boolean;

    function  SaveToString(var AValue: WideString): boolean;
    function  LoadFromString(AValue: WideString): boolean;

    function  Undo: boolean;
    function  Redo: boolean;

//    function  ImportAcDbTable: boolean;
//    function  ImportAlxdGrid6: boolean;

    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    //property OnPopupMenu: TOnPopupMenu read FOnPopupMenu write FOnPopupMenu;
  end;

implementation

uses
  uAlxdEditor;
  
////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

{function TAlxdSpreadSheetInt.Get_ScaledColWidth(Index: integer): integer;
begin
  Result:=Trunc(10 * FvarOptions.PixelToMmX);
end;
}
{
function TAlxdSpreadSheetInt.Get_ScaledRowHeight(Index: integer): integer;
begin
  Result:=Trunc(10 * FvarOptions.PixelToMmY);
end;
}
function  TAlxdSpreadSheetInt.CalcPage2TopLeft(currow, curcol: integer): TSize;
var
  ccell: TRect;
begin
  ccell.Bottom:=ClientRect.Bottom;
  ccell.Right:=ClientRect.Right;

  while (ccell.Bottom > FvarOptions.FixedRowHeight) and (currow > 0) do
  begin
    ccell.Top:=ccell.Bottom - FAlxdSpreadSheetArray.Rows.Items[currow].PaintSize;
    ccell.Bottom:=ccell.Top;
    Dec(currow);
  end;
  if ccell.Bottom <= FvarOptions.FixedRowHeight then Inc(currow);

  while (ccell.Right > FvarOptions.FixedColWidth) and (curcol > 0) do
  begin
    ccell.Left:=ccell.Right - FAlxdSpreadSheetArray.Columns.Items[curcol].PaintSize;
    ccell.Right:=ccell.Left;
    Dec(curcol);
  end;
  if ccell.Right <= FvarOptions.FixedColWidth then Inc(curcol);

  Result.cx:=LeftCol - curcol;
  Result.cy:=TopRow - currow;
end;

function  TAlxdSpreadSheetInt.CalcPage2BottomRight(currow, curcol: integer): TSize;
var
  ccell: TRect;
begin
  ccell.Top:=FvarOptions.FixedRowHeight;
  ccell.Left:=FvarOptions.FixedColWidth;

  //while (ccell.Top < ClientRect.Bottom) and (currow < FAlxdSpreadSheetArray.RowCountInt) do
  while (ccell.Top < ClientRect.Bottom) and (currow < FAlxdSpreadSheetArray.RowCountInt) do
  begin
    ccell.Bottom:=ccell.Top + FAlxdSpreadSheetArray.Rows.Items[currow].PaintSize;
    ccell.Top:=ccell.Bottom;
    Inc(currow);
  end;
  if ccell.Top >= ClientRect.Bottom then Dec(currow);

  //while (ccell.Left < ClientRect.Right) and (curcol < FAlxdSpreadSheetArray.ColCountInt) do
  while (ccell.Left < ClientRect.Right) and (curcol < FAlxdSpreadSheetArray.ColCountInt) do
  begin
    ccell.Right:=ccell.Left + FAlxdSpreadSheetArray.Columns.Items[curcol].PaintSize;
    ccell.Left:=ccell.Right;
    Inc(curcol);
  end;
  if ccell.Left >= ClientRect.Right then Dec(curcol);

  Result.cx:=curcol - LeftCol;
  Result.cy:=currow - TopRow;
end;

function  TAlxdSpreadSheetInt.CalcPlace(Pt: TPoint): TAlxdSpreadSheetPlacePos;
const
  BORDERSENSITIVE = 1;
var
  ccell: TRect;
  inrect, outrect: TRect;
  currow, curcol: integer;
  ishorborder: boolean;
  isverborder: boolean;
  dx, dy: integer;
  i: integer;
begin
  ishorborder:=false;
  isverborder:=false;
  Result.cell:=Point(-2, -2);

  if (Pt.Y <= FvarOptions.FixedRowHeight) then
    Result.cell.Y:=-1;

  if (Pt.X <= FvarOptions.FixedColWidth) then
    Result.cell.X:=-1;

  if (Result.cell.X = -1) and (Result.cell.Y = -1) then  
  begin
    Result.Place:=gpZero;
    exit;
  end;

//определение номера р€да, раз он не нулевой
  if (Pt.Y > FvarOptions.FixedRowHeight) then
  begin
    ccell.Top:=FvarOptions.FixedRowHeight;
    currow:=toprow;

    while (ccell.Top < ClientRect.Bottom) and (currow < FAlxdSpreadSheetArray.RowCountInt) do
    begin
      ccell.Top:=ccell.Top + FAlxdSpreadSheetArray.Rows.Items[currow].PaintSize;

      if Pt.Y < ccell.Top - BORDERSENSITIVE then
      begin
        Result.cell.Y:=currow;
        if (Result.cell.X = -1) then
        begin
          Result.Place:=gpLeftCol;
          exit;
        end;
        break;
      end
      else
      if (Pt.Y >= ccell.Top - BORDERSENSITIVE) and (Pt.Y <= ccell.Top + BORDERSENSITIVE) then
      begin
        Result.cell.Y:=currow;
        if (Result.cell.X = -1) then
        begin
          Result.Place:=gpRowSizing;
          exit;
        end;
        ishorborder:=true;
        break;
      end;
      Inc(currow);
    end;//while
  end;

//определение номера колонки, раз она не нулева€
  if (Pt.X > FvarOptions.FixedColWidth) then
  begin
    ccell.Left:=FvarOptions.FixedColWidth;
    curcol:=leftcol;

    while (ccell.Left < ClientRect.Right) and (curcol < FAlxdSpreadSheetArray.ColCountInt) do
    begin
      ccell.Left:=ccell.Left + FAlxdSpreadSheetArray.Columns.Items[curcol].PaintSize;

      if Pt.X < ccell.Left - BORDERSENSITIVE then
      begin
        Result.cell.X:=curcol;
        if (Result.cell.Y = -1) then
        begin
          Result.Place:=gpTopRow;
          exit;
        end;
        break;
      end
      else
      if (Pt.X >= ccell.Left - BORDERSENSITIVE) and (Pt.X <= ccell.Left + BORDERSENSITIVE) then
      begin
        Result.cell.X:=curcol;
        if (Result.cell.Y = -1) then
        begin
          Result.Place:=gpColSizing;
          exit;
        end;
        isverborder:=true;
        break;
      end;
      Inc(curcol);
    end;//while
  end;

//если хоть один параметр = -2, значит мышь на пустом поле играет
  if (Result.cell.X = -2) then
  begin
    Result.cell.X:=FAlxdSpreadSheetArray.ColCountInt - 1;
    Result.Place:=gpEmpty;
    exit;
  end;

  if (Result.cell.Y = -2) then
  begin
    Result.cell.Y:=FAlxdSpreadSheetArray.RowCountInt - 1;
    Result.Place:=gpEmpty;
    exit;
  end;

//если на бордюрах, то не бордюр ли выборки?
//  if ishorborder or isverborder then
//  begin
    //Result.Place:=gpBorder;

    dx:=-FAlxdSpreadSheetArray.Columns.PaintDeltaSize(0, LeftCol);
    dy:=-FAlxdSpreadSheetArray.Rows.PaintDeltaSize(0, TopRow);

    //выборка лишь одна

    with FAlxdSpreadSheetSelectionsInt do
      for i := 0 to Count - 1 do
      begin
        ccell:=Items[i].PaintSize;
        OffsetRect(ccell, dx, dy);
        OffsetRect(ccell, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

        inrect:=Rect(ccell.right - 3, ccell.bottom - 3, ccell.right + 3, ccell.bottom + 3);
        if RectHavePt(inrect, Pt) then
        begin
          Result.Place:=gpSelectionDot;
          exit;
        end;
        //SELECTIONBORDER

        inrect:=ccell;
        outrect:=ccell;
        InflateRect(inrect, -SELECTIONBORDER div 2, -SELECTIONBORDER div 2); //-1, -1);
        InflateRect(outrect, SELECTIONBORDER div 2, SELECTIONBORDER div 2); //2, 2);

        if RectHavePt(outrect, Pt) and not PtInRect(inrect, Pt) then
        begin
          Result.Place:=gpSelectionBorder;
          exit;
        end;

      end;
//  end;

//если мышь не на бордюрах, значит в €чейке
  //if not ishorborder and not isverborder then
    Result.Place:=gpCells;

  //if ishorborder or isverborder then
  //  Result.Place:=gpBorder;
//  begin

end;

function  TAlxdSpreadSheetInt.NeedVerScrollBar: boolean;
var
  i: integer;
  maxsize: integer;
  size: integer;
begin
  size:=0;
  maxsize:=ClientHeight - FvarOptions.FixedRowHeight;
  for i := 0 to FAlxdSpreadSheetArray.RowCountInt - 1 do
  begin
    size:=size + FAlxdSpreadSheetArray.Rows.Items[i].PaintSize;
    if size > maxsize then
    begin
      Result:=True;
      exit;
    end;
  end;

  Result:=False;
end;

function TAlxdSpreadSheetInt.NeedHorScrollBar: boolean;
var
  i: integer;
  maxsize: integer;
  size: integer;
begin
  size:=0;
  maxsize:=ClientWidth - FvarOptions.FixedColWidth;
  for i := 0 to FAlxdSpreadSheetArray.ColCountInt - 1 do
  begin
    size:=size + FAlxdSpreadSheetArray.Columns.Items[i].PaintSize;
    if size > maxsize then
    begin
      Result:=True;
      exit;
    end;
  end;

  Result:=False;
end;

procedure TAlxdSpreadSheetInt.ModifyScrollBar(ScrollBar, ScrollCode, Pos: Cardinal);
var
  si: SCROLLINFO;
  sz: TSize;
begin
  si.cbSize:=SizeOf(SCROLLINFO);
  si.fMask:=SIF_ALL;
  GetScrollInfo(Handle, ScrollBar, si);

  if ScrollBar = SB_VERT then
  begin
    case ScrollCode of
    SB_THUMBTRACK:
      begin
        TopRow:=si.nTrackPos;
        si.nPos:=TopRow;
      end;
    SB_PAGEDOWN:
      begin
        sz:=CalcPage2BottomRight(TopRow, LeftCol);
        TopRow:=TopRow + sz.cy;
        si.nPos:=TopRow;
      end;
    SB_PAGEUP:
      begin
        sz:=CalcPage2TopLeft(TopRow, LeftCol);
        TopRow:=TopRow - sz.cy;
        si.nPos:=TopRow;
      end;
    SB_LINEDOWN:
      begin
        TopRow:=TopRow + 1;
        si.nPos:=TopRow;
      end;
    SB_LINEUP:
      begin
        TopRow:=TopRow - 1;
        si.nPos:=TopRow;
      end;
    end;
  end;

  if ScrollBar = SB_HORZ then
  begin
    case ScrollCode of
    SB_THUMBTRACK:
      begin
        LeftCol:=si.nTrackPos;
        si.nPos:=LeftCol;
      end;
    SB_PAGEDOWN:
      begin
        sz:=CalcPage2BottomRight(TopRow, LeftCol);
        LeftCol:=LeftCol + sz.cx;
        si.nPos:=LeftCol;
      end;
    SB_PAGEUP:
      begin
        sz:=CalcPage2TopLeft(TopRow, LeftCol);
        LeftCol:=LeftCol - sz.cx;
        si.nPos:=LeftCol;
      end;
    SB_LINEDOWN:
      begin
        LeftCol:=LeftCol + 1;
        si.nPos:=LeftCol;
      end;
    SB_LINEUP:
      begin
        LeftCol:=LeftCol - 1;
        si.nPos:=LeftCol;
      end;
    end;
  end;

  si.fMask:=SIF_POS;
  SetScrollInfo(Handle, ScrollBar, si, True);

  Repaint;
end;

procedure TAlxdSpreadSheetInt.Set_AlxdSpreadSheetState(Value: TAlxdSpreadSheetState);
begin
  FAlxdSpreadSheetState:=Value;
end;

function  TAlxdSpreadSheetInt.Get_AlxdSpreadSheetState: TAlxdSpreadSheetState;
begin
  Result:=FAlxdSpreadSheetState;
end;

procedure TAlxdSpreadSheetInt.Set_FullFileName(Value: WideString);
begin
  FFullFileName:=Value;
end;

function  TAlxdSpreadSheetInt.Get_FullFileName: WideString;
begin
  Result:=FFullFileName;
end;

function  TAlxdSpreadSheetInt.Get_BlockDefinitionHandle: WideString;
begin
  Result:='';
  {$IFDEF DLL}
  if BlockDefinitionId > 0 then
    oarxId2Handle(BlockDefinitionId, Result);
  {$ENDIF}
end;

function  TAlxdSpreadSheetInt.Get_BlockReferenceHandle: WideString;
begin
  Result:='';
  {$IFDEF DLL}
  if BlockReferenceId > 0 then
    oarxId2Handle(BlockReferenceId, Result);
  {$ENDIF}
end;

function  TAlxdSpreadSheetInt.GetCellValue(const ACell: String; var AValue: String): boolean;
var
  cc: TCellCoord;
begin
  AValue:='';
  Result:=Formula2Cell(ACell, cc);
  if Result then
    AValue:=FAlxdSpreadSheetArray.Cells.Items[cc.Cell.X, cc.Cell.Y].Text;
end;

function  TAlxdSpreadSheetInt.GetRangeValues(const AStartCell, AEndCell: String; var AValue: String): boolean;
var
  sc, ec: TCellCoord;
  i, j: integer;
  first: boolean;
begin
  AValue:='';
  Result:=Formula2Cell(AStartCell, sc);
  if not Result then exit;
  Result:=Formula2Cell(AEndCell, ec);
  if not Result then exit;
  AValue:='''(';
  first:=true;
  for i:=sc.Cell.X to ec.Cell.X do
    for j:=sc.Cell.Y to ec.Cell.Y do
      with FAlxdSpreadSheetArray do
        if not Cells.Items[i, j].IsJoinedCell then
          if first then
          begin
            AValue:=AValue + Cells.Items[i, j].Text;
            first:=false;
          end
          else
            AValue:=AValue + ' ' + Cells.Items[i, j].Text;
  AValue:=AValue + ')';
  result:=true;
end;

function  TAlxdSpreadSheetInt.GetShiftedCell(const ACell: String; const DX, DY: integer; var AValue: String): boolean;
var
  cc: TCellCoord;
  w: WideString;
begin
  AValue:='';
  Result:=Formula2Cell(ACell, cc);
  if Result then
  begin
    if not cc.Xconst then
      cc.Cell.X := cc.Cell.X + DX;

    if not cc.Yconst then
      cc.Cell.Y := cc.Cell.Y + DY;

    Result:=Cell2Formula(cc, w);
    AValue:=w;
  end;
end;

procedure TAlxdSpreadSheetInt.ShiftCellValue(Source, Dest: TPoint; dx, dy: integer);
var
  s, o: string;
begin
  with FAlxdSpreadSheetArray do
  if Cells.Items[Source.X, Source.Y].HasFormula then
  begin
    s:=Cells.Items[Source.X, Source.Y].Formula;
    ShiftCells(s, o, dx, dy, GetShiftedCell);
    Cells.Items[Dest.X, Dest.Y].Formula:=o;
  end;
end;

procedure TAlxdSpreadSheetInt.ShiftCellValue(Source, Dest: TPoint);
var
  dx: integer;
  dy: integer;
  s, o: string;
begin
  with FAlxdSpreadSheetArray do
  if Cells.Items[Source.X, Source.Y].HasFormula then
  begin
    dx:=Dest.X - Source.X;
    dy:=Dest.Y - Source.Y;
    //shift cells in formula
    s:=Cells.Items[Source.X, Source.Y].Formula;
    ShiftCells(s, o, dx, dy, GetShiftedCell);
    Cells.Items[Dest.X, Dest.Y].Formula:=o;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Protected
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdSpreadSheetInt.Get_AlxdSpreadSheetStyle: TAlxdSpreadSheetStyleInt;
begin
  Result:=FAlxdSpreadSheetStyleInt;
end;

function  TAlxdSpreadSheetInt.Get_AlxdSpreadSheetArray: TAlxdSpreadSheetArray;
begin
  Result:=FAlxdSpreadSheetArray;
end;

function  TAlxdSpreadSheetInt.Get_AlxdSpreadSheetSelections: TAlxdSpreadSheetSelectionsInt;
begin
  Result:=FAlxdSpreadSheetSelectionsInt;
end;

function  TAlxdSpreadSheetInt.Get_EditorMode: boolean;
begin
  Result:=FEditInfo.FEditorMode;
end;

function  TAlxdSpreadSheetInt.Get_EditorHandle: integer;
begin
  Result:=0;
  with FEditInfo do
    if Assigned(FEditor) then
      Result:=FEditor.Handle;
end;

procedure TAlxdSpreadSheetInt.Set_AlxdSpreadSheetStyle(Value: TAlxdSpreadSheetStyleInt);
begin
  FAlxdSpreadSheetStyleInt.Assign(Value);
end;

procedure TAlxdSpreadSheetInt.Set_AlxdSpreadSheetArray(Value: TAlxdSpreadSheetArray);
begin
  FAlxdSpreadSheetArray:=Value;
end;

procedure TAlxdSpreadSheetInt.Set_AlxdSpreadSheetSelections(Value: TAlxdSpreadSheetSelectionsInt);
begin
  FAlxdSpreadSheetSelectionsInt.Assign(Value);
end;

procedure TAlxdSpreadSheetInt.Set_EditorMode(Value: boolean);
begin
  if FEditInfo.FEditorMode <> Value then
  begin
    FEditInfo.FEditorMode:=Value;

    if Value {show} then
    begin
      ShowEditor;
//      UpdateEditorAlignment;
      UpdateEditorPos;
      UpdateEditorSize;
      with FEditInfo.FEditor do
      begin
        SelStart:=0;
        SelStart:=Length(Text);
      end;
    end
    else
    begin
      HideEditor;
    end;

    FAlxdFormulaSelectionsInt.Clear;
    AlxdSpreadSheetState:=gsReadySelectCell;
  end;
end;

procedure TAlxdSpreadSheetInt.Set_BlockReferenceId(Value: longint);
begin
  if Value <> FAlxdSpreadSheetExchange.BlockRefId then
  begin
    FAlxdSpreadSheetExchange.BlockRefId:=Value;
    {$IFDEF DLL}
    oarxApplyBlockRef(@FAlxdSpreadSheetExchange);
    {$ENDIF}
  end;
end;

procedure TAlxdSpreadSheetInt.Set_LeftCol(Value: integer);
begin
  if Value < 0 then
    FLeftCol:=0
  else
  if Value > FAlxdSpreadSheetArray.ColCountInt - 1 then
    FLeftCol:=FAlxdSpreadSheetArray.ColCountInt - 1
  else
  begin
    FLeftCol:=Value;
    if EditorMode then
    begin
      UpdateEditorPos;
      UpdateEditorSize;
    end;    
  end;

{  if (Value >= 0) and (Value < FAlxdSpreadSheetArray.ColCount) then
    FLeftCol:=Value;}
end;

procedure TAlxdSpreadSheetInt.Set_TopRow(Value: integer);
begin
  if Value < 0 then
    FTopRow:=0
  else
  if Value > FAlxdSpreadSheetArray.RowCountInt - 1 then
    FTopRow:=FAlxdSpreadSheetArray.RowCountInt - 1
  else
  begin
    FTopRow:=Value;
    if EditorMode then
    begin
      UpdateEditorPos;
      UpdateEditorSize;
    end;
  end;

{  if (Value >= 0) and (Value < FAlxdSpreadSheetArray.RowCount) then
    FTopRow:=Value;}
end;

function  TAlxdSpreadSheetInt.Get_RightCol: integer;
var
  sz: TSize;
begin
  sz:=CalcPage2BottomRight(TopRow, LeftCol);
  Result:=LeftCol + sz.cx;
end;

procedure TAlxdSpreadSheetInt.Set_RightCol(Value: integer);
var
  sz: TSize;
begin
  sz:=CalcPage2BottomRight(TopRow, LeftCol);
  LeftCol:=Value - sz.cx;
end;

function  TAlxdSpreadSheetInt.Get_BottomRow: integer;
var
  sz: TSize;
begin
  sz:=CalcPage2BottomRight(TopRow, LeftCol);
  Result:=TopRow + sz.cy;
end;

procedure TAlxdSpreadSheetInt.Set_BottomRow(Value: integer);
var
  sz: TSize;
begin
  sz:=CalcPage2BottomRight(TopRow, LeftCol);
  TopRow:=Value - sz.cy;
end;

procedure TAlxdSpreadSheetInt.ShowEditor;
begin
{$IFDEF ASSDEBUG}
  OutputDebugString('TAlxdSpreadSheet.ShowEditor');
{$ENDIF}
  with FEditInfo do
  begin
    FEditCell:=Pointer(AlxdSpreadSheetSelections.CurrentCell);
    //FEditCell:=AlxdSpreadSheetSelections.CurrentCell.SelectionRect.TopLeft;
    FOldText:=FAlxdSpreadSheetArray.Cells.Items[FEditCell.Left, FEditCell.Top].Contain;
    with FEditor do
    begin
      HandleNeeded;
      Text:=FOldText;
//      SelStart:=Length(Text);
    end;
  end;
end;

procedure TAlxdSpreadSheetInt.HideEditor;
begin
{$IFDEF ASSDEBUG}
  OutputDebugString('TAlxdSpreadSheet.HideEditor');
{$ENDIF}
  with FEditinfo do
  begin
    FAlxdSpreadSheetArray.Cells.Items[FEditCell.Left, FEditCell.Top].Contain:=FEditor.Text;
//    CellWideContain[FEditCell.X, FEditCell.Y]:=FEditor.Text;
//    Recalculate;
    if Recalculate then
      RedrawBlockDefinition(0, 0)
    else
      RedrawBlockDefinition(FEditCell.Left, FEditCell.Top, [rmCells, rmOneCell]);

    FOldText:='';
    FEditCell:=nil;
//    FEditCell:=Point(-1, -1);
    //FEditorRect:=Rect(0, 0, 0, 0);
    FEditor.Hide;

    AlxdUndo.Fix;
  end;
end;

procedure TAlxdSpreadSheetInt.UpdateEditorPos;
begin
{$IFDEF DEBUG}
  OutputDebugString('TAlxdSpreadSheetInt.UpdateEditorPos');
{$ENDIF}
  with FEditinfo do
  begin
    //FEditCell.SelectionCell
    //FEditorRect:=FEditCell.PaintSize;
    FEditorRect:=FAlxdSpreadSheetArray.Cells.Items[FEditCell.Left, FEditCell.Top].PaintSize;

    OffsetRect(FEditorRect, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

    if FEditCell.Left < LeftCol then
      OffsetRect(FEditorRect, -FAlxdSpreadSheetArray.Columns.PaintDeltaSize(FEditCell.Left, LeftCol - FEditCell.Left), 0)
    else
      OffsetRect(FEditorRect, FAlxdSpreadSheetArray.Columns.PaintDeltaSize(LeftCol, FEditCell.Left - LeftCol), 0);

    if FEditCell.Top < TopRow then
      OffsetRect(FEditorRect, 0, -FAlxdSpreadSheetArray.Rows.PaintDeltaSize(FEditCell.Top, TopRow - FEditCell.Top))
    else
      OffsetRect(FEditorRect, 0, FAlxdSpreadSheetArray.Rows.PaintDeltaSize(TopRow, FEditCell.Top - TopRow));

    InflateRect(FEditorRect, -1, -1);
    Inc(FEditorRect.Right, 1);
    Inc(FEditorRect.Bottom, 1);

    IntersectRect(FEditorRect, FEditorRect, Rect(FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight, ClientRect.Right, ClientRect.Bottom));

    FEditor.Move(FEditorRect);

    //FEditorRect.Left:=FEditorRect.Left + FAlxdSpreadSheetArray.Columns.PaintDeltaSize(FEditCell.SelectionCell.X, FEditCell.SelectionCell.X - LeftCol);
    //FEditorRect.Top:=FEditorRect.Top + FAlxdSpreadSheetArray.Rows.PaintDeltaSize(FEditCell.SelectionCell.Y, FEditCell.SelectionCell.Y - TopRow);

    //FEditorRect.Right:=FEditorRect.Left + FEditCell.PaintSize;
{
    FAlxdSpreadSheetArray.Columns.PaintDeltaSize(pntcol, LeftCol - pntcol)

    with FCurrentRect do
      pr:=CalcSelectionRect(MakeSelection(Left, Top, Right, Bottom, stUsually));
    InflateRect(pr, -1, -1);
    Inc(pr.Right, LINEWIDTH);
    Inc(pr.Bottom, LINEWIDTH);

    IntersectRect(pr, pr, FDrawExtents);
    FEditClientRect:=pr;

    FEditor.Move(FEditClientRect);}
  end;
end;

procedure TAlxdSpreadSheetInt.UpdateEditorSize;
const
  SIZED = 12;
var
  cr: TRect;
  charsize: TSize;
  newHeight: integer;
  newWidth: integer;
  scrollSize: integer;
  d: integer;
begin
{$IFDEF DEBUG}
  OutputDebugString('TAlxdSpreadSheetInt.UpdateEditorSize');
{$ENDIF}
  with FEditinfo do
  if not IsRectEmpty(FEditorRect) then
  begin
    //clear cr
    FillChar(cr, SizeOf(cr), 0);
    //calc etalon size
    AlxdDrawText(Canvas.Handle, 'QQ', -1, cr, DT_CALCRECT, nil);
    charsize.cx:=cr.Right - cr.Left + 2;
    charsize.cy:=cr.Bottom - cr.Top + 2;

    //calc string width
    AlxdDrawText(Canvas.Handle, FEditor.Text, -1, cr, DT_CALCRECT, nil);

    //calc width
    newWidth:=cr.Right - cr.Left + GetSystemMetrics(SM_CXBORDER) * 4;// + indentx;
    newWidth:=newWidth + charsize.cx;

    scrollSize:=0;
    //if FVerScrollVisible then
    //  scrollSize:=GetSystemMetrics(SM_CYVSCROLL);

    d:=FEditorRect.Right - FEditorRect.Left;
    if d > newWidth then
      newWidth := d;

    if newWidth + FEditor.Left > ClientWidth - scrollSize then
      newWidth := ClientWidth - scrollSize - FEditor.Left;

    cr.Right:=cr.Left + newWidth;
    if (FEditor.Width > (newWidth * (SIZED div 2)) div 100) then
      FEditor.Width:=newWidth;

    //calc string height
    if FEditor.WordWrap then
      AlxdDrawText(Canvas.Handle, FEditor.Text, -1, cr, DT_WORDBREAK or DT_CALCRECT, nil);

    //calc height
    newHeight:=cr.Bottom - cr.Top + GetSystemMetrics(SM_CYBORDER) * 4;
    newHeight:=newHeight + charsize.cy;

    scrollSize:=0;
    //if FHorScrollVisible then
    //  scrollSize:=GetSystemMetrics(SM_CYHSCROLL);

    if FEditorRect.Bottom - FEditorRect.Top > newHeight then
      newHeight:=FEditorRect.Bottom - FEditorRect.Top;

    if newHeight + FEditor.Top > ClientHeight - scrollSize then
      newHeight:=ClientHeight - scrollSize - FEditor.Top;

    FEditor.Height:=newHeight;
  end;
end;

procedure TAlxdSpreadSheetInt.UpdateEditorText;
begin
{$IFDEF ASSDEBUG}
  OutputDebugString('TAlxdSpreadSheetInt.UpdateEditorText');
{$ENDIF}
  KillTimer(Handle, 2);
  SetTimer(Handle, 2, FvarOptions.SyncDelay, nil);
  //update text see wm_timer
end;

procedure TAlxdSpreadSheetInt.UpdateEditorSyntaxPattern;
var
  i: integer;
  j: integer;
  v: TSyntaxPattern;
begin
  if EditorMode then
  with FEditInfo.FEditor do
  begin
    SyntaxPatternClear;//replace to Reset in future
    for i := 0 to FAlxdFormulaSelectionsInt.Count - 1 do
    begin
      j:=SyntaxPatternAdd;
      v.SyntaxPattern:=FAlxdFormulaSelectionsInt.Items[i].Formula;
      v.Color:=FAlxdFormulaSelectionsInt.ColorByIndex(i);
      SyntaxPatterns[j]:=v;
    end;
    SyntaxPatternRepaint;
  end;
end;

function TAlxdSpreadSheetInt.ChangeCellSelection(Source, Dest: TRect; ChangeCell: TChangeCell): boolean;
var
  backwards: boolean;
  i, j: integer;
//  ss, sd: TSelection;
//  s: string;
begin
//  Result:=False;

{  with Source do
    ss:=MakeSelection(Left, Top, Right, Bottom, stUsually);
  ExtendSelection(ss);

  with Dest do
    sd:=MakeSelection(Left, Top, Right, Bottom, stUsually);
  ExtendSelection(sd);
}
  //if not (EqualRect(ss.Rect, Source) and EqualRect(sd.Rect, Dest)) then
  //begin
//    AlxdMessageBox(0, 'Message#', nil, 0);
//    {$IFDEF DLL}
//    globalstring:=MessageMemIniFile(2803);
//    PostMessage(Handle, WM_ALXD_MESSAGEBOX, MB_ICONQUESTION + MB_OK, Integer(PChar(globalstring)));
//    {$ENDIF}
  //  Exit;
  //end;

  backwards:=(Dest.Left > Source.Left) or (Dest.Top > Source.Top);
  //backwards:=false;

  if backwards then
  begin
    for i:=Source.Right downto Source.Left do
      for j:=Source.Bottom downto Source.Top do
      begin
        ChangeCell(Point(i, j), Point(Dest.Left + i - Source.Left, Dest.Top + j - Source.Top));
      end;
  end
  else
  begin
    for i:=Source.Left to Source.Right do
      for j:=Source.Top to Source.Bottom do
      begin
        ChangeCell(Point(i, j), Point(Dest.Left + i - Source.Left, Dest.Top + j - Source.Top));
      end;
  end;

  Result:=True;
end;

function  TAlxdSpreadSheetInt.ExpandCellSelection(Source, Dest: TRect; ChangeCell: TChangeCell): boolean;
var
  i, j: integer;
  dx, dy: integer;

  procedure CopyY;
  var
    SourcePt: TPoint;
    DestPt: TPoint;
  begin
    SourcePt:=Point(i, j - Sign(dy));
    DestPt:=Point(i, j);
    ChangeCell(SourcePt, DestPt);
  end;

  procedure CopyX;
  var
    SourcePt: TPoint;
    DestPt: TPoint;
  begin
    SourcePt:=Point(i - Sign(dx), j);
    DestPt:=Point(i, j);
    ChangeCell(SourcePt, DestPt);
  end;

begin
  if (Source.Top = Dest.Top) then
  begin
    dy:=Dest.Bottom - Source.Bottom;
    for j:=Source.Bottom + 1 to Dest.Bottom do
      for i:=Source.Left to Source.Right do
        CopyY;
  end
  else
  begin
    dy:=Dest.Top - Source.Top;
    for j:=Source.Top-1 downto Dest.Top do
      for i:=Source.Left to Source.Right do
        CopyY;
  end;

  if (Source.Left = Dest.Left) then
  begin
    dx:=Dest.Right - Source.Right;
    for i:=Source.Right+1 to Dest.Right do
      for j:=Dest.Top to Dest.Bottom do
        CopyX;
  end
  else
  begin
    dx:=Dest.Left - Source.Left;
    for i:=Source.Left-1 downto Dest.Left do
      for j:=Dest.Top to Dest.Bottom do
        CopyX;
  end;

  Result:=True;
end;

procedure TAlxdSpreadSheetInt.MoveCellContent(Source, Dest: TPoint);
begin
  FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].CopyContent(FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y]);
  ShiftCellValue(Source, Dest);

  FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y].ClearContent;
end;

procedure TAlxdSpreadSheetInt.CopyCellContent(Source, Dest: TPoint);
begin
  FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].CopyContent(FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y]);
  ShiftCellValue(Source, Dest);
end;

procedure TAlxdSpreadSheetInt.IncCopyCellContent(Source, Dest: TPoint);
var
  delta: integer;
  r: TRegExpr;
  w: WideString;
  s: WideString;
  v: double;
  b: boolean;
  i: integer;
  t: WideString;
  g: integer;
begin
  if FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y].HasFormula then
    ShiftCellValue(Source, Dest)
  else
  begin
    delta:=ifthen(Abs(Dest.X - Source.X) > Abs(Dest.Y - Source.Y), Dest.X - Source.X, Dest.Y - Source.Y);
    //delta:=Max(Dest.X - Source.X, Dest.Y - Source.Y);
    w:=FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y].ContainAsMText;
    s:=w;

    r:=TRegExpr.Create;
    try
      r.Expression:='-?\d+\.?\d?';
      g:=0;

      if r.Exec(w) then
      repeat

        if AlxdDisToF(r.Match[0], v) then
        begin
          b:=(Round(v - Frac(v)) = v);

          for i := 0 to r.SubExprMatchCount do
          begin
            v:=v+delta;

            if b then
              t:=IntToStr(Round(v))
            else
              t:=AlxdRToS(v);

            s:=LeftStr(s, r.MatchPos[i] - 1 + g) + t + RightStr(w, Length(w) - r.MatchPos[i] - r.MatchLen[i] + 1);
            g:=g + (Length(t) - r.MatchLen[i]);
          end;//for
        end;//if

      until not r.ExecNext;

      FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].Contain:=s;
    finally
      r.Free;
    end;
  end;//if HasFormula
end;

procedure TAlxdSpreadSheetInt.ExchangeCellContent(Source, Dest: TPoint);
var
  w: WideString;
  dx, dy: integer;
begin
  //keep dest value
  w:=FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].Contain;
  //copy value only
  FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].CopyContent(FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y]);
  dx:=dest.X - source.X;
  dy:=dest.Y - source.Y;
  ShiftCellValue(Dest, Dest, dx, dy);

  //assign kept value
  FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y].Contain:=w;
  dx:= dx * -1;
  dy:= dy * -1;
  ShiftCellValue(Source, Source, dx, dy);
end;

procedure TAlxdSpreadSheetInt.AppendCellContent(Source, Dest: TPoint);
begin
  with FAlxdSpreadSheetArray.Cells do
    Items[Dest.X, Dest.Y].Contain:=Items[Dest.X, Dest.Y].Contain + Items[Source.X, Source.Y].Contain;
end;

procedure TAlxdSpreadSheetInt.MoveCellFormat(Source, Dest: TPoint);
begin
  FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].CopyFormat(FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y]);
  FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y].ClearFormat;
end;

procedure TAlxdSpreadSheetInt.CopyCellFormat(Source, Dest: TPoint);
begin
  FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].CopyFormat(FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y]);
end;

procedure TAlxdSpreadSheetInt.ExchangeCellFormat(Source, Dest: TPoint);
var
  tmp: TAlxdCellInt;
begin
  tmp:=TAlxdCellInt.CreateEx(nil, -1, -1);
  try
    tmp.Assign(FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y]);
    FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].CopyFormat(FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y]);
    FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y].CopyFormat(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TAlxdSpreadSheetInt.MoveCellAll(Source, Dest: TPoint);
begin
  FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].CopyAll(FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y]);
  ShiftCellValue(Source, Dest);

  FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y].ClearAll;
end;

procedure TAlxdSpreadSheetInt.CopyCellAll(Source, Dest: TPoint);
begin
  FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].CopyAll(FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y]);
  ShiftCellValue(Source, Dest);
end;

procedure TAlxdSpreadSheetInt.IncCopyCellAll(Source, Dest: TPoint);
begin
  IncCopyCellContent(Source, Dest);
  CopyCellFormat(Source, Dest);
end;

procedure TAlxdSpreadSheetInt.ExchangeCellAll(Source, Dest: TPoint);
var
  tmp: TAlxdCellInt;
  dx, dy: integer;  
begin
  tmp:=TAlxdCellInt.CreateEx(nil, -1, -1);
  try
    tmp.Assign(FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y]);
    FAlxdSpreadSheetArray.Cells.Items[Dest.X, Dest.Y].CopyAll(FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y]);
    dx:=dest.X - source.X;
    dy:=dest.Y - source.Y;
    ShiftCellValue(Dest, Dest, dx, dy);

    FAlxdSpreadSheetArray.Cells.Items[Source.X, Source.Y].CopyAll(tmp);
    dx:= dx * -1;
    dy:= dy * -1;
    ShiftCellValue(Source, Source, dx, dy);

  finally
    tmp.Free;
  end;
end;

procedure TAlxdSpreadSheetInt.StateMachine(Message: TMessage);
var
  pt: TPoint;
  ptc: TPoint;
  newsize: double;
  placepos: TAlxdSpreadSheetPlacePos;
  tempselection: TAlxdSpreadSheetSelectionInt;
  //frmlselection: TAlxdSpreadSheetSelectionInt;
  needinvalidate: boolean;
  //psize: TSize;
begin

  GetCursorPos(pt);
  ptc:=ScreenToClient(Pt);
  {$IFDEF DEBUG}
//  OutputDebugString(PChar(Format('StateMachine + pt : %d,%d', [ptc.X, ptc.Y])));
  {$ENDIF}

  placepos:=CalcPlace(ptc);
  {$IFDEF DEBUG}
  OutputDebugString(PChar(Format('StateMachine + placepos.cell : %d,%d', [placepos.cell.X, placepos.cell.Y])));
  OutputDebugString(PChar(Format('StateMachine + placepos.place : %d', [Ord(placepos.place)])));
  {$ENDIF}

  //if not (csDesigning in ComponentState) then
  //  if not Focused then
  //    SetFocus;

  {if EditorMode then
  begin
    OutputDebugString('StateMachine + EDITORMODE');
  end;}

  needinvalidate:=false;
  tempselection:=TAlxdSpreadSheetSelectionInt.Create(Self);
//  frmlselection:=TAlxdSpreadSheetSelectionInt.Create(Self);
  try
    with FAlxdSpreadSheetSelectionsInt do
      if Count > 0 then
        tempselection.Assign(Items[Count-1]);

{    with FAlxdFormulaSelectionsInt do
      if Count > 0 then
        frmlselection.Assign(Items[Count-1]);}
        {
        if (placepos.place = gpEmpty) and (AlxdSpreadSheetState <> gsReadySelectCell) then
        begin
          AlxdSpreadSheetState:=gsReadySelectCell;
          PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);
        end;
        }
//
// input state switcher
//
    case AlxdSpreadSheetState of
    gsReadySelectCell..gsReadySelection2Assist:
    //if AlxdSpreadSheetState in [gsReadySelectCell..gsReadySelection2Assist] then
//      if (Message.Msg = WM_MOUSEMOVE) or (Message.Msg = WM_RBUTTONDOWN) then
      case Message.Msg of
{      if (Message.Msg = WM_MOUSEMOVE) or
         (Message.Msg = WM_LBUTTONDOWN) or
         (Message.Msg = WM_RBUTTONDOWN) then}
      WM_COMMAND:
        begin
          if EditorMode then
            if FEditInfo.FEditor.IsFormula then
            begin
              FAlxdFormulaSelectionsInt.FillOutByFormula(FEditInfo.FEditor.Text);
              AlxdSpreadSheetState:=gsWaitFormulaSelect;//gsReadySelectCell2Formula;
              //StateMachineFormula(Message);
              needinvalidate:=True;
            end;
        end;
      WM_MOUSEACTIVATE:
        begin
          {if not (csDesigning in ComponentState) then
          begin
            EditorMode:=False;
            if not Focused then
              SetFocus;
          end;}
          if not EditorMode then
            PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);

          //PostMessage(Handle, WM_LBUTTONDOWN, 0, MakeLong(pt.X, pt.Y));

          {$IFDEF DEBUG}
          OutputDebugString('StateMachine + WM_MOUSEACTIVATE');
          //OutputDebugString(PChar(Format('StateMachine + WM_KEYDOWN + VK_TAB + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
          {$ENDIF}
        end;
      WM_MOUSEMOVE,WM_LBUTTONDOWN, WM_RBUTTONDOWN:
      //WM_MOUSEMOVE:
        begin
          //if not Message.Msg = WM_MOUSEMOVE then
          if Message.Msg = WM_LBUTTONDOWN then
            if not (csDesigning in ComponentState) then
            begin
              if EditorMode then
              begin
                EditorMode:=False;
                needinvalidate:=true;
              end;
              
              if not Focused then
                SetFocus;
            end;

          //if Message.Msg = WM_MOUSEMOVE then
                 
          case placepos.place of
          gpZero, gpCells:
            begin
              AlxdSpreadSheetState:=gsReadySelectCell;
            end;
          gpTopRow:
            begin
              AlxdSpreadSheetState:=gsReadySelectCol;
            end;
          gpLeftCol:
            begin
              AlxdSpreadSheetState:=gsReadySelectRow;
            end;
          gpColSizing:
            begin
              AlxdSpreadSheetState:=gsReadySizingCol;
            end;
          gpRowSizing:
            begin
              AlxdSpreadSheetState:=gsReadySizingRow;
            end;
          gpSelectionBorder:
            begin
              if GetKeyState(VK_CONTROL) < 0 then
              begin
                AlxdSpreadSheetState:=gsReadySelectionCopy;
              end
              else
              begin
                AlxdSpreadSheetState:=gsReadySelectionMove;
              end;
            end;
          gpSelectionDot:
            begin
              if FAlxdSpreadSheetSelectionsInt.Count = 1 then
                if GetKeyState(VK_CONTROL) < 0 then
                begin
                  AlxdSpreadSheetState:=gsReadySelectionExpandInc;
                end
                else
                begin
                  AlxdSpreadSheetState:=gsReadySelectionExpand;
                end;
              //  AlxdSpreadSheetState:=gsReadySelectionExpand;
            end;
          gpEmpty:
            begin
              AlxdSpreadSheetState:=gsReadySelectCell;
            end;
          end;
          //cursor change HERE!?
          //if not EditorMode then
          //  PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);

        end;
      {
      WM_LBUTTONDOWN, WM_RBUTTONDOWN:
        begin
          if not (csDesigning in ComponentState) then
          begin
            EditorMode:=False;
            if not Focused then
              SetFocus;
          end;
        end;
        }
      WM_KEYDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          {if GetKeyState(VK_SHIFT) < 0 then
            AlxdSpreadSheetState:=gsSelectCell
          else}
          case Message.WParam of
          VK_ESCAPE:
            if EditorMode then
            begin
              with FEditInfo do
              begin
                FEditor.Lines.Text:=FOldText;
                FEditor.SelStart:=Length(FOldText);
              end;
              EditorMode:=False;
              Invalidate;
              //needinvalidate:=True;
            end;
          VK_DOWN:
            begin
              EditorMode:=False;
              if GetKeyState(VK_SHIFT) < 0 then
                AlxdSpreadSheetState:=gsSelectCell
              else
              begin
                ClearToOne;

                CurrentCell.SelectionType:=stUsually;
                //CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Left, CurrentCell.SelectionRect.Bottom + 1, CurrentCell.SelectionRect.Right, CurrentCell.SelectionRect.Bottom + 1);
                if GetKeyState(VK_CONTROL) < 0 then
                  CurrentCell.SelectionRect:=Rect(LastSelectedCell.SelectionCell.X, FAlxdSpreadSheetArray.RowCountInt - 1, LastSelectedCell.SelectionCell.X, FAlxdSpreadSheetArray.RowCountInt - 1)
                else
                  //CurrentCell.SelectionRect:=Rect(LastSelectedCell.SelectionCell.X, CurrentCell.SelectionRect.Bottom + 1, LastSelectedCell.SelectionCell.X, CurrentCell.SelectionRect.Bottom + 1);
                  CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionCell.X, CurrentCell.SelectionRect.Bottom + 1, CurrentCell.SelectionCell.X, CurrentCell.SelectionRect.Bottom + 1);
                //CurrentCell.SelectionCell:=Point(LastSelectedCell.SelectionCell.X, CurrentCell.SelectionRect.Bottom);
                CurrentCell.SelectionCell:=Point(CurrentCell.SelectionCell.X, CurrentCell.SelectionRect.Bottom);

                LastSelectedCell.Assign(CurrentCell);

                //tempselection.SelectionRect:=CurrentCell.SelectionRect;
                tempselection.Assign(CurrentCell);

                //psize:=CalcPage2TopLeft(CurrentCell.SelectionCell.X, CurrentCell.SelectionCell.Y);
                //Set_BottomRow(LastSelectedCell.SelectionRect.Bottom);
                if BottomRow < LastSelectedCell.SelectionRect.Bottom + 1 then
                  BottomRow:=LastSelectedCell.SelectionRect.Bottom + 1;
                needinvalidate:=true;
              end;
            end;
          VK_UP:
            begin
              EditorMode:=False;
              if GetKeyState(VK_SHIFT) < 0 then
                AlxdSpreadSheetState:=gsSelectCell
              else
              begin
                ClearToOne;

                CurrentCell.SelectionType:=stUsually;
                //CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Left, CurrentCell.SelectionRect.Top - 1, CurrentCell.SelectionRect.Right, CurrentCell.SelectionRect.Top - 1);
                if GetKeyState(VK_CONTROL) < 0 then
                  CurrentCell.SelectionRect:=Rect(LastSelectedCell.SelectionCell.X, 0, LastSelectedCell.SelectionCell.X, 0)
                else
                  //CurrentCell.SelectionRect:=Rect(LastSelectedCell.SelectionCell.X, CurrentCell.SelectionRect.Top - 1, LastSelectedCell.SelectionCell.X, CurrentCell.SelectionRect.Top - 1);
                  CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionCell.X, CurrentCell.SelectionRect.Top - 1, CurrentCell.SelectionCell.X, CurrentCell.SelectionRect.Top - 1);
                //CurrentCell.SelectionCell:=Point(LastSelectedCell.SelectionCell.X, CurrentCell.SelectionRect.Top);
                CurrentCell.SelectionCell:=Point(CurrentCell.SelectionCell.X, CurrentCell.SelectionRect.Top);

                LastSelectedCell.Assign(CurrentCell);

                //tempselection.SelectionRect:=CurrentCell.SelectionRect;
                tempselection.Assign(CurrentCell);

                if TopRow > LastSelectedCell.SelectionRect.Top then
                  TopRow:=LastSelectedCell.SelectionRect.Top;
                needinvalidate:=true;
              end;
            end;
          VK_LEFT:
            begin
              EditorMode:=False;
              if GetKeyState(VK_SHIFT) < 0 then
                AlxdSpreadSheetState:=gsSelectCell
              else
              begin
                ClearToOne;

                CurrentCell.SelectionType:=stUsually;
                //CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Left, CurrentCell.SelectionRect.Top - 1, CurrentCell.SelectionRect.Right, CurrentCell.SelectionRect.Top - 1);
                if GetKeyState(VK_CONTROL) < 0 then
                  CurrentCell.SelectionRect:=Rect(0, LastSelectedCell.SelectionCell.Y, 0, LastSelectedCell.SelectionCell.Y)
                else
                  //CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Left-1, LastSelectedCell.SelectionCell.Y, CurrentCell.SelectionRect.Left - 1, LastSelectedCell.SelectionCell.Y);
                  CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Left - 1, CurrentCell.SelectionCell.Y, CurrentCell.SelectionRect.Left - 1, CurrentCell.SelectionCell.Y);
                //CurrentCell.SelectionCell:=Point(CurrentCell.SelectionRect.Left, LastSelectedCell.SelectionCell.Y);
                CurrentCell.SelectionCell:=Point(CurrentCell.SelectionRect.Left, CurrentCell.SelectionCell.Y);

                LastSelectedCell.Assign(CurrentCell);

                //tempselection.SelectionRect:=CurrentCell.SelectionRect;
                tempselection.Assign(CurrentCell);

                if LeftCol > LastSelectedCell.SelectionRect.Left then
                  LeftCol:=LastSelectedCell.SelectionRect.Left;
                needinvalidate:=true;
              end;
            end;
          VK_RIGHT:
            begin
              EditorMode:=False;
              if GetKeyState(VK_SHIFT) < 0 then
                AlxdSpreadSheetState:=gsSelectCell
              else
              begin
                ClearToOne;

                CurrentCell.SelectionType:=stUsually;
                //CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Left, CurrentCell.SelectionRect.Top - 1, CurrentCell.SelectionRect.Right, CurrentCell.SelectionRect.Top - 1);
                if GetKeyState(VK_CONTROL) < 0 then
                  CurrentCell.SelectionRect:=Rect(FAlxdSpreadSheetArray.ColCountInt - 1, LastSelectedCell.SelectionCell.Y, FAlxdSpreadSheetArray.ColCountInt - 1, LastSelectedCell.SelectionCell.Y)
                else
                  //CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Right+1, LastSelectedCell.SelectionCell.Y, CurrentCell.SelectionRect.Right+1, LastSelectedCell.SelectionCell.Y);
                  CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Right + 1, CurrentCell.SelectionCell.Y, CurrentCell.SelectionRect.Right + 1, CurrentCell.SelectionCell.Y);
                //CurrentCell.SelectionCell:=Point(CurrentCell.SelectionRect.Right, LastSelectedCell.SelectionCell.Y);
                CurrentCell.SelectionCell:=Point(CurrentCell.SelectionRect.Left, CurrentCell.SelectionCell.Y);

                LastSelectedCell.Assign(CurrentCell);

                //tempselection.SelectionRect:=CurrentCell.SelectionRect;
                tempselection.Assign(CurrentCell);

                if RightCol < LastSelectedCell.SelectionRect.Right + 1 then
                  RightCol:=LastSelectedCell.SelectionRect.Right + 1;
                needinvalidate:=true;
              end;
            end;
          VK_HOME:
            begin
              EditorMode:=False;
              if GetKeyState(VK_SHIFT) < 0 then
                AlxdSpreadSheetState:=gsSelectCell
              else
              begin
                ClearToOne;

                CurrentCell.SelectionType:=stUsually;
                //CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Left, CurrentCell.SelectionRect.Top - 1, CurrentCell.SelectionRect.Right, CurrentCell.SelectionRect.Top - 1);
                if GetKeyState(VK_CONTROL) < 0 then
                begin
                  CurrentCell.SelectionRect:=Rect(0, 0, 0, 0);
                  CurrentCell.SelectionCell:=Point(CurrentCell.SelectionRect.Left, CurrentCell.SelectionRect.Top);
                end
                else
                begin
                  CurrentCell.SelectionRect:=Rect(0, LastSelectedCell.SelectionCell.Y, 0, LastSelectedCell.SelectionCell.Y);
                  CurrentCell.SelectionCell:=Point(CurrentCell.SelectionRect.Left, LastSelectedCell.SelectionCell.Y);
                end;

                LastSelectedCell.Assign(CurrentCell);

                tempselection.SelectionRect:=CurrentCell.SelectionRect;

                if TopRow > LastSelectedCell.SelectionRect.Top then
                  TopRow:=LastSelectedCell.SelectionRect.Top;
                if LeftCol > LastSelectedCell.SelectionRect.Left then
                  LeftCol:=LastSelectedCell.SelectionRect.Left;
                needinvalidate:=true;
              end;
            end;
          VK_END:
            begin
              EditorMode:=False;
              if GetKeyState(VK_SHIFT) < 0 then
                AlxdSpreadSheetState:=gsSelectCell
              else
              begin
                ClearToOne;
                
                CurrentCell.SelectionType:=stUsually;
                //CurrentCell.SelectionRect:=Rect(CurrentCell.SelectionRect.Left, CurrentCell.SelectionRect.Top - 1, CurrentCell.SelectionRect.Right, CurrentCell.SelectionRect.Top - 1);
                if GetKeyState(VK_CONTROL) < 0 then
                begin
                  CurrentCell.SelectionRect:=Rect(FAlxdSpreadSheetArray.ColCountInt - 1, FAlxdSpreadSheetArray.RowCountInt - 1, FAlxdSpreadSheetArray.ColCountInt - 1, FAlxdSpreadSheetArray.RowCountInt - 1);
                  CurrentCell.SelectionCell:=Point(CurrentCell.SelectionRect.Right, CurrentCell.SelectionRect.Bottom);
                end
                else
                begin
                  CurrentCell.SelectionRect:=Rect(FAlxdSpreadSheetArray.ColCountInt - 1, LastSelectedCell.SelectionCell.Y, FAlxdSpreadSheetArray.ColCountInt - 1, LastSelectedCell.SelectionCell.Y);
                  CurrentCell.SelectionCell:=Point(CurrentCell.SelectionRect.Right, LastSelectedCell.SelectionCell.Y);
                end;

                LastSelectedCell.Assign(CurrentCell);

                tempselection.SelectionRect:=CurrentCell.SelectionRect;

                if BottomRow < LastSelectedCell.SelectionRect.Bottom + 1 then
                  BottomRow:=LastSelectedCell.SelectionRect.Bottom + 1;
                if RightCol < LastSelectedCell.SelectionRect.Right + 1 then
                  RightCol:=LastSelectedCell.SelectionRect.Right + 1;
                needinvalidate:=true;
              end;
            end;
          VK_TAB:
            begin
              EditorMode:=False;
              pt:=AlxdSpreadSheetSelections.TabCell(CurrentCell.SelectionRect.TopLeft, GetKeyState(VK_SHIFT) < 0);
              {$IFDEF DEBUG}
              OutputDebugString(PChar(Format('StateMachine + WM_KEYDOWN + VK_TAB + pt : %d,%d', [pt.X, pt.Y])));
              OutputDebugString(PChar(Format('StateMachine + WM_KEYDOWN + VK_TAB + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
              {$ENDIF}
              CurrentCell.SelectionRect:=Rect(pt, pt);
              CurrentCell.SelectionCell:=pt;

              LastSelectedCell.Assign(CurrentCell);

              if AlxdSpreadSheetSelections.HasOneCellOnly then
                tempselection.SelectionRect:=CurrentCell.SelectionRect;
              needinvalidate:=true;

              {$IFDEF DEBUG}
              OutputDebugString(PChar(Format('StateMachine + WM_KEYDOWN + VK_TAB + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
              OutputDebugString(PChar(Format('StateMachine + WM_KEYDOWN + VK_TAB + LastSelectedCell : %d,%d', [LastSelectedCell.Left, LastSelectedCell.Top])));
              {$ENDIF}
            end;  
          VK_RETURN, VK_F2:
            begin
              EditorMode:=True;
              if FEditInfo.FEditor.IsFormula then
              begin
                FAlxdFormulaSelectionsInt.FillOutByFormula(FEditInfo.FEditor.Text);
                AlxdSpreadSheetState:=gsWaitFormulaSelect;//gsReadySelectCell2Formula;
                needinvalidate:=True;
              end;

            end;  
          end;//case Message.WParam of
        end;//with
      end;
    end;
    {$IFDEF DEBUG}
    OutputDebugString(PChar(Format('StateMachine + AlxdSpreadSheetState : %d', [Ord(AlxdSpreadSheetState)])));
    {$ENDIF}

//
// middle state switcher
//
    case AlxdSpreadSheetState of
    gsReadySelectCell:
      case Message.Msg of
      WM_LBUTTONDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          EditorMode:=False;
          case placepos.place of
          gpZero:
            begin
              ClearToOne;
              {CurrentCell.SelectionType:=stUsually;
              CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
              CurrentCell.SelectionCell:=placepos.cell;
              LastSelectedCell.Assign(CurrentCell);}
              //CurrentCell.SelectionType:=stAll;
              //tempselection.SelectionRect:=Rect(0, 0, FAlxdSpreadSheetArray.ColCountInt - 1, FAlxdSpreadSheetArray.RowCountInt - 1);
              tempselection.SelectionType:=stAll;
              AlxdSpreadSheetState:=gsSelectCell;
            end;
          gpCells:
            begin
              if GetKeyState(VK_SHIFT) < 0 then
              begin
                LastSelectedCell.SelectionType:=stUsually;
                LastSelectedCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
                LastSelectedCell.SelectionCell:=placepos.cell;

                tempselection.SelectionType:=stUsually;
                tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

                AlxdSpreadSheetState:=gsSelectCell;
              end
              else
              if GetKeyState(VK_CONTROL) < 0 then
              begin
                Add;
                Items[Count-1].Update;
                CurrentCell.SelectionType:=stUsually;
                CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
                CurrentCell.SelectionCell:=placepos.cell;

                LastSelectedCell.Assign(CurrentCell);

                tempselection.SelectionType:=stUsually;
                tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

                AlxdSpreadSheetState:=gsSelectCell;
                needinvalidate:=true;
              end
              else
              begin
                ClearToOne;
                CurrentCell.SelectionType:=stUsually;
                CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
                CurrentCell.SelectionCell:=placepos.cell;

                LastSelectedCell.Assign(CurrentCell);

                tempselection.SelectionType:=stUsually;
                tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

                AlxdSpreadSheetState:=gsSelectCell;
              end;
            end;
          end;//case placepos.place of
          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + WM_LBUTTONDOWN + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
          {$ENDIF}
        end;//WM_LBUTTONDOWN
      WM_LBUTTONDBLCLK:
        begin
          if placepos.place <> gpEmpty then
          begin
            EditorMode:=True;
            if FEditInfo.FEditor.IsFormula then
            begin
              FAlxdFormulaSelectionsInt.FillOutByFormula(FEditInfo.FEditor.Text);
              AlxdSpreadSheetState:=gsWaitFormulaSelect;//gsReadySelectCell2Formula;
              needinvalidate:=True;
            end;
          end;
          {$IFDEF DEBUG}
          OutputDebugString('StateMachine + gsReadySelectCell : WM_LBUTTONDBLCLK ');
          {$ENDIF}
        end;
      WM_RBUTTONDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          if EditorMode then
          begin
            EditorMode:=False;
            needinvalidate:=true;
          end;

          if not FAlxdSpreadSheetSelectionsInt.HasCell(placepos.cell.X, placepos.cell.Y) then
          begin
            ClearToOne;
            case placepos.place of
            gpZero:
              begin
                tempselection.SelectionType:=stAll;
              end;
            gpCells:
              begin
                ClearToOne;
                CurrentCell.SelectionType:=stUsually;
                CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
                CurrentCell.SelectionCell:=placepos.cell;

                LastSelectedCell.Assign(CurrentCell);

                tempselection.SelectionType:=stUsually;
                tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);
                //Invalidate;
                //AlxdSpreadSheetState:=gsSelectCell;
              end;
            //gpEmpty
            end;//case placepos.place of
            FAlxdSpreadSheetSelectionsInt.Items[Count-1].Assign(tempselection);
            FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
            Invalidate;
          end;

          if placepos.place <> gpEmpty then
          begin
            PopupMenu.PopupComponent:=Self;
            PopupMenu.Tag:=Ord(gpCells);
            PopupMenu.Popup(pt.X, pt.Y);
          end;

          AlxdSpreadSheetState:=gsReadySelectCell;

          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + WM_RBUTTONDOWN + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
          {$ENDIF}
        end;//WM_LBUTTONDOWN
      end;//case Message.Msg of
    gsReadySelectCol:
      case Message.Msg of
      WM_LBUTTONDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          if GetKeyState(VK_SHIFT) < 0 then
          begin
            AlxdSpreadSheetState:=gsSelectCol;
          end
          else
          if GetKeyState(VK_CONTROL) < 0 then
          begin
            Add;
            Items[Count-1].Update;
            CurrentCell.SelectionType:=stUsually;
            //CurrentCell.SelectionType:=stColumn;
            placepos.cell:=Point(placepos.cell.X, FAlxdSpreadSheetArray.Columns.Items[placepos.cell.X].IndexFirstSimpleCell);
            CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);

            LastSelectedCell.Assign(CurrentCell);

            AlxdSpreadSheetState:=gsSelectCol;
            needinvalidate:=true;
          end
          else
          begin
            ClearToOne;
            CurrentCell.SelectionType:=stUsually;
            //CurrentCell.SelectionType:=stColumn;

            placepos.cell:=Point(placepos.cell.X, FAlxdSpreadSheetArray.Columns.Items[placepos.cell.X].IndexFirstSimpleCell);
            CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
            //CurrentCell.SelectionRect:=Rect(placepos.cell, );

            LastSelectedCell.Assign(CurrentCell);

            AlxdSpreadSheetState:=gsSelectCol;
          end;
        end;//with
      WM_RBUTTONDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          if EditorMode then
          begin
            EditorMode:=False;
            Invalidate;
          end;

          if not HasColumn(placepos.cell.X, True) then
          begin
            ClearToOne;
            CurrentCell.SelectionType:=stUsually;
            placepos.cell:=Point(placepos.cell.X, FAlxdSpreadSheetArray.Columns.Items[placepos.cell.X].IndexFirstSimpleCell);
            CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);

            LastSelectedCell.Assign(CurrentCell);

            tempselection.SelectionType:=stColumn;
            tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);
            Items[Count-1].Assign(tempselection);

            FfrmEditor.ActionUpdate([aumSelections]);

            Invalidate;
          end;

          PopupMenu.PopupComponent:=Self;
          PopupMenu.Tag:=Ord(placepos.place);
          PopupMenu.Popup(pt.X, pt.Y);
        end;//with
      end;
    gsReadySelectRow:
      case Message.Msg of
      WM_LBUTTONDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          if GetKeyState(VK_SHIFT) < 0 then
          begin
            AlxdSpreadSheetState:=gsSelectRow;
          end
          else
          if GetKeyState(VK_CONTROL) < 0 then
          begin
            Add;
            Items[Count-1].Update;
            CurrentCell.SelectionType:=stUsually;
            placepos.cell:=Point(FAlxdSpreadSheetArray.Rows.Items[placepos.cell.Y].IndexFirstSimpleCell, placepos.cell.Y);
            CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);

            LastSelectedCell.Assign(CurrentCell);

            AlxdSpreadSheetState:=gsSelectRow;
            needinvalidate:=true;
          end
          else
          begin
            ClearToOne;
            CurrentCell.SelectionType:=stUsually;
            placepos.cell:=Point(FAlxdSpreadSheetArray.Rows.Items[placepos.cell.Y].IndexFirstSimpleCell, placepos.cell.Y);
            CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);

            LastSelectedCell.Assign(CurrentCell);

            AlxdSpreadSheetState:=gsSelectRow;
          end;
        end;//with
      WM_RBUTTONDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          if EditorMode then
          begin
            EditorMode:=False;
            Invalidate;
          end;

          if not HasRow(placepos.cell.Y, True) then
          begin
            ClearToOne;
            CurrentCell.SelectionType:=stUsually;
            placepos.cell:=Point(FAlxdSpreadSheetArray.Rows.Items[placepos.cell.Y].IndexFirstSimpleCell, placepos.cell.Y);
            CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);

            LastSelectedCell.Assign(CurrentCell);

            tempselection.SelectionType:=stRow;
            tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);
            Items[Count-1].Assign(tempselection);

            FfrmEditor.ActionUpdate([aumSelections]);
            
            Invalidate;
          end;

          PopupMenu.PopupComponent:=Self;
          PopupMenu.Tag:=Ord(placepos.place);
          PopupMenu.Popup(pt.X, pt.Y);
        end;//with
      end;
    gsReadySizingCol:
      begin
        case Message.Msg of
        WM_LBUTTONDOWN:
          begin
          FSizeInfo.ItemNo:=placepos.cell.X;
          FSizeInfo.StartCoord:=Ptc;
          FSizeInfo.StartSize:=FAlxdSpreadSheetArray.Columns.Items[FSizeInfo.ItemNo].RealSize;
          AlxdSpreadSheetState:=gsSizingCol;
          end;//WM_LBUTTONDOWN
        end;
      end;
    gsReadySizingRow:
      case Message.Msg of
      WM_LBUTTONDOWN:
        begin
          FSizeInfo.ItemNo:=placepos.cell.Y;
          FSizeInfo.StartCoord:=Ptc;
          FSizeInfo.StartSize:=FAlxdSpreadSheetArray.Rows.Items[FSizeInfo.ItemNo].RealSize;
          AlxdSpreadSheetState:=gsSizingRow;
        end;//WM_LBUTTONDOWN
      end;
    gsReadySelectionMove:
      case Message.Msg of
      WM_LBUTTONDOWN:
        begin
          AlxdSpreadSheetState:=gsSelectionMove;
          {$IFDEF SDEBUG}
          //OutputDebugString('StateMachine + gsSelectionMove : WM_LBUTTONDOWN');
          {$ENDIF}
        end;//WM_LBUTTONDOWN
      WM_RBUTTONDOWN:
        begin
          AlxdSpreadSheetState:=gsSelectionCopy;
          {$IFDEF SDEBUG}
          //OutputDebugString('StateMachine + gsSelectionMove : WM_RBUTTONDOWN');
          {$ENDIF}
        end;//WM_LBUTTONDOWN
      WM_KEYDOWN:
        begin
          case Message.WParam of
          VK_CONTROL:
          //if GetKeyState(VK_CONTROL) < 0 then
            begin
              AlxdSpreadSheetState:=gsReadySelectionCopy;
              PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);
            end;
          end;
          {$IFDEF SDEBUG}
          OutputDebugString('StateMachine + gsSelectionMove : WM_KEYDOWN');
          {$ENDIF}
        end;
      end;
    gsReadySelectionCopy:
      case Message.Msg of
      WM_LBUTTONDOWN:
        begin
          AlxdSpreadSheetState:=gsSelectionCopy;
          {$IFDEF SDEBUG}
          OutputDebugString('StateMachine + gsSelectionCopy : WM_LBUTTONDOWN');
          {$ENDIF}
        end;//WM_LBUTTONDOWN
      WM_KEYUP:
        begin
          case Message.WParam of
          VK_CONTROL:
            begin
              AlxdSpreadSheetState:=gsReadySelectionMove;
              PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);
            end;
          end;
          {$IFDEF SDEBUG}
          OutputDebugString('StateMachine + gsSelectionCopy : WM_KEYUP');
          {$ENDIF}
        end;

      end;//case
    gsReadySelectionExpand:
      case Message.Msg of
      WM_LBUTTONDOWN, WM_RBUTTONDOWN:
        begin
          AlxdSpreadSheetState:=gsSelectionExpand;
          {$IFDEF SDEBUG}
          //OutputDebugString('StateMachine + gsSelectionMove : WM_LBUTTONDOWN');
          {$ENDIF}
        end;//WM_LBUTTONDOWN
      WM_KEYDOWN:
        begin
          case Message.WParam of
          VK_CONTROL:
          //if GetKeyState(VK_CONTROL) < 0 then
            begin
              AlxdSpreadSheetState:=gsReadySelectionExpandInc;
              PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);
            end;
          end;
          {$IFDEF SDEBUG}
          OutputDebugString('StateMachine + gsReadySelectionExpand : WM_KEYDOWN');
          {$ENDIF}
        end;
      end;//case
    gsReadySelectionExpandInc:
      case Message.Msg of
      WM_LBUTTONDOWN, WM_RBUTTONDOWN:
        begin
          AlxdSpreadSheetState:=gsSelectionExpandInc;
          {$IFDEF SDEBUG}
          //OutputDebugString('StateMachine + gsSelectionMove : WM_LBUTTONDOWN');
          {$ENDIF}
        end;//WM_LBUTTONDOWN
      WM_KEYUP:
        begin
          case Message.WParam of
          VK_CONTROL:
            begin
              AlxdSpreadSheetState:=gsReadySelectionExpand;
              PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);
            end;
          end;
          {$IFDEF SDEBUG}
          OutputDebugString('StateMachine + gsReadySelectionExpandInc : WM_KEYUP');
          {$ENDIF}
        end;
      end;//case
    gsSelectionExpand:
      case Message.Msg of
      WM_KEYDOWN:
        begin
          case Message.WParam of
          VK_CONTROL:
            begin
              AlxdSpreadSheetState:=gsSelectionExpandInc;
              PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);
            end;
          end;
          {$IFDEF SDEBUG}
          OutputDebugString('StateMachine + gsSelectionExpand : WM_KEYDOWN');
          {$ENDIF}
        end;
      end;//case Message.Msg of
    gsSelectionExpandInc:
      case Message.Msg of
      WM_KEYUP:
        begin
          case Message.WParam of
          VK_CONTROL:
            begin
              AlxdSpreadSheetState:=gsSelectionExpand;
              PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);
            end;
          end;
          {$IFDEF SDEBUG}
          OutputDebugString('StateMachine + gsSelectionExpandInc : WM_KEYDOWN');
          {$ENDIF}
        end;
      end;//case Message.Msg of
    end;//case AlxdSpreadSheetState of

//
// output state switcher
//
    case AlxdSpreadSheetState of
    gsSelectCell:
      case Message.Msg of
      WM_LBUTTONDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          {LastSelectedCell.SelectionType:=stUsually;
          LastSelectedCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
          LastSelectedCell.SelectionCell:=placepos.cell;}

          {
          tempselection.SelectionType:=stUsually;
          tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);
          }
          //FAlxdSpreadSheetSelectionsInt.CurrentCell.SelectionType:=stUsually;
          //FAlxdSpreadSheetSelectionsInt.CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
          MouseCapture:=True;
          SetTimer(Handle, 1, 100, nil);

        end;//WM_LBUTTONDOWN
      WM_MOUSEMOVE:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          LastSelectedCell.SelectionType:=stUsually;
          LastSelectedCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
          LastSelectedCell.SelectionCell:=placepos.cell;

          //tempselection.SelectionType:=stUsually;
          tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);
          {$IFDEF SDEBUG}
          OutputDebugString(PChar(Format('StateMachine + WM_MOUSEMOVE + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
          OutputDebugString(PChar(Format('StateMachine + WM_MOUSEMOVE + LastSelectedCell : %d,%d', [LastSelectedCell.Left, LastSelectedCell.Top])));
          {$ENDIF}
        end;
      WM_LBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;
          AlxdSpreadSheetState:=gsReadySelectCell;
          {$IFDEF DEBUG}
          OutputDebugString('StateMachine + WM_LBUTTONUP');
          {$ENDIF}
        end;
      WM_RBUTTONUP:
        begin
          {KillTimer(Handle, 1);
          MouseCapture:=False;}

          {with FfrmEditor.FDragRects do
          begin
            FSourceRect:=FDragInfo.FStartSelection.SelectionRect;
            FDestRect:=FDragInfo.FCurrentSelection.SelectionRect;
          end;}

          {PopupMenu.PopupComponent:=Self;
          PopupMenu.Tag:=Ord(gpZero);
          PopupMenu.Popup(pt.X, pt.Y);

          AlxdSpreadSheetState:=gsReadySelectCell;}
          {$IFDEF DEBUG}
          OutputDebugString('StateMachine + WM_RBUTTONUP');
          {$ENDIF}
        end;
      WM_KEYDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          EditorMode:=False;
          case Message.WParam of
          VK_DOWN:
            begin
              LastSelectedCell.SelectionType:=stUsually;
              //LastSelectedCell.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, placepos.cell);

              if GetKeyState(VK_CONTROL) < 0 then
              //  LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionRect.Left, LastSelectedCell.SelectionRect.Top, LastSelectedCell.SelectionRect.Right, FAlxdSpreadSheetArray.RowCountInt - 1)
                LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionCell.X, FAlxdSpreadSheetArray.RowCountInt - 1, LastSelectedCell.SelectionCell.X, FAlxdSpreadSheetArray.RowCountInt - 1)
              else
                LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionCell.X, LastSelectedCell.SelectionRect.Bottom + 1, LastSelectedCell.SelectionCell.X, LastSelectedCell.SelectionRect.Bottom + 1);
              LastSelectedCell.SelectionCell:=Point(LastSelectedCell.SelectionCell.X, LastSelectedCell.SelectionRect.Bottom);

              tempselection.SelectionType:=stUsually;
              tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

              if BottomRow < LastSelectedCell.SelectionRect.Bottom + 1 then
                BottomRow:=LastSelectedCell.SelectionRect.Bottom + 1;
              {$IFDEF DEBUG}
              OutputDebugString('StateMachine + WM_KEYDOWN + VK_DOWN');
              {$ENDIF}
            end;
          VK_UP:
            begin
              LastSelectedCell.SelectionType:=stUsually;
              //LastSelectedCell.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, placepos.cell);

              if GetKeyState(VK_CONTROL) < 0 then
              //  LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionRect.Left, LastSelectedCell.SelectionRect.Top, LastSelectedCell.SelectionRect.Right, 0)
                LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionCell.X, 0, LastSelectedCell.SelectionCell.X, 0)
              else
              //  LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionRect.Left, LastSelectedCell.SelectionRect.Top, LastSelectedCell.SelectionRect.Right, LastSelectedCell.SelectionRect.Bottom - 1);
                LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionCell.X, LastSelectedCell.SelectionRect.Top - 1, LastSelectedCell.SelectionCell.X, LastSelectedCell.SelectionRect.Top - 1);
              LastSelectedCell.SelectionCell:=Point(LastSelectedCell.SelectionCell.X, LastSelectedCell.SelectionRect.Top);

              tempselection.SelectionType:=stUsually;
              tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

              if TopRow > LastSelectedCell.SelectionRect.Top then
                TopRow:=LastSelectedCell.SelectionRect.Top;

              {$IFDEF DEBUG}
              OutputDebugString('StateMachine + WM_KEYDOWN + VK_UP');
              //OutputDebugString(PChar(Format('StateMachine + WM_KEYDOWN + VK_UP + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
              //OutputDebugString(PChar(Format('StateMachine + WM_KEYDOWN + VK_UP + LastSelectedCell : %d,%d', [LastSelectedCell.Left, LastSelectedCell.Top])));
              {$ENDIF}
            end;
          VK_LEFT:
            begin
              LastSelectedCell.SelectionType:=stUsually;
              //LastSelectedCell.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, placepos.cell);

              if GetKeyState(VK_CONTROL) < 0 then
              //  LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionRect.Left, LastSelectedCell.SelectionRect.Top, LastSelectedCell.SelectionRect.Right, FAlxdSpreadSheetArray.RowCountInt - 1)
                LastSelectedCell.SelectionRect:=Rect(0, LastSelectedCell.SelectionCell.Y, 0, LastSelectedCell.SelectionCell.Y)
              else
                LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionRect.Left - 1, LastSelectedCell.SelectionCell.Y, LastSelectedCell.SelectionRect.Left - 1, LastSelectedCell.SelectionCell.Y);
              LastSelectedCell.SelectionCell:=Point(LastSelectedCell.SelectionRect.Left, LastSelectedCell.SelectionCell.Y);

              tempselection.SelectionType:=stUsually;
              tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

              if LeftCol > LastSelectedCell.SelectionRect.Left then
                LeftCol:=LastSelectedCell.SelectionRect.Left;

              {$IFDEF DEBUG}
              OutputDebugString('StateMachine + WM_KEYDOWN + VK_LEFT');
              {$ENDIF}
            end;
          VK_RIGHT:
            begin
              LastSelectedCell.SelectionType:=stUsually;
              //LastSelectedCell.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, placepos.cell);

              if GetKeyState(VK_CONTROL) < 0 then
              //  LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionRect.Left, LastSelectedCell.SelectionRect.Top, LastSelectedCell.SelectionRect.Right, FAlxdSpreadSheetArray.RowCountInt - 1)
                LastSelectedCell.SelectionRect:=Rect(FAlxdSpreadSheetArray.ColCountInt - 1, LastSelectedCell.SelectionCell.Y, FAlxdSpreadSheetArray.ColCountInt - 1, LastSelectedCell.SelectionCell.Y)
              else
                LastSelectedCell.SelectionRect:=Rect(LastSelectedCell.SelectionRect.Right + 1, LastSelectedCell.SelectionCell.Y, LastSelectedCell.SelectionRect.Right + 1, LastSelectedCell.SelectionCell.Y);
              LastSelectedCell.SelectionCell:=Point(LastSelectedCell.SelectionRect.Left, LastSelectedCell.SelectionCell.Y);

              tempselection.SelectionType:=stUsually;
              tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

              if RightCol < LastSelectedCell.SelectionRect.Right + 1 then
                RightCol:=LastSelectedCell.SelectionRect.Right + 1;

              {$IFDEF DEBUG}
              OutputDebugString('StateMachine + WM_KEYDOWN + VK_RIGHT');
              {$ENDIF}
            end;
          VK_HOME:
            begin
              LastSelectedCell.SelectionType:=stUsually;

              if GetKeyState(VK_CONTROL) < 0 then
              begin
                LastSelectedCell.SelectionRect:=Rect(0, 0, 0, 0);
                LastSelectedCell.SelectionCell:=Point(LastSelectedCell.SelectionRect.Left, LastSelectedCell.SelectionRect.Top);
              end
              else
              begin
                LastSelectedCell.SelectionRect:=Rect(0, LastSelectedCell.SelectionCell.Y, 0, LastSelectedCell.SelectionCell.Y);
                LastSelectedCell.SelectionCell:=Point(LastSelectedCell.SelectionRect.Left, LastSelectedCell.SelectionCell.Y);
              end;

              tempselection.SelectionType:=stUsually;
              tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

              if TopRow > LastSelectedCell.SelectionRect.Top then
                TopRow:=LastSelectedCell.SelectionRect.Top;
              if LeftCol > LastSelectedCell.SelectionRect.Left then
                LeftCol:=LastSelectedCell.SelectionRect.Left;

              {$IFDEF DEBUG}
              OutputDebugString('StateMachine + WM_KEYDOWN + VK_HOME');
              {$ENDIF}
            end;
          VK_END:
            begin
              LastSelectedCell.SelectionType:=stUsually;

              if GetKeyState(VK_CONTROL) < 0 then
              begin
                LastSelectedCell.SelectionRect:=Rect(FAlxdSpreadSheetArray.ColCountInt - 1, FAlxdSpreadSheetArray.RowCountInt - 1, FAlxdSpreadSheetArray.ColCountInt - 1, FAlxdSpreadSheetArray.RowCountInt - 1);
                LastSelectedCell.SelectionCell:=Point(LastSelectedCell.SelectionRect.Right, LastSelectedCell.SelectionRect.Bottom);
              end
              else
              begin
                LastSelectedCell.SelectionRect:=Rect(FAlxdSpreadSheetArray.ColCountInt - 1, LastSelectedCell.SelectionCell.Y, FAlxdSpreadSheetArray.ColCountInt - 1, LastSelectedCell.SelectionCell.Y);
                LastSelectedCell.SelectionCell:=Point(LastSelectedCell.SelectionRect.Right, LastSelectedCell.SelectionCell.Y);
              end;

              tempselection.SelectionType:=stUsually;
              tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

              if BottomRow < LastSelectedCell.SelectionRect.Bottom + 1 then
                BottomRow:=LastSelectedCell.SelectionRect.Bottom + 1;
              if RightCol < LastSelectedCell.SelectionRect.Right + 1 then
                RightCol:=LastSelectedCell.SelectionRect.Right + 1;

              {$IFDEF DEBUG}
              OutputDebugString('StateMachine + WM_KEYDOWN + VK_HOME');
              {$ENDIF}
            end;
          end;//case Message.WParam of

        end;//with
      WM_KEYUP:
        begin
          AlxdSpreadSheetState:=gsReadySelectCell;
        end;
      end;//case Message.Msg of
    gsSelectCol:
      case Message.Msg of
      WM_LBUTTONDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          LastSelectedCell.SelectionType:=stUsually;
          placepos.cell:=Point(placepos.cell.X, FAlxdSpreadSheetArray.Columns.Items[placepos.cell.X].IndexFirstSimpleCell);
          LastSelectedCell.SelectionRect:=Rect(placepos.cell, placepos.cell);

          tempselection.SelectionType:=stColumn;
          tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

          //FAlxdSpreadSheetSelectionsInt.CurrentCell.SelectionType:=stUsually;
          //FAlxdSpreadSheetSelectionsInt.CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
          MouseCapture:=True;
          SetTimer(Handle, 1, 100, nil);

        end;//WM_LBUTTONDOWN
      WM_MOUSEMOVE:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          LastSelectedCell.SelectionType:=stUsually;
          placepos.cell:=Point(placepos.cell.X, FAlxdSpreadSheetArray.Columns.Items[placepos.cell.X].IndexFirstSimpleCell);
          LastSelectedCell.SelectionRect:=Rect(placepos.cell, placepos.cell);

          tempselection.SelectionType:=stColumn;
          tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);
          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + gsSelectCol + WM_MOUSEMOVE + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
          OutputDebugString(PChar(Format('StateMachine + gsSelectCol + WM_MOUSEMOVE + LastSelectedCell : %d,%d', [LastSelectedCell.Left, LastSelectedCell.Top])));
          {$ENDIF}
        end;
      WM_LBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;
          AlxdSpreadSheetState:=gsReadySelectCol;
          {$IFDEF DEBUG}
          OutputDebugString('StateMachine + gsSelectCol + WM_LBUTTONUP');
          {$ENDIF}
        end;
      end;//case Message.Msg of
    gsSelectRow:
      case Message.Msg of
      WM_LBUTTONDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          LastSelectedCell.SelectionType:=stUsually;
          placepos.cell:=Point(FAlxdSpreadSheetArray.Rows.Items[placepos.cell.Y].IndexFirstSimpleCell, placepos.cell.Y);
          LastSelectedCell.SelectionRect:=Rect(placepos.cell, placepos.cell);

          tempselection.SelectionType:=stRow;
          tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

          //FAlxdSpreadSheetSelectionsInt.CurrentCell.SelectionType:=stUsually;
          //FAlxdSpreadSheetSelectionsInt.CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
          MouseCapture:=True;
          SetTimer(Handle, 1, 100, nil);

        end;//WM_LBUTTONDOWN
      WM_MOUSEMOVE:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          LastSelectedCell.SelectionType:=stUsually;
          placepos.cell:=Point(FAlxdSpreadSheetArray.Rows.Items[placepos.cell.Y].IndexFirstSimpleCell, placepos.cell.Y);
          LastSelectedCell.SelectionRect:=Rect(placepos.cell, placepos.cell);

          tempselection.SelectionType:=stRow;
          tempselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);
          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + gsSelectRow + WM_MOUSEMOVE + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
          OutputDebugString(PChar(Format('StateMachine + gsSelectCol + WM_MOUSEMOVE + LastSelectedCell : %d,%d', [LastSelectedCell.Left, LastSelectedCell.Top])));
          {$ENDIF}
        end;
      WM_LBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;
          AlxdSpreadSheetState:=gsReadySelectRow;
          {$IFDEF DEBUG}
          OutputDebugString('StateMachine + gsSelectRow + WM_LBUTTONUP');
          {$ENDIF}
        end;
      end;//case Message.Msg of
    gsSizingCol:
      case Message.Msg of
      WM_MOUSEMOVE:
        begin
          newsize:=FSizeInfo.StartSize + (Ptc.X - FSizeInfo.StartCoord.X) / FvarOptions.PixelToMmX;
          if newsize > 0 then
            FAlxdSpreadSheetArray.Columns.Items[FSizeInfo.ItemNo].Size:=newsize;
          needinvalidate:=True;
          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + gsSizingCol + WM_MOUSEMOVE + Ptc : %d,%d', [Ptc.X, Ptc.Y])));
          {$ENDIF}
        end;//WM_MOUSEMOVE:
      WM_LBUTTONUP:
        begin
          newsize:=FSizeInfo.StartSize + (Ptc.X - FSizeInfo.StartCoord.X) / FvarOptions.PixelToMmX;
          if newsize > 0 then
            FAlxdSpreadSheetArray.Columns.Size:=newsize;
          needinvalidate:=True;

          AlxdSpreadSheetState:=gsReadySizingCol;
          RedrawBlockDefinition(0, 0);
        end;//WM_LBUTTONUP
      end;
    gsSizingRow:
      case Message.Msg of
      WM_MOUSEMOVE:
        begin
          newsize:=FSizeInfo.StartSize + (Ptc.Y - FSizeInfo.StartCoord.Y) / FvarOptions.PixelToMmY;
          if newsize > 0 then
            FAlxdSpreadSheetArray.Rows.Items[FSizeInfo.ItemNo].Size:=newsize;
          needinvalidate:=True;
          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + gsSizingRow + WM_MOUSEMOVE + Ptc : %d,%d', [Ptc.X, Ptc.Y])));
          {$ENDIF}
        end;//WM_MOUSEMOVE:
      WM_LBUTTONUP:
        begin
          newsize:=FSizeInfo.StartSize + (Ptc.Y - FSizeInfo.StartCoord.Y) / FvarOptions.PixelToMmY;
          if newsize > 0 then
            FAlxdSpreadSheetArray.Rows.Size:=newsize;
          needinvalidate:=True;

          AlxdSpreadSheetState:=gsReadySizingRow;
          RedrawBlockDefinition(0, 0);
        end;//WM_LBUTTONUP
      end;
    gsSelectionMove:
      case Message.Msg of
      WM_LBUTTONDOWN:
        begin
          EditorMode:=False;
          MouseCapture:=True;
          SetTimer(Handle, 1, 100, nil);
          //CalcDragInfo(placepos.cell);
          FDragInfo.FStartSelection:=AlxdSpreadSheetSelections.Items[0];
          FDragInfo.FCurrentSelection.Assign(FDragInfo.FStartSelection);
          FDragInfo.FStartCell:=FDragInfo.FStartSelection.NearestCell(placepos.cell);

        end;
      WM_MOUSEMOVE:
        begin
          FDragInfo.FCurrentSelection.Assign(FDragInfo.FStartSelection);
          FDragInfo.FCurrentSelection.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
          needinvalidate:=True;
          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + gsSelectionMove + WM_MOUSEMOVE + FDragInfo.FStartCell : %d,%d', [FDragInfo.FStartCell.X, FDragInfo.FStartCell.Y])));
          OutputDebugString(PChar(Format('StateMachine + gsSelectionMove + WM_MOUSEMOVE + placepos.cell : %d,%d', [placepos.cell.X, placepos.cell.Y])));
          {$ENDIF}
        end;
      WM_LBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;

          with FAlxdSpreadSheetSelectionsInt do
          begin
            CurrentCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            LastSelectedCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
          end;

          MoveCellsContent(FDragInfo.FStartSelection.SelectionRect, FDragInfo.FCurrentSelection.SelectionRect);

          tempselection.Assign(FDragInfo.FCurrentSelection);
          FDragInfo.FStartSelection:=nil;
          AlxdSpreadSheetState:=gsReadySelectCell;
          RedrawBlockDefinition(0, 0);
          needinvalidate:=True;
        end;
      WM_KEYDOWN:
        begin
          case Message.WParam of
          VK_CONTROL:
          //if GetKeyState(VK_CONTROL) < 0 then
            begin
              AlxdSpreadSheetState:=gsSelectionCopy;
              PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);
            end;
          end;
          {$IFDEF SDEBUG}
          OutputDebugString('StateMachine + gsSelectionMove : WM_KEYDOWN');
          {$ENDIF}
        end;
      end;
    gsSelectionCopy:
      case Message.Msg of
      WM_RBUTTONDOWN, WM_LBUTTONDOWN:
        begin
          EditorMode:=False;
          MouseCapture:=True;
          SetTimer(Handle, 1, 100, nil);
          //CalcDragInfo(placepos.cell);
          FDragInfo.FStartSelection:=AlxdSpreadSheetSelections.Items[0];
          FDragInfo.FCurrentSelection.Assign(FDragInfo.FStartSelection);
          FDragInfo.FStartCell:=FDragInfo.FStartSelection.NearestCell(placepos.cell);
        end;
      WM_MOUSEMOVE:
        begin
          FDragInfo.FCurrentSelection.Assign(FDragInfo.FStartSelection);
          FDragInfo.FCurrentSelection.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
          needinvalidate:=True;
          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + gsSelectionMove + WM_MOUSEMOVE + FDragInfo.FStartCell : %d,%d', [FDragInfo.FStartCell.X, FDragInfo.FStartCell.Y])));
          OutputDebugString(PChar(Format('StateMachine + gsSelectionMove + WM_MOUSEMOVE + placepos.cell : %d,%d', [placepos.cell.X, placepos.cell.Y])));
          {$ENDIF}
        end;
      WM_LBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;

          with FAlxdSpreadSheetSelectionsInt do
          begin
            CurrentCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            LastSelectedCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
          end;

          CopyCellsContent(FDragInfo.FStartSelection.SelectionRect, FDragInfo.FCurrentSelection.SelectionRect);

          tempselection.Assign(FDragInfo.FCurrentSelection);

          FDragInfo.FStartSelection:=nil;
          AlxdSpreadSheetState:=gsReadySelectCell;
          with FDragInfo.FCurrentSelection.SelectionRect do
            RedrawBlockDefinition(Left, Top);
          needinvalidate:=True;
        end;
      WM_RBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;

          with FAlxdSpreadSheetSelectionsInt do
          begin
            CurrentCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            LastSelectedCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
          end;

          with FfrmEditor.FDragRects do
          begin
            FSourceRect:=FDragInfo.FStartSelection.SelectionRect;
            FDestRect:=FDragInfo.FCurrentSelection.SelectionRect;
          end;

          PopupMenu.PopupComponent:=Self;
          PopupMenu.Tag:=Ord(gpSelectionBorder);
          PopupMenu.Popup(pt.X, pt.Y);

          tempselection.Assign(FDragInfo.FCurrentSelection);

          FDragInfo.FStartSelection:=nil;
          AlxdSpreadSheetState:=gsReadySelectCell;
          needinvalidate:=True;
        end;
      WM_KEYUP:
        begin
          case Message.WParam of
          VK_CONTROL:
            begin
              AlxdSpreadSheetState:=gsSelectionMove;
              PostMessage(Handle, WM_SETCURSOR, Handle, HTCLIENT);
            end;
          end;
          {$IFDEF SDEBUG}
          OutputDebugString('StateMachine + gsSelectionCopy : WM_KEYUP');
          {$ENDIF}
        end;
      end;
    gsSelectionExpand:
      case Message.Msg of
      WM_RBUTTONDOWN, WM_LBUTTONDOWN:
        begin
          EditorMode:=False;
          MouseCapture:=True;
          SetTimer(Handle, 1, 100, nil);
          //CalcDragInfo(placepos.cell);
          FDragInfo.FStartSelection:=AlxdSpreadSheetSelections.Items[0];
          FDragInfo.FCurrentSelection.Assign(FDragInfo.FStartSelection);
          FDragInfo.FStartCell:=FDragInfo.FStartSelection.NearestCell(placepos.cell);
        end;
      WM_MOUSEMOVE:
        begin
          FDragInfo.FCurrentSelection.Assign(FDragInfo.FStartSelection);
          FDragInfo.FCurrentSelection.SelectionRect:=Rect(FDragInfo.FStartSelection.SelectionRect.TopLeft, placepos.cell);
          //FDragInfo.FCurrentSelection.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
          needinvalidate:=True;
          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + gsSelectionMove + WM_MOUSEMOVE + FDragInfo.FStartCell : %d,%d', [FDragInfo.FStartCell.X, FDragInfo.FStartCell.Y])));
          OutputDebugString(PChar(Format('StateMachine + gsSelectionMove + WM_MOUSEMOVE + placepos.cell : %d,%d', [placepos.cell.X, placepos.cell.Y])));
          {$ENDIF}
        end;
      WM_LBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;

          with FAlxdSpreadSheetSelectionsInt do
          begin
            //CurrentCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            LastSelectedCell.Offset(FDragInfo.FCurrentSelection.NearestCell(placepos.cell).X - FDragInfo.FStartCell.X, FDragInfo.FCurrentSelection.NearestCell(placepos.cell).Y - FDragInfo.FStartCell.Y);
            //LastSelectedCell.SelectionRect (placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            //LastSelectedCell.SelectionCell:=placepos.cell;
          end;

          ExpandCopyCellsAll(FDragInfo.FStartSelection.SelectionRect, FDragInfo.FCurrentSelection.SelectionRect);

          tempselection.Assign(FDragInfo.FCurrentSelection);

          FDragInfo.FStartSelection:=nil;
          AlxdSpreadSheetState:=gsReadySelectCell;
          RedrawBlockDefinition(0, 0);
          needinvalidate:=True;
        end;
      WM_RBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;

          with FAlxdSpreadSheetSelectionsInt do
          begin
            //CurrentCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            LastSelectedCell.Offset(FDragInfo.FCurrentSelection.NearestCell(placepos.cell).X - FDragInfo.FStartCell.X, FDragInfo.FCurrentSelection.NearestCell(placepos.cell).Y - FDragInfo.FStartCell.Y);
            //LastSelectedCell.SelectionRect (placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            //LastSelectedCell.SelectionCell:=placepos.cell;
          end;

          with FfrmEditor.FDragRects do
          begin
            FSourceRect:=FDragInfo.FStartSelection.SelectionRect;
            FDestRect:=FDragInfo.FCurrentSelection.SelectionRect;
          end;

          PopupMenu.PopupComponent:=Self;
          PopupMenu.Tag:=Ord(gpSelectionDot);
          PopupMenu.Popup(pt.X, pt.Y);

          tempselection.Assign(FDragInfo.FCurrentSelection);

          FDragInfo.FStartSelection:=nil;
          AlxdSpreadSheetState:=gsReadySelectCell;
          needinvalidate:=True;
        end;
      end;//case
       
    gsSelectionExpandInc:
      case Message.Msg of
      WM_RBUTTONDOWN, WM_LBUTTONDOWN:
        begin
          EditorMode:=False;
          MouseCapture:=True;
          SetTimer(Handle, 1, 100, nil);
          //CalcDragInfo(placepos.cell);
          FDragInfo.FStartSelection:=AlxdSpreadSheetSelections.Items[0];
          FDragInfo.FCurrentSelection.Assign(FDragInfo.FStartSelection);
          FDragInfo.FStartCell:=FDragInfo.FStartSelection.NearestCell(placepos.cell);
        end;
      WM_MOUSEMOVE:
        begin
          FDragInfo.FCurrentSelection.Assign(FDragInfo.FStartSelection);
          FDragInfo.FCurrentSelection.SelectionRect:=Rect(FDragInfo.FStartSelection.SelectionRect.TopLeft, placepos.cell);
          //FDragInfo.FCurrentSelection.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
          needinvalidate:=True;
          {$IFDEF DEBUG}
          OutputDebugString(PChar(Format('StateMachine + gsSelectionMove + WM_MOUSEMOVE + FDragInfo.FStartCell : %d,%d', [FDragInfo.FStartCell.X, FDragInfo.FStartCell.Y])));
          OutputDebugString(PChar(Format('StateMachine + gsSelectionMove + WM_MOUSEMOVE + placepos.cell : %d,%d', [placepos.cell.X, placepos.cell.Y])));
          {$ENDIF}
        end;
      WM_LBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;

          with FAlxdSpreadSheetSelectionsInt do
          begin
            //CurrentCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            LastSelectedCell.Offset(FDragInfo.FCurrentSelection.NearestCell(placepos.cell).X - FDragInfo.FStartCell.X, FDragInfo.FCurrentSelection.NearestCell(placepos.cell).Y - FDragInfo.FStartCell.Y);
            //LastSelectedCell.SelectionRect (placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            //LastSelectedCell.SelectionCell:=placepos.cell;
          end;

          ExpandIncCopyCellsAll(FDragInfo.FStartSelection.SelectionRect, FDragInfo.FCurrentSelection.SelectionRect);

          tempselection.Assign(FDragInfo.FCurrentSelection);

          FDragInfo.FStartSelection:=nil;
          AlxdSpreadSheetState:=gsReadySelectCell;
          RedrawBlockDefinition(0, 0);
          needinvalidate:=True;
        end;
      WM_RBUTTONUP:
        begin
          KillTimer(Handle, 1);
          MouseCapture:=False;

          with FAlxdSpreadSheetSelectionsInt do
          begin
            //CurrentCell.Offset(placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            LastSelectedCell.Offset(FDragInfo.FCurrentSelection.NearestCell(placepos.cell).X - FDragInfo.FStartCell.X, FDragInfo.FCurrentSelection.NearestCell(placepos.cell).Y - FDragInfo.FStartCell.Y);
            //LastSelectedCell.SelectionRect (placepos.cell.X - FDragInfo.FStartCell.X, placepos.cell.Y - FDragInfo.FStartCell.Y);
            //LastSelectedCell.SelectionCell:=placepos.cell;
          end;

          with FfrmEditor.FDragRects do
          begin
            FSourceRect:=FDragInfo.FStartSelection.SelectionRect;
            FDestRect:=FDragInfo.FCurrentSelection.SelectionRect;
          end;

          PopupMenu.PopupComponent:=Self;
          PopupMenu.Tag:=Ord(gpSelectionDot);
          PopupMenu.Popup(pt.X, pt.Y);

          tempselection.Assign(FDragInfo.FCurrentSelection);

          FDragInfo.FStartSelection:=nil;
          AlxdSpreadSheetState:=gsReadySelectCell;
          needinvalidate:=True;
        end;
      end;//case

    gsWaitFormulaSelect:
      case Message.Msg of
      WM_COMMAND:
        begin
          if EditorMode then
            if not FEditInfo.FEditor.IsFormula then
            begin
              AlxdSpreadSheetState:=gsReadySelectCell;
              if FAlxdFormulaSelectionsInt.Count > 0 then
              begin
                FAlxdFormulaSelectionsInt.ClearToOne;
                FAlxdFormulaSelectionsInt.Delete(0);
              end;
            end;
            {else
              StateMachineFormula(Message);}
        end;
      else
        StateMachineFormula(Message);
      end;//case
    gsReadyAddSelection2Formula..gsSelectRow2Formula:
      begin
        StateMachineFormula(Message);
      end;
    end;

    with FAlxdSpreadSheetSelectionsInt do
    if Count > 0 then
    if not tempselection.Equal(Items[Count-1]) then
    begin
      Items[Count-1].Assign(tempselection);
      FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
      needinvalidate:=needinvalidate or True;
    end;

    {with FAlxdFormulaSelectionsInt do
    if Count > 0 then
    if not frmlselection.Equal(Items[Count-1]) then
    begin
      Items[Count-1].Assign(frmlselection);
      //FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
      needinvalidate:=needinvalidate or True;
    end;}

    if needinvalidate then
    begin
      Invalidate;
      //Repaint;
    end;

  {$IFDEF DEBUG}
  OutputDebugString(PChar(Format('StateMachine + AlxdSpreadSheetState : %d', [Ord(AlxdSpreadSheetState)])));
  {$ENDIF}

  finally
    //frmlselection.Free;
    tempselection.Free;
  end;//try
end;

procedure TAlxdSpreadSheetInt.StateMachineFormula(Message: TMessage);

  function IsOperator(w: WideChar): boolean;
  var
    s: Char;
  begin
    s:=Char(w);
    Result:=(s in ['=', '+', '-', '*', '/', '(', ')', '<', '>', ':', ';']);
  end;

var
  pt: TPoint;
  ptc: TPoint;
  placepos: TAlxdSpreadSheetPlacePos;
  frmlselection: TAlxdSpreadSheetSelectionInt;
  needinvalidate: boolean;
  i: integer;
begin
  GetCursorPos(pt);
  ptc:=ScreenToClient(Pt);
  {$IFDEF DEBUG}
//  OutputDebugString(PChar(Format('StateMachine + pt : %d,%d', [ptc.X, ptc.Y])));
  {$ENDIF}
  placepos:=CalcPlace(ptc);

  needinvalidate:=false;
  frmlselection:=TAlxdSpreadSheetSelectionInt.Create(Self);
  try
    {frmlselection.Left:=-1;
    frmlselection.Top:=-1;}
    i:=-1;
     //with FAlxdFormulaSelectionsInt do
      //if Count = 0 then

{
     with FAlxdFormulaSelectionsInt do
      if Count > 0 then
        frmlselection.Assign(Items[Count-1]);
}

    with FAlxdFormulaSelectionsInt do
      //if Count > 0 then
      //begin
        //i:=Count - 1;
        if Length(FEditInfo.FEditor.SelText) > 0 then
        begin
          i:=FindByFormula(FEditInfo.FEditor.SelText);
          //if i < 0 then
            //i:=Count - 1;
          if i >= 0 then
            frmlselection.Assign(Items[i]);
        end;
      //end;

//
// input state switcher
//

    case AlxdSpreadSheetState of
    gsWaitFormulaSelect:
      case Message.Msg of
      WM_LBUTTONDOWN:
        begin
          if Length(FEditInfo.FEditor.SelText) > 0 then
            AlxdSpreadSheetState:=gsReadyChangeSelection2Formula
          else
          if IsOperator(FEditInfo.FEditor.PrevSelected) then
            AlxdSpreadSheetState:=gsReadyAddSelection2Formula
          else
          begin
            FAlxdFormulaSelectionsInt.Clear;
            AlxdSpreadSheetState:=gsReadySelectCell;
            StateMachine(Message);
          end;
        end;
      WM_KEYDOWN:
        case Message.WParam of
        VK_ESCAPE:
          begin
            FAlxdFormulaSelectionsInt.Clear;
            AlxdSpreadSheetState:=gsReadySelectCell;
            with Message do
              PostMessage(Handle, Msg, WParam, LParam);
          end;
        VK_RETURN:
          begin
            FAlxdFormulaSelectionsInt.Clear;
            AlxdSpreadSheetState:=gsReadySelectCell;
            with Message do
              PostMessage(Handle, Msg, WParam, LParam);
          end;
        VK_LEFT..VK_DOWN:
          begin
            with FEditInfo.FEditor do
              if (SelLength > 0) and (i >= 0) then
                AlxdSpreadSheetState:=gsReadyChangeSelection2Formula
              else
              begin
                //SendMessage(
                EditorMode:=False;

                FAlxdFormulaSelectionsInt.Clear;
                needinvalidate:=true;
                AlxdSpreadSheetState:=gsReadySelectCell;
                with Message do
                  PostMessage(Handle, Msg, WParam, LParam);
              end;
          end;
        else//перескок через указатель на €чейку при нажатии на кнопычку
          if Char(Message.WParam) in [^H, #32..#255] then
            with FEditInfo.FEditor do
              if SelLength > 0 then
              begin
                //i:=FAlxdFormulaSelectionsInt.FindByFormula(SelText);
                if i >= 0 then
                begin
                  SelStart:=SelStart+SelLength;
                  SelLength:=0;
                  i:=-1;
                end;
              end;
        end;
      WM_KEYUP:
        if Char(Message.WParam) in [^H, #32..#255] then
          with FEditInfo.FEditor do
          begin
            FAlxdFormulaSelectionsInt.FillOutByFormula(Text);
            UpdateEditorSyntaxPattern;
            needinvalidate:=true;
          end;

      end;
    end;//case

//
// middle state switcher
//

    case AlxdSpreadSheetState of
    gsReadyAddSelection2Formula:
      case Message.Msg of
      WM_LBUTTONDOWN:
        with FAlxdFormulaSelectionsInt do
        begin
          //FAlxdFormulaSelectionsInt.FillOutByFormula(FEditInfo.FEditor.Text);

          Add;
          i:=Count - 1;
          //frmlselection.Assign(Items[Count-1]);

          CurrentCell.SelectionType:=stUsually;
          CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
          CurrentCell.SelectionCell:=placepos.cell;

          LastSelectedCell.Assign(CurrentCell);

          AlxdSpreadSheetState:=gsSelectCell2Formula;

        end;//begin
     end;//case Message.Msg of
    gsReadyChangeSelection2Formula:
      case Message.Msg of
      WM_LBUTTONDOWN:
        with FAlxdFormulaSelectionsInt do
        begin
          if i < 0 then
          begin
            FEditInfo.FEditor.Insert('');
            FAlxdFormulaSelectionsInt.FillOutByFormula(FEditInfo.FEditor.Text);

            Add;
            i:=Count - 1;
          end
          else
          if GetKeyState(VK_CONTROL) < 0 then
          begin
            with FEditInfo.FEditor do
            begin
              SelStart:=SelStart + SelLength;
              SelLength:=0;
              Insert(';');
              SelStart:=SelStart + 1;
            end;

            Add;
            i:=Count - 1;
          end;

          {  if Count > 0 then
              i:=Count - 1;}

          {i:=FindByFormula(FEditInfo.FEditor.Selected);}
          {if i > -1 then
            frmlselection.Assign(Items[i]);}

          CurrentCell.SelectionType:=stUsually;
          CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
          CurrentCell.SelectionCell:=placepos.cell;

          LastSelectedCell.Assign(CurrentCell);

          AlxdSpreadSheetState:=gsSelectCell2Formula;
        end;
      WM_KEYDOWN:
        begin
          AlxdSpreadSheetState:=gsSelectCell2Formula;
        end;
      end;//case
    end;//case AlxdSpreadSheetState of

//
// output state switcher
//

    case AlxdSpreadSheetState of
     gsSelectCell2Formula:
       case Message.Msg of
       WM_LBUTTONDOWN:
         with FAlxdFormulaSelectionsInt do
         begin
           LastSelectedCell.SelectionType:=stUsually;
           LastSelectedCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
           LastSelectedCell.SelectionCell:=placepos.cell;

           frmlselection.SelectionType:=stUsually;
           frmlselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

          //FAlxdSpreadSheetSelectionsInt.CurrentCell.SelectionType:=stUsually;
          //FAlxdSpreadSheetSelectionsInt.CurrentCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
           MouseCapture:=True;
           SetTimer(Handle, 1, 100, nil);

           FEditInfo.FEditor.Insert(frmlselection.Formula);

         end;//WM_LBUTTONDOWN
       WM_MOUSEMOVE:
         with FAlxdFormulaSelectionsInt do
         begin
           LastSelectedCell.SelectionType:=stUsually;
           LastSelectedCell.SelectionRect:=Rect(placepos.cell, placepos.cell);
           LastSelectedCell.SelectionCell:=placepos.cell;

           frmlselection.SelectionType:=stUsually;
           frmlselection.SelectionRect:=Rect(CurrentCell.SelectionRect.TopLeft, LastSelectedCell.SelectionRect.BottomRight);

           if not frmlselection.Equal(Items[i]) then
             FEditInfo.FEditor.Insert(frmlselection.Formula);

           {$IFDEF SDEBUG}
           OutputDebugString(PChar(Format('StateMachine + WM_MOUSEMOVE + CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
           OutputDebugString(PChar(Format('StateMachine + WM_MOUSEMOVE + LastSelectedCell : %d,%d', [LastSelectedCell.Left, LastSelectedCell.Top])));
           {$ENDIF}
         end;
       WM_LBUTTONUP:
         begin
           KillTimer(Handle, 1);
           MouseCapture:=False;
           AlxdSpreadSheetState:=gsWaitFormulaSelect;
           {$IFDEF DEBUG}
           OutputDebugString('StateMachine + WM_LBUTTONUP');
           {$ENDIF}
         end;
       WM_KEYDOWN:
        with FAlxdSpreadSheetSelectionsInt do
        begin
          case Message.WParam of
          VK_DOWN:
            begin
              if frmlselection.Bottom < FAlxdSpreadSheetArray.RowCountInt - 1 then
              begin
                frmlselection.Offset(0, 1);
                FEditInfo.FEditor.Insert(frmlselection.Formula);
                needinvalidate:=true;
              end;
              AlxdSpreadSheetState:=gsWaitFormulaSelect;
            end;
          VK_UP:
            begin
              if frmlselection.Top > 0 then
              begin
                frmlselection.Offset(0, -1);
                FEditInfo.FEditor.Insert(frmlselection.Formula);
                needinvalidate:=true;
              end;
              AlxdSpreadSheetState:=gsWaitFormulaSelect;
            end;
          VK_LEFT:
            begin
              if frmlselection.Left > 0 then
              begin
                frmlselection.Offset(-1, 0);
                FEditInfo.FEditor.Insert(frmlselection.Formula);
                needinvalidate:=true;
              end;
              AlxdSpreadSheetState:=gsWaitFormulaSelect;
            end;
          VK_RIGHT:
            begin
              if frmlselection.Right < FAlxdSpreadSheetArray.ColCountInt - 1 then
              begin
                frmlselection.Offset(1, 0);
                FEditInfo.FEditor.Insert(frmlselection.Formula);
                needinvalidate:=true;
              end;
              AlxdSpreadSheetState:=gsWaitFormulaSelect;
            end;
          end;
        end;//WM_KEYDOWN
       end;//case
    end;//case AlxdSpreadSheetState of

    with FAlxdFormulaSelectionsInt do
      if (Count > 0) and (i >= 0) and (i < Count) then
        if not frmlselection.Equal(Items[i]) then
        begin
          Items[i].Assign(frmlselection);
          UpdateEditorSyntaxPattern;
          //FfrmEditor.ActionUpdate([aumBorders, aumCells, aumSelections]);
          needinvalidate:=needinvalidate or True;
        end;

  if needinvalidate then
    Invalidate;

  finally
    frmlselection.Free;
  end;
end;

procedure TAlxdSpreadSheetInt.WndProc(var Message: TMessage);
begin
  case Message.Msg of
  WM_ALXD_EDITORMODE:
    begin
      EditorMode:=(Message.WParam > 0);
      Invalidate;
    end;
  WM_ALXD_SELTEXTISSELECTION:
    if EditorMode then
    begin
      Message.Result:=FAlxdFormulaSelectionsInt.FindByFormula(FEditInfo.FEditor.SelText);
    end;
  WM_GETDLGCODE:
    with Message do
    begin
      Result := DLGC_WANTARROWS;
      Result := Result or DLGC_WANTTAB;
      Result := Result or DLGC_WANTCHARS;
    end;
  WM_CHAR:
    with Message do
    begin
      inherited;
      if Char(WParam) in [^H, #32..#255] then
      begin
        EditorMode:=True;
        FEditInfo.FEditor.SelectAll;
        PostMessage(FEditInfo.FEditor.Handle, Msg, WParam, 0);
      end;
    end;
  WM_KEYDOWN, WM_KEYUP,
  WM_MOUSEACTIVATE,
  WM_MOUSEMOVE,
  WM_LBUTTONDOWN..WM_RBUTTONDBLCLK:
    begin
      StateMachine(Message);
    end;
  WM_SYSKEYDOWN, WM_SYSKEYUP:
    begin
      inherited;
      StateMachine(Message);
    end;
  WM_MOUSEWHEEL:
    with TWMMouseWheel(Message) do
      ModifyScrollBar(SB_VERT, Integer((WheelDelta div WHEEL_DELTA) < 0), 0);
  WM_COMMAND:
    with TWMCommand(Message) do
    begin
      if (Ctl = FEditInfo.FEditor.Handle) and EditorMode then
        case NotifyCode of
          EN_CHANGE:
            begin
              UpdateEditorText;
              FEditInfo.FEditor.SyntaxPatternRepaint;
              StateMachine(Message);
            end;
          EN_UPDATE:
            begin
              UpdateEditorSize;
            end;
        end;
    end;
  WM_HSCROLL:
    with TWMHScroll(Message) do
      ModifyScrollBar(SB_HORZ, ScrollCode, Pos);
  WM_VSCROLL:
    with TWMVScroll(Message) do
      ModifyScrollBar(SB_VERT, ScrollCode, Pos);
  WM_CUT:
    begin
      AlxdSpreadSheetSelections.CutToClipboard;
      Recalculate;
      RedrawBlockDefinition;
      Invalidate;
    end;
  WM_COPY:
    begin
      AlxdSpreadSheetSelections.CopyToClipboard;
    end;
  WM_PASTE:
    begin
      AlxdSpreadSheetSelections.PasteFromClipboard;
      Recalculate;
      RedrawBlockDefinition;
      Invalidate;
    end;
  WM_CLEAR:
    begin
      AlxdSpreadSheetArray.Cells.ClearContent;
      Recalculate;
      RedrawBlockDefinition;
      Invalidate;
    end;
  WM_UNDO:
    begin
      Undo;
      Recalculate;
      RedrawBlockDefinition;
      Invalidate;
    end

  else
    inherited;
  end;
end;

procedure TAlxdSpreadSheetInt.WMSetCursor(var Msg: TWMSetCursor);
var
  Cur: HCURSOR;
begin
//  if EditorMode then exit;
  Cur:=0;

  if Msg.HitTest = HTCLIENT then
  begin
    if (AlxdSpreadSheetState = gsReadySelectCol) or (AlxdSpreadSheetState = gsSelectCol)  then
      Cur:=LoadCursor(HInstance, 'CR302');
    if (AlxdSpreadSheetState = gsReadySelectRow) or (AlxdSpreadSheetState = gsSelectRow) then
      Cur:=LoadCursor(HInstance, 'CR303');

    if (AlxdSpreadSheetState = gsReadySizingCol) or (AlxdSpreadSheetState = gsSizingCol) then
      Cur:=LoadCursor(HInstance, 'CR258');
    if (AlxdSpreadSheetState = gsReadySizingRow) or (AlxdSpreadSheetState = gsSizingRow) then
      Cur:=LoadCursor(HInstance, 'CR260');

    if (AlxdSpreadSheetState = gsReadySelectionMove) or (AlxdSpreadSheetState = gsSelectionMove) then
      Cur:=LoadCursor(HInstance, 'CR309');
    if (AlxdSpreadSheetState = gsReadySelectionCopy) or (AlxdSpreadSheetState = gsSelectionCopy) then
      Cur:=LoadCursor(HInstance, 'CR269');

{    if (FSpreadSheetState = gsSelectionMoving) then
      Cur:=LoadCursor(HInstance, 'CR310');}
    if (AlxdSpreadSheetState = gsReadySelectionExpand) or (AlxdSpreadSheetState = gsSelectionExpand) then
      Cur:=LoadCursor(HInstance, 'CR270');
    if (AlxdSpreadSheetState = gsReadySelectionExpandInc) or (AlxdSpreadSheetState = gsSelectionExpandInc) then
      Cur:=LoadCursor(HInstance, 'CR279');
  end;

  if Cur<>0 then
    SetCursor(Cur)
  else
    inherited;

  {$IFDEF SDEBUG}
  OutputDebugString(PChar(Format('TAlxdSpreadSheet WM_SETCURSOR Cur: %d', [Cur])));
  {$ENDIF}
end;

procedure TAlxdSpreadSheetInt.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if EditorMode and (Message.FocusedWnd <> FEditinfo.FEditor.Handle) then
    Windows.SetFocus(FEditInfo.FEditor.Handle);

end;

procedure TAlxdSpreadSheetInt.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
end;

procedure TAlxdSpreadSheetInt.WMTimer(var Message: TWMTimer);
var
  Pt: TPoint;
  Ptc: TPoint;
begin
  case Message.TimerID of
  1:
    begin
      GetCursorPos(Pt);
      Ptc:=ScreenToClient(Pt);

      if AlxdSpreadSheetState <> gsSelectRow then
        if Ptc.X < FvarOptions.FixedColWidth then
        begin
          ModifyScrollBar(SB_HORZ, SB_LINEUP, 0);
          PostMessage(Handle, WM_MOUSEMOVE, 0, MakeLong(Pt.X, Pt.Y));
        end
        else
        //if (Ptc.X > ClientRect.Right) and (FRightCol < FAlxdSpreadSheetArray.ColCount) then
        if (Ptc.X > ClientRect.Right) then
        begin
          ModifyScrollBar(SB_HORZ, SB_LINEDOWN, 0);
          PostMessage(Handle, WM_MOUSEMOVE, 0, MakeLong(Pt.X, Pt.Y));
        end;

      if AlxdSpreadSheetState <> gsSelectCol then
        if Ptc.Y < FvarOptions.FixedRowHeight then
        begin
          ModifyScrollBar(SB_VERT, SB_LINEUP, 0);
          PostMessage(Handle, WM_MOUSEMOVE, 0, MakeLong(Pt.X, Pt.Y));
        end
        else
        //if (Ptc.Y > ClientRect.Bottom) and (FBottomRow < FAlxdSpreadSheetArray.RowCount)  then
        if (Ptc.Y > ClientRect.Bottom) then
        begin
          ModifyScrollBar(SB_VERT, SB_LINEDOWN, 0);
          PostMessage(Handle, WM_MOUSEMOVE, 0, MakeLong(Pt.X, Pt.Y));
        end;
    end;//1
  2:
    begin
      with Message do
        KillTimer(Handle, TimerID);

      with FEditinfo do
        if Assigned(FEditCell) then
          if FAlxdSpreadSheetArray.Cells.Items[FEditCell.Left, FEditCell.Top].TextType <> cttsBText then //if cell contain blockname
            if not IsFormula(FEditor.Text) then
            begin
              FAlxdSpreadSheetArray.Cells.Items[FEditCell.Left, FEditCell.Top].Contain:=FEditor.Text;

              if Recalculate then
                RedrawBlockDefinition(0, 0, [rmCells])
              else
                RedrawBlockDefinition(FEditCell.Left, FEditCell.Top, [rmOneCell, rmCells]);

          //FEnterFormula:=IsFormula(FEditor.Text);
          //CellWideContain[FEditCell.X, FEditCell.Y]:=FEditor.Text;
          //RedrawBlockDefinition(FEditCell.X, FEditCell.Y);
          {$IFDEF DLL}
  //        expRedrawSelections(Pointer(Self), SelectionCount, FSelections, SelectionColor2);
          //RedrawSelections;
  //        if BlockReferenceID <> 0 then
  //          expRedrawSelections(Self, SelectionCount, FSelections, SelectionColor2)
          {$ENDIF}
            end;
    end;
  end;//case
end;


//—лой 1
procedure TAlxdSpreadSheetInt.PaintBackground(ACanvas: TCanvas);
begin
  with ACanvas do
  begin
    Brush.Color:=clWhite;
    Windows.FillRect(Handle, ClientRect, Brush.Handle);
  end;
end;

//—лой 2
procedure TAlxdSpreadSheetInt.PaintCells(ACanvas: TCanvas);
var
  currow, curcol: integer;
  pntrow, pntcol: integer;
  //jcurrow, jcurcol: integer;
  ccell: TRect;
  tcell: TRect;
  jp: TAlxdJoinedPlace;
begin
//clLtGray - границы €чеек таблицы
  with ACanvas do
  begin

    currow:=TopRow;
    ccell.Top:=FvarOptions.FixedRowHeight;
    while (ccell.Top < ClientRect.Bottom) and (currow <= FAlxdSpreadSheetArray.RowCountInt) do
    begin
      if currow < FAlxdSpreadSheetArray.RowCountInt then
        ccell.Bottom:=ccell.Top + FAlxdSpreadSheetArray.Rows.Items[currow].PaintSize;

      curcol:=LeftCol;
      ccell.Left:=FvarOptions.FixedColWidth;
      while (ccell.Left < ClientRect.Right) and (curcol <= FAlxdSpreadSheetArray.ColCountInt) do
      begin
        if curcol < FAlxdSpreadSheetArray.ColCountInt then
          ccell.Right:=ccell.Left + FAlxdSpreadSheetArray.Columns.Items[curcol].PaintSize;

        jp:=[jpLeft, jpTop, jpRight, jpBottom];

        if (curcol < FAlxdSpreadSheetArray.ColCountInt) and (currow < FAlxdSpreadSheetArray.RowCountInt) then
        begin
          //отрисовка границ €чеек (не бордюров!)
          Pen.Color:=clLtGray; //D0D7E5?
          jp:=FAlxdSpreadSheetArray.Cells.Items[curcol, currow].JoinedPlace;

          if FvarOptions.DrawHidedBorders then
          begin
            if jpLeft in jp then
            begin
              Windows.MoveToEx(Handle, ccell.Left, ccell.Bottom, nil);
              Windows.LineTo(Handle, ccell.Left, ccell.Top);
            end;

            if jpTop in jp then
            begin
              Windows.MoveToEx(Handle, ccell.Left, ccell.Top, nil);
              Windows.LineTo(Handle, ccell.Right, ccell.Top);
            end;

            if jpRight in jp then
            begin
              Windows.MoveToEx(Handle, ccell.Right, ccell.Top, nil);
              Windows.LineTo(Handle, ccell.Right, ccell.Bottom);
            end;

            if jpBottom in jp then
            begin
              Windows.MoveToEx(Handle, ccell.Left, ccell.Bottom, nil);
              Windows.LineTo(Handle, ccell.Right, ccell.Bottom);
            end;
          end;

          //отрисовка заливки €чеек (цвет €чейки или цвет выборки)
          tcell:=ccell;
          if jpTop in jp then Inc(tcell.Top);
          if jpLeft in jp then Inc(tcell.Left);

          {if FAlxdSpreadSheetSelectionsInt.HasCell(curcol, currow) and
             not FAlxdSpreadSheetSelectionsInt.CurrentCell.HasCell(curcol, currow) then
              Brush.Color:=FvarOptions.SelectionColor //EAECF5
          else}
            if FAlxdSpreadSheetArray.Cells.Items[curcol, currow].IsVisibleCell then
              Brush.Color:=clWhite//FvarOptions.FixedColor;
            else
              Brush.Color:=clLtGray;//FvarOptions.FixedColor;

          //отрисовка текста
          with FAlxdSpreadSheetArray do
          begin
            //pntcol:=curcol;
            //pntrow:=currow;

            if Cells.Items[curcol, currow].IsJoinedCell then
            begin
              pntcol:=Cells.Items[curcol, currow].JoinedRect.Left;
              pntrow:=Cells.Items[curcol, currow].JoinedRect.Top;

              //if (Cells.Items[curcol, currow].JoinedCols = -1) or (Cells.Items[pntcol, pntrow].JoinedRows = -1) then
              if (pntcol < LeftCol) or (pntrow < TopRow) then
                if (Abs(Cells.Items[curcol, currow].JoinedCols) = Cells.Items[pntcol, pntrow].JoinedCols) and
                   (Abs(Cells.Items[curcol, currow].JoinedRows) = Cells.Items[pntcol, pntrow].JoinedRows) then
                begin
                  tcell:=Cells.Items[pntcol, pntrow].PaintSize;

                  OffsetRect(tcell, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

                  if (pntcol < LeftCol) then
                    OffsetRect(tcell, -FAlxdSpreadSheetArray.Columns.PaintDeltaSize(pntcol, LeftCol - pntcol), 0)
                  else
                    OffsetRect(tcell, FAlxdSpreadSheetArray.Columns.PaintDeltaSize(LeftCol, pntcol - LeftCol), 0);

                  if (pntrow < TopRow) then
                    OffsetRect(tcell, 0, -FAlxdSpreadSheetArray.Rows.PaintDeltaSize(pntrow, TopRow - pntrow))
                  else
                    OffsetRect(tcell, 0, FAlxdSpreadSheetArray.Rows.PaintDeltaSize(TopRow, pntrow - TopRow));

                  Inc(tcell.Left);
                  Inc(tcell.Top);
                  Windows.FillRect(Handle, tcell, Brush.Handle);
                  AlxdDrawAlignedText(Handle, Cells.Items[pntcol, pntrow].Text, tcell, DT_WORDBREAK or Integer(Cells.Items[pntcol, pntrow].PaintHorizontalAlignment), nil, Cells.Items[pntcol, pntrow].PaintVerticalAlignment);
                end;
            end
            else
            begin
              tcell:=Cells.Items[curcol, currow].PaintSize;
              OffsetRect(tcell, ccell.Left, ccell.Top);
              Inc(tcell.Left);
              Inc(tcell.Top);
              Windows.FillRect(Handle, tcell, Brush.Handle);
              AlxdDrawAlignedText(Handle, Cells.Items[curcol, currow].Text, tcell, DT_WORDBREAK or Integer(Cells.Items[curcol, currow].PaintHorizontalAlignment), nil, Cells.Items[curcol, currow].PaintVerticalAlignment);
            end;

            //Windows.FillRect(Handle, tcell, Brush.Handle);

//or (pntrow < TopRow)then
//            if Cells.Items[curcol, currow].JoinedCols then
{            tcell:=Cells.Items[curcol, currow].PaintSize;
            OffsetRect(tcell, ccell.Left, ccell.Top);

            pntcol:=curcol;
            pntrow:=currow;
            if Cells.Items[pntcol, pntrow].IsJoinedCell then
            begin
              pntcol:=Cells.Items[curcol, currow].JoinedRect.Left;
              pntrow:=Cells.Items[curcol, currow].JoinedRect.Top;
            end;
}
{            if Cells.Items[curcol, currow].IsSimpleCell or Cells.Items[curcol, currow].IsJoiningCell then
            begin
              tcell:=Cells.Items[curcol, currow].PaintSize;
              OffsetRect(tcell, ccell.Left, ccell.Top);
              Windows.FillRect(Handle, tcell, Brush.Handle);

              Inc(tcell.Left);
              Inc(tcell.Top);
              AlxdDrawAlignedText(Handle, Cells.Items[curcol, currow].Text, tcell, DT_WORDBREAK, nil, dvaBottom);
            end;}
            //else
              //Windows.FillRect(Handle, tcell, Brush.Handle);
          end;

        end;//if (curcol < FAlxdSpreadSheetArray.ColCount) and (currow < FAlxdSpreadSheetArray.RowCount) then

        //отрисовка вертикальных бордюров
        if currow < FAlxdSpreadSheetArray.RowCountInt then
          if jpLeft in jp then
            if FAlxdSpreadSheetArray.VerBorders.Items[curcol, currow].State = dbDraw then
            begin
              Pen.Color:=FAlxdSpreadSheetArray.VerBorders.Items[curcol, currow].PaintColor; //clGreen; //D0D7E5
              Windows.MoveToEx(Handle, ccell.Left, ccell.Bottom, nil);
              Windows.LineTo(Handle, ccell.Left, ccell.Top);
            end;

        //отрисовка горизонтальных бордюров
        if curcol < FAlxdSpreadSheetArray.ColCountInt then
          if jpTop in jp then
            if FAlxdSpreadSheetArray.HorBorders.Items[curcol, currow].State = dbDraw then
            begin
              Pen.Color:=FAlxdSpreadSheetArray.HorBorders.Items[curcol, currow].PaintColor;
              //clGreen;//D0D7E5;
              Windows.MoveToEx(Handle, ccell.Left, ccell.Top, nil);
              Windows.LineTo(Handle, ccell.Right, ccell.Top);
            end;

        ccell.Left:=ccell.Right;
        Inc(curcol);
      end;

      ccell.Top:=ccell.Bottom;
      Inc(currow);
    end;

  end;

  //FRightCol:=curcol;
  //FBottomRow:=currow;
end;

//—лой 3
procedure TAlxdSpreadSheetInt.PaintSelection(ACanvas: TCanvas);
var
  dx, dy: integer;
  crect: TRect;
  i: integer;
  tcell: TRect;

  procedure DrawDot(centerPt: TPoint);
  var
    drect: TRect;
  begin
    with ACanvas do
    begin
      drect:=Rect(centerPt.X - 3, centerPt.Y - 3, centerPt.X + 4, centerPt.Y + 4);

      Brush.Color:=clWhite;
      Windows.FillRect(Handle, drect, Brush.Handle);

      InflateRect(drect, -1, -1);
      Brush.Color:=clBlack;
      Windows.FillRect(Handle, drect, Brush.Handle);
    end;
  end;

  procedure DrawSingleSelection(selRect: TRect);
  var
    tempRect: TRect;
  begin
    with ACanvas do
    begin
      tempRect:=selRect;

      //draw background color of selection
      Brush.Color:=FvarOptions.SelectionColor;
      Brush.Style:=bsSolid;
      InflateRect(tempRect, -2, -2);
      Inc(tempRect.Left, 1);
      Inc(tempRect.Top, 1);
      Windows.FillRect(Handle, tempRect, Brush.Handle);

      //draw active cell color under selection (not filled current cell odnako!)
      if IntersectRect(tempRect, selRect, tcell) then
      begin
        Brush.Color:=clWhite;
        //InflateRect(tcell, -2, -2);
        //divRect:=selRect;
        //divRect.BottomRight:=Point(tempRect.Right, tempRect.Top);
        //Windows.FillRect(Handle, divRect, Brush.Handle);
        Windows.FillRect(Handle, tcell, Brush.Handle);
      end;
      //else
      //Inc(selRect.Left, 3);
      //Inc(selRect.Top, 3);
      //Dec(selRect.Right, 2);
      //  Windows.FillRect(Handle, selRect, Brush.Handle);

      //draw contour of selection
      Pen.Color:=clBlack;
      Pen.Width:=SELECTIONBORDER;
      Brush.Style:=bsClear;
      //Windows.Rectangle(Handle, selRect.Left, selRect.Top, selRect.Right + 1, selRect.Bottom + 1);
      Windows.Rectangle(Handle, selRect.Left, selRect.Top, selRect.Right + 1, selRect.Bottom + 1);
    end;
  end;

  procedure DrawMultiSelection(selRect: TRect; isLast: boolean = false);
  var
    tempRect: TRect;
  begin
    with ACanvas do
    begin
      if isLast then
      begin
        tempRect:=selRect;

        //draw background color of selection
        Brush.Color:=FvarOptions.SelectionColor;
        Brush.Style:=bsSolid;
        InflateRect(tempRect, -2, -2);
        Inc(tempRect.Left, 1);
        Inc(tempRect.Top, 1);
        Windows.FillRect(Handle, tempRect, Brush.Handle);

        //draw active cell color under selection (not filled current cell odnako!)
        if IntersectRect(tempRect, selRect, tcell) then
        begin
          Brush.Color:=clWhite;
          //InflateRect(tcell, -2, -2);
          //divRect:=selRect;
          //divRect.BottomRight:=Point(tempRect.Right, tempRect.Top);
          //Windows.FillRect(Handle, divRect, Brush.Handle);
          Windows.FillRect(Handle, tcell, Brush.Handle);
        end;
      end;

      Pen.Color:=clBlack;
      Pen.Width:=2;
      Brush.Style:=bsClear;
      Windows.Rectangle(Handle, selRect.Left + 1, selRect.Top + 1, selRect.Right+1, selRect.Bottom+1);
    end;
  end;

  procedure DrawFormulaSelection(selRect: TRect; selColor: TColor);
  begin
    with ACanvas do
    begin
      Pen.Color:=selColor;
      Pen.Width:=1;
      Windows.Rectangle(Handle, selRect.Left + 1, selRect.Top + 1, selRect.Right, selRect.Bottom);
    end;
  end;

  procedure DrawDragSelection(selRect: TRect);
  begin
    with ACanvas do
    begin
      Pen.Color:=clMedGray;
      Pen.Width:=SELECTIONBORDER;
      Windows.Rectangle(Handle, selRect.Left, selRect.Top, selRect.Right + 1, selRect.Bottom + 1);
    end;
  end;

  function PaintSizeCell: TRect;
  var
    pntcol, pntrow: integer;
  begin
    with FAlxdSpreadSheetSelectionsInt do
    begin
      pntcol:=CurrentCell.Left;
      pntrow:=CurrentCell.Top;
      result:=FAlxdSpreadSheetArray.Cells.Items[pntcol, pntrow].PaintSize;
      {$IFDEF DEBUG}
      OutputDebugString(PChar(Format('PaintSelection.CurrentCell : %d,%d', [CurrentCell.Left, CurrentCell.Top])));
      {$ENDIF}

      if (pntcol < LeftCol) then
        OffsetRect(result, -FAlxdSpreadSheetArray.Columns.PaintDeltaSize(pntcol, LeftCol - pntcol), 0)
      else
        OffsetRect(result, FAlxdSpreadSheetArray.Columns.PaintDeltaSize(LeftCol, pntcol - LeftCol), 0);

      if (pntrow < TopRow) then
        OffsetRect(result, 0, -FAlxdSpreadSheetArray.Rows.PaintDeltaSize(pntrow, TopRow - pntrow))
      else
        OffsetRect(result, 0, FAlxdSpreadSheetArray.Rows.PaintDeltaSize(TopRow, pntrow - TopRow));

    end;
  end;

begin
  //tcell:=PaintSizeCell;
  //OffsetRect(tcell, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

  with ACanvas do
  begin
    dx:=-FAlxdSpreadSheetArray.Columns.PaintDeltaSize(0, LeftCol);
    dy:=-FAlxdSpreadSheetArray.Rows.PaintDeltaSize(0, TopRow);

    tcell:=PaintSizeCell;
    //OffsetRect(tcell, dx, dy);
    OffsetRect(tcell, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

    //drag выборка есть
    if FDragInfo.FStartSelection <> nil then
      if not FDragInfo.FStartSelection.Equal(FDragInfo.FCurrentSelection) then
      begin
        crect:=FDragInfo.FCurrentSelection.PaintSize;
        OffsetRect(crect, dx, dy);
        OffsetRect(crect, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

        DrawDragSelection(crect);
      end;

    //frml выборка есть
    for i:=0 to FAlxdFormulaSelectionsInt.Count - 1 do
    begin
      crect:=FAlxdFormulaSelectionsInt.Items[i].PaintSize;//DrawRect(i);
      OffsetRect(crect, dx, dy);
      OffsetRect(crect, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

      DrawFormulaSelection(crect, FAlxdFormulaSelectionsInt.ColorByIndex(i));
    end;

    //выборка лишь одна
    if not FAlxdSpreadSheetSelectionsInt.Multiselect then
    begin
      crect:=FAlxdSpreadSheetSelectionsInt.Items[0].PaintSize;
      OffsetRect(crect, dx, dy);
      OffsetRect(crect, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

      DrawSingleSelection(crect);
      DrawDot(crect.BottomRight);
    end
    else
    //ой блин, их много!
    begin
      for i:=0 to FAlxdSpreadSheetSelectionsInt.Count - 1 do
      begin
        crect:=FAlxdSpreadSheetSelectionsInt.Items[i].PaintSize;
        OffsetRect(crect, dx, dy);
        OffsetRect(crect, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

        DrawMultiSelection(crect, i < FAlxdSpreadSheetSelectionsInt.Count);
      end;
    end;

  end;
end;

//—лой 4
procedure TAlxdSpreadSheetInt.PaintFixed(ACanvas: TCanvas);

  procedure DrawCell(ARect: TRect);
  var
    frect: TRect;
  begin
    with ACanvas do
    begin
      //Brush.Color:=FvarOptions.FixedColor;
      //Brush.Color:=AFillColor;
      frect:=ARect;
      Inc(frect.Top);
      Inc(frect.Left);
      Windows.FillRect(Handle, frect, Brush.Handle);

      Pen.Color:=FvarOptions.FixedLineColor; //clRed;//clDkGray; //E4ECF7
      Windows.MoveToEx(Handle, ARect.Left, ARect.Bottom, nil);
      Windows.LineTo(Handle, ARect.Right, ARect.Bottom);      
      Windows.LineTo(Handle, ARect.Right, ARect.Top);           
    end;
  end;

var
  curcol, currow: integer;
  ccell: TRect;
  ctext: TRect;
begin
//clLtGray - границы €чеек таблицы
//clDkGray - границы fixed €чеек
//$404040  - верн€€ и лева€ границы таблицы (дл€ красоты)

//обрати внимание, что отсчет координат идет от Ќ”Ћя!!!
//следовательно, если размер нулевой колонки = 60
//то FillRect будет от 0 до 59!!! и не жди, что от 0 до 60!!!
//а вот линии будут начерчены по координатам, т.е. по 60!!!

  curcol:=LeftCol;
  currow:=TopRow;
  with ACanvas do
  begin
    //draw zero cell
    ccell:=Rect(-1, -1, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);
    Brush.Color:=FvarOptions.FixedColor;
    DrawCell(ccell);

    ctext:=ccell;
    InflateRect(ctext, -1, -1);
    with FAlxdSpreadSheetArray do
      //AlxdDrawAlignedText(Handle, Format('%d x %d'#10'[%d x %d]', [ColCountInt, RowCountInt, ColLineCount, RowLineCount]), ctext, DT_CENTER or DT_WORDBREAK, nil, pvaMiddle);
      //AlxdDrawAlignedText(Handle, Format('%d x %d'#10'[%f x %f]', [ColLineCount, RowLineCount, ColDrawingSize, RowDrawingSize]), ctext, DT_CENTER or DT_WORDBREAK, nil, pvaMiddle);
      AlxdDrawAlignedText(Handle, Format('%d x %d'#10'[%s x %s]', [ColLineCount, RowLineCount, AlxdRToS(ColDrawingSize), AlxdRToS(RowDrawingSize)]), ctext, DT_CENTER or DT_WORDBREAK, nil, pvaMiddle);

    //Windows.MoveToEx(Handle, 0, 0, nil);
    //Windows.LineTo(Handle, FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight);

    //draw zero col
    ccell:=Rect(-1, FvarOptions.FixedRowHeight, FvarOptions.FixedColWidth, 0);
    while (ccell.Top < ClientRect.Bottom) and (currow < FAlxdSpreadSheetArray.RowCountInt) do
    begin
      ccell.Bottom:=ccell.Top + FAlxdSpreadSheetArray.Rows.Items[currow].PaintSize;
      if FAlxdSpreadSheetSelectionsInt.HasRow(currow) then
        Brush.Color:=FvarOptions.SelectionColor
      else
        Brush.Color:=FvarOptions.FixedColor;
      DrawCell(ccell);

      //Brush.Color:=FvarOptions.FixedColor;
      ctext:=ccell;
      InflateRect(ctext, -1, -1);
      AlxdDrawAlignedText(Handle, FAlxdSpreadSheetArray.Rows.Items[currow].PaintTitle, ctext, DT_CENTER or DT_WORDBREAK, nil, pvaMiddle);

      ccell.Top:=ccell.Bottom;
      Inc(currow);
    end;

    //draw zero row
    ccell:=Rect(FvarOptions.FixedColWidth, -1, 0, FvarOptions.FixedRowHeight);
    while (ccell.Left < ClientRect.Right) and (curcol < FAlxdSpreadSheetArray.ColCountInt) do
    begin
      ccell.Right:=ccell.Left + FAlxdSpreadSheetArray.Columns.Items[curcol].PaintSize;
      if FAlxdSpreadSheetSelectionsInt.HasColumn(curcol) then
        Brush.Color:=FvarOptions.SelectionColor
      else
        Brush.Color:=FvarOptions.FixedColor;
      DrawCell(ccell);

      //Brush.Color:=FvarOptions.FixedColor;
      ctext:=ccell;
      InflateRect(ctext, -1, -1);
      AlxdDrawAlignedText(Handle, FAlxdSpreadSheetArray.Columns.Items[curcol].PaintTitle, ctext, DT_CENTER or DT_WORDBREAK, nil, pvaMiddle);

      ccell.Left:=ccell.Right;
      Inc(curcol);
    end;

  end;
end;

//отрисовка идет в несколько слоев
// —лой 1 - background - задний фон,
// отрисовываетс€ на весь компонент заданным цветом
// —лой 2 - cells - €чейки и их содержимое
//
// —лой 3 - selection - выборки
//
// —лой 4 - fixed - заголовки колонок и р€дов
procedure TAlxdSpreadSheetInt.Paint;

  procedure CopySelection(Dest, Source: TCanvas);
  var
    r: TRect;
  begin
    with Dest do
    begin
      CopyMode:=cmSrcAnd;
      r:=Rect(FvarOptions.FixedColWidth - (SELECTIONBORDER div 2), FvarOptions.FixedRowHeight - (SELECTIONBORDER div 2), ClientRect.Right, ClientRect.Bottom);
      CopyRect(r, Source, r);
    end;
  end;

  procedure CopyNotFixed(Dest, Source: TCanvas);
  var
    r: TRect;
  begin
    with Dest do
    begin
      CopyMode:=cmSrcAnd;
      r:=Rect(FvarOptions.FixedColWidth, FvarOptions.FixedRowHeight, ClientRect.Right, ClientRect.Bottom);
      CopyRect(r, Source, r);
    end;
  end;

  procedure CopyFixed(Dest, Source: TCanvas);
  var
    r: TRect;
  begin
    with Dest do
    begin
      CopyMode:=cmSrcCopy;
      r:=Rect(0, 0, ClientRect.Right, FvarOptions.FixedRowHeight + 1);
      CopyRect(r, Source, r);

      r:=Rect(0, 0, FvarOptions.FixedColWidth + 1, ClientRect.Bottom);
      CopyRect(r, Source, r);
    end;
  end;

var
  LayerCommon: TBitmap;
  Layer1: TBitmap;
  Layer2: TBitmap;
  Layer3: TBitmap;
  Layer4: TBitmap;
begin
  LayerCommon:=TBitmap.Create;
  Layer1:=TBitmap.Create;
  Layer2:=TBitmap.Create;
  Layer3:=TBitmap.Create;
  Layer4:=TBitmap.Create;

  Layer1.Canvas.Font.Name:=FvarOptions.FontName;
  Layer2.Canvas.Font.Name:=FvarOptions.FontName;
  Layer3.Canvas.Font.Name:=FvarOptions.FontName;
  Layer4.Canvas.Font.Name:=FvarOptions.FontName;

  Layer1.Canvas.Font.Size:=FvarOptions.FontSize;
  Layer2.Canvas.Font.Size:=FvarOptions.FontSize;
  Layer3.Canvas.Font.Size:=FvarOptions.FontSize;
  Layer4.Canvas.Font.Size:=FvarOptions.FontSize;

  try
    LayerCommon.Height:=Height;
    LayerCommon.Width:=Width;

    Layer1.Height:=Height;
    Layer1.Width:=Width;

    Layer2.Height:=Height;
    Layer2.Width:=Width;

    Layer3.Height:=Height;
    Layer3.Width:=Width;
    //Layer3.TransparentColor:=clBlack;

    Layer4.Height:=Height;
    Layer4.Width:=Width;

    PaintBackground(Layer1.Canvas);
    PaintCells(Layer2.Canvas);
    PaintFixed(Layer3.Canvas);
    PaintSelection(Layer4.Canvas);

    with LayerCommon.Canvas do
    begin
      //merge layers with AND
      CopyMode:=cmSrcAnd;
      CopyRect(ClientRect, Layer1.Canvas, ClientRect);
      CopyFixed(LayerCommon.Canvas, Layer3.Canvas);
      CopyNotFixed(LayerCommon.Canvas, Layer2.Canvas);
      CopySelection(LayerCommon.Canvas, Layer4.Canvas);
    end;

    //draw to canvas
    Canvas.Draw(0, 0, LayerCommon);
  finally
    Layer4.Free;
    Layer3.Free;
    Layer2.Free;
    Layer1.Free;
    LayerCommon.Free;
  end;
end;

procedure TAlxdSpreadSheetInt.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_TABSTOP and not WS_BORDER;
    WindowClass.style := CS_DBLCLKS;
    ExStyle := ExStyle or WS_EX_CLIENTEDGE;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdSpreadSheetInt.UpdateScrollBars;
var
  si: SCROLLINFO;
  nsb: boolean;
begin
  if not HandleAllocated then exit;

  //FVerScrollVisible:=false;
  nsb:=NeedVerScrollBar;
  if nsb then
  begin
    //FVerScrollVisible:=true;

    si.cbSize:=sizeof(SCROLLINFO);
    si.fMask:=SIF_RANGE; //SIF_ALL
    si.nMin:=0;
    si.nMax:=FAlxdSpreadSheetArray.RowCountInt-1;
    //si.nPage:=1;
    si.nPos:=TopRow;
    //si.nTrackPos - ignored by Windows
    SetScrollInfo(Handle, SB_VERT, si, nsb);
  end;
  ShowScrollBar(Handle, SB_VERT, nsb);

  //FHorScrollVisible:=false;
  nsb:=NeedHorScrollBar;
  if nsb then
  begin
    //FHorScrollVisible:=true;
    
    si.cbSize:=sizeof(SCROLLINFO);
    si.fMask:=SIF_RANGE;
    si.nMin:=0;
    si.nMax:=FAlxdSpreadSheetArray.ColCountInt-1;
    //si.nPage:=1;
    si.nPos:=LeftCol;
    //si.nTrackPos - ignored by Windows
    SetScrollInfo(Handle, SB_HORZ, si, nsb);
  end;
  ShowScrollBar(Handle, SB_HORZ, nsb);
end;

procedure TAlxdSpreadSheetInt.AddRows(Count: Integer);
var
  //tmp: integer;
  i: integer;
begin
  //tmp:=FAlxdSpreadSheetArray.RowCountInt;
  //tmp:=FAlxdSpreadSheetArray.RowCountInt;
  for i := 0 to Count - 1 do
    FAlxdSpreadSheetArray.AddRow;

  FAlxdSpreadSheetSelectionsInt.Update;
    
  //RedrawBlockDefinition(0, tmp);
  AlxdUndo.Fix;
  //Invalidate;
end;

procedure TAlxdSpreadSheetInt.DeleteRows;
var
  i, j: integer;
  sa: TPtArray;
begin
  {$IFDEF DEBUG}
  with FAlxdSpreadSheetSelectionsInt do
    OutputDebugString(PChar(Format('TAlxdSpreadSheetInt.DeleteRows + Start + CurrentCell : %d, %d', [CurrentCell.Left, CurrentCell.Top])));
  {$ENDIF}

  with FAlxdSpreadSheetSelectionsInt do
  begin
    sa:=VerPosDelta;
    for i := 0 to Count - 1 do
      for j := 0 to sa[i].Y do
        FAlxdSpreadSheetArray.DeleteRow(sa[i].X);
    Update;
  end;
  //FAlxdSpreadSheetArray.DeleteRow(FAlxdSpreadSheetSelectionsInt.CurrentCell.Top);

  if TopRow > FAlxdSpreadSheetArray.RowCountInt - 1 then
    TopRow:=FAlxdSpreadSheetArray.RowCountInt-1;
    //BottomRow:=FAlxdSpreadSheetArray.RowCountInt-1;

  //FAlxdSpreadSheetSelectionsInt.Update;

  //RedrawBlockDefinition(0, 0);
  AlxdUndo.Fix;
  //Invalidate;
  {$IFDEF DEBUG}
  with FAlxdSpreadSheetSelectionsInt do
    OutputDebugString(PChar(Format('TAlxdSpreadSheetInt.DeleteRows + Finish + CurrentCell : %d, %d', [CurrentCell.Left, CurrentCell.Top])));
  {$ENDIF}
end;

procedure TAlxdSpreadSheetInt.InsertRows;
var
  i, j: integer;
  sa: TPtArray;
begin
  with FAlxdSpreadSheetSelectionsInt do
  begin
    sa:=VerPosDelta;
    for i := 0 to Count - 1 do
      for j := 0 to sa[i].Y do
        FAlxdSpreadSheetArray.InsertRow(sa[i].X);
    Update;
  end;

  //FAlxdSpreadSheetArray.InsertRow(FAlxdSpreadSheetSelectionsInt.CurrentCell.Top);
  //RedrawBlockDefinition(0, 0);
  AlxdUndo.Fix;
  //Invalidate;
end;

procedure TAlxdSpreadSheetInt.AddColumns(Count: Integer);
var
  //tmp: integer;
  i: integer;
begin
  //tmp:=FAlxdSpreadSheetArray.ColCountInt;
  for i := 0 to Count - 1 do
    FAlxdSpreadSheetArray.AddColumn;

  FAlxdSpreadSheetSelectionsInt.Update;    

  //RedrawBlockDefinition(tmp, 0);
  AlxdUndo.Fix;
end;

procedure TAlxdSpreadSheetInt.DeleteColumns;
var
  i, j: integer;
  sa: TPtArray;
begin
  {$IFDEF DEBUG}
  with FAlxdSpreadSheetSelectionsInt do
    OutputDebugString(PChar(Format('TAlxdSpreadSheetInt.DeleteColumns + Start + CurrentCell : %d, %d', [CurrentCell.Left, CurrentCell.Left])));
  {$ENDIF}
  with FAlxdSpreadSheetSelectionsInt do
  begin
    sa:=HorPosDelta;
    for i := 0 to Count - 1 do
      for j := 0 to sa[i].Y do
        FAlxdSpreadSheetArray.DeleteColumn(sa[i].X);
    Update;
  end;

  //FAlxdSpreadSheetArray.DeleteColumn(FAlxdSpreadSheetSelectionsInt.CurrentCell.Left);

  if LeftCol > FAlxdSpreadSheetArray.ColCountInt - 1 then
    LeftCol:=FAlxdSpreadSheetArray.ColCountInt-1;

  //FAlxdSpreadSheetSelectionsInt.Update;

  //RedrawBlockDefinition(0, 0);
  AlxdUndo.Fix;  
  //Invalidate;
  {$IFDEF DEBUG}
  with FAlxdSpreadSheetSelectionsInt do
    OutputDebugString(PChar(Format('TAlxdSpreadSheetInt.DeleteColumns + Finish + CurrentCell : %d, %d', [CurrentCell.Left, CurrentCell.Left])));
  {$ENDIF}
end;

procedure TAlxdSpreadSheetInt.InsertColumns;
var
  i, j: integer;
  sa: TPtArray;
begin
  with FAlxdSpreadSheetSelectionsInt do
  begin
    sa:=HorPosDelta;
    for i := 0 to Count - 1 do
      for j := 0 to sa[i].Y do
        FAlxdSpreadSheetArray.InsertColumn(sa[i].X);
    Update;
  end;

//  FAlxdSpreadSheetArray.InsertColumn(FAlxdSpreadSheetSelectionsInt.CurrentCell.Left);
  //RedrawBlockDefinition(0, 0);
  AlxdUndo.Fix;
//  Invalidate;
end;
{
procedure TAlxdSpreadSheetInt.Join;
begin
  FAlxdSpreadSheetSelectionsInt.Join;
end;

procedure TAlxdSpreadSheetInt.Disjoin;
begin
  FAlxdSpreadSheetSelectionsInt.Disjoin;
  RedrawBlockDefinition(0, 0);
  Invalidate;
end;
}

function  TAlxdSpreadSheetInt.MoveCellsContent(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ChangeCellSelection(Source, Dest, MoveCellContent);
    Recalculate;
  end;
end;

function  TAlxdSpreadSheetInt.CopyCellsContent(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ChangeCellSelection(Source, Dest, CopyCellContent);
    Recalculate;
  end;
end;

function  TAlxdSpreadSheetInt.ExchangeCellsContent(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ChangeCellSelection(Source, Dest, ExchangeCellContent);
    Recalculate;
  end;
end;

function  TAlxdSpreadSheetInt.AppendCellsContent(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
    Result:=ChangeCellSelection(Source, Dest, AppendCellContent);
end;

function  TAlxdSpreadSheetInt.MoveCellsFormat(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
    Result:=ChangeCellSelection(Source, Dest, MoveCellFormat);
end;

function  TAlxdSpreadSheetInt.CopyCellsFormat(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
    Result:=ChangeCellSelection(Source, Dest, CopyCellFormat);
end;

function  TAlxdSpreadSheetInt.ExchangeCellsFormat(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
    Result:=ChangeCellSelection(Source, Dest, ExchangeCellFormat);
end;

function  TAlxdSpreadSheetInt.MoveCellsAll(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ChangeCellSelection(Source, Dest, MoveCellAll);
    Recalculate;
  end;
end;

function  TAlxdSpreadSheetInt.CopyCellsAll(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ChangeCellSelection(Source, Dest, CopyCellAll);
    Recalculate;
  end;
end;

function  TAlxdSpreadSheetInt.ExchangeCellsAll(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ChangeCellSelection(Source, Dest, ExchangeCellAll);
    Recalculate;
  end;
end;

//-------

function  TAlxdSpreadSheetInt.ExpandCopyCellsContent(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ExpandCellSelection(Source, Dest, CopyCellContent);
    Recalculate;
  end;
end;

function  TAlxdSpreadSheetInt.ExpandCopyCellsFormat(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
    Result:=ExpandCellSelection(Source, Dest, CopyCellFormat);
end;

function  TAlxdSpreadSheetInt.ExpandCopyCellsAll(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ExpandCellSelection(Source, Dest, CopyCellAll);
    Recalculate;
  end;
end;

function  TAlxdSpreadSheetInt.ExpandIncCopyCellsContent(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ExpandCellSelection(Source, Dest, IncCopyCellContent);
    Recalculate;
  end;
end;

function  TAlxdSpreadSheetInt.ExpandIncCopyCellsAll(Source, Dest: TRect): boolean;
begin
  Result:=False;
  if not EqualRect(Source, Dest) then
  begin
    Result:=ExpandCellSelection(Source, Dest, IncCopyCellAll);
    Recalculate;
  end;
end;

procedure TAlxdSpreadSheetInt.CreateBlockDefinition;
begin
  {$IFDEF DLL}
  //oarxCreateBlockDef(FAlxdSpreadSheetExchange.BlockDefId, FAlxdSpreadSheetExchange.DictionaryId);
  oarxCreateBlockDef(@FAlxdSpreadSheetExchange);
  {$ENDIF}
end;

procedure TAlxdSpreadSheetInt.RedrawBlockDefinition(fromColumn, fromRow: integer; motive: TAlxdRedrawMotive);
var
{$IFDEF DLL}
  locked: TWasLocked;
  tmpValue: TAlxdSpreadSheetStyleExchange;
  minPt, maxPt: Variant;
  tmpPoint: TAds_point;
{$ENDIF}
  tick: Cardinal;
begin
  {$IFDEF DLL}
  if FAlxdSpreadSheetExchange.BlockDefId <> 0 then
  begin
  {$ENDIF}
    tick:=GetTickCount;
    {$IFDEF DLL}
    tmpValue:=FAlxdSpreadSheetStyleInt.AlxdSpreadSheetStyleExchange;
    oarxSaveLayersLock(@tmpValue, @locked);

    oarxOpenGrid(@FAlxdSpreadSheetExchange);
    {$ENDIF}
    FAlxdSpreadSheetArray.Redraw(fromColumn, fromRow, motive);

    //redraw header
    RedrawHeader(motive);

    {$IFDEF DLL}
    //justify
    tmpPoint:=FAlxdSpreadSheetExchange.BlockDefInsPt;

    FAlxdSpreadSheetExchange.BlockDefInsPt[0]:=0;
    FAlxdSpreadSheetExchange.BlockDefInsPt[1]:=0;
    FAlxdSpreadSheetExchange.BlockDefInsPt[2]:=0;

    oarxBoundaryBlockDef(@FAlxdSpreadSheetExchange, minPt, maxPt);
    case tmpValue.Justify of
    jsTopLeft:
      begin
        FAlxdSpreadSheetExchange.BlockDefInsPt[0]:=0;//minPt[0];
        FAlxdSpreadSheetExchange.BlockDefInsPt[1]:=maxPt[1];
        FAlxdSpreadSheetExchange.BlockDefInsPt[2]:=0;
      end;
    jsTopRight:
      begin
        FAlxdSpreadSheetExchange.BlockDefInsPt[0]:=maxPt[0];//maxPt[0] - minPt[0];
        FAlxdSpreadSheetExchange.BlockDefInsPt[1]:=maxPt[1];
        FAlxdSpreadSheetExchange.BlockDefInsPt[2]:=0;
      end;
    jsBottomLeft:
      begin
        FAlxdSpreadSheetExchange.BlockDefInsPt[0]:=0;
        FAlxdSpreadSheetExchange.BlockDefInsPt[1]:=minPt[1];//minPt[1] - maxPt[1];
        FAlxdSpreadSheetExchange.BlockDefInsPt[2]:=0;
      end;
    jsBottomRight:
      begin
        FAlxdSpreadSheetExchange.BlockDefInsPt[0]:=maxPt[0];// - minPt[0];
        FAlxdSpreadSheetExchange.BlockDefInsPt[1]:=minPt[1];// - maxPt[1];
        FAlxdSpreadSheetExchange.BlockDefInsPt[2]:=0;
      end;
    end;

    oarxCloseGrid(@FAlxdSpreadSheetExchange);

    //if not (rmHeader in motive) then
    oarxRepositionAttributeRef(@FAlxdSpreadSheetExchange, tmpPoint);
    oarxLoadLayersLock(@tmpValue, @locked);

    if FAlxdSpreadSheetExchange.BlockRefId <> 0 then    
      oarxRedrawScreen(FAlxdSpreadSheetExchange.BlockRefId);
    //SendMessage(adsw_acadMainWnd, WM_PAINT, 0, 0);
    {$ENDIF}
    tick:=GetTickCount - tick;
    FfrmEditor.sbMain.Panels[4].Text:=FloatToStr(tick/1000);
  {$IFDEF DLL}
  end;
  {$ENDIF}
  {$IFDEF DEBUG}
  OutputDebugString(#10'TAlxdSpreadSheetInt.RedrawBlockDefinition');
  {$ENDIF}
end;

function  TAlxdSpreadSheetInt.RedrawHeader(motive: TAlxdRedrawMotive): boolean;
var
  tmpValue: TAlxdSpreadSheetStyleExchange;
begin
  Result:=false;
  {$IFDEF DLL}
  if rmHeader in motive then
  begin
    oarxEraseHeader(@FAlxdSpreadSheetExchange);

    tmpValue:=FAlxdSpreadSheetStyleInt.AlxdSpreadSheetStyleExchange;
    oarxRedrawHeader(@tmpValue, @FAlxdSpreadSheetExchange);
    if not (rmCopyOnWrite in motive) then
      oarxRedrawAttributeRef(@FAlxdSpreadSheetExchange);
    Result:=true;
  end;
//function oarxEraseHeader(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
//function oarxRedrawHeader(style: PAlxdSpreadSheetStyleExchange; Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;
//function oarxRedrawAttributeRef(const Value: PAlxdSpreadSheetExchange): boolean; cdecl; external alxdgridarx;

  {$ENDIF}
end;

function  TAlxdSpreadSheetInt.Recalculate: boolean;
var
  i, j: integer;
  ready: boolean;
  counter: integer;
  evaled: string;
  {$IFDEF DLL}
  r: integer;
  v: variant;
  t: integer;
  {$ENDIF}
begin
  counter:=0;
  ready:=false;
  Result:=false;

  while not ready and (counter < 10) do
  begin
    Inc(counter);
    ready:=true;

    with FAlxdSpreadSheetArray do
      for i:=0 to ColCountInt-1 do
        for j:=0 to RowCountInt-1 do
  //        with FCellsArray[i, j] do
          if Cells.Items[i, j].HasFormula then
          begin
            try
              if ParseMathToLisp(Cells.Items[i, j].Formula, FParserParams) then
              begin
                //Raise Exception.Create(FParserParams.OutStr);

                {$IFDEF DLL}
                //hCur:=expDoItBeforeVL;
                r:=oarxAcEdEvaluateLisp(FParserParams.OutStr, v, t);
                if r = 1 then
                  evaled:=v;
                {VLispList:=FVLispRead.FunCall(FParserParams.OutStr);
                VLispResult:=FVLispEval.FunCall(VLispList);
                if VarIsNumeric(VLispResult) then
                  evaled:=AlxdRToS(VLispResult)
                else
                  evaled:=VarToStr(VLispResult);}

                //expDoItAfterVL(hCur);
                {$ELSE}
                evaled:=FParserParams.OutStr;
                {$ENDIF}
              end
              else
              begin
                evaled:='!!!';
              end;
            except
              on E:Exception do
                evaled:=E.Message;
            end;
            ready:=ready and (Cells.Items[i, j].Text = evaled);
            Cells.Items[i, j].Text := evaled;
          end;//if HasFormula
//    if (ready and not result)
    //if not (ready and not result) then
    //  result:=true;
    Result:=not (ready and not result);
//    result:=not (ready and result);
//    result:=not (result or ready);
  end;//while

end;

function  TAlxdSpreadSheetInt.WriteToDictionary: boolean;
begin
  if FAlxdSpreadSheetExchange.DictionaryId <> 0 then
  begin
    FAlxdSpreadSheetStyleInt.WriteToDictionary(FAlxdSpreadSheetExchange);

    FAlxdSpreadSheetArray.Columns.WriteToDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.Rows.WriteToDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.Cells.WriteToDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.Fills.WriteToDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.VerBorders.WriteToDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.HorBorders.WriteToDictionary(FAlxdSpreadSheetExchange.DictionaryId);
  end;
  Result:=True;
end;

function  TAlxdSpreadSheetInt.ReadFromDictionary: boolean;
{$IFDEF DLL}
var
  locked: TWasLocked;
  tmpValue: TAlxdSpreadSheetStyleExchange;
  //tmpPoint: TAds_point;
{$ENDIF}
begin
  if FAlxdSpreadSheetExchange.DictionaryId <> 0 then
  begin
    FAlxdSpreadSheetStyleInt.ReadFromDictionary(FAlxdSpreadSheetExchange);

    FAlxdSpreadSheetArray.Columns.ReadFromDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.Rows.ReadFromDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.Cells.ReadFromDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.Fills.ReadFromDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.VerBorders.ReadFromDictionary(FAlxdSpreadSheetExchange.DictionaryId);
    FAlxdSpreadSheetArray.HorBorders.ReadFromDictionary(FAlxdSpreadSheetExchange.DictionaryId);

    {$IFDEF DLL}
    tmpValue:=FAlxdSpreadSheetStyleInt.AlxdSpreadSheetStyleExchange;
    if oarxIsUniqueGrid(@FAlxdSpreadSheetExchange) then
    begin
      oarxSaveLayersLock(@tmpValue, @locked);
      oarxEraseGrid(@FAlxdSpreadSheetExchange);
      oarxLoadLayersLock(@tmpValue, @locked);
    end
    else
    begin
      //tmpPoint:=FAlxdSpreadSheetExchange.BlockDefInsPt;
      FAlxdSpreadSheetExchange.HeaderRefId:=0;

      oarxCreateBlockDef(@FAlxdSpreadSheetExchange);
      RedrawBlockDefinition(0, 0, [rmAll, rmHeader, rmCopyOnWrite]);
      //RedrawBlockDefinition(0, 0, [rmAll]);
      {oarxSaveLayersLock(@tmpValue, @locked);

      oarxCreateBlockDef(@FAlxdSpreadSheetExchange);
      oarxOpenGrid(@FAlxdSpreadSheetExchange);
      oarxRedrawHeader(@tmpValue, @FAlxdSpreadSheetExchange);
      oarxCloseGrid(@FAlxdSpreadSheetExchange);

      oarxLoadLayersLock(@tmpValue, @locked);}
    end;
    {$ENDIF}

    FAlxdUndo.Reset;
    FAlxdUndo.Fix;
  end;
  Result:=True;
end;

function  TAlxdSpreadSheetInt.WriteToXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
//  node: IXMLNode;
begin
  try
    root:=ADoc.AddChild(AlxdSpreadSheetRoot);// as TXMLNode;

    AlxdSpreadSheetStyle.WriteToXML(root);
    AlxdSpreadSheetArray.Columns.WriteToXML(root);
    AlxdSpreadSheetArray.Rows.WriteToXML(root);
    AlxdSpreadSheetArray.Cells.WriteToXML(root);
    AlxdSpreadSheetArray.Fills.WriteToXML(root);
    AlxdSpreadSheetArray.VerBorders.WriteToXML(root);
    AlxdSpreadSheetArray.HorBorders.WriteToXML(root);

    Result:=True;
  except
    on E:Exception do
    begin
      AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function TAlxdSpreadSheetInt.ReadFromXML(ADoc: IXMLNode): boolean;
var
  root: IXMLNode;
begin
  try
    root:=ADoc.ChildNodes.FindNode(AlxdSpreadSheetRoot);

    AlxdSpreadSheetStyle.ReadFromXML(root);
    AlxdSpreadSheetArray.Columns.ReadFromXML(root);
    AlxdSpreadSheetArray.Rows.ReadFromXML(root);
    AlxdSpreadSheetArray.Cells.ReadFromXML(root, true);
    AlxdSpreadSheetArray.Fills.ReadFromXML(root, true);
    AlxdSpreadSheetArray.VerBorders.ReadFromXML(root, true);
    AlxdSpreadSheetArray.HorBorders.ReadFromXML(root, true);
  
    Result:=True;
  except
    on E:Exception do
    begin
      AlxdMessageBox(0, E.Message, '', MB_ICONERROR + MB_OK);
      Result:=False;
    end;
  end;
end;

function TAlxdSpreadSheetInt.SaveToXML(AFileName: WideString): boolean;
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

function TAlxdSpreadSheetInt.LoadFromXML(AFileName: WideString): boolean;
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
  FAlxdUndo.Fix;
end;

function  TAlxdSpreadSheetInt.SaveToString(var AValue: WideString): boolean;
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

function  TAlxdSpreadSheetInt.LoadFromString(AValue: WideString): boolean;
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

function  TAlxdSpreadSheetInt.Undo: boolean;
begin
  Result:=FAlxdUndo.Undo;
  FAlxdSpreadSheetSelectionsInt.Update;
end;

function  TAlxdSpreadSheetInt.Redo: boolean;
begin
  Result:=FAlxdUndo.Redo;
  FAlxdSpreadSheetSelectionsInt.Update;
end;

procedure TAlxdSpreadSheetInt.Assign(Source: TPersistent);
//var
//  i: integer;
begin
{  if Source is TAlxdSpreadSheetInt then
    for i := 0 to High(AlxdSpreadSheetStylePropValues) do
    begin
      SetPropValue(Self, AlxdSpreadSheetStylePropValues[i], GetPropValue(Source, AlxdSpreadSheetStylePropValues[i]));
    end;}
end;

constructor TAlxdSpreadSheetInt.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csCaptureMouse, csOpaque, csDoubleClicks];

  FAlxdSpreadSheet:=TAlxdSpreadSheet.Create(Self);

  FAlxdSpreadSheetArray:=TAlxdSpreadSheetArray.Create(Self);
  FAlxdSpreadSheetStyleInt:=TAlxdSpreadSheetStyleInt.Create(Self);
  
  FAlxdSpreadSheetSelectionsInt:=TAlxdSpreadSheetSelectionsInt.Create(Self);
  with FAlxdSpreadSheetSelectionsInt do
  begin
    Add;
    Items[0].SelectionType:=stUsually;
    Items[0].SelectionRect:=Rect(0, 0, 0, 0);
    Items[0].SelectionCell:=Point(0, 0);
    Items[0].Update;

    CurrentCell.Assign(Items[0]);
    LastSelectedCell.Assign(Items[0]);
  end;

  FAlxdFormulaSelectionsInt:=TAlxdSpreadSheetSelectionsInt.Create(Self);
  FAlxdUndo:=TAlxdUndo.Create(Self);


  FLeftCol:=0;
  FTopRow:=0;

  //FHorScrollVisible:=false;
  //FVerScrollVisible:=false;

  with FEditInfo do
  begin
    FEditor:=TAlxdEdit.Create(self);
    FEditor.Parent:=Self;
    FEditor.ParentColor:=True;
    FEditor.ParentFont:=True;
    FEditor.ParentBiDiMode:=True;
    FEditor.Visible:=False;
    //FEditor.DirectionEnter:=
  end;

  with FDragInfo do
  begin
    FCurrentSelection:=TAlxdSpreadSheetSelectionInt.Create(Self);
  end;


  //ColCount = 1;
  //RowCount = 1;

//  FAlxdSpreadSheetArray.ColCount:=1;//не менее 1!
//  FAlxdSpreadSheetArray.RowCount:=1;//не менее 1!

//  FAlxdSpreadSheetArray.ColCount:=7;//не менее 1!
//  FAlxdSpreadSheetArray.RowCount:=10;//не менее 1!
  //FAlxdSpreadSheetArray.ColCountInt:=1;
  //FAlxdSpreadSheetArray.RowCountInt:=1;

//  with FAlxdSpreadSheetArray do
//  begin
//    Cells.Items[1,1].Text:='ѕоле %<\AcVar Date \f "d MMMM yyyy">% “екст по русски. “еперь идет текст по английски. This is english text string with veryveryveryveryvery long word. Now: 20%%d, %%c20mm, %%p300. Test for unicode characters: A=\U+00C4? hiragana-\U+304A chinise-\U+5175';
//    Cells.Items[1,1].Text:='Field %<\AcVar Date \f "d MMMM yyyy">% Text “екст по русски.';
//    Cells.Items[1,1].TextType:=cttsDText;
//Field AcVar Date \f "d MMMM yyyy" Text “екст по русски.
//  end;

  FParserParams.GetCellValue:=GetCellValue;
  FParserParams.GetRangeValues:=GetRangeValues;

//  AlxdSpreadSheetStyle.ColCount:=7;
//  AlxdSpreadSheetStyle.RowCount:=10;
{
  FAlxdSpreadSheetArray.Cells.Items[0,9].Text:='short test1';
  FAlxdSpreadSheetArray.Cells.Items[1,1].Text:='long test2';

  FAlxdSpreadSheetSelectionsInt.Items[0].SelectionType:=stUsually;
  FAlxdSpreadSheetSelectionsInt.Items[0].SelectionRect:=Rect(1,1,3,3);
  FAlxdSpreadSheetSelectionsInt.Items[0].Join;

  FAlxdSpreadSheetSelectionsInt.Items[0].SelectionType:=stUsually;
  FAlxdSpreadSheetSelectionsInt.Items[0].SelectionRect:=Rect(4,1,6,2);
  FAlxdSpreadSheetSelectionsInt.Items[0].Join;

  FAlxdSpreadSheetSelectionsInt.Items[0].SelectionType:=stUsually;
  FAlxdSpreadSheetSelectionsInt.Items[0].SelectionRect:=Rect(4,3,6,5);
  FAlxdSpreadSheetSelectionsInt.Items[0].Join;

  FAlxdSpreadSheetSelectionsInt.Items[0].SelectionType:=stUsually;
  FAlxdSpreadSheetSelectionsInt.Items[0].SelectionRect:=Rect(0,0,0,0);
 }
   FAlxdUndo.Fix;
end;

destructor TAlxdSpreadSheetInt.Destroy;
begin
  with FDragInfo do
    if FCurrentSelection <> nil then
      FCurrentSelection.Free;

  with FEditInfo do
    if FEditor <> nil then
      FEditor.Free;

  WriteToDictionary;

  FAlxdUndo.Free;
  FAlxdFormulaSelectionsInt.Free;
  FAlxdSpreadSheetSelectionsInt.Free;
  FAlxdSpreadSheetStyleInt.Free;
  FAlxdSpreadSheetArray.Free;
  inherited;
end;

end.
