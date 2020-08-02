unit xAlxdSpreadSheet;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes, ComObj, ActiveX, AlxdGrid_TLB, StdVcl, uAlxdSystem;

type
  TAlxdSpreadSheet = class(TAutoIntfObject, IAlxdSpreadSheet)
  private
    FOwner: TComponent;
  protected
    procedure AddRows(Count: Integer); safecall;
    procedure DeleteRows; safecall;
    procedure InsertRows; safecall;
    procedure AddColumns(Count: Integer); safecall;
    procedure CreateBlockDefinition; safecall;
    procedure DeleteColumns; safecall;
    procedure InsertColumns; safecall;
    procedure RedrawBlockDefinition; safecall;
    function Get_BlockDefinitionID: Integer; safecall;
    function Get_BlockReferenceID: Integer; safecall;
    procedure Set_BlockReferenceID(Value: Integer); safecall;
    function ReadFromDictionary: WordBool; safecall;
    function WriteToDictionary: WordBool; safecall;
    function Get_AlxdSpreadSheetStyle: AlxdSpreadSheetStyle; safecall;
    function Get_AlxdCells: AlxdCells; safecall;
    function Get_DictionaryID: Integer; safecall;
    function Get_AlxdColumns: AlxdItems; safecall;
    function Get_AlxdRows: AlxdItems; safecall;
    function Recalculate: WordBool; safecall;
    function Get_AlxdFills: AlxdFills; safecall;
    function Get_AlxdHorizontalBorders: AlxdBorders; safecall;
    function Get_AlxdVerticalBorders: AlxdBorders; safecall;
    function Get_AlxdSpreadSheetSelections: IAlxdSpreadSheetSelections; safecall;
    procedure RedrawBlockDefinitionFull; safecall;
    function Get_BlockReferencePtrByJig: Integer; safecall;
    procedure Set_BlockReferencePtrByJig(Value: Integer); safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdSpreadSheet;

////////////////////////////////////////////////////////////////////////////////
//
//  Protected
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdSpreadSheet.AddRows(Count: Integer);
begin
  (FOwner as TAlxdSpreadSheetInt).AddRows(Count);
end;


procedure TAlxdSpreadSheet.InsertRows;
begin
  (FOwner as TAlxdSpreadSheetInt).InsertRows;
end;

procedure TAlxdSpreadSheet.DeleteRows;
begin
  (FOwner as TAlxdSpreadSheetInt).DeleteRows;
end;

procedure TAlxdSpreadSheet.AddColumns(Count: Integer);
begin
  (FOwner as TAlxdSpreadSheetInt).AddColumns(Count);
end;

procedure TAlxdSpreadSheet.InsertColumns;
begin
  (FOwner as TAlxdSpreadSheetInt).InsertColumns;
end;

procedure TAlxdSpreadSheet.DeleteColumns;
begin
  (FOwner as TAlxdSpreadSheetInt).DeleteColumns;
end;

procedure TAlxdSpreadSheet.CreateBlockDefinition;
begin
  (FOwner as TAlxdSpreadSheetInt).CreateBlockDefinition;
end;

procedure TAlxdSpreadSheet.RedrawBlockDefinition;
begin
  (FOwner as TAlxdSpreadSheetInt).RedrawBlockDefinition(0, 0);
end;

procedure TAlxdSpreadSheet.RedrawBlockDefinitionFull;
begin
  (FOwner as TAlxdSpreadSheetInt).RedrawBlockDefinition(0, 0, [rmAll, rmHeader]);
end;

function TAlxdSpreadSheet.Get_BlockDefinitionID: Integer;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).BlockDefinitionId;
end;

function TAlxdSpreadSheet.Get_BlockReferenceID: Integer;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).BlockReferenceId;
end;

procedure TAlxdSpreadSheet.Set_BlockReferenceID(Value: Integer);
begin
  (FOwner as TAlxdSpreadSheetInt).BlockReferenceId:=Value;
end;

function TAlxdSpreadSheet.Get_BlockReferencePtrByJig: Integer;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).BlockReferencePtrByJig;
end;

procedure TAlxdSpreadSheet.Set_BlockReferencePtrByJig(Value: Integer);
begin
  (FOwner as TAlxdSpreadSheetInt).BlockReferencePtrByJig:=Value;
end;

function TAlxdSpreadSheet.ReadFromDictionary: WordBool;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).ReadFromDictionary;
end;

function TAlxdSpreadSheet.WriteToDictionary: WordBool;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).WriteToDictionary;
end;

function TAlxdSpreadSheet.Get_AlxdSpreadSheetStyle: AlxdSpreadSheetStyle;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).AlxdSpreadSheetStyle.Intf;
end;

function TAlxdSpreadSheet.Get_AlxdCells: AlxdCells;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Cells.Intf;
end;

function TAlxdSpreadSheet.Get_AlxdFills: AlxdFills;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Fills.Intf;
end;

function TAlxdSpreadSheet.Get_DictionaryID: Integer;
begin
//  (FOwner as TAlxdSpreadSheetInt).Di
end;

function TAlxdSpreadSheet.Get_AlxdColumns: AlxdItems;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Columns.Intf;
end;

function TAlxdSpreadSheet.Get_AlxdRows: AlxdItems;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.Rows.Intf;
end;

function TAlxdSpreadSheet.Get_AlxdHorizontalBorders: AlxdBorders;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.HorBorders.Intf;
end;

function TAlxdSpreadSheet.Get_AlxdVerticalBorders: AlxdBorders;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).AlxdSpreadSheetArray.VerBorders.Intf;
end;

function TAlxdSpreadSheet.Get_AlxdSpreadSheetSelections: IAlxdSpreadSheetSelections;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).AlxdSpreadSheetSelections.Intf;
end;

function TAlxdSpreadSheet.Recalculate: WordBool;
begin
  Result:=(FOwner as TAlxdSpreadSheetInt).Recalculate;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Public
//
////////////////////////////////////////////////////////////////////////////////

procedure TAlxdSpreadSheet.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheet.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdSpreadSheet.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheet.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdSpreadSheet.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheet.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdSpreadSheet);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdSpreadSheet.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheet.Destroy');
  {$ENDIF}
  inherited;
end;


end.
