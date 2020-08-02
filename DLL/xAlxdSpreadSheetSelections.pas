unit xAlxdSpreadSheetSelections;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes, ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  //TAlxdSpreadSheetSelections = class(TAutoObject, IAlxdSpreadSheetSelections)
  TAlxdSpreadSheetSelections = class(TAutoIntfObject, IAlxdSpreadSheetSelections)
  private
    FOwner: TComponent;
  protected
    function Get_Items(Index: Integer): IAlxdSpreadSheetSelection; safecall;
    function Get_CurrentCell: IAlxdSpreadSheetSelection; safecall;
    procedure Set_CurrentCell(const Value: IAlxdSpreadSheetSelection); safecall;
    function Get_LastSelectedCell: IAlxdSpreadSheetSelection; safecall;
    procedure Set_LastSelectedCell(const Value: IAlxdSpreadSheetSelection);
      safecall;
    //function Get_Items(Col, Row: Integer): AlxdCell; safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdSpreadSheetSelections, uAlxdSpreadSheetSelection;

function TAlxdSpreadSheetSelections.Get_Items(Index: Integer): IAlxdSpreadSheetSelection;
begin
  Result:=(FOwner as TAlxdSpreadSheetSelectionsInt).Items[Index].Intf;
end;

function TAlxdSpreadSheetSelections.Get_CurrentCell: IAlxdSpreadSheetSelection;
begin
  Result:=(FOwner as TAlxdSpreadSheetSelectionsInt).CurrentCell.Intf;
end;

procedure TAlxdSpreadSheetSelections.Set_CurrentCell(const Value: IAlxdSpreadSheetSelection);
begin
  (FOwner as TAlxdSpreadSheetSelectionsInt).CurrentCell.Assign(TAlxdSpreadSheetSelectionInt(Value.Pointer));
end;

function TAlxdSpreadSheetSelections.Get_LastSelectedCell: IAlxdSpreadSheetSelection;
begin
  Result:=(FOwner as TAlxdSpreadSheetSelectionsInt).LastSelectedCell.Intf;
end;

procedure TAlxdSpreadSheetSelections.Set_LastSelectedCell(const Value: IAlxdSpreadSheetSelection);
begin
  (FOwner as TAlxdSpreadSheetSelectionsInt).LastSelectedCell.Assign(TAlxdSpreadSheetSelectionInt(Value.Pointer));
end;

procedure TAlxdSpreadSheetSelections.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelections.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdSpreadSheetSelections.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelections.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdSpreadSheetSelections.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelections.Create');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdSpreadSheetSelections);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdSpreadSheetSelections.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetSelections.Destroy');
  {$ENDIF}
  inherited;
end;

{initialization
  TAutoObjectFactory.Create(ComServer, TAlxdSpreadSheetSelections, Class_AlxdSpreadSheetSelections,
    ciMultiInstance, tmApartment);}


end.
